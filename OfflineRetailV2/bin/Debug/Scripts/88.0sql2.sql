USE Retail2020DB
GO
--==========================DiscountMaster===============================================
IF NOT EXISTS (
    SELECT 1
    FROM sys.triggers
    WHERE name = 'AfterDeleteDiscountMaster'
)
BEGIN
    EXEC('
        CREATE TRIGGER AfterDeleteDiscountMaster
        ON DiscountMaster
        AFTER DELETE
        AS
        BEGIN
            SET NOCOUNT ON;

            INSERT INTO DeletedRowsLog
            (
                TableID,
                CloudId,
                TableName,
                CreatedDate,
                isPost
            )
            SELECT
                ID,
                CloudId,
                ''DiscountMaster'',
                GETDATE(),
                0
            FROM deleted
            WHERE CloudId IS NOT NULL;
        END
    ')
END
GO
USE Retail2020DB
GO
--==========================TempDiscountID===============================================
IF NOT EXISTS (
    SELECT 1
    FROM sys.triggers
    WHERE name = 'AfterDeleteTempDiscountID'
)
BEGIN
    EXEC('
        CREATE TRIGGER AfterDeleteTempDiscountID
        ON TempDiscountID
        AFTER DELETE
        AS
        BEGIN
            SET NOCOUNT ON;

            INSERT INTO DeletedRowsLog
            (
                TableID,
                CloudId,
                TableName,
                CreatedDate,
                isPost
            )
            SELECT
                ID,
                CloudId,
                ''TempDiscountID'',
                GETDATE(),
                0
            FROM deleted
            WHERE CloudId IS NOT NULL;
        END
    ')
END
GO
USE Retail2020DB
GO
--==========================BuyNGetFreeHeader===============================================
IF NOT EXISTS (
    SELECT 1
    FROM sys.triggers
    WHERE name = 'AfterDeleteBuyNGetFreeHeader'
)
BEGIN
    EXEC('
        CREATE TRIGGER AfterDeleteBuyNGetFreeHeader
        ON BuyNGetFreeHeader
        AFTER DELETE
        AS
        BEGIN
            SET NOCOUNT ON;

            INSERT INTO DeletedRowsLog
            (
                TableID,
                CloudId,
                TableName,
                CreatedDate,
                isPost
            )
            SELECT
                ID,
                CloudId,
                ''BuyNGetFreeHeader'',
                GETDATE(),
                0
            FROM deleted
            WHERE CloudId IS NOT NULL;
        END
    ')
END
GO
USE Retail2020DB
GO
--==========================BuyNGetFreeDetails===============================================
IF NOT EXISTS (
    SELECT 1
    FROM sys.triggers
    WHERE name = 'AfterDeleteBuyNGetFreeDetails'
)
BEGIN
    EXEC('
        CREATE TRIGGER AfterDeleteBuyNGetFreeDetails
        ON BuyNGetFreeDetails
        AFTER DELETE
        AS
        BEGIN
            SET NOCOUNT ON;

            INSERT INTO DeletedRowsLog
            (
                TableID,
                CloudId,
                TableName,
                CreatedDate,
                isPost
            )
            SELECT
                ID,
                CloudId,
                ''BuyNGetFreeDetails'',
                GETDATE(),
                0
            FROM deleted
            WHERE CloudId IS NOT NULL;
        END
    ')
END
GO
USE Retail2020DB
GO
--==========================MixNmatchHeader===============================================
IF NOT EXISTS (
    SELECT 1
    FROM sys.triggers
    WHERE name = 'AfterDeleteMixNmatchHeader'
)
BEGIN
    EXEC('
        CREATE TRIGGER AfterDeleteMixNmatchHeader
        ON MixNmatchHeader
        AFTER DELETE
        AS
        BEGIN
            SET NOCOUNT ON;

            INSERT INTO DeletedRowsLog
            (
                TableID,
                CloudId,
                TableName,
                CreatedDate,
                isPost
            )
            SELECT
                ID,
                CloudId,
                ''MixNmatchHeader'',
                GETDATE(),
                0
            FROM deleted
            WHERE CloudId IS NOT NULL;
        END
    ')
END
GO
USE Retail2020DB
GO
--==========================SalePriceHeader===============================================
IF NOT EXISTS (
    SELECT 1
    FROM sys.triggers
    WHERE name = 'AfterDeleteSalePriceHeader'
)
BEGIN
    EXEC('
        CREATE TRIGGER AfterDeleteSalePriceHeader
        ON SalePriceHeader
        AFTER DELETE
        AS
        BEGIN
            SET NOCOUNT ON;

            INSERT INTO DeletedRowsLog
            (
                TableID,
                CloudId,
                TableName,
                CreatedDate,
                isPost
            )
            SELECT
                ID,
                CloudId,
                ''SalePriceHeader'',
                GETDATE(),
                0
            FROM deleted
            WHERE CloudId IS NOT NULL;
        END
    ')
END
GO
USE Retail2020DB
GO
--==========================SalePriceDetails===============================================
IF NOT EXISTS (
    SELECT 1
    FROM sys.triggers
    WHERE name = 'AfterDeleteSalePriceDetails'
)
BEGIN
    EXEC('
        CREATE TRIGGER AfterDeleteSalePriceDetails
        ON SalePriceDetails
        AFTER DELETE
        AS
        BEGIN
            SET NOCOUNT ON;

            INSERT INTO DeletedRowsLog
            (
                TableID,
                CloudId,
                TableName,
                CreatedDate,
                isPost
            )
            SELECT
                ID,
                CloudId,
                ''SalePriceDetails'',
                GETDATE(),
                0
            FROM deleted
            WHERE CloudId IS NOT NULL;
        END
    ')
END
GO
USE Retail2020DB
GO
--==========================FuturePriceHeader===============================================
IF NOT EXISTS (
    SELECT 1
    FROM sys.triggers
    WHERE name = 'AfterDeleteFuturePriceHeader'
)
BEGIN
    EXEC('
        CREATE TRIGGER AfterDeleteFuturePriceHeader
        ON FuturePriceHeader
        AFTER DELETE
        AS
        BEGIN
            SET NOCOUNT ON;

            INSERT INTO DeletedRowsLog
            (
                TableID,
                CloudId,
                TableName,
                CreatedDate,
                isPost
            )
            SELECT
                ID,
                CloudId,
                ''FuturePriceHeader'',
                GETDATE(),
                0
            FROM deleted
            WHERE CloudId IS NOT NULL;
        END
    ')
END
GO
USE Retail2020DB
GO
--==========================FuturePriceDetails===============================================
IF NOT EXISTS (
    SELECT 1
    FROM sys.triggers
    WHERE name = 'AfterDeleteFuturePriceDetails'
)
BEGIN
    EXEC('
        CREATE TRIGGER AfterDeleteFuturePriceDetails
        ON FuturePriceDetails
        AFTER DELETE
        AS
        BEGIN
            SET NOCOUNT ON;

            INSERT INTO DeletedRowsLog
            (
                TableID,
                CloudId,
                TableName,
                CreatedDate,
                isPost
            )
            SELECT
                ID,
                CloudId,
                ''FuturePriceDetails'',
                GETDATE(),
                0
            FROM deleted
            WHERE CloudId IS NOT NULL;
        END
    ')
END
GO
USE Retail2020DB
GO
--==========================FeesMaster===============================================
IF NOT EXISTS (
    SELECT 1
    FROM sys.triggers
    WHERE name = 'AfterDeleteFeesMaster'
)
BEGIN
    EXEC('
        CREATE TRIGGER AfterDeleteFeesMaster
        ON FeesMaster
        AFTER DELETE
        AS
        BEGIN
            SET NOCOUNT ON;

            INSERT INTO DeletedRowsLog
            (
                TableID,
                CloudId,
                TableName,
                CreatedDate,
                isPost
            )
            SELECT
                ID,
                CloudId,
                ''FeesMaster'',
                GETDATE(),
                0
            FROM deleted
            WHERE CloudId IS NOT NULL;
        END
    ')
END
GO
USE Retail2020DB
GO
--==========================FeesRestrictedItems===============================================
IF NOT EXISTS (
    SELECT 1
    FROM sys.triggers
    WHERE name = 'AfterDeleteFeesRestrictedItems'
)
BEGIN
    EXEC('
        CREATE TRIGGER AfterDeleteFeesRestrictedItems
        ON FeesRestrictedItems
        AFTER DELETE
        AS
        BEGIN
            SET NOCOUNT ON;

            INSERT INTO DeletedRowsLog
            (
                TableID,
                CloudId,
                TableName,
                CreatedDate,
                isPost
            )
            SELECT
                ID,
                CloudId,
                ''FeesRestrictedItems'',
                GETDATE(),
                0
            FROM deleted
            WHERE CloudId IS NOT NULL;
        END
    ')
END
GO
USE Retail2020DB
GO
--==========================SecurityPermission===============================================
IF NOT EXISTS (
    SELECT 1
    FROM sys.triggers
    WHERE name = 'AfterDeleteSecurityPermission'
)
BEGIN
    EXEC('
        CREATE TRIGGER AfterDeleteSecurityPermission
        ON SecurityPermission
        AFTER DELETE
        AS
        BEGIN
            SET NOCOUNT ON;

            INSERT INTO DeletedRowsLog
            (
                TableID,
                CloudId,
                TableName,
                CreatedDate,
                isPost
            )
            SELECT
                ID,
                CloudId,
                ''SecurityPermission'',
                GETDATE(),
                0
            FROM deleted
            WHERE CloudId IS NOT NULL;
        END
    ')
END
GO