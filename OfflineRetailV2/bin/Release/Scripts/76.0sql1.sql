ALTER PROCEDURE [dbo].[sp_GenerateTradeCloseout]
    @TradeCloseoutID INT,
    @IsZReport BIT,
    @EmployeeID INT,
    @TerminalName NVARCHAR(50)
AS
BEGIN
    SET NOCOUNT ON;
    
    DECLARE @TotalTendered DECIMAL(18,2), @TotalVat DECIMAL(18,2), @TotalNet DECIMAL(18,2), @InvCount INT;

    -- 1. Calculate totals based ONLY on tenders linked to this Closeout
    -- Proportional VAT Calculation: (VatTotal / GrossTotal) * TenderAmount
    SELECT 
        @TotalTendered = ISNULL(SUM(TT.TenderAmount), 0),
        @TotalVat = ISNULL(SUM(
            CASE 
                WHEN TI.GrossTotal > 0 THEN (TI.VatTotal / TI.GrossTotal) * TT.TenderAmount 
                ELSE 0 
            END
        ), 0),
        @InvCount = COUNT(DISTINCT TR.TransNoteNo)
    FROM TradeTender TT
    INNER JOIN TradeTrans TR ON TT.TransactionNo = TR.ID
    INNER JOIN TradeInvoices TI ON TR.TransNoteNo = TI.TradeInvoiceId
    WHERE TR.TradeCloseoutID = @TradeCloseoutID;

    -- Net = Gross(Tendered) - Tax(VAT)
    SET @TotalNet = @TotalTendered - @TotalVat;

    -- 2. Refresh Snapshots
    DELETE FROM TradeCloseoutCustomerSummary WHERE TradeCloseoutID = @TradeCloseoutID;
    DELETE FROM TradeCloseoutTender WHERE TradeCloseoutID = @TradeCloseoutID;

    -- Summary by Customer based on Tendered amount in this session
    INSERT INTO TradeCloseoutCustomerSummary (TradeCloseoutID, TradeCustomerID, CompanyName, InvoiceCount, TotalGross)
    SELECT 
        @TradeCloseoutID, 
        TI.TradeCustomerID, 
        TI.CompanyName, 
        COUNT(DISTINCT TI.TradeInvoiceId), 
        SUM(TT.TenderAmount) 
    FROM TradeTender TT
    INNER JOIN TradeTrans TR ON TT.TransactionNo = TR.ID
    INNER JOIN TradeInvoices TI ON TR.TransNoteNo = TI.TradeInvoiceId
    WHERE TR.TradeCloseoutID = @TradeCloseoutID
    GROUP BY TI.TradeCustomerID, TI.CompanyName;

    -- Grouping by Tender Type (Link with TenderTypes table instead of Hardcoding)
    INSERT INTO TradeCloseoutTender (TradeCloseoutID, TenderName, Amount, TenderCount)
    SELECT 
        @TradeCloseoutID, 
        ISNULL(TY.Name, 'Other'),
        SUM(TT.TenderAmount), 
        COUNT(TT.ID)
    FROM TradeTender TT
    INNER JOIN TradeTrans TR ON TT.TransactionNo = TR.ID
    LEFT JOIN TenderTypes TY ON TT.TenderType = TY.ID
    WHERE TR.TradeCloseoutID = @TradeCloseoutID
    GROUP BY TY.Name;

    -- 3. Update Header
    UPDATE TradeCloseoutHeader
    SET TotalGross = @TotalTendered,
        InvoiceCount = @InvCount,
        TotalNet = @TotalNet, 
        TotalVat = @TotalVat   -- Ab yahan Tax update hoga aur Report mein show hoga
    WHERE ID = @TradeCloseoutID;

    -- 4. FINALIZATION
    IF @IsZReport = 1
    BEGIN
        UPDATE TradeCloseoutHeader
        SET EndTime = GETDATE(), 
            IsZReport = 1
        WHERE ID = @TradeCloseoutID;

        -- Mark Invoices as closed in Z-Report ONLY if their Status is 'Paid'
        UPDATE TradeInvoices
        SET IsClosedInZReport = 1
        WHERE TradeCloseoutID = @TradeCloseoutID 
          AND [Status] = 'Paid';
    END

    -- 5. Return Results
    SELECT 
        @TotalNet as NetSales, 
        @TotalVat as VatSales, 
        @TotalTendered as GrossSales,
        @InvCount as TotalInvoices, 
        @TerminalName as Terminal;
END
GO