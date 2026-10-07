
using OfflineRetailV2.Data;
using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Text.RegularExpressions;

namespace OfflineRetailV2 { 

public sealed class BcbpParser
{
    
    // C# 7.2 compliant array initialization
    private readonly SegmentLayout[] _layouts = new SegmentLayout[]
    {
            new SegmentLayout(6, 2, 4, 4),
            new SegmentLayout(7, 2, 4, 5),
            new SegmentLayout(6, 3, 5, 4),
            new SegmentLayout(7, 3, 5, 5)
    };

    // Unit-test-friendly pure parser method.
    public ParseResult Parse(string rawInput, bool strict = true)
    {
        var errors = new List<string>();
        var warnings = new List<string>();
        var clean = NormalizeAztecScannerArtifacts(
            NormalizeScannedInput((rawInput ?? string.Empty).TrimEnd('\r', '\n')));

        if (string.IsNullOrWhiteSpace(clean))
        {
            var result = new ParseResult();
            result.RawInput = string.Empty;
            result.ValidationErrors = new List<string> { "Input is empty." };
            return result;
        }

        var attempts = new List<ParseResult>();
        foreach (var layout in _layouts)
        {
            attempts.Add(ParseWithLayout(clean, layout));
        }

        var best = attempts
            .OrderBy(a => a.ValidationErrors.Count)
            .ThenByDescending(a => (a.BoardingPass != null) ? a.BoardingPass.Segments.Count(s => s.FromAirport.Length == 3 && s.ToAirport.Length == 3) : 0)
            .First();

        if (!strict && best.ValidationErrors.Count > 0)
        {
            var nonFatal = best.ValidationErrors.Where(IsNonFatalInOperationalMode).ToList();
            warnings.AddRange(nonFatal);
            var fatal = best.ValidationErrors.Except(nonFatal).ToList();

            return new ParseResult
            {
                RawInput = best.RawInput,
                BoardingPass = best.BoardingPass,
                ValidationErrors = fatal,
                Warnings = warnings
            };
        }
        return best;
    }

    private ParseResult ParseWithLayout(string clean, SegmentLayout layout)
    {
        var errors = new List<string>();
        var pass = new BcbpBoardingPass();
        int offset = 0;

        try
        {
            pass.FormatCode = Read(clean, ref offset, BcbpFieldLengths.FormatCode, "Format code", errors);
            var legsRaw = Read(clean, ref offset, BcbpFieldLengths.NumberOfLegs, "Number of legs", errors);
            pass.NumberOfLegs = int.TryParse(legsRaw, out var legs) ? legs : 0;
            pass.PassengerNameRaw = Read(clean, ref offset, BcbpFieldLengths.PassengerName, "Passenger name", errors);
            pass.PassengerNameNormalized = pass.PassengerNameRaw.Trim();
            pass.ElectronicTicketIndicator = Read(clean, ref offset, BcbpFieldLengths.ElectronicTicketIndicator, "Electronic ticket indicator", errors);

            TryRealignHeaderIfShifted(pass, ref offset);
            TryRealignHeaderForBlankEt(pass, clean, ref offset);

            if (pass.NumberOfLegs < 1 || pass.NumberOfLegs > 4)
            {
                errors.Add("Number of legs must be in range 1..4.");
            }

            // Replaced Math.Clamp with explicit Min/Max for C# 7.2
            int segmentCount = Math.Max(0, Math.Min(pass.NumberOfLegs, 4));
            for (int i = 0; i < segmentCount; i++)
            {
                pass.Segments.Add(ParseSegment(clean, ref offset, i + 1, layout, errors));
            }

            if (offset < clean.Length)
            {
                pass.StructuredData = ParseStructuredData(clean, ref offset, errors);
            }
        }
        catch (Exception ex)
        {
            errors.Add("Unexpected parse failure: " + ex.Message);
        }

        

        return new ParseResult
        {
            RawInput = clean,
            BoardingPass = pass,
            ValidationErrors = errors.Distinct().ToList()
        };
    }

