 --Add NotPaid column in Invoice table if not exists
IF NOT EXISTS (
    SELECT 1
    FROM sys.columns
    WHERE Name = 'NotPaid'
      AND Object_ID = Object_ID('[Retail2020DB].[dbo].[Invoice]')
)
BEGIN
    ALTER TABLE [Retail2020DB].[dbo].[Invoice]
    ADD [NotPaid] CHAR(1) NULL;
END

------------------------------------------------------------------------------------------------
 --Insert Pending Payments function if not exists
IF NOT EXISTS (SELECT 1 FROM [dbo].[POSFunctionSetup] WHERE [FunctionName] = 'Pending Payments')
BEGIN
    INSERT INTO [dbo].[POSFunctionSetup]
        ([FunctionType], [FunctionName], [DisplayOrder], [IsVisible], [FunctionDescription], [CreatedBy], [CreatedOn], [LastChangedBy], [LastChangedOn], [ChangedByAdmin], [ChangedOnAdmin])
    VALUES
        ('FunctionButton', 'Pending Payments', 48, 'Y', NULL, 0, GETDATE(), 0, GETDATE(), Null, NULL);
END


------------------------------------------------------------------------------------------------
 --Insert Security Permission if not exists
IF NOT EXISTS (SELECT 1 FROM [dbo].[SecurityPermission] WHERE [SecurityDesc] = 'Access Invoice Screen')
BEGIN
    INSERT INTO [dbo].[SecurityPermission]
        ([SlNo], [GroupSlNo], [SecurityGroup], [SecurityCode], [SecurityDesc], [CreatedOn])
    VALUES
        (42, 1, 'View', '1z2', 'Access Invoice Screen', GETDATE());
END


--------------------------------------------------------------------------------------------------
-- Create TradeCustomers table if not exists
IF NOT EXISTS (
    SELECT 1 
    FROM sys.objects 
    WHERE object_id = OBJECT_ID(N'[dbo].[TradeCustomers]') 
      AND type = 'U'
)
BEGIN
    CREATE TABLE [dbo].[TradeCustomers] (
        TradeCustomerId INT IDENTITY PRIMARY KEY,
        CustomerID INT NOT NULL,
        CompanyName VARCHAR(200) NOT NULL,
        ContactPerson VARCHAR(150),
        Email VARCHAR(150),
        Phone VARCHAR(50),
        BillingAddress NVARCHAR(60),
		ShippingAddress NVARCHAR(60),
        VatNumber VARCHAR(50),
        CreditLimit DECIMAL(18,2) NOT NULL DEFAULT 0,
        PaymentTermsDays INT NOT NULL DEFAULT 0,
        Status VARCHAR(20) NOT NULL, -- Active / OnHold
		CompanySignature VARBINARY(MAX) NULL,
        CreatedOn DATETIME DEFAULT GETDATE(),
        CreatedBy INT NOT NULL,
        LastChangedOn DATETIME DEFAULT GETDATE(),
        LastChangedBy INT NOT NULL
    );
END
GO

------------------------------------------------------------
-- Create TradeInvoices table if not exists
IF NOT EXISTS (
    SELECT 1 
    FROM sys.objects 
    WHERE object_id = OBJECT_ID(N'[dbo].[TradeInvoices]') 
      AND type = 'U'
)
BEGIN
    CREATE TABLE [dbo].[TradeInvoices] (
        TradeInvoiceId INT IDENTITY PRIMARY KEY,
        InvoiceNo VARCHAR(30) NOT NULL,
        InvoiceVersion INT NOT NULL,
		TransactionNo INT NOT NULL,
        TradeCustomerId INT NOT NULL,
        InvoiceDate DATETIME NOT NULL,
        DueDate DATETIME NOT NULL,
        NetTotal DECIMAL(18,2) NOT NULL,
        VatTotal DECIMAL(18,2) NOT NULL,
        GrossTotal DECIMAL(18,2) NOT NULL,
        Status VARCHAR(20) NOT NULL,       --Unpaid, Partially Paid, Paid
        TemplateId INT NOT NULL,
        TemplateVersion INT NOT NULL,
        SupersededInvoiceId INT NULL,
		BillingAddress NVARCHAR(MAX) NULL,
		ShippingAddress  NVARCHAR(60) NULL,
		CompanyName VARCHAR(200) NULL,
		Phone VARCHAR(50) NULL,
		Email VARCHAR(150) NULL,
		Notes NVARCHAR(MAX) NULL,
        Terms NVARCHAR(MAX) NULL,
        PaymentTermsDays INT NULL,
        CreatedOn DATETIME DEFAULT GETDATE(),
        CreatedBy INT NOT NULL,
        LastChangedOn DATETIME DEFAULT GETDATE(),
        LastChangedBy INT NOT NULL,
		TradeCloseoutID INT NULL,
        IsClosedInZReport BIT NOT NULL DEFAULT 0
    );
