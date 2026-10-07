/* Loyalty columns for Customer / Tender (idempotent). No CouponNumber. */

-- Customer.LoyaltyPhoneNumber
IF EXISTS (
    SELECT 1 FROM syscolumns
    WHERE ID = OBJECT_ID('[dbo].[Customer]') AND NAME = 'Loyalty_Phone_Number'
)
AND NOT EXISTS (
    SELECT 1 FROM syscolumns
    WHERE ID = OBJECT_ID('[dbo].[Customer]') AND NAME = 'LoyaltyPhoneNumber'
)
BEGIN
    EXEC sp_rename '[dbo].[Customer].[Loyalty_Phone_Number]', 'LoyaltyPhoneNumber', 'COLUMN';
END
GO

IF EXISTS (
    SELECT 1 FROM syscolumns
    WHERE ID = OBJECT_ID('[dbo].[Customer]') AND NAME = 'Loyalty-Phone-Number'
)
AND NOT EXISTS (
    SELECT 1 FROM syscolumns
    WHERE ID = OBJECT_ID('[dbo].[Customer]') AND NAME = 'LoyaltyPhoneNumber'
)
BEGIN
    EXEC sp_rename '[dbo].[Customer].[Loyalty-Phone-Number]', 'LoyaltyPhoneNumber', 'COLUMN';
END
GO

IF EXISTS (
    SELECT 1 FROM syscolumns
    WHERE ID = OBJECT_ID('[dbo].[Customer]') AND NAME = 'Loyalty Phone Number'
)
AND NOT EXISTS (
    SELECT 1 FROM syscolumns
    WHERE ID = OBJECT_ID('[dbo].[Customer]') AND NAME = 'LoyaltyPhoneNumber'
)
BEGIN
    EXEC sp_rename '[dbo].[Customer].[Loyalty Phone Number]', 'LoyaltyPhoneNumber', 'COLUMN';
END
GO

IF NOT EXISTS (
    SELECT 1 FROM syscolumns
    WHERE ID = OBJECT_ID('[dbo].[Customer]') AND NAME = 'LoyaltyPhoneNumber'
)
BEGIN
    ALTER TABLE [dbo].[Customer] ADD [LoyaltyPhoneNumber] VARCHAR(50) NULL;
END
GO

-- Customer.LoyaltyNumber
IF EXISTS (
    SELECT 1 FROM syscolumns
    WHERE ID = OBJECT_ID('[dbo].[Customer]') AND NAME = 'Loyalty_Number'
)
AND NOT EXISTS (
    SELECT 1 FROM syscolumns
    WHERE ID = OBJECT_ID('[dbo].[Customer]') AND NAME = 'LoyaltyNumber'
)
BEGIN
    EXEC sp_rename '[dbo].[Customer].[Loyalty_Number]', 'LoyaltyNumber', 'COLUMN';
END
GO

IF EXISTS (
    SELECT 1 FROM syscolumns
    WHERE ID = OBJECT_ID('[dbo].[Customer]') AND NAME = 'Loyalty-Number'
)
AND NOT EXISTS (
    SELECT 1 FROM syscolumns
    WHERE ID = OBJECT_ID('[dbo].[Customer]') AND NAME = 'LoyaltyNumber'
)
BEGIN
    EXEC sp_rename '[dbo].[Customer].[Loyalty-Number]', 'LoyaltyNumber', 'COLUMN';
END
GO

IF EXISTS (
    SELECT 1 FROM syscolumns
    WHERE ID = OBJECT_ID('[dbo].[Customer]') AND NAME = 'Loyalty Number'
)
AND NOT EXISTS (
    SELECT 1 FROM syscolumns
    WHERE ID = OBJECT_ID('[dbo].[Customer]') AND NAME = 'LoyaltyNumber'
)
BEGIN
    EXEC sp_rename '[dbo].[Customer].[Loyalty Number]', 'LoyaltyNumber', 'COLUMN';
END
GO

IF NOT EXISTS (
    SELECT 1 FROM syscolumns
    WHERE ID = OBJECT_ID('[dbo].[Customer]') AND NAME = 'LoyaltyNumber'
)
BEGIN
    ALTER TABLE [dbo].[Customer] ADD [LoyaltyNumber] VARCHAR(50) NULL;
END
GO

-- Tender.LoyaltyNumber
IF EXISTS (
    SELECT 1 FROM syscolumns
    WHERE ID = OBJECT_ID('[dbo].[Tender]') AND NAME = 'Loyalty_Number'
)
AND NOT EXISTS (
    SELECT 1 FROM syscolumns
    WHERE ID = OBJECT_ID('[dbo].[Tender]') AND NAME = 'LoyaltyNumber'
)
BEGIN
    EXEC sp_rename '[dbo].[Tender].[Loyalty_Number]', 'LoyaltyNumber', 'COLUMN';
END
GO

IF EXISTS (
    SELECT 1 FROM syscolumns
    WHERE ID = OBJECT_ID('[dbo].[Tender]') AND NAME = 'Loyalty-Number'
)
AND NOT EXISTS (
    SELECT 1 FROM syscolumns
    WHERE ID = OBJECT_ID('[dbo].[Tender]') AND NAME = 'LoyaltyNumber'
)
BEGIN
    EXEC sp_rename '[dbo].[Tender].[Loyalty-Number]', 'LoyaltyNumber', 'COLUMN';
END
GO

IF EXISTS (
    SELECT 1 FROM syscolumns
    WHERE ID = OBJECT_ID('[dbo].[Tender]') AND NAME = 'Loyalty Number'
)
AND NOT EXISTS (
    SELECT 1 FROM syscolumns
    WHERE ID = OBJECT_ID('[dbo].[Tender]') AND NAME = 'LoyaltyNumber'
)
BEGIN
    EXEC sp_rename '[dbo].[Tender].[Loyalty Number]', 'LoyaltyNumber', 'COLUMN';
END
GO

IF NOT EXISTS (
    SELECT 1 FROM syscolumns
    WHERE ID = OBJECT_ID('[dbo].[Tender]') AND NAME = 'LoyaltyNumber'
)
BEGIN
    ALTER TABLE [dbo].[Tender] ADD [LoyaltyNumber] VARCHAR(50) NULL;
END
GO