    private class SegmentLayout
    {
        public int PnrLength { get; }
        public int CarrierLength { get; }
        public int FlightNumberLength { get; }
        public int SequenceLength { get; }
        public SegmentLayout(int p, int c, int f, int s) { PnrLength = p; CarrierLength = c; FlightNumberLength = f; SequenceLength = s; }
    }

    private static FlightSegment ParseSegment(
        string input,
        ref int offset,
        int segmentIndex,
        SegmentLayout layout,
        List<string> errors)
    {
        var segment = new FlightSegment
        {
            Pnr = Read(input, ref offset, layout.PnrLength, $"Segment {segmentIndex} PNR", errors).Trim(),
            FromAirport = Read(input, ref offset, BcbpFieldLengths.FromAirport, $"Segment {segmentIndex} from airport", errors).Trim(),
            ToAirport = Read(input, ref offset, BcbpFieldLengths.ToAirport, $"Segment {segmentIndex} to airport", errors).Trim(),
            CarrierCode = Read(input, ref offset, layout.CarrierLength, $"Segment {segmentIndex} carrier", errors).Trim(),
            FlightNumberRaw = Read(input, ref offset, layout.FlightNumberLength, $"Segment {segmentIndex} flight number", errors).Trim(),
            JulianDate = Read(input, ref offset, BcbpFieldLengths.JulianDate, $"Segment {segmentIndex} Julian date", errors),
            CompartmentCode = Read(input, ref offset, BcbpFieldLengths.CompartmentCode, $"Segment {segmentIndex} compartment", errors),
            SeatNumber = Read(input, ref offset, BcbpFieldLengths.SeatNumber, $"Segment {segmentIndex} seat", errors).Trim(),
            SequenceNumber = Read(input, ref offset, layout.SequenceLength, $"Segment {segmentIndex} sequence", errors).Trim(),
        };

        ResolvePassengerStatusBeforeStructuredBlock(input, ref offset, segmentIndex, segment, errors);

        if (int.TryParse(segment.FlightNumberRaw, out var flightNo))
        {
            segment.FlightNumber = flightNo;
        }

        return segment;
    }

    /// <summary>
    /// Some Aztec scans omit the single passenger-status character before the 2-char ASCII hex
    /// length of the conditional section (gap shows as whitespace). Resolution 792: size field follows mandatory data.
    /// </summary>
    private static void ResolvePassengerStatusBeforeStructuredBlock(
        string input,
        ref int offset,
        int segmentIndex,
        FlightSegment segment,
        List<string> errors)
    {
        if (offset >= input.Length)
        {
            segment.PassengerStatus = " ";
            return;
        }

        while (offset < input.Length && char.IsWhiteSpace(input[offset]))
        {
            offset++;
        }

        if (offset >= input.Length)
        {
            segment.PassengerStatus = " ";
            return;
        }

        // "316>503" = status digit + 2-char hex length (both decimal digits) + ">".
        // Use this before generic hex-length parse so "31" is not taken as length from "316>".
        // "35C>" stays length "35" + payload "C…" because the second length nybble is A–F.
        if (offset + 3 < input.Length &&
            char.IsDigit(input[offset]) &&
            char.IsDigit(input[offset + 1]) &&
            char.IsDigit(input[offset + 2]) &&
            input[offset + 3] == '>')
        {
            segment.PassengerStatus = input[offset].ToString();
            offset++;
            return;
        }

        if (char.IsWhiteSpace(input[offset]))
        {
            var peek = offset;
            while (peek < input.Length && char.IsWhiteSpace(input[peek]))
            {
                peek++;
            }

            if (peek + 2 <= input.Length &&
                IsAsciiHex(input[peek]) &&
                IsAsciiHex(input[peek + 1]))
            {
                segment.PassengerStatus = "1";
                offset = peek;
                return;
            }
        }

        // "35C>…" — length is hex "35", payload starts with "C"; do not consume "3" as status.
        if (offset + 2 < input.Length &&
            IsAsciiHex(input[offset]) &&
            IsAsciiHex(input[offset + 1]) &&
            input[offset + 2] != '>')
        {
            segment.PassengerStatus = "1";
            return;
        }

        segment.PassengerStatus = Read(input, ref offset, BcbpFieldLengths.PassengerStatus,
            $"Segment {segmentIndex} passenger status", errors);
    }