END
GO

------------------------------------------------------------
-- Create TradeInvoiceItems table if not exists
IF NOT EXISTS (
    SELECT 1 
    FROM sys.objects 
    WHERE object_id = OBJECT_ID(N'[dbo].[TradeInvoiceItems]') 
      AND type = 'U'
)
BEGIN
    CREATE TABLE [dbo].[TradeInvoiceItems] (
        InvoiceItemId INT IDENTITY PRIMARY KEY,
        TradeInvoiceId INT NOT NULL,
        ProductId INT NOT NULL,
        Description VARCHAR(300),
        Quantity DECIMAL(18,2) NOT NULL,
        UnitPrice DECIMAL(18,2) NOT NULL,
        VatRate DECIMAL(5,2) NOT NULL,
        LineNet DECIMAL(18,2) NOT NULL,
        LineVat DECIMAL(18,2) NOT NULL,
        LineTotal DECIMAL(18,2) NOT NULL,
        CreatedOn DATETIME DEFAULT GETDATE(),
        CreatedBy INT NOT NULL,
        LastChangedOn DATETIME DEFAULT GETDATE(),
        LastChangedBy INT NOT NULL,

        CONSTRAINT FK_TradeInvoiceItems_TradeInvoices
            FOREIGN KEY (TradeInvoiceId)
            REFERENCES dbo.TradeInvoices (TradeInvoiceId)
    );
END
GO


------------------------------------------------------------
-- Create TradeInvoiceTemplates table if not exists
IF NOT EXISTS (
    SELECT 1 
    FROM sys.objects 
    WHERE object_id = OBJECT_ID(N'[dbo].[TradeInvoiceTemplates]') 
      AND type = 'U'
)
BEGIN
    CREATE TABLE [dbo].[TradeInvoiceTemplates] (
        TemplateId INT IDENTITY PRIMARY KEY,
        TemplateName VARCHAR(100) NOT NULL,
        IsDefault BIT NOT NULL DEFAULT 0,
        CurrentVersion INT NOT NULL DEFAULT 1,

        -- Basic Header/Footer settings (editable in v1)
        HeaderText VARCHAR(500),
        FooterText VARCHAR(500),
        ShowLogo BIT DEFAULT 1,
        CreatedOn DATETIME DEFAULT GETDATE(),
        CreatedBy INT NOT NULL,
        LastChangedOn DATETIME DEFAULT GETDATE(),
        LastChangedBy INT NOT NULL
    );
END
GO

------------------------------------------------------------
-- Create TradeInvoiceTemplateLayout table (for column visibility/order)
IF NOT EXISTS (
    SELECT 1 
    FROM sys.objects 
    WHERE object_id = OBJECT_ID(N'[dbo].[TradeInvoiceTemplateLayout]') 
      AND type = 'U'
)
BEGIN
    CREATE TABLE [dbo].[TradeInvoiceTemplateLayout] (
        LayoutId INT IDENTITY PRIMARY KEY,
        TemplateId INT NOT NULL,
        Version INT NOT NULL, -- Ties specific layout config to a template version
        Section VARCHAR(50) NOT NULL, -- 'Header', 'Items', 'Totals'
        FieldName VARCHAR(50) NOT NULL, -- e.g., 'Description', 'Quantity', 'LineTotal'
        DisplayName VARCHAR(100),
        IsVisible BIT DEFAULT 1,
        DisplayOrder INT NOT NULL,
        CreatedOn DATETIME DEFAULT GETDATE(),
        CONSTRAINT FK_Layout_Template FOREIGN KEY (TemplateId)
            REFERENCES dbo.TradeInvoiceTemplates (TemplateId)
    );
