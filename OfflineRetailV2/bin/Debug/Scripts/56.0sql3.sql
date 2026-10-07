ALTER procedure [dbo].[sp_initializereceipts]
  	@ReturnID	int output

as

declare @qty numeric(15,3);
declare @ptype char(1);
declare @pid int;

begin


  IF OBJECT_ID('Invoice', 'U') IS NOT NULL  DROP TABLE Invoice;
  IF OBJECT_ID('Item', 'U') IS NOT NULL  DROP TABLE Item;
  IF OBJECT_ID('Trans', 'U') IS NOT NULL  DROP TABLE Trans;
  IF OBJECT_ID('Closeout', 'U') IS NOT NULL  DROP TABLE Closeout;
  IF OBJECT_ID('CloseoutTender', 'U') IS NOT NULL  DROP TABLE CloseoutTender;
  IF OBJECT_ID('CloseoutCurrencyCalculator', 'U') IS NOT NULL  DROP TABLE CloseoutCurrencyCalculator;
  IF OBJECT_ID('Tender', 'U') IS NOT NULL  DROP TABLE Tender;
  IF OBJECT_ID('Layaway', 'U') IS NOT NULL  DROP TABLE Layaway;
  IF OBJECT_ID('LayPmts', 'U') IS NOT NULL  DROP TABLE LayPmts;
  IF OBJECT_ID('ItemMatrixOptions', 'U') IS NOT NULL  DROP TABLE ItemMatrixOptions;
  IF OBJECT_ID('SerialDetail', 'U') IS NOT NULL  DROP TABLE SerialDetail;
  IF OBJECT_ID('Suspnded', 'U') IS NOT NULL  DROP TABLE Suspnded;
  IF OBJECT_ID('Notes', 'U') IS NOT NULL  DROP TABLE Notes;
  IF OBJECT_ID('GiftCert', 'U') IS NOT NULL  DROP TABLE GiftCert;
  IF OBJECT_ID('AcctRecv', 'U') IS NOT NULL  DROP TABLE AcctRecv;
  IF OBJECT_ID('CardAuthorisation', 'U') IS NOT NULL  DROP TABLE CardAuthorisation;
  IF OBJECT_ID('CardTrans', 'U') IS NOT NULL  DROP TABLE CardTrans;
  IF OBJECT_ID('workorder', 'U') IS NOT NULL  DROP TABLE workorder;
  IF OBJECT_ID('VoidInv', 'U') IS NOT NULL  DROP TABLE VoidInv;
  IF OBJECT_ID('StoreCreditTransaction', 'U') IS NOT NULL  DROP TABLE StoreCreditTransaction;

  /*  drop table Invoice;
  drop table Item;
  drop table Trans;
  drop table Closeout;
  drop table CloseoutTender;
  drop table Tender;
  drop table Layaway;
  drop table LayPmts;
  drop table ItemMatrixOptions;
  drop table SerialDetail;
  drop table Suspnded;
  drop table Notes;

  drop table GiftCert;
  drop table AcctRecv;
  drop table CardAuthorisation;
  drop table CardTrans;
  drop table workorder;
  drop table VoidInv;*/

  CREATE TABLE [dbo].[Invoice](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[CustomerID] [int] NULL CONSTRAINT [DF_Invoice_CustomerID]  DEFAULT ((0)),
	[EmployeeID] [int] NULL CONSTRAINT [DF_Invoice_EmployeeID]  DEFAULT ((0)),
	[TransactionNo] [int] NULL CONSTRAINT [DF_Invoice_TransactionNo]  DEFAULT ((0)),
	[Tax] [numeric](15, 3) NULL CONSTRAINT [DF_Invoice_Tax]  DEFAULT ((0)),
	[TaxID1] [int] NULL CONSTRAINT [DF_Invoice_TaxID1]  DEFAULT ((0)),
	[TaxID2] [int] NULL CONSTRAINT [DF_Invoice_TaxID2]  DEFAULT ((0)),
	[TaxID3] [int] NULL CONSTRAINT [DF_Invoice_TaxID3]  DEFAULT ((0)),
	[Tax1] [numeric](15, 3) NULL CONSTRAINT [DF_Invoice_Tax1]  DEFAULT ((0)),
	[Tax2] [numeric](15, 3) NULL CONSTRAINT [DF_Invoice_Tax2]  DEFAULT ((0)),
	[Tax3] [numeric](15, 3) NULL CONSTRAINT [DF_Invoice_Tax3]  DEFAULT ((0)),
	[Discount] [numeric](15, 3) NOT NULL,
    [Coupon] [numeric](15, 3) NULL CONSTRAINT [DF_Invoice_Coupon]  DEFAULT ((0)),
	[TotalSale] [numeric](15, 3) NULL,
	[DiscountReason] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Status] [int] NULL,
	[ReceiptCnt] [int] NULL CONSTRAINT [DF_Invoice_ReceiptCnt]  DEFAULT ((1)),
	[LayawayNo] [int] NULL CONSTRAINT [DF_Invoice_LayawayNo]  DEFAULT ((0)),
	[TransMSeconds] [int] NULL CONSTRAINT [DF_Invoice_TransMSeconds]  DEFAULT ((0)),
	[CreatedBy] [int] NULL CONSTRAINT [DF_Invoice_CreatedBy]  DEFAULT ((0)),
	[CreatedOn] [datetime] NULL,
	[LastChangedBy] [int] NULL CONSTRAINT [DF_Invoice_LastChangedBy]  DEFAULT ((0)),
	[LastChangedOn] [datetime] NULL,
	[ChangedByAdmin] [int] NULL,
	[ChangedOnAdmin] [datetime] NULL,
	[BreakpackFlag] [char](1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL CONSTRAINT [DF_Invoice_BreakpackFlag]  DEFAULT ('Y'),
	[ServiceType] [varchar](10) NULL CONSTRAINT [DF_Invoice_ServiceType]  DEFAULT ('Sales'),
	[RentDeposit] [numeric](15, 3) NULL CONSTRAINT [DF_Invoice_RentDeposit]  DEFAULT ((0)),
	[RentReturnDeposit] [numeric](15, 3) NULL CONSTRAINT [DF_Invoice_RentReturnDeposit]  DEFAULT ((0)),
	[RentReturnFlag] [char](1) NULL CONSTRAINT [DF_Invoice_RentReturnFlag]  DEFAULT ('N'),
	[RepairDeliveryDate] [datetime] NULL,
	[RepairNotifiedDate] [datetime] NULL,
	[RepairProblem] [nvarchar](200) NULL,
	[RepairNotes] [nvarchar](200) NULL,
	[RepairRemarks] [nvarchar](200) NULL,
	[RepairAdvanceAmount] [numeric](15, 3) NULL CONSTRAINT [DF_Invoice_RepairAdvanceAmount]  DEFAULT ((0)),
	[RepairAmount] [numeric](15, 3) NULL CONSTRAINT [DF_Invoice_RepairAmount]  DEFAULT ((0)),
	[RepairDueAmount] [numeric](15, 3) NULL CONSTRAINT [DF_Invoice_RepairDueAmount]  DEFAULT ((0)),
	[RepairStatus] [varchar](20) NULL CONSTRAINT [DF_Invoice_RepairStatus]  DEFAULT ('In'),
	[RentParentID] [int] NULL CONSTRAINT [DF_Invoice_RentParentID]  DEFAULT ((0)),
	[RepairParentID] [int] NULL CONSTRAINT [DF_Invoice_RepairParentID]  DEFAULT ((0)),
        [IsRentCalculated] [char](1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL CONSTRAINT [DF_Invoice_IsRentCalculated]  DEFAULT ('N'),
        [CouponPerc] [numeric](15, 3) NULL CONSTRAINT [DF_Invoice_CouponPerc]  DEFAULT ((0)),
        [Fees] [numeric](15, 3) NULL CONSTRAINT [DF_Invoice_Fees]  DEFAULT ((0)),
        [FeesTax] [numeric](15, 3) NULL CONSTRAINT [DF_Invoice_FeesTax]  DEFAULT ((0)), 
        [DTaxID] [int] NULL CONSTRAINT [DF_Invoice_DTaxID]  DEFAULT ((0)),
        [DTax] [numeric](15, 3) NULL CONSTRAINT [DF_Invoice_DTax]  DEFAULT ((0)),
	[RepairItemName] [nvarchar](50) NULL,
	[RepairItemSlNo] [nvarchar](30) NULL,
	[RepairDateIn] [datetime] NULL,
	[RepairFindUs] [nvarchar](50) NULL,
	[CustomerOrderRef] [int] NULL CONSTRAINT [DF_Invoice_CustomerOrderRef]  DEFAULT ((0)),
	[FeesCoupon] [numeric](15, 3) NULL CONSTRAINT [DF_Invoice_FeesCoupon]  DEFAULT ((0)),
    [FeesCouponTax] [numeric](15, 3) NULL CONSTRAINT [DF_Invoice_FeesTaxCoupon]  DEFAULT ((0)), 
	[CustomerDOB] [datetime] NULL,
	[GiftAidFlag] [char](1) NULL CONSTRAINT [DF_Invoice_GiftAidFlag]  DEFAULT ('N'),
	[WooCommID] [int] NULL DEFAULT 0,
	[XeroID] [varchar](100) NULL,
	[QuickBooksCloudFlag] [char](1) NULL DEFAULT ('N'),
	[QBTrnID] [varchar](50) NULL,
 CONSTRAINT [PK_Invoice] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]


IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Invoice]') AND name = N'IX_Invoice_TaxID1')
DROP INDEX [IX_Invoice_TaxID1] ON [dbo].[Invoice] WITH ( ONLINE = OFF )

CREATE NONCLUSTERED INDEX [IX_Invoice_TaxID1] ON [dbo].[Invoice] 
(
	[TaxID1] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]

IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Invoice]') AND name = N'IX_Invoice_TaxID2')
DROP INDEX [IX_Invoice_TaxID2] ON [dbo].[Invoice] WITH ( ONLINE = OFF )

CREATE NONCLUSTERED INDEX [IX_Invoice_TaxID2] ON [dbo].[Invoice] 
(
	[TaxID2] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]


IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Invoice]') AND name = N'IX_Invoice_TaxID3')
DROP INDEX [IX_Invoice_TaxID3] ON [dbo].[Invoice] WITH ( ONLINE = OFF )

CREATE NONCLUSTERED INDEX [IX_Invoice_TaxID3] ON [dbo].[Invoice] 
(
	[TaxID3] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]


IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Invoice]') AND name = N'IX_Invoice_TransactionNo')
DROP INDEX [IX_Invoice_TransactionNo] ON [dbo].[Invoice] WITH ( ONLINE = OFF )

CREATE NONCLUSTERED INDEX [IX_Invoice_TransactionNo] ON [dbo].[Invoice] 
(
	[TransactionNo] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]


IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Invoice]') AND name = N'IX_Invoice_Status')
DROP INDEX [IX_Invoice_Status] ON [dbo].[Invoice] WITH ( ONLINE = OFF )

CREATE NONCLUSTERED INDEX [IX_Invoice_Status] ON [dbo].[Invoice] 
(
	[Status] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]

IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Invoice]') AND name = N'IX_Invoice_Coupon')
DROP INDEX [IX_Invoice_Coupon] ON [dbo].[Invoice] WITH ( ONLINE = OFF )

CREATE NONCLUSTERED INDEX [IX_Invoice_Coupon] ON [dbo].[Invoice] 
(
	[Coupon] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]


IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Invoice]') AND name = N'IX_Invoice_CouponPerc')
DROP INDEX [IX_Invoice_CouponPerc] ON [dbo].[Invoice] WITH ( ONLINE = OFF )

CREATE NONCLUSTERED INDEX [IX_Invoice_CouponPerc] ON [dbo].[Invoice] 
(
	[CouponPerc] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]


IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Invoice]') AND name = N'IX_Invoice_Discount')
DROP INDEX [IX_Invoice_Discount] ON [dbo].[Invoice] WITH ( ONLINE = OFF )

CREATE NONCLUSTERED INDEX [IX_Invoice_Discount] ON [dbo].[Invoice] 
(
	[Discount] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]

IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Invoice]') AND name = N'IX_Invoice_DTax')
DROP INDEX [IX_Invoice_DTax] ON [dbo].[Invoice] WITH ( ONLINE = OFF )

CREATE NONCLUSTERED INDEX [IX_Invoice_DTax] ON [dbo].[Invoice] 
(
	[DTax] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]

IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Invoice]') AND name = N'IX_Invoice_DTaxID')
DROP INDEX [IX_Invoice_DTaxID] ON [dbo].[Invoice] WITH ( ONLINE = OFF )

CREATE NONCLUSTERED INDEX [IX_Invoice_DTaxID] ON [dbo].[Invoice] 
(
	[DTaxID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]

IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Invoice]') AND name = N'IX_Invoice_Fees')
DROP INDEX [IX_Invoice_Fees] ON [dbo].[Invoice] WITH ( ONLINE = OFF )

CREATE NONCLUSTERED INDEX [IX_Invoice_Fees] ON [dbo].[Invoice] 
(
	[Fees] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]

IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Invoice]') AND name = N'IX_Invoice_FeesTax')
DROP INDEX [IX_Invoice_FeesTax] ON [dbo].[Invoice] WITH ( ONLINE = OFF )

CREATE NONCLUSTERED INDEX [IX_Invoice_FeesTax] ON [dbo].[Invoice] 
(
	[FeesTax] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]

IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Invoice]') AND name = N'IX_Invoice_LayawayNo')
DROP INDEX [IX_Invoice_LayawayNo] ON [dbo].[Invoice] WITH ( ONLINE = OFF )

CREATE NONCLUSTERED INDEX [IX_Invoice_LayawayNo] ON [dbo].[Invoice] 
(
	[LayawayNo] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]

IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Invoice]') AND name = N'IX_Invoice_Tax')
DROP INDEX [IX_Invoice_Tax] ON [dbo].[Invoice] WITH ( ONLINE = OFF )

CREATE NONCLUSTERED INDEX [IX_Invoice_Tax] ON [dbo].[Invoice] 
(
	[Tax] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]

IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Invoice]') AND name = N'IX_Invoice_Tax1')
DROP INDEX [IX_Invoice_Tax1] ON [dbo].[Invoice] WITH ( ONLINE = OFF )

CREATE NONCLUSTERED INDEX [IX_Invoice_Tax1] ON [dbo].[Invoice] 
(
	[Tax1] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]

IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Invoice]') AND name = N'IX_Invoice_Tax2')
DROP INDEX [IX_Invoice_Tax2] ON [dbo].[Invoice] WITH ( ONLINE = OFF )

CREATE NONCLUSTERED INDEX [IX_Invoice_Tax2] ON [dbo].[Invoice] 
(
	[Tax2] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]

IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Invoice]') AND name = N'IX_Invoice_Tax3')
DROP INDEX [IX_Invoice_Tax3] ON [dbo].[Invoice] WITH ( ONLINE = OFF )

CREATE NONCLUSTERED INDEX [IX_Invoice_Tax3] ON [dbo].[Invoice] 
(
	[Tax3] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]

IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Invoice]') AND name = N'IX_Invoice_TotalSale')
DROP INDEX [IX_Invoice_TotalSale] ON [dbo].[Invoice] WITH ( ONLINE = OFF )

CREATE NONCLUSTERED INDEX [IX_Invoice_TotalSale] ON [dbo].[Invoice] 
(
	[TotalSale] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]

IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Invoice]') AND name = N'IX_Invoice_CustomerOrderRef')
DROP INDEX [IX_Invoice_TransactionNo] ON [dbo].[Invoice] WITH ( ONLINE = OFF )

CREATE NONCLUSTERED INDEX [IX_Invoice_CustomerOrderRef] ON [dbo].[Invoice] 
(
	[CustomerOrderRef] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]

