SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_WholesaleCloseoutReportHeader]
	@tax_inclusive	char(1),
	@CloseoutType	char(1),
	@CloseoutID		int,
	@Terminal		nvarchar(50),
	@Sync			char(1)
AS
BEGIN
    DELETE FROM CloseoutReportMain WHERE ReportTerminalName = @Terminal;
    DELETE FROM CloseOutReportTender WHERE ReportTerminalName = @Terminal;
    DELETE FROM CloseOutSalesHour WHERE ReportTerminalName = @Terminal;
    DELETE FROM CloseOutSalesDept WHERE ReportTerminalName = @Terminal;
    DELETE FROM CloseOutReturn WHERE ReportTerminalName = @Terminal;

    DECLARE @EmpID nvarchar(12), @EmpName nvarchar(50), @SD datetime, @ED datetime, @CTeml nvarchar(50);
    DECLARE @TotalGross numeric(18,3) = 0, @TotalVat numeric(18,3) = 0, @TotalNet numeric(18,3) = 0;
    DECLARE @ProductTx numeric(18,3) = 0, @ProductNTx numeric(18,3) = 0, @ProductSales numeric(18,3) = 0;
    DECLARE @InvoiceCount int = 0;
    DECLARE @Tax1Name nvarchar(20) = '';
    DECLARE @Tax1Exist char(1) = 'N';

    SELECT @SD = StartTime, @ED = ISNULL(EndTime, GETDATE()), 
           @EmpID = ISNULL(e.EmployeeID, 'ADMIN'), @EmpName = e.FirstName + ' ' + e.LastName,
           @CTeml = h.TerminalName
    FROM TradeCloseoutHeader h
    LEFT JOIN Employee e ON e.ID = h.EmployeeID
    WHERE h.ID = @CloseoutID;

    SELECT 
        @InvoiceCount = COUNT(TradeInvoiceId),
        @TotalGross = ISNULL(SUM(GrossTotal), 0),
        @TotalVat = ISNULL(SUM(VatTotal), 0),
        @TotalNet = ISNULL(SUM(NetTotal), 0),
        @ProductTx = ISNULL(SUM(CASE WHEN VatTotal > 0 THEN NetTotal ELSE 0 END), 0),
        @ProductNTx = ISNULL(SUM(CASE WHEN ISNULL(VatTotal,0) = 0 THEN NetTotal ELSE 0 END), 0)
    FROM TradeInvoices 
    WHERE TradeCloseoutID = @CloseoutID;

    SET @ProductSales = @ProductTx + @ProductNTx;

    IF @TotalVat > 0 
    BEGIN
        SET @Tax1Exist = 'Y';
        SELECT TOP 1 @Tax1Name = TaxName FROM TaxHeader; 
        IF @Tax1Name IS NULL OR @Tax1Name = '' SET @Tax1Name = 'Tax';
    END

    INSERT INTO CloseoutReportMain (
        TaxedSales, NonTaxedSales, Tax1Amount, Tax2Amount, Tax3Amount, ServiceSales, ProductSales, OtherSales,
        DiscountItemNo, DiscountItemAmount, DiscountInvoiceNo, DiscountInvoiceAmount, LayawayDeposits, LayawayRefund, LayawayPayment, LayawaySalesPosted,
        GCsold, HApayments, PaidOuts, HACharged, SCissued, SCredeemed, NoOfSales, Tax1Name, Tax1Exist, Tax2Name, Tax2Exist, Tax3Name, Tax3Exist,
        CloseoutID, StartDateTime, EndDateTime, CloseoutType, Notes, EmpID, TerminalName, ReportTerminalName, TotalSales_PreTax, CostOfGoods,
        NoSaleCount, RentSales, RentDeposit, RentDepositReturned, RentTax1Amount, RentTax2Amount, RentTax3Amount, RentDiscountInvoiceNo, RentDiscountInvoiceAmount,
        RepairSales, RepairTax1Amount, RepairTax2Amount, RepairTax3Amount, RepairDiscountItemNo, RepairDiscountItemAmount, RepairDiscountInvoiceNo, RepairDiscountInvoiceAmount,
        ServiceTax1Amount, ServiceTax2Amount, ServiceTax3Amount, ServiceDiscountItemNo, ServiceDiscountItemAmount, OtherTax1Amount, OtherTax2Amount, OtherTax3Amount,
        OtherDiscountItemNo, OtherDiscountItemAmount, SalesInvoiceCount, RentInvoiceCount, RepairInvoiceCount, ProductTx, ProductNTx, ServiceTx, ServiceNTx, OtherTx, OtherNTx,
        CashTip, CCTip, SalesFees, SalesFeesTax, RentFees, RentFeesTax, RepairFees, RepairFeesTax, DTax, MGCsold, PGCsold, BottleRefund, DGCsold, PLGCsold, Free_Qty, Free_Amount, LottoPayout, GiftAid
    ) VALUES (
        0, 0, @TotalVat, 0, 0, 0, @ProductSales, 0, 
        0, 0, 0, 0, 0, 0, 0, 0, 
        0, 0, 0, 0, 0, 0, @InvoiceCount, @Tax1Name, @Tax1Exist, '', 'N', '', 'N', 
        @CloseoutID, @SD, @ED, @CloseoutType, '', @EmpID, @CTeml, @Terminal, @TotalNet, 0, 
        0, 0, 0, 0, 0, 0, 0, 0, 0, 
        0, 0, 0, 0, 0, 0, 0, 0, 
        0, 0, 0, 0, 0, 0, 0, 0, 
        0, 0, @InvoiceCount, 0, 0, 
        @ProductTx, @ProductNTx, 0, 0, 0, 0, 
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
    );

    INSERT INTO CloseOutReportTender (RecordType, CloseOutID, TenderID, TenderName, TenderAmount, TenderCount, ReportTerminalName)
    SELECT 'T', @CloseoutID, TT.TenderType, ISNULL(TY.Name, 'Trade Account'), SUM(TT.TenderAmount), COUNT(TT.ID), @Terminal
    FROM TradeTender TT
    INNER JOIN TradeTrans TR ON TT.TransactionNo = TR.ID
    LEFT JOIN TenderTypes TY ON TT.TenderType = TY.ID
    WHERE TR.TradeCloseoutID = @CloseoutID
    GROUP BY TT.TenderType, TY.Name;

    INSERT INTO CloseOutReportTender (RecordType, CloseOutID, TenderID, TenderName, TenderAmount, TenderCount, ReportTerminalName)
    SELECT 'C', CloseOutID, TenderID, TenderName, 0, 0, ReportTerminalName 
    FROM CloseOutReportTender WHERE ReportTerminalName = @Terminal AND RecordType = 'T';

    INSERT INTO CloseOutReportTender (RecordType, CloseOutID, TenderID, TenderName, TenderAmount, TenderCount, ReportTerminalName)
    SELECT 'R', CloseOutID, TenderID, TenderName, -TenderAmount, 0, ReportTerminalName 
    FROM CloseOutReportTender WHERE ReportTerminalName = @Terminal AND RecordType = 'T';

    CREATE TABLE #TimeSlots (ID INT IDENTITY(0,1), Timeinterval VARCHAR(30), SalesAmount NUMERIC(18,3) DEFAULT 0, NoOfSales INT DEFAULT 0);
    INSERT INTO #TimeSlots (Timeinterval) VALUES 
    ('12:00 M  -  1:00 AM'), (' 1:00 AM  -  2:00 AM'), (' 2:00 AM  -  3:00 AM'), (' 3:00 AM  -  4:00 AM'),
    (' 4:00 AM  -  5:00 AM'), (' 5:00 AM  -  6:00 AM'), (' 6:00 AM  -  7:00 AM'), (' 7:00 AM  -  8:00 AM'),
    (' 8:00 AM  -  9:00 AM'), (' 9:00 AM  - 10:00 AM'), ('10:00 AM  - 11:00 AM'), ('11:00 AM  - 12:00 N '),
    ('12:00 N  -  1:00 PM'), (' 1:00 PM  -  2:00 PM'), (' 2:00 PM  -  3:00 PM'), (' 3:00 PM  -  4:00 PM'),
    (' 4:00 PM  -  5:00 PM'), (' 5:00 PM  -  6:00 PM'), (' 6:00 PM  -  7:00 PM'), (' 7:00 PM  -  8:00 PM'),
    (' 8:00 PM  -  9:00 PM'), (' 9:00 PM  - 10:00 PM'), ('10:00 PM  - 11:00 PM'), ('11:00 PM  - 12:00 M ');

    UPDATE t
    SET t.SalesAmount = ISNULL(s.TotalAmount, 0),
        t.NoOfSales = ISNULL(s.InvCount, 0)
    FROM #TimeSlots t
    LEFT JOIN (
        SELECT DATEPART(HOUR, InvoiceDate) as Hr, SUM(NetTotal) as TotalAmount, COUNT(TradeInvoiceId) as InvCount
        FROM TradeInvoices WHERE TradeCloseoutID = @CloseoutID GROUP BY DATEPART(HOUR, InvoiceDate)
    ) s ON t.ID = s.Hr;

    INSERT INTO CloseOutSalesHour (Timeinterval, SalesAmount, NoOfSales, CloseoutID, StartDateTime, EndDateTime, CloseoutType, Notes, EmpID, TerminalName, ReportTerminalName)
    SELECT Timeinterval, SalesAmount, NoOfSales, @CloseoutID, @SD, @ED, @CloseoutType, '', @EmpID, @CTeml, @Terminal
    FROM #TimeSlots ORDER BY ID;
    
    DROP TABLE #TimeSlots;

END
GO