END
GO

------------------------------------------------------------
-- Insert Default Template
IF NOT EXISTS (SELECT 1 FROM [dbo].[TradeInvoiceTemplates])
BEGIN
    INSERT INTO [dbo].[TradeInvoiceTemplates] 
        (TemplateName, IsDefault, CurrentVersion, HeaderText, FooterText, ShowLogo, CreatedBy, LastChangedBy)
    VALUES 
        ('Standard A4 Invoice', 1, 1, 'TAX INVOICE', 'Thank you for your business. Please pay by due date.', 1, 0, 0);
        
    DECLARE @NewTemplateId INT = SCOPE_IDENTITY();
    
    -- Insert default layout for Version 1
    INSERT INTO [dbo].[TradeInvoiceTemplateLayout] (TemplateId, Version, Section, FieldName, DisplayName, IsVisible, DisplayOrder) VALUES
    (@NewTemplateId, 1, 'Items', 'SKU', 'Item Code', 1, 1),
    (@NewTemplateId, 1, 'Items', 'Description', 'Description', 1, 2),
    (@NewTemplateId, 1, 'Items', 'Quantity', 'Qty', 1, 3),
    (@NewTemplateId, 1, 'Items', 'UnitPrice', 'Unit Price', 1, 4),
    (@NewTemplateId, 1, 'Items', 'VatRate', 'VAT %', 1, 5),
    (@NewTemplateId, 1, 'Items', 'LineTotal', 'Total', 1, 6);
END
GO

------------------------------------------------------------
-- Create TradeTrans table if not exists
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TradeTrans]') AND type = 'U')
BEGIN
    CREATE TABLE [dbo].[TradeTrans](
        [ID] [int] IDENTITY(1,1) NOT NULL PRIMARY KEY,
        [TransType] [int] NULL,
        [EmployeeID] [int] NULL,
        [RegisterID] [int] NULL,
        [StoreID] [int] NULL,
        [CustomerID] [int] NULL,
        [TransDate] [datetime] NULL,
        [CloseoutID] [int] NULL,
        [TransNoteNo] [int] NULL,
        [CreatedBy] [int] NULL,
        [CreatedOn] [datetime] NULL,
        [LastChangedBy] [int] NULL,
        [LastChangedOn] [datetime] NULL,
        [ChangedByAdmin] [int] NULL,
        [ChangedOnAdmin] [datetime] NULL,
        [TerminalName] [nvarchar](50) NULL,
        [ExpFlag] [char](1) NULL,
        [BreakpackFlag] [char](1) NULL,
        [StoreCreditAmount] [decimal](18, 2) NULL,
		[TradeCloseoutID] [int] NULL
    )
END
GO

------------------------------------------------------------
-- Create TradeCustomerCreditJournal table if not exists
IF NOT EXISTS (
    SELECT 1 
    FROM sys.objects 
    WHERE object_id = OBJECT_ID(N'[dbo].[TradeCustomerCreditJournal]') 
      AND type = 'U'
)
BEGIN
    CREATE TABLE [dbo].[TradeCustomerCreditJournal](
        [ID] INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
        [DocNo] NVARCHAR(50) NULL,
        [DocDate] DATETIME NULL,
        [TradeCustomerId] NVARCHAR(50) NOT NULL,
        [TranType] NVARCHAR(50) NULL,
        [TranSubType] NVARCHAR(50) NULL,
        [Amount] DECIMAL(18, 3) NULL,
        [NewLimit] DECIMAL(18, 3) NULL,
        [TerminalName] NVARCHAR(50) NULL,
        [EmpID] INT NULL,
        [TranDate] DATETIME DEFAULT GETDATE(),
        [Notes] NVARCHAR(MAX) NULL,
		[TradeCloseoutID] INT NULL
    );
END
GO

------------------------------------------------------------
-- Insert Trade Invoices function if not exists
IF NOT EXISTS (SELECT 1 FROM [dbo].[POSFunctionSetup] WHERE [FunctionName] = 'Trade Invoices')
BEGIN
    INSERT INTO [dbo].[POSFunctionSetup]
        ([FunctionType], [FunctionName], [DisplayOrder], [IsVisible], [FunctionDescription], [CreatedBy], [CreatedOn], [LastChangedBy], [LastChangedOn], [ChangedByAdmin], [ChangedOnAdmin])
    VALUES
        ('FunctionButton', 'Trade Invoices', 49, 'Y', NULL, 0, GETDATE(), 0, GETDATE(), NULL, NULL);