    private static bool IsAsciiHex(char c)
    {
        return (c >= '0' && c <= '9') || (c >= 'A' && c <= 'F') || (c >= 'a' && c <= 'f');
    }

    private static StructuredData ParseStructuredData(string input, ref int offset, List<string> errors)
    {
        var structured = new StructuredData { HasStructuredBlock = false };
        int initialOffset = offset;

        if (input.Length - offset < 2)
        {
            structured.Remainder = input.Substring(offset);
            return structured;
        }

        var lengthHex = input.Substring(offset, 2);
        if (!int.TryParse(lengthHex, NumberStyles.HexNumber, CultureInfo.InvariantCulture, out var declaredLength))
        {
            structured.Remainder = input.Substring(offset);
            return structured;
        }

        offset += 2;
        structured.DeclaredStructuredLength = declaredLength;
        structured.HasStructuredBlock = true;

        int available = input.Length - offset;
        int take = Math.Min(declaredLength, available);
        if (take < declaredLength)
        {
            errors.Add("Structured block length mismatch: declared " + declaredLength.ToString("X2") + ", available " + available + ".");
        }

        var rawStructured = input.Substring(offset, take);
        offset += take;
        if (rawStructured.StartsWith(">"))
        {
            rawStructured = rawStructured.Substring(1);
        }
        else if (offset < input.Length && input[offset] == '>')
        {
            offset++;
        }
        structured.RawStructured = rawStructured;

        if (offset < input.Length)
        {
            structured.SecurityData = input.Substring(offset);
            structured.Remainder = input.Substring(offset);
        }

        ParseKnownConditionalFields(rawStructured, structured);
        if (string.IsNullOrEmpty(structured.RawStructured))
        {
            structured.HasStructuredBlock = false;
            offset = initialOffset;
        }

        return structured;
    }

    private static void ParseKnownConditionalFields(string block, StructuredData structured)
    {
        if (string.IsNullOrWhiteSpace(block)) return;

        // C# 7.2 compliant Split
        char[] separators = new char[] { '|', ';' };
        var tokens = block.Split(separators, StringSplitOptions.RemoveEmptyEntries);

        foreach (var token in tokens)
        {
            var trimmedToken = token.Trim();
            var kv = trimmedToken.Split(new char[] { '=' }, 2);
            if (kv.Length != 2) continue;

            var key = kv[0].Trim().ToUpperInvariant();
            var val = kv[1].Trim();

            switch (key)
            {
                case "DOI": structured.DateOfIssueJulian = val; break;
                case "SOC": structured.SourceOfCheckIn = val; break;
                case "SOB": structured.SourceOfBoardingPassIssuance = val; break;
                case "BAG":
                    var bags = val.Split(new char[] { ',' }, StringSplitOptions.RemoveEmptyEntries);
                    foreach (var b in bags) structured.BaggageTagNumbers.Add(b.Trim());
                    break;
                case "SEL": structured.SelecteeIndicator = val; break;
                case "FAST": structured.FastTrackIndicator = val; break;
                case "SEC": structured.SecurityData = val; break;
                default: structured.AirlineSpecificFields[key] = val; break;
            }
        }

        // C# 7.2 Fallback for positional hinting
        if (structured.DateOfIssueJulian == null && block.Length >= 4)
        {
            string prefix = block.Substring(0, 4);
            bool isDigit = true;
            foreach (char c in prefix) if (!char.IsDigit(c)) isDigit = false;

            if (isDigit) structured.DateOfIssueJulian = prefix;
        }
    }
    private static string Read(string input, ref int offset, int length, string name, List<string> errors)
    {
        if (offset + length > input.Length)
        {
            errors.Add(name + ": expected " + length + " chars at offset " + offset + ", but input ended early.");
            var remaining = offset < input.Length ? input.Substring(offset) : string.Empty;
            offset = input.Length;
            return remaining.PadRight(length);
        }
        var value = input.Substring(offset, length);
        offset += length;
        return value;
    }

