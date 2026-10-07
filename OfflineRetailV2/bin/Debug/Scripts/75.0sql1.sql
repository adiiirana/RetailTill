ALTER PROCEDURE [dbo].[sp_GenerateTradeCloseout]
    @TradeCloseoutID INT,
    @IsZReport BIT,
    @EmployeeID INT,
    @TerminalName NVARCHAR(50)
AS
BEGIN
    SET NOCOUNT ON;
    DECLARE @TotalNet DECIMAL(18,2), @TotalVat DECIMAL(18,2), @TotalGross DECIMAL(18,2), @InvCount INT;

    -- 1. Always calculate the latest totals
    SELECT
        @TotalNet = ISNULL(SUM(NetTotal), 0),
        @TotalVat = ISNULL(SUM(VatTotal), 0),
        @TotalGross = ISNULL(SUM(GrossTotal), 0),
        @InvCount = COUNT(TradeInvoiceId)
    FROM TradeInvoices
    WHERE TradeCloseoutID = @TradeCloseoutID
      AND [Status] = 'Paid';

    -- 2. Always Refresh snapshots
    DELETE FROM TradeCloseoutCustomerSummary WHERE TradeCloseoutID = @TradeCloseoutID;
    DELETE FROM TradeCloseoutTender WHERE TradeCloseoutID = @TradeCloseoutID;

    INSERT INTO TradeCloseoutCustomerSummary (TradeCloseoutID, TradeCustomerID, CompanyName, InvoiceCount, TotalGross)
    SELECT @TradeCloseoutID, TradeCustomerID, CompanyName, COUNT(TradeInvoiceId), SUM(GrossTotal)
    FROM TradeInvoices
    WHERE TradeCloseoutID = @TradeCloseoutID AND [Status] = 'Paid'
    GROUP BY TradeCustomerID, CompanyName;

    INSERT INTO TradeCloseoutTender (TradeCloseoutID, TenderName, Amount, TenderCount)
    VALUES (@TradeCloseoutID, 'On Account', @TotalGross, @InvCount);

    -- 3. ALWAYS Update the Header totals so X-Report has data
    UPDATE TradeCloseoutHeader
    SET TotalNet = @TotalNet, 
        TotalVat = @TotalVat, 
        TotalGross = @TotalGross,
        InvoiceCount = @InvCount
    WHERE ID = @TradeCloseoutID;

    -- 4. FINALIZATION (Only for Z-Report)
    IF @IsZReport = 1
    BEGIN
        UPDATE TradeCloseoutHeader
        SET EndTime = GETDATE(), 
            IsZReport = 1
        WHERE ID = @TradeCloseoutID;

        UPDATE TradeInvoices
        SET IsClosedInZReport = 1
        WHERE TradeCloseoutID = @TradeCloseoutID AND [Status] = 'Paid';
    END

    -- 5. Return data
    SELECT @TotalNet as NetSales, @TotalVat as VatSales, @TotalGross as GrossSales,
           @InvCount as TotalInvoices, @TerminalName as Terminal;
END