END

------------------------------------------------------------
-- Insert Security Permission if you want to control access
IF NOT EXISTS (SELECT 1 FROM [dbo].[SecurityPermission] WHERE [SecurityDesc] = 'Access Trade Invoices Screen')
BEGIN
    INSERT INTO [dbo].[SecurityPermission]
        ([SlNo], [GroupSlNo], [SecurityGroup], [SecurityCode], [SecurityDesc], [CreatedOn])
    VALUES
        (43, 1, 'View', '1z3', 'Access Trade Invoices Screen', GETDATE());
END

------------------------------------------------------------
-- Create TradeCloseoutHeader table if not exists
IF NOT EXISTS (
    SELECT 1 
    FROM sys.objects 
    WHERE object_id = OBJECT_ID(N'[dbo].[TradeCloseoutHeader]') 
      AND type = 'U'
)
BEGIN
    CREATE TABLE [dbo].[TradeCloseoutHeader](
        [ID] INT IDENTITY(1,1) NOT NULL,
        [RetailCloseoutID] INT NULL,
        [TerminalName] NVARCHAR(50) NULL,
        [EmployeeID] INT NULL,
        [StartTime] DATETIME NULL,
        [EndTime] DATETIME NULL,
        [IsZReport] BIT DEFAULT 0,
        [TotalNet] DECIMAL(18, 2) DEFAULT 0,
        [TotalVat] DECIMAL(18, 2) DEFAULT 0,
        [TotalGross] DECIMAL(18, 2) DEFAULT 0,
        [InvoiceCount] INT DEFAULT 0,
        CONSTRAINT [PK_TradeCloseoutHeader] PRIMARY KEY CLUSTERED ([ID] ASC)
    );
END
GO

------------------------------------------------------------
-- Create TradeCloseoutTender table if not exists
IF NOT EXISTS (
    SELECT 1 
    FROM sys.objects 
    WHERE object_id = OBJECT_ID(N'[dbo].[TradeCloseoutTender]') 
      AND type = 'U'
)
BEGIN
    CREATE TABLE [dbo].[TradeCloseoutTender](
        [ID] INT IDENTITY(1,1) NOT NULL,
        [TradeCloseoutID] INT NOT NULL,
        [TenderName] NVARCHAR(50) NULL,
        [Amount] DECIMAL(18, 2) DEFAULT 0,
        [TenderCount] INT DEFAULT 0,
        CONSTRAINT [PK_TradeCloseoutTender] PRIMARY KEY CLUSTERED ([ID] ASC),
        CONSTRAINT [FK_TradeCloseoutTender_Header]
            FOREIGN KEY([TradeCloseoutID])
            REFERENCES [dbo].[TradeCloseoutHeader] ([ID]) 
            ON DELETE CASCADE
    );
END
GO

------------------------------------------------------------
-- Create TradeCloseoutCustomerSummary table if not exists
IF NOT EXISTS (
    SELECT 1 
    FROM sys.objects 
    WHERE object_id = OBJECT_ID(N'[dbo].[TradeCloseoutCustomerSummary]') 
      AND type = 'U'
)
BEGIN
    CREATE TABLE [dbo].[TradeCloseoutCustomerSummary](
        [ID] INT IDENTITY(1,1) NOT NULL,
        [TradeCloseoutID] INT NOT NULL,
        [TradeCustomerID] INT NULL,
        [CompanyName] NVARCHAR(100) NULL,
        [InvoiceCount] INT DEFAULT 0,
        [TotalGross] DECIMAL(18, 2) DEFAULT 0,
        CONSTRAINT [PK_TradeCloseoutCustomerSummary] PRIMARY KEY CLUSTERED ([ID] ASC),
        CONSTRAINT [FK_TradeCloseoutCustomerSummary_Header]
            FOREIGN KEY([TradeCloseoutID])
            REFERENCES [dbo].[TradeCloseoutHeader] ([ID]) 
            ON DELETE CASCADE
    );