CREATE TABLE [dbo].[Item](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[InvoiceNo] [int] NULL,
	[ProductID] [int] NULL,
	[DescID] [int] NULL CONSTRAINT [DF_Item_DescID]  DEFAULT ((0)),
	[Price] [numeric](15, 3) NULL,
	[NormalPrice] [numeric](15, 3) NULL,
	[Qty] [numeric](15, 3) NULL,
	[Cost] [numeric](15, 3) NULL,
	[SKU] [nvarchar](16) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Description] [nvarchar](200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ProductType] [char](1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[DepartmentID] [int] NULL CONSTRAINT [DF_Item_DepartmentID]  DEFAULT ((0)),
	[CategoryID] [int] NULL CONSTRAINT [DF_Item_CategoryID]  DEFAULT ((0)),
	[TaxID1] [int] NULL CONSTRAINT [DF_Item_Tax1ID]  DEFAULT ((0)),
	[TaxID2] [int] NULL CONSTRAINT [DF_Item_Tax2ID]  DEFAULT ((0)),
	[TaxID3] [int] NULL CONSTRAINT [DF_Item_Tax3ID]  DEFAULT ((0)),
	[Taxable1] [char](1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL CONSTRAINT [DF_Item_Taxable1]  DEFAULT ('N'),
	[Taxable2] [char](1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL CONSTRAINT [DF_Item_Taxable2]  DEFAULT ('N'),
	[Taxable3] [char](1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL CONSTRAINT [DF_Item_Taxable3]  DEFAULT ('N'),
	[TaxRate1] [numeric](15, 3) NULL CONSTRAINT [DF_Item_Tax1Rate]  DEFAULT ((0)),
	[TaxRate2] [numeric](15, 3) NULL CONSTRAINT [DF_Item_Tax2Rate]  DEFAULT ((0)),
	[TaxRate3] [numeric](15, 3) NULL CONSTRAINT [DF_Item_Tax3Rate]  DEFAULT ((0)),
	[UOMCount] [numeric](15, 3) NULL CONSTRAINT [DF_Item_UOMCount]  DEFAULT ((0)),
	[UOMPrice] [numeric](15, 3) NULL CONSTRAINT [DF_Item_UOMPrice]  DEFAULT ((0)),
	[UOMDesc] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[PromoID] [int] NULL,
	[PercentFS] [numeric](15, 3) NULL CONSTRAINT [DF_Item_PercentFS]  DEFAULT ((0)),
	[ReturnedItemID] [int] NULL CONSTRAINT [DF_Item_ReturnedItemID]  DEFAULT ((0)),
	[ReturnedItemCnt] [numeric](15, 3) NULL CONSTRAINT [DF_Item_ReturnedItemCnt]  DEFAULT ((0)),
	[CreatedBy] [int] NULL CONSTRAINT [DF_Item_CreatedBy]  DEFAULT ((0)),
	[CreatedOn] [datetime] NULL,
	[LastChangedBy] [int] NULL CONSTRAINT [DF_Item_LastChangedBy]  DEFAULT ((0)),
	[LastChangedOn] [datetime] NULL,
	[Notes] [nvarchar](200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Tagged] [char](1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL CONSTRAINT [DF_Item_Tagged]  DEFAULT ('N'),

	[ItemIndex] [int] NULL CONSTRAINT [DF_Item_ItemIndex]  DEFAULT ((1)),
	[DiscountID] [int] NULL CONSTRAINT [DF_Item_DiscountID]  DEFAULT ((0)),
	[Discount] [numeric](15, 3) NULL CONSTRAINT [DF_Item_Discount]  DEFAULT ((0)),
	[DiscValue] [numeric](15, 3) NULL CONSTRAINT [DF_Item_DiscValue]  DEFAULT ((0)),
	[DiscountText] [nvarchar](60) NULL CONSTRAINT [DF_Item_DiscountText]  DEFAULT (''),
	[DiscLogic] [char](1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL CONSTRAINT [DF_Item_DiscLogic]  DEFAULT (''),
	[BreakpackFlag] [char](1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL CONSTRAINT [DF_Item_BreakpackFlag]  DEFAULT ('Y'),
	
	[ServiceType] [varchar](10) NULL CONSTRAINT [DF_Item_ServiceType]  DEFAULT ('Sales'),
	[RentApplicable] [char](2) NULL CONSTRAINT [DF_Item_RentApplicable]  DEFAULT ('NA'),
	[RentEffectiveFrom] [datetime] NULL,
	[RentDuration] [numeric](15, 3) NULL CONSTRAINT [DF_Item_RentDuration]  DEFAULT ((0)),
	[RentDeposit] [numeric](15, 3) NULL CONSTRAINT [DF_Item_RentDeposit]  DEFAULT ((0)),
	[RentReturnFlag] [char](1) NULL CONSTRAINT [DF_Item_RentReturnFlag]  DEFAULT ('N'),
	[RepairItemTag] [nvarchar](30) NULL,
	[RepairItemSLNO] [nvarchar](30) NULL,
	[RepairItemPurchaseDate] [datetime] NULL,
	[RepairItemDeliveryDate] [datetime] NULL,
	[TaxType1] [int] NULL CONSTRAINT [DF_Item_TaxType1]  DEFAULT ((0)),
	[TaxType2] [int] NULL CONSTRAINT [DF_Item_TaxType2]  DEFAULT ((0)),
	[TaxType3] [int] NULL CONSTRAINT [DF_Item_TaxType3]  DEFAULT ((0)),

	[TaxTotal1] [numeric](15, 3) NULL CONSTRAINT [DF_Item_TaxTotal11]  DEFAULT ((0)),
	[TaxTotal2] [numeric](15, 3) NULL CONSTRAINT [DF_Item_TaxTotal12]  DEFAULT ((0)),
	[TaxTotal3] [numeric](15, 3) NULL CONSTRAINT [DF_Item_TaxTotal13]  DEFAULT ((0)),
    	[FSTender] [char](1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL CONSTRAINT [DF_Item_FSTender] DEFAULT ('N'),
    	[MixMatchID] [int] NULL CONSTRAINT [DF_Item_MixMatchID]  DEFAULT ((0)),

    	[FeesID] [int] NULL CONSTRAINT [DF_Item_FeesID]  DEFAULT ((0)),
    	[FeesLogic] [char](1) NULL CONSTRAINT [DF_Item_FeesLogic]  DEFAULT (('')),
    	[FeesValue] [numeric](15, 3) NULL CONSTRAINT [DF_Item_FeesValue]  DEFAULT ((0)),
    	[FeesTaxRate] [numeric](15, 3) NULL CONSTRAINT [DF_Item_FeesTaxRate]  DEFAULT ((0)),
    	[Fees] [numeric](15, 3) NULL CONSTRAINT [DF_Item_Fees]  DEFAULT ((0)),
    	[FeesTax] [numeric](15, 3) NULL CONSTRAINT [DF_Item_FeesTax]  DEFAULT ((0)), 
    	[FeesText] [nvarchar](60) NULL CONSTRAINT [DF_Item_FeesText]  DEFAULT (('')),
	[FeesQty] [char](1) NULL CONSTRAINT [DF_Item_FeesQty]  DEFAULT (('N')),
    	[SalePriceID] [int] NULL CONSTRAINT [DF_Item_SalePriceID]  DEFAULT ((0)),	

        [DTaxID] [int] NULL CONSTRAINT [DF_Item_DTaxID]  DEFAULT ((0)),
        [DTaxType] [int] NULL CONSTRAINT [DF_Item_DTaxType]  DEFAULT ((0)),
	[DTaxRate] [numeric](15, 3) NULL CONSTRAINT [DF_Item_DTaxRate]  DEFAULT ((0)),
        [DTax] [numeric](15, 3) NULL CONSTRAINT [DF_Item_DTax]  DEFAULT ((0)),
	[EditFlag] [char](1) NULL CONSTRAINT [DF_Item_EditFlag]  DEFAULT (('N')),
	[QtyDecimal] [int] NULL CONSTRAINT [DF_Item_QtyDecimal]  DEFAULT ((0)),
	[PromptPrice] [char](1) NULL CONSTRAINT [DF_Item_PromptPrice]  DEFAULT (('N')),

	[BuyNGetFreeHeaderID] [int] NULL CONSTRAINT [DF_Item_BuyNGetFreeHeaderID]  DEFAULT ((0)),
	[BuyNGetFreeCategory] [char](1) NULL CONSTRAINT [DF_Item_BuyNGetFreeCategory]  DEFAULT (('X')),
	[BuyNGetFreeName] [nvarchar](60) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Age] [int] NULL CONSTRAINT [DF_Item_Age]  DEFAULT ((0)),
	[TaxIncludeRate] [numeric](15, 3) NULL CONSTRAINT [DF_Item_TaxIncludeRate]  DEFAULT ((0)),
	[TaxIncludePrice] [numeric](15, 3) NULL CONSTRAINT [DF_Item_TaxIncludePrice]  DEFAULT ((0)),
	[UOM] [nvarchar](15) NULL DEFAULT (('')),
 CONSTRAINT [PK_Item] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]


IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Item]') AND name = N'IX_Item_DescID')
DROP INDEX [IX_Item_DescID] ON [dbo].[Item] WITH ( ONLINE = OFF )

CREATE NONCLUSTERED INDEX [IX_Item_DescID] ON [dbo].[Item] 
(
	[DescID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]


IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Item]') AND name = N'IX_Item_FSTender')
DROP INDEX [IX_Item_FSTender] ON [dbo].[Item] WITH ( ONLINE = OFF )

CREATE NONCLUSTERED INDEX [IX_Item_FSTender] ON [dbo].[Item] 
(
	[FSTender] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]


IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Item]') AND name = N'IX_Item_InvoiceNo')
DROP INDEX [IX_Item_InvoiceNo] ON [dbo].[Item] WITH ( ONLINE = OFF )

CREATE NONCLUSTERED INDEX [IX_Item_InvoiceNo] ON [dbo].[Item] 
(
	[InvoiceNo] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]


IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Item]') AND name = N'IX_Item_ProductID')
DROP INDEX [IX_Item_ProductID] ON [dbo].[Item] WITH ( ONLINE = OFF )

CREATE NONCLUSTERED INDEX [IX_Item_ProductID] ON [dbo].[Item] 
(
	[ProductID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]


IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Item]') AND name = N'IX_Item_ProductType')
DROP INDEX [IX_Item_ProductType] ON [dbo].[Item] WITH ( ONLINE = OFF )

CREATE NONCLUSTERED INDEX [IX_Item_ProductType] ON [dbo].[Item] 
(
	[ProductType] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]


IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Item]') AND name = N'IX_Item_ServiceType')
DROP INDEX [IX_Item_ServiceType] ON [dbo].[Item] WITH ( ONLINE = OFF )

CREATE NONCLUSTERED INDEX [IX_Item_ServiceType] ON [dbo].[Item] 
(
	[ServiceType] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]


IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Item]') AND name = N'IX_Item_tagged')
DROP INDEX [IX_Item_Tagged] ON [dbo].[Item] WITH ( ONLINE = OFF )

CREATE NONCLUSTERED INDEX [IX_Item_tagged] ON [dbo].[Item] 
(
	[Tagged] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]


IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Item]') AND name = N'IX_Item_Cost')
DROP INDEX [IX_Item_Cost] ON [dbo].[Item] WITH ( ONLINE = OFF )

CREATE NONCLUSTERED INDEX [IX_Item_Cost] ON [dbo].[Item] 
(
	[Cost] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]


IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Item]') AND name = N'IX_Item_DepartmentID')
DROP INDEX [IX_Item_DepartmentID] ON [dbo].[Item] WITH ( ONLINE = OFF )

CREATE NONCLUSTERED INDEX [IX_Item_DepartmentID] ON [dbo].[Item] 
(
	[DepartmentID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]


IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Item]') AND name = N'IX_Item_Discount')
DROP INDEX [IX_Item_Discount] ON [dbo].[Item] WITH ( ONLINE = OFF )

CREATE NONCLUSTERED INDEX [IX_Item_Discount] ON [dbo].[Item] 
(
	[Discount] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]


IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Item]') AND name = N'IX_Item_NormalPrice')
DROP INDEX [IX_Item_NormalPrice] ON [dbo].[Item] WITH ( ONLINE = OFF )

CREATE NONCLUSTERED INDEX [IX_Item_NormalPrice] ON [dbo].[Item] 
(
	[NormalPrice] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]


IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Item]') AND name = N'IX_Item_Price')
DROP INDEX [IX_Item_Price] ON [dbo].[Item] WITH ( ONLINE = OFF )

CREATE NONCLUSTERED INDEX [IX_Item_Price] ON [dbo].[Item] 
(
	[Price] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]


IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Item]') AND name = N'IX_Item_Qty')
DROP INDEX [IX_Item_Qty] ON [dbo].[Item] WITH ( ONLINE = OFF )

CREATE NONCLUSTERED INDEX [IX_Item_Qty] ON [dbo].[Item] 
(
	[Qty] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]

IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Item]') AND name = N'IX_Item_ReturnedItemCnt')
DROP INDEX [IX_Item_ReturnedItemCnt] ON [dbo].[Item] WITH ( ONLINE = OFF )

CREATE NONCLUSTERED INDEX [IX_Item_ReturnedItemCnt] ON [dbo].[Item] 
(
	[ReturnedItemCnt] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]

IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Item]') AND name = N'IX_Item_ReturnedItemID')
DROP INDEX [IX_Item_ReturnedItemID] ON [dbo].[Item] WITH ( ONLINE = OFF )

CREATE NONCLUSTERED INDEX [IX_Item_ReturnedItemID] ON [dbo].[Item] 
(
	[ReturnedItemID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]


IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Item]') AND name = N'IX_Item_Taxable1')
DROP INDEX [IX_Item_Taxable1] ON [dbo].[Item] WITH ( ONLINE = OFF )

CREATE NONCLUSTERED INDEX [IX_Item_Taxable1] ON [dbo].[Item] 
(
	[Taxable1] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]


IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Item]') AND name = N'IX_Item_Taxable2')
DROP INDEX [IX_Item_Taxable2] ON [dbo].[Item] WITH ( ONLINE = OFF )

CREATE NONCLUSTERED INDEX [IX_Item_Taxable2] ON [dbo].[Item] 
(
	[Taxable2] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]


IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Item]') AND name = N'IX_Item_Taxable3')
DROP INDEX [IX_Item_Taxable3] ON [dbo].[Item] WITH ( ONLINE = OFF )

CREATE NONCLUSTERED INDEX [IX_Item_Taxable3] ON [dbo].[Item] 
(
	[Taxable3] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]


IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Item]') AND name = N'IX_Item_TaxRate1')
DROP INDEX [IX_Item_TaxRate1] ON [dbo].[Item] WITH ( ONLINE = OFF )

CREATE NONCLUSTERED INDEX [IX_Item_TaxRate1] ON [dbo].[Item] 
(
	[TaxRate1] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]

IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Item]') AND name = N'IX_Item_TaxRate2')
DROP INDEX [IX_Item_TaxRate2] ON [dbo].[Item] WITH ( ONLINE = OFF )

CREATE NONCLUSTERED INDEX [IX_Item_TaxRate2] ON [dbo].[Item] 
(
	[TaxRate2] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]


IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Item]') AND name = N'IX_Item_TaxRate3')
DROP INDEX [IX_Item_TaxRate3] ON [dbo].[Item] WITH ( ONLINE = OFF )

CREATE NONCLUSTERED INDEX [IX_Item_TaxRate3] ON [dbo].[Item] 
(
	[TaxRate3] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]


IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Item]') AND name = N'IX_Item_TaxTotal1')
DROP INDEX [IX_Item_TaxTotal1] ON [dbo].[Item] WITH ( ONLINE = OFF )

CREATE NONCLUSTERED INDEX [IX_Item_TaxTotal1] ON [dbo].[Item] 
(
	[TaxTotal1] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]

IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Item]') AND name = N'IX_Item_TaxTotal2')
DROP INDEX [IX_Item_TaxTotal2] ON [dbo].[Item] WITH ( ONLINE = OFF )

CREATE NONCLUSTERED INDEX [IX_Item_TaxTotal2] ON [dbo].[Item] 
(
	[TaxTotal2] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]


IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Item]') AND name = N'IX_Item_TaxTotal3')
DROP INDEX [IX_Item_TaxTotal3] ON [dbo].[Item] WITH ( ONLINE = OFF )

CREATE NONCLUSTERED INDEX [IX_Item_TaxTotal3] ON [dbo].[Item] 
(
	[TaxTotal3] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]


IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Item]') AND name = N'IX_Item_QtyDecimal')
DROP INDEX [IX_Item_QtyDecimal] ON [dbo].[Item] WITH ( ONLINE = OFF )

CREATE NONCLUSTERED INDEX [IX_Item_QtyDecimal] ON [dbo].[Item] 
(
	[QtyDecimal] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]







CREATE TABLE [dbo].[Trans](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[TransType] [smallint] NULL CONSTRAINT [DF_Trans_TransType]  DEFAULT ((0)),
	[EmployeeID] [int] NULL CONSTRAINT [DF_Trans_EmployeeID]  DEFAULT ((0)),
	[RegisterID] [int] NULL CONSTRAINT [DF_Trans_RegisterID]  DEFAULT ((0)),
	[StoreID] [int] NULL CONSTRAINT [DF_Trans_StoreID]  DEFAULT ((0)),
	[CustomerID] [int] NULL CONSTRAINT [DF_Trans_CustomerID]  DEFAULT ((0)),
	[TransDate] [datetime] NULL,
	[CloseoutID] [int] NULL CONSTRAINT [DF_Trans_CloseoutID]  DEFAULT ((0)),
	[TransNoteNo] [int] NULL CONSTRAINT [DF_Trans_TransNoteNo]  DEFAULT ((0)),
	[CreatedBy] [int] NULL CONSTRAINT [DF_Trans_CreatedBy]  DEFAULT ((0)),
	[CreatedOn] [datetime] NULL,
	[LastChangedBy] [int] NULL CONSTRAINT [DF_Trans_LastChangedBy]  DEFAULT ((0)),
	[LastChangedOn] [datetime] NULL,
	[ChangedByAdmin] [int] NULL,
	[ChangedOnAdmin] [datetime] NULL,
	[TerminalName] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ExpFlag] [char](1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL CONSTRAINT [DF_Trans_ExpFlag]  DEFAULT ('N'),
	[BreakpackFlag] [char](1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL CONSTRAINT [DF_Trans_BreakpackFlag]  DEFAULT ('Y'),
	[StoreCreditAmount] [numeric](15, 3) NULL CONSTRAINT [DF_Trans_StoreCreditAmount]  DEFAULT ((0)),
 CONSTRAINT [PK_Trans] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]


IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Trans]') AND name = N'IX_Trans_CloseoutID')
DROP INDEX [IX_Trans_CloseoutID] ON [dbo].[Trans] WITH ( ONLINE = OFF )

CREATE NONCLUSTERED INDEX [IX_Trans_CloseoutID] ON [dbo].[Trans] 
(
	[CloseoutID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]

IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Trans]') AND name = N'IX_Trans_CustomerID')
DROP INDEX [IX_Trans_CustomerID] ON [dbo].[Trans] WITH ( ONLINE = OFF )

CREATE NONCLUSTERED INDEX [IX_Trans_CustomerID] ON [dbo].[Trans] 
(
	[CustomerID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]


IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Trans]') AND name = N'IX_Trans_EmployeeID')
DROP INDEX [IX_Trans_EmployeeID] ON [dbo].[Trans] WITH ( ONLINE = OFF )

CREATE NONCLUSTERED INDEX [IX_Trans_EmployeeID] ON [dbo].[Trans] 
(
	[EmployeeID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]


IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Trans]') AND name = N'IX_Trans_TransDate')
DROP INDEX [IX_Trans_TransDate] ON [dbo].[Trans] WITH ( ONLINE = OFF )

CREATE NONCLUSTERED INDEX [IX_Trans_TransDate] ON [dbo].[Trans] 
(
	[TransDate] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]

IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Trans]') AND name = N'IX_Trans_TransType')
DROP INDEX [IX_Trans_TransType] ON [dbo].[Trans] WITH ( ONLINE = OFF )

CREATE NONCLUSTERED INDEX [IX_Trans_TransType] ON [dbo].[Trans] 
(
	[TransType] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]