    private static string NormalizeScannedInput(string input)
    {
        // Scanner/paste sources sometimes include non-breaking spaces; keep fixed-width behavior
        // by normalizing to regular ASCII spaces without collapsing characters.
        return input.Replace('\u00A0', ' ');
    }

    /// <summary>
    /// Aztec/mobile decoders often insert spaces that break fixed-width BCBP fields:
    /// between surname and ET/PNR, between PNR and airports, between carrier and flight (e.g. "LH 4010").
    /// Resolution 792 mandatory fields are contiguous; see BCBP Implementation Guide (mobile/Aztec samples).
    /// </summary>
    private static string NormalizeAztecScannerArtifacts(string input)
    {
        if (string.IsNullOrEmpty(input) || input[0] != 'M')
        {
            return input;
        }

        var s = input;

        // 1) "M1TEST/HIDDEN E8OQ6FU..."
        s = Regex.Replace(s, @"^(M[1-4])([\p{L}0-9/\-\']{1,20})\s+([A-Z])([A-Z0-9]{6})", m =>
        {
            var name = m.Groups[2].Value;
            var et = m.Groups[3].Value;
            var pnr = m.Groups[4].Value;

            // Replaced [..] range syntax with Substring
            var padded = name.Length > BcbpFieldLengths.PassengerName
                ? name.Substring(0, BcbpFieldLengths.PassengerName)
                : name.PadRight(BcbpFieldLengths.PassengerName);

            return m.Groups[1].Value + padded + et + pnr;
        }, RegexOptions.CultureInvariant);

        // 2-5) The other regexes are already compatible with C# 7.2
        s = Regex.Replace(s, @"([A-Z0-9]{6})\s+([A-Z]{7,12})\s+(\d{3,4})\b", "$1$2$3", RegexOptions.CultureInvariant);
        s = Regex.Replace(s, @"\b([A-Z]{2,3})\s+(\d{3,4})\b", "$1$2", RegexOptions.CultureInvariant);
        s = Regex.Replace(s, @"(H)(\d{4})\s+(\d{3})([A-Z])", "$1$2$3$4", RegexOptions.CultureInvariant);
        s = Regex.Replace(s, @"(\d{4})\s+(\d{3})([A-Z])(?=\d)", "$1$2$3", RegexOptions.CultureInvariant);

        return s;
    }

    private static void TryRealignHeaderIfShifted(BcbpBoardingPass pass, ref int offset)
    {
        if (string.IsNullOrEmpty(pass.PassengerNameRaw) || string.IsNullOrEmpty(pass.ElectronicTicketIndicator))
        {
            return;
        }

        var parsedEt = pass.ElectronicTicketIndicator[0];
        if (char.IsLetter(parsedEt) || parsedEt == ' ')
        {
            return;
        }

        // Replaced [^1] with manual index
        var candidateEt = pass.PassengerNameRaw[pass.PassengerNameRaw.Length - 1];

        if (!char.IsLetter(candidateEt))
        {
            return;
        }

        // Replaced [..^1] range with Substring(0, Length - 1)
        pass.PassengerNameRaw = pass.PassengerNameRaw.Substring(0, pass.PassengerNameRaw.Length - 1)
                                .PadRight(BcbpFieldLengths.PassengerName);

        pass.PassengerNameNormalized = pass.PassengerNameRaw.Trim();
        pass.ElectronicTicketIndicator = candidateEt.ToString();

        // Rewind offset
        offset = Math.Max(0, offset - 1);
    }

    private static void TryRealignHeaderForBlankEt(BcbpBoardingPass pass, string input, ref int offset)
    {
        if (string.IsNullOrEmpty(pass.ElectronicTicketIndicator) || pass.ElectronicTicketIndicator[0] != ' ')
        {
            return;
        }

        if (offset >= input.Length)
        {
            return;
        }

        var candidateEt = input[offset];
        if (!char.IsLetterOrDigit(candidateEt))
        {
            return;
        }

        pass.ElectronicTicketIndicator = candidateEt.ToString();
        offset++;
    }

    private static bool IsNonFatalInOperationalMode(string error)
    {
        return error.StartsWith("Structured block length mismatch:", StringComparison.Ordinal);
    }
}
}