END
GO

------------------------------------------------------------
create PROCEDURE [dbo].[sp_GenerateTradeCloseout]
    @TradeCloseoutID INT,
    @IsZReport BIT,
    @EmployeeID INT,
    @TerminalName NVARCHAR(50)
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE 
        @TotalNet DECIMAL(18,2),
        @TotalVat DECIMAL(18,2),
        @TotalGross DECIMAL(18,2),
        @InvCount INT;

    SELECT
        @TotalNet = ISNULL(SUM(NetTotal), 0),
        @TotalVat = ISNULL(SUM(VatTotal), 0),
        @TotalGross = ISNULL(SUM(GrossTotal), 0),
        @InvCount = COUNT(TradeInvoiceId)
    FROM TradeInvoices
    WHERE TradeCloseoutID = @TradeCloseoutID;

    UPDATE TradeCloseoutHeader
    SET
        TotalNet = @TotalNet,
        TotalVat = @TotalVat,
        TotalGross = @TotalGross,
        InvoiceCount = @InvCount
    WHERE ID = @TradeCloseoutID;

    DELETE FROM TradeCloseoutCustomerSummary 
    WHERE TradeCloseoutID = @TradeCloseoutID;

    DELETE FROM TradeCloseoutTender 
    WHERE TradeCloseoutID = @TradeCloseoutID;

    INSERT INTO TradeCloseoutCustomerSummary 
        (TradeCloseoutID, TradeCustomerID, CompanyName, InvoiceCount, TotalGross)
    SELECT 
        @TradeCloseoutID, 
        TradeCustomerID, 
        CompanyName, 
        COUNT(TradeInvoiceId), 
        SUM(GrossTotal)
    FROM TradeInvoices
    WHERE TradeCloseoutID = @TradeCloseoutID
    GROUP BY TradeCustomerID, CompanyName;

    INSERT INTO TradeCloseoutTender 
        (TradeCloseoutID, TenderName, Amount, TenderCount)
    VALUES 
        (@TradeCloseoutID, 'On Account', @TotalGross, @InvCount);

    IF @IsZReport = 1
    BEGIN
        UPDATE TradeCloseoutHeader
        SET EndTime = GETDATE(), IsZReport = 1
        WHERE ID = @TradeCloseoutID;
    END

    SELECT
        @TotalNet as NetSales,
        @TotalVat as VatSales,
        @TotalGross as GrossSales,
        @InvCount as TotalInvoices,
        @TerminalName as Terminal;
END
GO

------------------------------------------------------------
CREATE  PROCEDURE [dbo].[sp_FetchTradeCloseoutID]
    @User INT,
    @TerminalName NVARCHAR(50),
    @ReturnID INT OUTPUT
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @ID INT;

    SELECT @ID = ISNULL(MAX(ID), 0)
    FROM TradeCloseoutHeader
    WHERE TerminalName = @TerminalName
      AND IsZReport = 0;

    IF @ID = 0
    BEGIN
        DECLARE @CurrentRetailID INT;

        EXEC sp_FetchCloseoutID 
            @User, 
            @TerminalName, 
            @ReturnID = @CurrentRetailID OUTPUT;

        INSERT INTO TradeCloseoutHeader (
            RetailCloseoutID,
            TerminalName,
            EmployeeID,
            StartTime,
            IsZReport,
            TotalNet,
            TotalVat,
            TotalGross,
            InvoiceCount
        )
        VALUES (
            @CurrentRetailID,
            @TerminalName,
            @User,
            GETDATE(),
            0,
            0, 0, 0, 0
        );

        SET @ReturnID = SCOPE_IDENTITY();
    END
    ELSE
    BEGIN
        SET @ReturnID = @ID;
    END
END
GO

------------------------------------------------------------
-- 1. Update existing Setup table with global toggle
IF NOT EXISTS (
    SELECT 1
	FROM INFORMATION_SCHEMA.COLUMNS
	WHERE TABLE_NAME = 'Setup'
	AND COLUMN_NAME = 'IsWholesaleActive'
)
BEGIN
   ALTER TABLE Setup
   ADD IsWholesaleActive INT NOT NULL DEFAULT 0;
   PRINT 'Column [IsWholesaleActive] added to [Setup] table.';
