using System.Collections.Generic;

namespace OfflineRetailV2.Data
{
    
    internal static class BcbpFieldLengths
    {
        // Resolution 792: BCBP "M" format and fixed mandatory field sizes.
        public const int FormatCode = 1;
        public const int NumberOfLegs = 1;
        public const int PassengerName = 20;
        public const int ElectronicTicketIndicator = 1;

        // Based on requested parser profile for this task.
        public const int Pnr = 6;
        public const int FromAirport = 3;
        public const int ToAirport = 3;
        public const int CarrierCode = 3;
        public const int FlightNumber = 5;
        public const int JulianDate = 3;
        public const int CompartmentCode = 1;
        public const int SeatNumber = 4;
        public const int SequenceNumber = 4;
        public const int PassengerStatus = 1;

        public const int HeaderLength =
            FormatCode + NumberOfLegs + PassengerName + ElectronicTicketIndicator;

        public const int SegmentLength =
            Pnr + FromAirport + ToAirport + CarrierCode + FlightNumber + JulianDate +
            CompartmentCode + SeatNumber + SequenceNumber + PassengerStatus;
    }

    public sealed class ParseResult
    {
        public string RawInput { get; set; } = string.Empty;
        public BcbpBoardingPass BoardingPass { get; set; }
        public List<string> ValidationErrors { get; set; } = new List<string>();
        public List<string> Warnings { get; set; } = new List<string>();
        public bool IsValid => ValidationErrors.Count == 0;
    }

    public sealed class BcbpBoardingPass
    {
        public string FormatCode { get; set; } = string.Empty;
        public int NumberOfLegs { get; set; }
        public string PassengerNameRaw { get; set; } = string.Empty;
        public string PassengerNameNormalized { get; set; } = string.Empty;
        public string ElectronicTicketIndicator { get; set; } = string.Empty;
        public List<FlightSegment> Segments { get; set; } = new List<FlightSegment>();
        public StructuredData StructuredData { get; set; } = new StructuredData();
    }

    public sealed class FlightSegment
    {
        public string Pnr { get; set; } = string.Empty;
        public string FromAirport { get; set; } = string.Empty;
        public string ToAirport { get; set; } = string.Empty;
        public string CarrierCode { get; set; } = string.Empty;
        public string FlightNumberRaw { get; set; } = string.Empty;
        public int? FlightNumber { get; set; }
        public string JulianDate { get; set; } = string.Empty;
        public string CompartmentCode { get; set; } = string.Empty;
        public string SeatNumber { get; set; } = string.Empty;
        public string SequenceNumber { get; set; } = string.Empty;
        public string PassengerStatus { get; set; } = string.Empty;
    }

    public sealed class StructuredData
    {
        public bool HasStructuredBlock { get; set; }
        public string RawStructured { get; set; } = string.Empty;
        public int? DeclaredStructuredLength { get; set; }
        public string DateOfIssueJulian { get; set; }
        public string SourceOfCheckIn { get; set; }
        public string SourceOfBoardingPassIssuance { get; set; }
        public List<string> BaggageTagNumbers { get; set; } = new List<string>();
        public string SelecteeIndicator { get; set; }
        public string FastTrackIndicator { get; set; }
        public string SecurityData { get; set; }
        public Dictionary<string, string> AirlineSpecificFields { get; set; } = new Dictionary<string, string>();
        public string Remainder { get; set; }
    }
}