USE [Retail2020DB]
GO

IF OBJECT_ID('dbo.sp_tradesalessummary', 'P') IS NOT NULL
    DROP PROCEDURE [dbo].[sp_tradesalessummary]
GO

CREATE PROCEDURE [dbo].[sp_tradesalessummary]
    @tax_inclusive CHAR(1),
    @f_date DATETIME,
    @t_date DATETIME,
    @terminal NVARCHAR(50)
AS
BEGIN
    SET NOCOUNT ON;

    DELETE FROM SummaryData WHERE TerminalName = @terminal;
    DELETE FROM SummaryDataTender WHERE TerminalName = @terminal;

    DECLARE @ProductSales NUMERIC(15,3) = 0;
    DECLARE @TaxAmount NUMERIC(15,3) = 0;
    DECLARE @CostOfGoods NUMERIC(15,3) = 0;
    
    SELECT 
        @ProductSales = ISNULL(SUM(i.NetTotal), 0),
        @TaxAmount = ISNULL(SUM(i.VatTotal), 0)
    FROM TradeInvoices i
    INNER JOIN TradeTrans t ON i.TransactionNo = t.ID
    WHERE t.TransDate BETWEEN @f_date AND @t_date
      AND i.Status <> 'Voided' AND t.TransType = 1;

    SELECT 
        @CostOfGoods = ISNULL(SUM(p.Cost * ti.Quantity), 0)
    FROM TradeInvoiceItems ti
    INNER JOIN TradeInvoices i ON ti.TradeInvoiceId = i.TradeInvoiceId
    INNER JOIN TradeTrans t ON i.TransactionNo = t.ID
    LEFT JOIN Product p ON ti.ProductId = p.ID
    WHERE t.TransDate BETWEEN @f_date AND @t_date
      AND i.Status <> 'Voided' AND t.TransType = 1;

    INSERT INTO SummaryData(
        TerminalName, ProductSales, ServiceSales, OtherSales, ProductDiscount, ServiceDiscount, OtherDiscount,
        TicketDiscount_Sales, DestinationTax, TaxName1_Sales, TaxName2_Sales, TaxName3_Sales,
        Tax1_Sales, Tax2_Sales, Tax3_Sales, TaxableSales_1, TaxableSales_2, TaxableSales_3, NonTaxableSales,
        TaxableSales_Info_1, TaxableSales_Info_2, TaxableSales_Info_3, Fees_Sales, TaxOnFees_Sales, FS_Tender,
        Layaway_Sales, GC_Sales, MGC_Sales, PGC_Sales, DGC_Sales, PLGC_Sales, CostOfGoods, BootleRefund,
        P_Tax1, P_Tax2, P_Tax3, S_Tax1, S_Tax2, S_Tax3, B_Tax1, B_Tax2, B_Tax3,
        RentExist, RentSales, Tax1_Rent, Tax2_Rent, Tax3_Rent, TaxName1_Rent, TaxName2_Rent, TaxName3_Rent,
        TicketDiscount_Rent, Fees_Rent, TaxOnFees_Rent,
        RepairExist, RepairSales, TaxName1_Repair, TaxName2_Repair, TaxName3_Repair, Tax1_Repair, Tax2_Repair,
        Tax3_Repair, RepairDiscount, TicketDiscount_Repair, Fees_Repair, TaxOnFees_Repair, Repair_Deposit,
        Free_Qty, Free_Amount, Paidout, LottoPayout, GiftAid
    )
    VALUES (
        @terminal, @ProductSales, 0, 0, 0, 0, 0,
        0, 0, 'Total Tax', '', '',
        @TaxAmount, 0, 0, @ProductSales, 0, 0, 0,
        'Taxable Sales', '', '', 0, 0, 0,
        0, 0, 0, 0, 0, 0, @CostOfGoods, 0,
        @TaxAmount, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, '', '', '',
        0, 0, 0,
        0, 0, '', '', '', 0, 0,
        0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0
    );

    INSERT INTO SummaryDataTender(TerminalName, TransType, TenderID, TenderName, TenderAmount)
    SELECT 
        @terminal, 
        1,
        tt.TenderType, 
        typ.Name, 
        SUM(tt.TenderAmount)
    FROM TradeTender tt
    INNER JOIN TradeTrans tr ON tt.TransactionNo = tr.ID
    INNER JOIN TenderTypes typ ON tt.TenderType = typ.ID
    WHERE tr.TransDate BETWEEN @f_date AND @t_date
      AND tr.TransType IN (1, 14)
    GROUP BY tt.TenderType, typ.Name;
    
END
GO