END
ELSE
BEGIN
   PRINT 'Column [IsWholesaleActive] already exists in [Setup] table.';
END



------------------------------------------------------------
-- 2. Create TradeStoreInfo table if it does not exist
IF NOT EXISTS (
SELECT 1
FROM sys.tables
WHERE name = 'TradeStoreInfo'
)
BEGIN
   CREATE TABLE TradeStoreInfo (
   ID INT IDENTITY(1,1) PRIMARY KEY,
WSBankName NVARCHAR(100),
WSAccountNo NVARCHAR(50),
WSSortCode NVARCHAR(20),
WSTerms NVARCHAR(MAX),
WSNotes NVARCHAR(MAX),
LastChanged DATETIME NOT NULL DEFAULT GETDATE(),
        ShowBankDetails BIT DEFAULT 0,
        ShowTerms BIT DEFAULT 0,
        ShowNotes BIT DEFAULT 0 
);

    PRINT 'Table [TradeStoreInfo] created successfully.';
END
ELSE
BEGIN
    PRINT 'Table [TradeStoreInfo] already exists.';
END
GO


------------------------------------------------------------
-- Seed initial data for TradeStoreInfo
-- Ensures UPDATE statements always have a row
IF NOT EXISTS (SELECT 1 FROM TradeStoreInfo)
BEGIN
     INSERT INTO TradeStoreInfo
	 (WSBankName, WSAccountNo, WSSortCode, WSTerms, WSNotes)
	 VALUES
	 ('', '', '', '', '');

    PRINT 'Initial record seeded into [TradeStoreInfo].';
END
ELSE
BEGIN
    PRINT 'TradeStoreInfo already contains data.';
END
GO


------------------------------------------------------------
-- Safety update (for older databases)
-- UPDATE Setup
-- SET IsWholesaleActive = 0
-- WHERE IsWholesaleActive IS NULL;


------------------------------------------------------------
-- Create TradeTender table if not exists
IF NOT EXISTS (
    SELECT 1 
    FROM sys.objects 
    WHERE object_id = OBJECT_ID(N'[dbo].[TradeTender]') 
      AND type = 'U'
)
BEGIN
    CREATE TABLE [dbo].[TradeTender](
        [ID] INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
        [TransactionNo] INT NULL,
        [TenderType] SMALLINT NULL,
        [TenderAmount] NUMERIC(15, 3) NULL,
        [CCNumber] NVARCHAR(18) NULL,
        [CCApproval] NVARCHAR(6) NULL,
        [CCReference] NVARCHAR(12) NULL,
        [CreatedBy] INT NULL,
        [CreatedOn] DATETIME NULL,
        [LastChangedBy] INT NULL,
        [LastChangedOn] DATETIME NULL
    );
END
GO

------------------------------------------------------------
-- Create or Alter sp_GenerateTradeCloseout (UPDATED WITH PAID FILTER)
CREATE OR ALTER PROCEDURE [dbo].[sp_GenerateTradeCloseout]
    @TradeCloseoutID INT,
    @IsZReport BIT,
    @EmployeeID INT,
    @TerminalName NVARCHAR(50)
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE 
        @TotalNet DECIMAL(18,2),
        @TotalVat DECIMAL(18,2),
        @TotalGross DECIMAL(18,2),
        @InvCount INT;

    -- 1. Calculate totals ONLY for 'Paid' invoices
    SELECT
        @TotalNet = ISNULL(SUM(NetTotal), 0),
        @TotalVat = ISNULL(SUM(VatTotal), 0),
        @TotalGross = ISNULL(SUM(GrossTotal), 0),
        @InvCount = COUNT(TradeInvoiceId)
    FROM TradeInvoices
    WHERE TradeCloseoutID = @TradeCloseoutID
      AND [Status] = 'Paid';

    -- 2. Update Header totals
    UPDATE TradeCloseoutHeader
    SET
        TotalNet = @TotalNet,
        TotalVat = @TotalVat,
        TotalGross = @TotalGross,
        InvoiceCount = @InvCount
    WHERE ID = @TradeCloseoutID;

    -- 3. REFRESH SNAPSHOTS
    DELETE FROM TradeCloseoutCustomerSummary 
    WHERE TradeCloseoutID = @TradeCloseoutID;

    DELETE FROM TradeCloseoutTender 
    WHERE TradeCloseoutID = @TradeCloseoutID;

    -- Only insert customer summaries for 'Paid' invoices
    INSERT INTO TradeCloseoutCustomerSummary 
        (TradeCloseoutID, TradeCustomerID, CompanyName, InvoiceCount, TotalGross)
    SELECT 
        @TradeCloseoutID, 
        TradeCustomerID, 
        CompanyName, 
        COUNT(TradeInvoiceId), 
        SUM(GrossTotal)
    FROM TradeInvoices
    WHERE TradeCloseoutID = @TradeCloseoutID
      AND [Status] = 'Paid'
    GROUP BY TradeCustomerID, CompanyName;

    -- Tender based on Paid invoices only
    INSERT INTO TradeCloseoutTender 
        (TradeCloseoutID, TenderName, Amount, TenderCount)
    VALUES 
        (@TradeCloseoutID, 'On Account', @TotalGross, @InvCount);

    -- 4. If it's a Z-Report, lock the session
    IF @IsZReport = 1
    BEGIN
        UPDATE TradeCloseoutHeader
        SET EndTime = GETDATE(), IsZReport = 1
        WHERE ID = @TradeCloseoutID;
    END

    -- 5. Final Selection
    SELECT
        @TotalNet as NetSales,
        @TotalVat as VatSales,
        @TotalGross as GrossSales,
        @InvCount as TotalInvoices,
        @TerminalName as Terminal;
