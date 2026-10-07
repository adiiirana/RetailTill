IF EXISTS (
    SELECT 1
    FROM sys.columns
    WHERE Name = 'NotPaid'
      AND Object_ID = Object_ID('[Retail2020DB].[dbo].[Invoice]')
)
BEGIN
    ALTER TABLE [Retail2020DB].[dbo].[Invoice]
    DROP COLUMN [NotPaid];
END

IF EXISTS (
    SELECT 1 
    FROM [dbo].[POSFunctionSetup] 
    WHERE [FunctionName] = 'Pending Payments'
)
BEGIN
    DELETE FROM [dbo].[POSFunctionSetup]
    WHERE [FunctionName] = 'Pending Payments';
END

IF EXISTS (
    SELECT 1 
    FROM [dbo].[SecurityPermission] 
    WHERE [SecurityDesc] = 'Access Invoice Screen'
)
BEGIN
    DELETE FROM [dbo].[SecurityPermission]
    WHERE [SecurityDesc] = 'Access Invoice Screen';
END


-------------------------------------------------------------
IF NOT EXISTS(SELECT 1 FROM sys.columns WHERE Name = N'BankName' AND Object_ID = Object_ID(N'dbo.TradeInvoices'))
BEGIN
   ALTER TABLE [dbo].[TradeInvoices] ADD 
       [BankName] NVARCHAR(100) NULL,
       [AccountNo] NVARCHAR(50) NULL,
       [SortCode] NVARCHAR(20) NULL;
    
   PRINT 'Bank fields added to TradeInvoices table.'
END
ELSE
BEGIN
   PRINT 'Bank fields already exist.'
END
GO