CREATE TABLE [dbo].[CloseOut](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[CloseoutType] [char](1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL CONSTRAINT [DF_CloseOut_CloseoutType]  DEFAULT ('C'),
	[ConsolidatedID] [int] NULL CONSTRAINT [DF_CloseOut_ConsolidatedID]  DEFAULT ((0)),
	[StartDatetime] [datetime] NULL,
	[EndDatetime] [datetime] NULL,
	[Notes] [nvarchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[TransactionCnt] [int] NULL CONSTRAINT [DF_CloseOut_TransactionCnt]  DEFAULT ((0)),
	[CreatedBy] [int] NULL CONSTRAINT [DF_CloseOut_CreatedBy]  DEFAULT ((0)),
	[ChangedBy] [int] NULL CONSTRAINT [DF_CloseOut_ChangedBy]  DEFAULT ((0)),
	[TerminalName] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
 CONSTRAINT [PK_CloseOut] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]

IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[CloseOut]') AND name = N'IX_CloseOut_CloseoutType')
DROP INDEX [IX_CloseOut_CloseoutType] ON [dbo].[CloseOut] WITH ( ONLINE = OFF )

CREATE NONCLUSTERED INDEX [IX_CloseOut_CloseoutType] ON [dbo].[CloseOut] 
(
	[CloseoutType] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]

IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[CloseOut]') AND name = N'IX_CloseOut_ConsolidatedID')
DROP INDEX [IX_CloseOut_ConsolidatedID] ON [dbo].[CloseOut] WITH ( ONLINE = OFF )

CREATE NONCLUSTERED INDEX [IX_CloseOut_ConsolidatedID] ON [dbo].[CloseOut] 
(
	[ConsolidatedID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]


IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[CloseOut]') AND name = N'IX_CloseOut_CreatedBy')
DROP INDEX [IX_CloseOut_CreatedBy] ON [dbo].[CloseOut] WITH ( ONLINE = OFF )

CREATE NONCLUSTERED INDEX [IX_CloseOut_CreatedBy] ON [dbo].[CloseOut] 
(
	[CreatedBy] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]


IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[CloseOut]') AND name = N'IX_CloseOut_enddatetime')
DROP INDEX [IX_CloseOut_enddatetime] ON [dbo].[CloseOut] WITH ( ONLINE = OFF )

CREATE NONCLUSTERED INDEX [IX_CloseOut_enddatetime] ON [dbo].[CloseOut] 
(
	[EndDatetime] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]


IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[CloseOut]') AND name = N'IX_CloseOut_TransactionCnt')
DROP INDEX [IX_CloseOut_TransactionCnt] ON [dbo].[CloseOut] WITH ( ONLINE = OFF )

CREATE NONCLUSTERED INDEX [IX_CloseOut_TransactionCnt] ON [dbo].[CloseOut] 
(
	[TransactionCnt] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]



CREATE TABLE [dbo].[CloseOutTender](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[CloseOutID] [int] NULL,
	[TenderID] [int] NULL,
	[TenderAmount] [numeric](15, 3) NULL CONSTRAINT [DF_CloseOutTender_TenderAmount]  DEFAULT ((0)),
 CONSTRAINT [PK_CloseOutTender] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]


IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[CloseOutTender]') AND name = N'IX_CloseOutTender_CloseOutID')
DROP INDEX [IX_CloseOutTender_CloseOutID] ON [dbo].[CloseOutTender] WITH ( ONLINE = OFF )

CREATE NONCLUSTERED INDEX [IX_CloseOutTender_CloseOutID] ON [dbo].[CloseOutTender] 
(
	[CloseOutID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]


IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[CloseOutTender]') AND name = N'IX_CloseOutTender_TenderID')
DROP INDEX [IX_CloseOutTender_TenderID] ON [dbo].[CloseOutTender] WITH ( ONLINE = OFF )

CREATE NONCLUSTERED INDEX [IX_CloseOutTender_TenderID] ON [dbo].[CloseOutTender] 
(
	[TenderID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]



CREATE TABLE [dbo].[CloseoutCurrencyCalculator](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[RefID] [int] NULL,
	[Penny] [nvarchar](10) NULL,
	[Nickel] [nvarchar](10) NULL,
	[Dime] [nvarchar](10) NULL,
	[Quarter] [nvarchar](10) NULL,
	[Halve] [nvarchar](10) NULL,
	[One] [nvarchar](10) NULL,
	[Five] [nvarchar](10) NULL,
	[Ten] [nvarchar](10) NULL,
	[Twenty] [nvarchar](10) NULL,
	[Fifty] [nvarchar](10) NULL,
	[Hundred] [nvarchar](10) NULL,
	[Two] [nvarchar](10) NULL,
	[TwoHundred] [nvarchar](10) NULL,
	[FiveHundred] [nvarchar](10) NULL,
	[TwoPenny] [nvarchar](10) NULL,
	[TwentyPenny] [nvarchar](10) NULL,
 CONSTRAINT [PK_CloseoutCurrencyCalculator] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]



CREATE TABLE [dbo].[GiftCert](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[GiftCertID] [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Amount] [numeric](15, 3) NULL CONSTRAINT [DF_GiftCert_Amount]  DEFAULT ((0)),
	[ItemID] [int] NULL CONSTRAINT [DF_GiftCert_ItemID]  DEFAULT ((0)),
	[TenderNo] [int] NULL CONSTRAINT [DF_GiftCert_TenderNo]  DEFAULT ((0)),
	[RegisterID] [smallint] NULL CONSTRAINT [DF_GiftCert_RegisterID]  DEFAULT ((0)),
	[CreatedBy] [int] NULL CONSTRAINT [DF_GiftCert_CreatedBy]  DEFAULT ((0)),
	[CreatedOn] [datetime] NULL,
	[LastChangedBy] [int] NULL CONSTRAINT [DF_GiftCert_LastChangedBy]  DEFAULT ((0)),
	[LastChangedOn] [datetime] NULL,
	[CustomerID] [int] NULL DEFAULT ((0)),
	[IssueStore] [nvarchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[OperateStore] [nvarchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ExpFlag] [char](1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL CONSTRAINT [DF__GiftCert__ExpFla__28D80438]  DEFAULT ('N'),
        [ImportBatch] [int] NULL CONSTRAINT [DF_GiftCert_ImportBatch]  DEFAULT ((0)),
	[ImportOn] [datetime] NULL,
	[COID] [int] NULL DEFAULT ((0)),
 CONSTRAINT [PK_GiftCert] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]

IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[GiftCert]') AND name = N'IX_GiftCert_COID')
DROP INDEX [IX_GiftCert_COID] ON [dbo].[GiftCert] WITH ( ONLINE = OFF )

CREATE NONCLUSTERED INDEX [IX_GiftCert_COID] ON [dbo].[GiftCert] 
(
	[COID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]

IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[GiftCert]') AND name = N'IX_GiftCert_IssueStore')
DROP INDEX [IX_GiftCert_IssueStore] ON [dbo].[GiftCert] WITH ( ONLINE = OFF )

CREATE NONCLUSTERED INDEX [IX_GiftCert_IssueStore] ON [dbo].[GiftCert] 
(
	[IssueStore] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]

IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[GiftCert]') AND name = N'IX_GiftCert_OperateStore')
DROP INDEX [IX_GiftCert_OperateStore] ON [dbo].[GiftCert] WITH ( ONLINE = OFF )

CREATE NONCLUSTERED INDEX [IX_GiftCert_OperateStore] ON [dbo].[GiftCert] 
(
	[OperateStore] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]


CREATE TABLE [dbo].[ItemMatrixOptions](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ItemID] [int] NULL CONSTRAINT [DF_ItemMatrixOptions_ItemID]  DEFAULT ((0)),
	[MatrixOptionID] [int] NULL CONSTRAINT [DF_ItemMatrixOptions_MatrixOptionID]  DEFAULT ((0)),
	[OptionValue1] [nvarchar](30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[OptionValue2] [nvarchar](30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[OptionValue3] [nvarchar](30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[CreatedBy] [int] NULL CONSTRAINT [DF_ItemMatrixOptions_CreatedBy]  DEFAULT ((0)),
	[CreatedOn] [datetime] NULL,
	[LastChangedBy] [int] NULL CONSTRAINT [DF_ItemMatrixOptions_LastChangedBy]  DEFAULT ((0)),
	[LastChangedOn] [datetime] NULL,
 CONSTRAINT [PK_ItemMatrixOptions] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]


IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[ItemMatrixOptions]') AND name = N'IX_ItemMatrixOptions_ItemID')
DROP INDEX [IX_ItemMatrixOptions_ItemID] ON [dbo].[ItemMatrixOptions] WITH ( ONLINE = OFF )

CREATE NONCLUSTERED INDEX [IX_ItemMatrixOptions_ItemID] ON [dbo].[ItemMatrixOptions] 
(
	[ItemID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]

IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[ItemMatrixOptions]') AND name = N'IX_ItemMatrixOptions_MatrixOptionID')
DROP INDEX [IX_ItemMatrixOptions_MatrixOptionID] ON [dbo].[ItemMatrixOptions] WITH ( ONLINE = OFF )

CREATE NONCLUSTERED INDEX [IX_ItemMatrixOptions_MatrixOptionID] ON [dbo].[ItemMatrixOptions] 
(
	[MatrixOptionID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]


CREATE TABLE [dbo].[Layaway](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[DateLayaway] [datetime] NULL,
	[DateDue] [datetime] NULL,
	[DateClosed] [datetime] NULL,
	[CreatedBy] [int] NULL CONSTRAINT [DF_Layaway_CreatedBy]  DEFAULT ((0)),
	[CreatedOn] [datetime] NULL,
	[LastChangedBy] [int] NULL CONSTRAINT [DF_Layaway_LastChangedBy]  DEFAULT ((0)),
	[LastChangedOn] [datetime] NULL,
	[TerminalName] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
 CONSTRAINT [PK_Layaway] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]


CREATE TABLE [dbo].[Laypmts](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[InvoiceNo] [int] NULL CONSTRAINT [DF_Laypmts_InvoiceNo]  DEFAULT ((0)),
	[TransactionNo] [int] NULL CONSTRAINT [DF_Laypmts_TransactionNo]  DEFAULT ((0)),
	[Payment] [numeric](15, 3) NULL CONSTRAINT [DF_Laypmts_Payment]  DEFAULT ((0)),
	[CreatedBy] [int] NULL CONSTRAINT [DF_Laypmts_CreatedBy]  DEFAULT ((0)),
	[CreatedOn] [datetime] NULL,
	[LastChangedBy] [int] NULL CONSTRAINT [DF_Laypmts_LastChangedBy]  DEFAULT ((0)),
	[LastChangedOn] [datetime] NULL,
	[TerminalName] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
 CONSTRAINT [PK_Laypmts] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]


IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Laypmts]') AND name = N'IX_Laypmts_InvoiceNo')
DROP INDEX [IX_Laypmts_InvoiceNo] ON [dbo].[Laypmts] WITH ( ONLINE = OFF )

CREATE NONCLUSTERED INDEX [IX_Laypmts_InvoiceNo] ON [dbo].[Laypmts] 
(
	[InvoiceNo] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]

IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Laypmts]') AND name = N'IX_Laypmts_TransactionNo')
DROP INDEX [IX_Laypmts_TransactionNo] ON [dbo].[Laypmts] WITH ( ONLINE = OFF )

CREATE NONCLUSTERED INDEX [IX_Laypmts_TransactionNo] ON [dbo].[Laypmts] 
(
	[TransactionNo] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]


CREATE TABLE [dbo].[Notes](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[RefID] [int] NOT NULL,
	[RefType] [varchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Note] [nvarchar](150) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[DateTime] [datetime] NULL,
	[SpecialEvent] [char](1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL CONSTRAINT [DF_CustNote_SpecialEvent]  DEFAULT ('N'),
	[ScanFile] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[DocumentFile] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[CreatedBy] [int] NULL,
	[CreatedOn] [datetime] NULL,
	[LastChangedBy] [int] NULL,
	[LastChangedOn] [datetime] NULL,
 CONSTRAINT [PK_CustNote] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]


IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Notes]') AND name = N'IX_Notes_RefID')
DROP INDEX [IX_Notes_RefID] ON [dbo].[Notes] WITH ( ONLINE = OFF )

CREATE NONCLUSTERED INDEX [IX_Notes_RefID] ON [dbo].[Notes] 
(
	[RefID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]

IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Notes]') AND name = N'IX_Notes_RefType')
DROP INDEX [IX_Notes_RefType] ON [dbo].[Notes] WITH ( ONLINE = OFF )

CREATE NONCLUSTERED INDEX [IX_Notes_RefType] ON [dbo].[Notes] 
(
	[RefType] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]



CREATE TABLE [dbo].[SerialDetail](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[SerialHeaderID] [int] NOT NULL CONSTRAINT [DF_SerialDetail_SerialHeaderID]  DEFAULT ((0)),
	[Serial1] [nvarchar](30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Serial2] [nvarchar](30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Serial3] [nvarchar](30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ItemID] [int] NULL CONSTRAINT [DF_SerialDetail_ItemID]  DEFAULT ((0)),
	[CreatedBy] [int] NULL CONSTRAINT [DF_SerialDetail_CreatedBy]  DEFAULT ((0)),
	[CreatedOn] [datetime] NULL,
	[LastChangedBy] [int] NULL CONSTRAINT [DF_SerialDetail_LastChangedBy]  DEFAULT ((0)),
	[LastChangedOn] [datetime] NULL,
	[SoldType] [char](1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL DEFAULT ('I'),
 CONSTRAINT [PK_SerialDetail] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]

IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[SerialDetail]') AND name = N'IX_SerialDetail_ItemID')
DROP INDEX [IX_SerialDetail_ItemID] ON [dbo].[SerialDetail] WITH ( ONLINE = OFF )

CREATE NONCLUSTERED INDEX [IX_SerialDetail_ItemID] ON [dbo].[SerialDetail] 
(
	[ItemID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]


IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[SerialDetail]') AND name = N'IX_SerialDetail_SerialHeaderID')
DROP INDEX [IX_SerialDetail_SerialHeaderID] ON [dbo].[SerialDetail] WITH ( ONLINE = OFF )

CREATE NONCLUSTERED INDEX [IX_SerialDetail_SerialHeaderID] ON [dbo].[SerialDetail] 
(
	[SerialHeaderID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]



CREATE TABLE [dbo].[Suspnded](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[InvoiceNo] [int] NULL,
	[ProductID] [int] NULL,
	[PriceA] [numeric](15, 3) NULL,
	[PriceB] [numeric](15, 3) NULL CONSTRAINT [DF_Table_1__1]  DEFAULT ((0)),
	[PriceC] [numeric](15, 3) NULL CONSTRAINT [DF_Table_1_]  DEFAULT ((0)),
	[PriceOverride] [numeric](15, 3) NULL,
	[SalePrice] [numeric](15, 3) NULL CONSTRAINT [DF_Suspnded_SalePrice]  DEFAULT ((0)),
	[NewPrice] [numeric](15, 3) NULL CONSTRAINT [DF_Suspnded_NewPrice]  DEFAULT ((0)),
	[Qty] [numeric](15, 3) NULL,
	[Cost] [numeric](15, 3) NULL,
	[SKU] [nvarchar](16) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Description] [nvarchar](150) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ProductType] [char](1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[DepartmentID] [int] NULL CONSTRAINT [DF_Suspnded_DepartmentID]  DEFAULT ((0)),
	[CategoryID] [int] NULL CONSTRAINT [DF_Suspnded_CategoryID]  DEFAULT ((0)),
	[TaxID1] [int] NULL CONSTRAINT [DF_Suspnded_TaxID1]  DEFAULT ((0)),
	[TaxID2] [int] NULL CONSTRAINT [DF_Suspnded_TaxID2]  DEFAULT ((0)),
	[TaxID3] [int] NULL CONSTRAINT [DF_Suspnded_TaxID3]  DEFAULT ((0)),
	[Taxable1] [char](1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL CONSTRAINT [DF_Suspnded_Taxable1]  DEFAULT ('N'),
	[Taxable2] [char](1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL CONSTRAINT [DF_Suspnded_Taxable2]  DEFAULT ('N'),
	[Taxable3] [char](1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL CONSTRAINT [DF_Suspnded_Taxable3]  DEFAULT ('N'),
	[TaxRate1] [numeric](15, 3) NULL CONSTRAINT [DF_Suspnded_TaxRate1]  DEFAULT ((0)),
	[TaxRate2] [numeric](15, 3) NULL CONSTRAINT [DF_Suspnded_TaxRate2]  DEFAULT ((0)),
	[TaxRate3] [numeric](15, 3) NULL CONSTRAINT [DF_Suspnded_TaxRate3]  DEFAULT ((0)),
	[UOMCount] [numeric](15, 3) NULL CONSTRAINT [DF_Suspnded_UOMCount]  DEFAULT ((0)),
	[UOMPrice] [numeric](15, 3) NULL CONSTRAINT [DF_Suspnded_UOMPrice]  DEFAULT ((0)),
	[UOMDesc] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[CustomerID] [int] NULL CONSTRAINT [DF_Suspnded_CustomerID]  DEFAULT ((0)),
	[DiscountLevel] [char](1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[DateTimeSuspended] [datetime] NULL,
	[GiftCertID] [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[OnSale] [char](1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL CONSTRAINT [DF_Suspnded_OnSale]  DEFAULT ('N'),
	[FSPaid] [numeric](15, 3) NULL CONSTRAINT [DF_Suspnded_FSPaid]  DEFAULT ((0)),
	[MinimumAge] [smallint] NULL CONSTRAINT [DF_Suspnded_MinimumAge]  DEFAULT ((0)),
	[ReturnedItemID] [int] NULL,
	[MatrixOptionID] [int] NULL CONSTRAINT [DF_Suspnded_MatrixOptionID]  DEFAULT ((0)),
	[OptionValue1] [nvarchar](30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[OptionValue2] [nvarchar](30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[OptionValue3] [nvarchar](30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[CreatedBy] [int] NULL CONSTRAINT [DF_Suspnded_CreatedBy]  DEFAULT ((0)),
	[CreatedOn] [datetime] NULL,
	[LastChangedBy] [int] NULL CONSTRAINT [DF_Suspnded_LastChangedBy]  DEFAULT ((0)),
	[LastChangedOn] [datetime] NULL,
	[CloseoutID] [int] NULL DEFAULT ((0)),

	[ItemIndex] [int] NULL CONSTRAINT [DF_Suspnded_ItemIndex]  DEFAULT ((1)),
	[DiscountID] [int] NULL CONSTRAINT [DF_Suspnded_DiscountID]  DEFAULT ((0)),
	[Discount] [numeric](15, 3) NULL CONSTRAINT [DF_Suspnded_Discount]  DEFAULT ((0)),
	[DiscValue] [numeric](15, 3) NULL CONSTRAINT [DF_Suspnded_DiscValue]  DEFAULT ((0)),
	[DiscountText] [nvarchar](60) NULL CONSTRAINT [DF_Suspnded_DiscountText]  DEFAULT (''),
	[DiscLogic] [char](1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL CONSTRAINT [DF_Suspnded_DiscLogic]  DEFAULT (''),
	[BreakpackFlag] [char](1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL CONSTRAINT [DF_Suspnded_BreakpackFlag]  DEFAULT ('Y'),

	[TaxType1] [int] NULL CONSTRAINT [DF_Suspnded_TaxType1]  DEFAULT ((0)),
	[TaxType2] [int] NULL CONSTRAINT [DF_Suspnded_TaxType2]  DEFAULT ((0)),
	[TaxType3] [int] NULL CONSTRAINT [DF_Suspnded_TaxType3]  DEFAULT ((0)),

	[TaxTotal1] [numeric](15, 3) NULL CONSTRAINT [DF_Suspnded_TaxTotal11]  DEFAULT ((0)),
	[TaxTotal2] [numeric](15, 3) NULL CONSTRAINT [DF_Suspnded_TaxTotal12]  DEFAULT ((0)),
	[TaxTotal3] [numeric](15, 3) NULL CONSTRAINT [DF_Suspnded_TaxTotal13]  DEFAULT ((0)),
	
	[MixMatchID] [int] NULL CONSTRAINT [DF_Suspnded_MixMatchID]  DEFAULT ((0)),
    	[MixMatchType] [char](1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL CONSTRAINT [DF_Suspnded_MixMatchType]  DEFAULT (''),
    	[MixMatchFlag] [char](1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL CONSTRAINT [DF_Suspnded_MixMatchFlag]  DEFAULT ('N'),
    	[MixMatchValue] [numeric](15, 3) NULL CONSTRAINT [DF_Suspnded_MixMatchValue]  DEFAULT ((0)),
    	[MixMatchUnique] [int] NULL CONSTRAINT [DF_Suspnded_MixMatchUnique]  DEFAULT ((0)),
	[MixMatchQty] [int] NULL CONSTRAINT [DF_Suspnded_MixMatchQty]  DEFAULT ((0)),
	[MixMatchLast] [char](1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL CONSTRAINT [DF_Suspnded_MixMatchLast]  DEFAULT ('N'),


    	[FeesID] [int] NULL CONSTRAINT [DF_Suspnded_FeesID]  DEFAULT ((0)),
    	[FeesLogic] [char](1) NULL CONSTRAINT [DF_Suspnded_FeesLogic]  DEFAULT (('')),
    	[FeesValue] [numeric](15, 3) NULL CONSTRAINT [DF_Suspnded_FeesValue]  DEFAULT ((0)),
    	[FeesTaxRate] [numeric](15, 3) NULL CONSTRAINT [DF_Suspnded_FeesTaxRate]  DEFAULT ((0)),
    	[Fees] [numeric](15, 3) NULL CONSTRAINT [DF_Suspnded_Fees]  DEFAULT ((0)),
    	[FeesTax] [numeric](15, 3) NULL CONSTRAINT [DF_Suspnded_FeesTax]  DEFAULT ((0)), 
    	[FeesText] [nvarchar](60) NULL CONSTRAINT [DF_Suspnded_FeesText]  DEFAULT (('')),
	[FeesQty] [char](1) NULL CONSTRAINT [DF_Suspnded_FeesQty]  DEFAULT (('N')),

	[SalePriceID] [int] NULL CONSTRAINT [DF_Suspnded_SalePriceID]  DEFAULT ((0)),

	[DTaxID] [int] NULL CONSTRAINT [DF_Suspnded_DTaxID]  DEFAULT ((0)),
        [DTaxType] [int] NULL CONSTRAINT [DF_Suspnded_DTaxType]  DEFAULT ((0)),
	[DTaxRate] [numeric](15, 3) NULL CONSTRAINT [DF_Suspnded_DTaxRate]  DEFAULT ((0)),
        [DTax] [numeric](15, 3) NULL CONSTRAINT [DF_Suspnded_DTax]  DEFAULT ((0)),
	[EditFlag] [char](1) NULL CONSTRAINT [DF_Suspnded_EditFlag]  DEFAULT (('N')),
	[Notes] [nvarchar](200) NULL CONSTRAINT [DF_Suspnded_Notes]  DEFAULT (('')),
	[QtyDecimal] [int] NULL CONSTRAINT [DF_Suspnded_QtyDecimal]  DEFAULT ((0)),
	[PromptPrice] [char](1) NULL CONSTRAINT [DF_Suspnded_PromptPrice]  DEFAULT (('N')),
	[BuyNGetFreeHeaderID] [int] NULL CONSTRAINT [DF_Suspnded_BuyNGetFreeHeaderID]  DEFAULT ((0)),
	[BuyNGetFreeCategory] [char](1) NULL CONSTRAINT [DF_Suspnded_BuyNGetFreeCategory]  DEFAULT (('X')),
	[BuyNGetFreeName] [nvarchar](60) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Age] [int] NULL CONSTRAINT [DF_Suspnded_Age]  DEFAULT ((0)),
	[TaxIncludeRate] [numeric](15, 3) NULL CONSTRAINT [DF_Suspnded_TaxIncludeRate]  DEFAULT ((0)),
	[TaxIncludePrice] [numeric](15, 3) NULL CONSTRAINT [DF_Suspnded_TaxIncludePrice]  DEFAULT ((0)),
[UOM] [nvarchar](15) NULL DEFAULT (('')),
 CONSTRAINT [PK_Suspnded] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]


CREATE TABLE [dbo].[Tender](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[TransactionNo] [int] NULL CONSTRAINT [DF_Tender_TransactionNo]  DEFAULT ((0)),
	[TenderType] [smallint] NULL CONSTRAINT [DF_Tender_TenderType]  DEFAULT ((0)),
	[TenderAmount] [numeric](15, 3) NULL CONSTRAINT [DF_Tender_TenderAmount]  DEFAULT ((0)),
	[CCNumber] [nvarchar](18) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[CCApproval] [nvarchar](6) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[CCReference] [nvarchar](12) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[CreatedBy] [int] NULL CONSTRAINT [DF_Tender_CreatedBy]  DEFAULT ((0)),
	[CreatedOn] [datetime] NULL,
	[LastChangedBy] [int] NULL CONSTRAINT [DF_Tender_LastChangedBy]  DEFAULT ((0)),
	[LastChangedOn] [datetime] NULL,
 CONSTRAINT [PK_Tender] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]


IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Tender]') AND name = N'IX_Tender_TenderAmount')
DROP INDEX [IX_Tender_TenderAmount] ON [dbo].[Tender] WITH ( ONLINE = OFF )

CREATE NONCLUSTERED INDEX [IX_Tender_TenderAmount] ON [dbo].[Tender] 
(
	[TenderAmount] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]

IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Tender]') AND name = N'IX_Tender_TenderType')
DROP INDEX [IX_Tender_TenderType] ON [dbo].[Tender] WITH ( ONLINE = OFF )

CREATE NONCLUSTERED INDEX [IX_Tender_TenderType] ON [dbo].[Tender] 
(
	[TenderType] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]

IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Tender]') AND name = N'IX_Tender_TransactionNo')
DROP INDEX [IX_Tender_TransactionNo] ON [dbo].[Tender] WITH ( ONLINE = OFF )

CREATE NONCLUSTERED INDEX [IX_Tender_TransactionNo] ON [dbo].[Tender] 
(
	[TransactionNo] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]



CREATE TABLE [dbo].[AcctRecv](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[CustomerID] [int] NULL CONSTRAINT [DF_Acct_Recv_CustomerID]  DEFAULT ((0)),
	[InvoiceNo] [int] NULL CONSTRAINT [DF_Acct_Recv_InvoiceNo]  DEFAULT ((0)),
	[Amount] [numeric](15, 3) NULL CONSTRAINT [DF_Acct_Recv_Amount]  DEFAULT ((0)),
	[TranType] [smallint] NULL CONSTRAINT [DF_Acct_Recv_TranType]  DEFAULT ((0)),
	[Date] [datetime] NULL,
	[CreatedBy] [int] NULL CONSTRAINT [DF_Acct_Recv_CreatedBy]  DEFAULT ((0)),
	[CreatedOn] [datetime] NULL,
	[LastChangedBy] [int] NULL CONSTRAINT [DF_Acct_Recv_LastChangedBy]  DEFAULT ((0)),
	[LastChangedOn] [datetime] NULL,
	[IssueStore] [nvarchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[OperateStore] [nvarchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ExpFlag] [char](1) NULL DEFAULT ('N') ,
 CONSTRAINT [PK_Acct_Recv] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]


IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[AcctRecv]') AND name = N'IX_AcctRecv_customerid')
DROP INDEX [IX_AcctRecv_customerid] ON [dbo].[AcctRecv] WITH ( ONLINE = OFF )

CREATE NONCLUSTERED INDEX [IX_AcctRecv_customerid] ON [dbo].[AcctRecv] 
(
	[CustomerID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]


IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[AcctRecv]') AND name = N'IX_AcctRecv_Date')
DROP INDEX [IX_AcctRecv_Date] ON [dbo].[AcctRecv] WITH ( ONLINE = OFF )

CREATE NONCLUSTERED INDEX [IX_AcctRecv_Date] ON [dbo].[AcctRecv] 
(
	[Date] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]


IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[AcctRecv]') AND name = N'IX_AcctRecv_InvoiceNo')
DROP INDEX [IX_AcctRecv_InvoiceNo] ON [dbo].[AcctRecv] WITH ( ONLINE = OFF )

CREATE NONCLUSTERED INDEX [IX_AcctRecv_InvoiceNo] ON [dbo].[AcctRecv] 
(
	[InvoiceNo] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]


IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[AcctRecv]') AND name = N'IX_AcctRecv_IssueStore')
DROP INDEX [IX_AcctRecv_IssueStore] ON [dbo].[AcctRecv] WITH ( ONLINE = OFF )

CREATE NONCLUSTERED INDEX [IX_AcctRecv_IssueStore] ON [dbo].[AcctRecv] 
(
	[IssueStore] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]


IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[AcctRecv]') AND name = N'IX_AcctRecv_OperateStore')
DROP INDEX [IX_AcctRecv_OperateStore] ON [dbo].[AcctRecv] WITH ( ONLINE = OFF )

CREATE NONCLUSTERED INDEX [IX_AcctRecv_OperateStore] ON [dbo].[AcctRecv] 
(
	[OperateStore] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]


IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[AcctRecv]') AND name = N'IX_AcctRecv_TranType')
DROP INDEX [IX_AcctRecv_TranType] ON [dbo].[AcctRecv] WITH ( ONLINE = OFF )

CREATE NONCLUSTERED INDEX [IX_AcctRecv_TranType] ON [dbo].[AcctRecv] 
(
	[TranType] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]


CREATE TABLE [dbo].[StoreCreditTransaction](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[RefCustomer] [int] NOT NULL,
	[TranType] [varchar](30) NOT NULL,
	[TranDate] [datetime] NOT NULL,
	[TranAmount] [numeric](15, 3) NOT NULL,
	[RefInvoice] [int] NULL CONSTRAINT [DF_StoreCreditTransaction_RefInvoice]  DEFAULT ((0)),
	[CreatedBy] [int] NULL CONSTRAINT [DF_StoreCreditTransaction_CreatedBy]  DEFAULT ((0)),
	[CreatedOn] [datetime] NULL,
	[LastChangedBy] [int] NULL CONSTRAINT [DF_StoreCreditTransaction_LastChangedBy]  DEFAULT ((0)),
	[LastChangedOn] [datetime] NULL,
	[IssueStore] [nvarchar](10) NULL,
	[OperateStore] [nvarchar](10) NULL,
	[ExpFlag] [char](1) NULL,
 CONSTRAINT [PK_StoreCreditLog] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]


CREATE TABLE [dbo].[CardTrans](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[CustomerID] [int] NULL CONSTRAINT [DF_CardTrans_CustomerID]  DEFAULT ((0)),
	[EmployeeID] [int] NULL CONSTRAINT [DF_CardTrans_EmployeeID]  DEFAULT ((0)),
	[CardType] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[CardAmount] [numeric](15, 3) NULL CONSTRAINT [DF_CardTrans_CardAmount]  DEFAULT ((0)),
	[TransactionNo] [int] NULL CONSTRAINT [DF_CardTrans_TransactionNo]  DEFAULT ((0)),
	[CreatedBy] [int] NULL CONSTRAINT [DF_CardTrans_CreatedBy]  DEFAULT ((0)),
	[CreatedOn] [datetime] NULL,
	[LastChangedBy] [int] NULL CONSTRAINT [DF_CardTrans_LastChangedBy]  DEFAULT ((0)),
	[LastChangedOn] [datetime] NULL,
	[AuthCode] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Reference] [varchar](150) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[IsDebitCard] [char](1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL DEFAULT ('N'),
	[PaymentGateway] [int] NULL DEFAULT ((1)),
	[MercuryAcqRef] [varchar](200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[MercuryToken] [varchar](150) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[MercuryInvoiceNo] [varchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[IsComplete] [char](1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL DEFAULT ('N'),
	[MercuryProcessData] [varchar](200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[MercuryTranCode] [varchar](40) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[MercuryPurchaseAmount] [numeric](15, 3) NULL DEFAULT ((0)),
	[RefCardAct] [varchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[RefCardMerchID] [varchar](24) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[RefCardLogo] [varchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[RefCardEntry] [varchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[RefCardAuthID] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[RefCardTranID] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[RefCardAuthAmount] [numeric](15, 3) NULL DEFAULT ((0)),
	[TransactionType] [varchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[AdjustFlag] [char](1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL DEFAULT ('N'),
	[MercuryResponseOrigin] [varchar](150) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[MercuryRecordNo] [varchar](150) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[MercuryResponseReturnCode] [varchar](150) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[MercuryTextResponse] [varchar](150) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ReturnAmount] [numeric](15, 3) NULL CONSTRAINT [DF_CardTrans_RReturnAmount]  DEFAULT ((0)),
	[RefCardBalance] [numeric](15, 3) NULL CONSTRAINT [DF_CardTrans_RefCardBalance]  DEFAULT ((0)),
	[TerminalName] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[LogFileName] [varchar](30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,

 CONSTRAINT [PK_CardTrans] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]


IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[CardTrans]') AND name = N'IX_CardTrans_transactionno')
DROP INDEX [IX_CardTrans_transactionno] ON [dbo].[CardTrans] WITH ( ONLINE = OFF )

CREATE NONCLUSTERED INDEX [IX_CardTrans_transactionno] ON [dbo].[CardTrans] 
(
	[TransactionNo] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]


/*
CREATE TABLE [dbo].[StockJournal](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[DocNo] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[DocDate] [datetime] NULL,
	[ProductID] [int] NULL CONSTRAINT [DF_StockJournal_ProductID]  DEFAULT ((0)),
	[TranType] [varchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[TranSubType] [varchar](15) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Qty] [numeric](15, 3) NULL CONSTRAINT [DF_StockJournal_Qty]  DEFAULT ((0)),
	[Cost] [numeric](15, 3) NULL CONSTRAINT [DF_StockJournal_Cost]  DEFAULT ((0)),
	[StockOnHand] [numeric](15, 3) NULL CONSTRAINT [DF_StockJournal_StockOnHand]  DEFAULT ((0)),
	[TerminalName] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[EmpID] [int] NULL,
	[TranDate] [datetime] NULL,
	[Notes] [varchar](250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]

*/

CREATE TABLE [dbo].[WorkOrder](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[InvoiceNo] [int] NULL,
	[ProductID] [int] NULL,
	[PriceA] [numeric](15, 3) NULL CONSTRAINT [DF_WorkOrder_PriceA]  DEFAULT ((0)),
	[PriceB] [numeric](15, 3) NULL CONSTRAINT [DF_WorkOrder_PriceB]  DEFAULT ((0)),
	[PriceC] [numeric](15, 3) NULL CONSTRAINT [DF_WorkOrder_PriceC]  DEFAULT ((0)),
	[PriceOverride] [numeric](15, 3) NULL CONSTRAINT [DF_WorkOrder_PriceOverride]  DEFAULT ((0)),
	[SalePrice] [numeric](15, 3) NULL CONSTRAINT [DF_WorkOrder_SalePrice]  DEFAULT ((0)),
	[NewPrice] [numeric](15, 3) NULL CONSTRAINT [DF_WorkOrder_NewPrice]  DEFAULT ((0)),
	[Qty] [numeric](15, 3) NULL CONSTRAINT [DF_WorkOrder_Qty]  DEFAULT ((0)),
	[Cost] [numeric](15, 3) NULL,
	[SKU] [nvarchar](16) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Description] [nvarchar](150) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ProductType] [char](1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[DepartmentID] [int] NULL CONSTRAINT [DF_WorkOrder_DepartmentID]  DEFAULT ((0)),
	[CategoryID] [int] NULL CONSTRAINT [DF_WorkOrder_CategoryID]  DEFAULT ((0)),
	[TaxID1] [int] NULL CONSTRAINT [DF_WorkOrder_TaxID1]  DEFAULT ((0)),
	[TaxID2] [int] NULL CONSTRAINT [DF_WorkOrder_TaxID2]  DEFAULT ((0)),
	[TaxID3] [int] NULL CONSTRAINT [DF_WorkOrder_TaxID3]  DEFAULT ((0)),
	[Taxable1] [char](1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL CONSTRAINT [DF_WorkOrder_Taxable1]  DEFAULT ('N'),
	[Taxable2] [char](1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL CONSTRAINT [DF_WorkOrder_Taxable2]  DEFAULT ('N'),
	[Taxable3] [char](1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL CONSTRAINT [DF_WorkOrder_Taxable3]  DEFAULT ('N'),
	[TaxRate1] [numeric](15, 3) NULL CONSTRAINT [DF_WorkOrder_TaxRate1]  DEFAULT ((0)),
	[TaxRate2] [numeric](15, 3) NULL CONSTRAINT [DF_WorkOrder_TaxRate2]  DEFAULT ((0)),
	[TaxRate3] [numeric](15, 3) NULL CONSTRAINT [DF_WorkOrder_TaxRate3]  DEFAULT ((0)),
	[UOMCount] [numeric](15, 3) NULL CONSTRAINT [DF_WorkOrder_UOMCount]  DEFAULT ((0)),
	[UOMPrice] [numeric](15, 3) NULL CONSTRAINT [DF_WorkOrder_UOMPrice]  DEFAULT ((0)),
	[UOMDesc] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[MatrixOptionID] [int] NULL CONSTRAINT [DF_WorkOrder_MatrixOptionID]  DEFAULT ((0)),
	[OptionValue1] [nvarchar](30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[OptionValue2] [nvarchar](30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[OptionValue3] [nvarchar](30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[CustomerID] [int] NULL CONSTRAINT [DF_WorkOrder_CustomerID]  DEFAULT ((0)),
	[DiscountLevel] [char](1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[PaymentDate] [datetime] NULL,
	[OnSale] [char](1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL CONSTRAINT [DF_WorkOrder_OnSale]  DEFAULT ('N'),
	[FSPaid] [numeric](15, 3) NULL CONSTRAINT [DF_WorkOrder_FSPaid]  DEFAULT ((0)),
	[MinimumAge] [smallint] NULL CONSTRAINT [DF_WorkOrder_MinimumAge]  DEFAULT ((0)),
	[ReturnedItemID] [int] NULL,
	[CloseoutID] [int] NULL CONSTRAINT [DF_WorkOrder_CloseoutID]  DEFAULT ((0)),
	[CreatedBy] [int] NULL CONSTRAINT [DF_WorkOrder_CreatedBy]  DEFAULT ((0)),
	[CreatedOn] [datetime] NULL,
	[LastChangedBy] [int] NULL CONSTRAINT [DF_WorkOrder_LastChangedBy]  DEFAULT ((0)),
	[LastChangedOn] [datetime] NULL,
	[WorkOrderNo] [int] NULL DEFAULT ((0)),
	[TotalAmount] [numeric](15, 3) NULL DEFAULT ((0)),
	[TaxAmount] [numeric](15, 3) NULL DEFAULT ((0)),
	[ItemIndex] [int] NULL CONSTRAINT [DF_WorkOrder_ItemIndex]  DEFAULT ((1)),
	[DiscountID] [int] NULL CONSTRAINT [DF_WorkOrder_DiscountID]  DEFAULT ((0)),
	[Discount] [numeric](15, 3) NULL CONSTRAINT [DF_WorkOrder_Discount]  DEFAULT ((0)),
	[DiscValue] [numeric](15, 3) NULL CONSTRAINT [DF_WorkOrder_DiscValue]  DEFAULT ((0)),
	[DiscountText] [nvarchar](60) NULL CONSTRAINT [DF_WorkOrder_DiscountText]  DEFAULT (''),
	[DiscLogic] [char](1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL CONSTRAINT [DF_WorkOrder_DiscLogic]  DEFAULT (''),
	[BreakpackFlag] [char](1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL CONSTRAINT [DF_WorkOrder_BreakpackFlag]  DEFAULT ('Y'),
              	[TaxType1] [int] NULL CONSTRAINT [DF_WorkOrder_TaxType1]  DEFAULT ((0)),
	[TaxType2] [int] NULL CONSTRAINT [DF_WorkOrder_TaxType2]  DEFAULT ((0)),
	[TaxType3] [int] NULL CONSTRAINT [DF_WorkOrder_TaxType3]  DEFAULT ((0)),

	[TaxTotal1] [numeric](15, 3) NULL CONSTRAINT [DF_WorkOrder_TaxTotal11]  DEFAULT ((0)),
	[TaxTotal2] [numeric](15, 3) NULL CONSTRAINT [DF_WorkOrder_TaxTotal12]  DEFAULT ((0)),
	[TaxTotal3] [numeric](15, 3) NULL CONSTRAINT [DF_WorkOrder_TaxTotal13]  DEFAULT ((0)),
	[MixMatchID] [int] NULL CONSTRAINT [DF_WorkOrder_MixMatchID]  DEFAULT ((0)),
    	[MixMatchType] [char](1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL CONSTRAINT [DF_WorkOrder_MixMatchType]  DEFAULT (''),
	[MixMatchFlag] [char](1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL CONSTRAINT [DF_WorkOrder_MixMatchFlag]  DEFAULT ('N'),
        	[MixMatchValue] [numeric](15, 3) NULL CONSTRAINT [DF_WorkOrder_MixMatchValue]  DEFAULT ((0)),
        	[MixMatchUnique] [int] NULL CONSTRAINT [DF_WorkOrder_MixMatchUnique]  DEFAULT ((0)),
	[MixMatchQty] [int] NULL CONSTRAINT [DF_WorkOrder_MixMatchQty]  DEFAULT ((0)),
	[MixMatchLast] [char](1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL CONSTRAINT [DF_WorkOrder_MixMatchLast]  DEFAULT ('N'),


    	[FeesID] [int] NULL CONSTRAINT [DF_WorkOrder_FeesID]  DEFAULT ((0)),
	[FeesLogic] [char](1) NULL CONSTRAINT [DF_WorkOrder_FeesLogic]  DEFAULT (('')),
        	[FeesValue] [numeric](15, 3) NULL CONSTRAINT [DF_WorkOrder_FeesValue]  DEFAULT ((0)),
        	[FeesTaxRate] [numeric](15, 3) NULL CONSTRAINT [DF_WorkOrder_FeesTaxRate]  DEFAULT ((0)),
        	[Fees] [numeric](15, 3) NULL CONSTRAINT [DF_WorkOrder_Fees]  DEFAULT ((0)),
        	[FeesTax] [numeric](15, 3) NULL CONSTRAINT [DF_WorkOrder_FeesTax]  DEFAULT ((0)), 
        	[FeesText] [nvarchar](60) NULL CONSTRAINT [DF_WorkOrder_FeesText]  DEFAULT (('')),
	[FeesQty] [char](1) NULL CONSTRAINT [DF_WorkOrder_FeesQty]  DEFAULT (('N')),

	[SalePriceID] [int] NULL CONSTRAINT [DF_WorkOrder_SalePriceID]  DEFAULT ((0)),

	[DTaxID] [int] NULL CONSTRAINT [DF_WorkOrder_DTaxID]  DEFAULT ((0)),
        	[DTaxType] [int] NULL CONSTRAINT [DF_WorkOrder_DTaxType]  DEFAULT ((0)),
	[DTaxRate] [numeric](15, 3) NULL CONSTRAINT [DF_WorkOrder_DTaxRate]  DEFAULT ((0)),
        	[DTax] [numeric](15, 3) NULL CONSTRAINT [DF_WorkOrder_DTax]  DEFAULT ((0)),
	[EditFlag] [char](1) NULL CONSTRAINT [DF_WorkOrder_EditFlag]  DEFAULT (('N')),
	[PromptPrice] [char](1) NULL CONSTRAINT [DF_WorkOrder_PromptPrice]  DEFAULT (('N')),
	[BuyNGetFreeHeaderID] [int] NULL CONSTRAINT [DF_WorkOrder_BuyNGetFreeHeaderID]  DEFAULT ((0)),
	[BuyNGetFreeCategory] [char](1) NULL CONSTRAINT [DF_WorkOrder_BuyNGetFreeCategory]  DEFAULT (('X')),
	[BuyNGetFreeName] [nvarchar](60) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Age] [int] NULL CONSTRAINT [DF_WorkOrder_Age]  DEFAULT ((0)),
	[TaxIncludeRate] [numeric](15, 3) NULL CONSTRAINT [DF_WorkOrder_TaxIncludeRate]  DEFAULT ((0)),
	[TaxIncludePrice] [numeric](15, 3) NULL CONSTRAINT [DF_WorkOrder_TaxIncludePrice]  DEFAULT ((0)),
[UOM] [nvarchar](15) NULL DEFAULT (('')),
 CONSTRAINT [PK_WorkOrder] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]


CREATE TABLE [dbo].[VoidInv](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[InvoiceNo] [int] NOT NULL,
	[VoidBy] [int] NOT NULL,
	[VoidOn] [datetime] NULL,
 CONSTRAINT [PK_VoidInv] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]

IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[VoidInv]') AND name = N'IX_VoidInv_InvoiceNo')
DROP INDEX [IX_VoidInv_InvoiceNo] ON [dbo].[VoidInv] WITH ( ONLINE = OFF )

CREATE NONCLUSTERED INDEX [IX_VoidInv_InvoiceNo] ON [dbo].[VoidInv] 
(
	[InvoiceNo] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]


 CREATE TABLE [dbo].[CardAuthorisation](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[CardType] [varchar](50) NULL,
	[SaleTranNo] [varchar](50) NULL,
	[CancelTranNo] [varchar](50) NULL,
	[InvoiceNo] [int] NULL,
	[InvoiceAmount] [numeric](15, 3) NULL,
	[SaleOn] [datetime] NULL,
	[SaleBy] [int] NULL,
	[CancelOn] [datetime] NULL,
	[CancelBy] [int] NULL,
	[AuthorisedOn] [datetime] NULL,
	[AuthorisedBy] [int] NULL,
	[CompleteOn] [datetime] NULL,
	[CompleteBy] [int] NULL,
	[BatchFlag] [char](1) NULL default 'N',
	[TipAmount] [numeric](15,3) default 0,
	[AuthorisedTranNo] [varchar](50) NULL,
	[CompleteTranNo] [varchar](50) NULL,
 CONSTRAINT [PK_CardAuthorisation] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]

 Update Customer Set StoreCredit=0, TotalPurchases=0, DateLastPurchase=NULL, AmountLastPurchase=0 ;
 Update Employee Set TotalSales=0;
 Update product set QtyOnLayaway = 0;
 Update product set QtyOnHand = 0;
 Update product set expflag = 'N';
 Update matrix Set QtyOnHand=0;

 delete from stockjournal where transubtype <> 'Opening Stock';

    declare sc1 cursor
    for select p.ID, p.producttype, j.qty from stockjournal j left outer join product p on j.productid = p.ID 

    open sc1
    fetch next from sc1 into @pid,@ptype,@qty
    while @@fetch_status = 0 begin

      if @ptype = 'M' delete from stockjournal where productID = @pid
      
      if @ptype <> 'M' Update product Set QtyOnHand=@qty,expflag='N' where id =  @pid

      fetch next from sc1 into @pid,@ptype,@qty
    end
    close sc1
    deallocate sc1 	

 set @ReturnID = 0; 
 return 0;

end