END
GO

ALTER PROCEDURE [dbo].[sp_GenerateTradeCloseout]
@TradeCloseoutID INT,
@IsZReport BIT,
@EmployeeID INT,
@TerminalName NVARCHAR(50)
AS
BEGIN
SET NOCOUNT ON;
DECLARE @TotalNet DECIMAL(18,2), @TotalVat DECIMAL(18,2), @TotalGross DECIMAL(18,2), @InvCount INT;

-- 1. Calculate totals for 'Paid' invoices CURRENTLY linked to this session
SELECT
@TotalNet = ISNULL(SUM(NetTotal), 0),
@TotalVat = ISNULL(SUM(VatTotal), 0),
@TotalGross = ISNULL(SUM(GrossTotal), 0),
@InvCount = COUNT(TradeInvoiceId)
FROM TradeInvoices
WHERE TradeCloseoutID = @TradeCloseoutID
AND [Status] = 'Paid';

-- 2. Refresh snapshots for the report UI
DELETE FROM TradeCloseoutCustomerSummary WHERE TradeCloseoutID = @TradeCloseoutID;
DELETE FROM TradeCloseoutTender WHERE TradeCloseoutID = @TradeCloseoutID;

INSERT INTO TradeCloseoutCustomerSummary (TradeCloseoutID, TradeCustomerID, CompanyName, InvoiceCount, TotalGross)
SELECT @TradeCloseoutID, TradeCustomerID, CompanyName, COUNT(TradeInvoiceId), SUM(GrossTotal)
FROM TradeInvoices
WHERE TradeCloseoutID = @TradeCloseoutID AND [Status] = 'Paid'
GROUP BY TradeCustomerID, CompanyName;

INSERT INTO TradeCloseoutTender (TradeCloseoutID, TenderName, Amount, TenderCount)
VALUES (@TradeCloseoutID, 'On Account', @TotalGross, @InvCount);

-- 3. FINALIZATION (Triggered when your C# code sends IsZReport = 1)
IF @IsZReport = 1
BEGIN
-- Lock the Session Header
UPDATE TradeCloseoutHeader
SET TotalNet = @TotalNet, TotalVat = @TotalVat, TotalGross = @TotalGross,
InvoiceCount = @InvCount, EndTime = GETDATE(), IsZReport = 1
WHERE ID = @TradeCloseoutID;

-- STAMP the invoices so we know they were paid at the time of the Z-Report
UPDATE TradeInvoices
SET IsClosedInZReport = 1
WHERE TradeCloseoutID = @TradeCloseoutID AND [Status] = 'Paid';
END

-- 4. Return data for the UI
SELECT @TotalNet as NetSales, @TotalVat as VatSales, @TotalGross as GrossSales,
@InvCount as TotalInvoices, @TerminalName as Terminal;
END