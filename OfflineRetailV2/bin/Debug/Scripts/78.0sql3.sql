USE Retail2020DB
GO
--==========================Dept===============================================
IF NOT EXISTS (
    SELECT 1
    FROM sys.triggers
    WHERE name = 'AfterDeleteDept'
)
BEGIN
    EXEC('
        CREATE TRIGGER AfterDeleteDept
        ON Dept
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
                ''Dept'',
                GETDATE(),
                0
            FROM deleted
            WHERE CloudId IS NOT NULL;
        END
    ')
END
GO

--===============================================================================
--==========================Triggers CategoryTables============================
IF NOT EXISTS (
    SELECT 1
    FROM sys.triggers
    WHERE name = 'AfterDeleteCategory'
)
BEGIN
    EXEC('
        CREATE TRIGGER AfterDeleteCategory
        ON Category
        AFTER DELETE
        AS
        BEGIN
            SET NOCOUNT ON;

            -- Insert deleted row details into log table
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
                ''Category'',
                GETDATE(),
                0
            FROM deleted
            WHERE CloudId IS NOT NULL;
        END
    ')
END
GO
--=============================================================================
--==========================Triggers Product===================================
IF NOT EXISTS (
    SELECT 1
    FROM sys.triggers
    WHERE name = 'AfterDeleteProduct'
)
BEGIN
    EXEC('
        CREATE TRIGGER AfterDeleteProduct
        ON Product
        AFTER DELETE
        AS
        BEGIN
            SET NOCOUNT ON;

            -- Insert deleted row details into log table
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
                ''Product'',
                GETDATE(),
                0
            FROM deleted
            WHERE CloudId IS NOT NULL;
        END
    ')
END
GO
--=============================================================================
--==========================Triggers UOM===================================
IF NOT EXISTS (SELECT 1 FROM sys.triggers WHERE name = 'AfterDeleteUOM')
BEGIN
    EXEC('
        CREATE TRIGGER AfterDeleteUOM
        ON UOM
        AFTER DELETE
        AS
        BEGIN
            SET NOCOUNT ON;

            INSERT INTO DeletedRowsLog
            (TableID, CloudId, TableName, CreatedDate, isPost)
            SELECT ID, CloudId, ''UOM'', GETDATE(), 0
            FROM deleted
            WHERE CloudId IS NOT NULL;
        END
    ')
END
GO

--=============================================================================
--==========================Triggers Customer===================================
IF NOT EXISTS (SELECT 1 FROM sys.triggers WHERE name = 'AfterDeleteCustomer')
BEGIN
    EXEC('
        CREATE TRIGGER AfterDeleteCustomer
        ON Customer
        AFTER DELETE
        AS
        BEGIN
            SET NOCOUNT ON;

            INSERT INTO DeletedRowsLog
            (TableID, CloudId, TableName, CreatedDate, isPost)
            SELECT ID, CloudId, ''Customer'', GETDATE(), 0
            FROM deleted
            WHERE CloudId IS NOT NULL;
        END
    ')
END
GO

--=============================================================================
--==========================Triggers Employee===================================
IF NOT EXISTS (SELECT 1 FROM sys.triggers WHERE name = 'AfterDeleteEmployee')
BEGIN
    EXEC('
        CREATE TRIGGER AfterDeleteEmployee
        ON Employee
        AFTER DELETE
        AS
        BEGIN
            SET NOCOUNT ON;

            INSERT INTO DeletedRowsLog
            (TableID, CloudId, TableName, CreatedDate, isPost)
            SELECT ID, CloudId, ''Employee'', GETDATE(), 0
            FROM deleted
            WHERE CloudId IS NOT NULL;
        END
    ')
END
GO

--=============================================================================
--==========================Triggers Invoice===================================
IF NOT EXISTS (SELECT 1 FROM sys.triggers WHERE name = 'AfterDeleteInvoice')
BEGIN
    EXEC('
        CREATE TRIGGER AfterDeleteInvoice
        ON Invoice
        AFTER DELETE
        AS
        BEGIN
            SET NOCOUNT ON;

            INSERT INTO DeletedRowsLog
            (TableID, CloudId, TableName, CreatedDate, isPost)
            SELECT ID, CloudId, ''Invoice'', GETDATE(), 0
            FROM deleted
            WHERE CloudId IS NOT NULL;
        END
    ')
END
GO

--=============================================================================
--==========================Triggers Item===================================
IF NOT EXISTS (SELECT 1 FROM sys.triggers WHERE name = 'AfterDeleteItem')
BEGIN
    EXEC('
        CREATE TRIGGER AfterDeleteItem
        ON Item
        AFTER DELETE
        AS
        BEGIN
            SET NOCOUNT ON;

            INSERT INTO DeletedRowsLog
            (TableID, CloudId, TableName, CreatedDate, isPost)
            SELECT ID, CloudId, ''Item'', GETDATE(), 0
            FROM deleted
            WHERE CloudId IS NOT NULL;
        END
    ')
END
GO

--=============================================================================
--==========================Triggers Trans===================================
IF NOT EXISTS (SELECT 1 FROM sys.triggers WHERE name = 'AfterDeleteTrans')
BEGIN
    EXEC('
        CREATE TRIGGER AfterDeleteTrans
        ON Trans
        AFTER DELETE
        AS
        BEGIN
            SET NOCOUNT ON;

            INSERT INTO DeletedRowsLog
            (TableID, CloudId, TableName, CreatedDate, isPost)
            SELECT ID, CloudId, ''Trans'', GETDATE(), 0
            FROM deleted
            WHERE CloudId IS NOT NULL;
        END
    ')
END
GO

--=============================================================================
--==========================Triggers TransTypes===================================
IF NOT EXISTS (SELECT 1 FROM sys.triggers WHERE name = 'AfterDeleteTransTypes')
BEGIN
    EXEC('
        CREATE TRIGGER AfterDeleteTransTypes
        ON TransTypes
        AFTER DELETE
        AS
        BEGIN
            SET NOCOUNT ON;

            INSERT INTO DeletedRowsLog
            (TableID, CloudId, TableName, CreatedDate, isPost)
            SELECT ID, CloudId, ''TransTypes'', GETDATE(), 0
            FROM deleted
            WHERE CloudId IS NOT NULL;
        END
    ')
END
GO

--=============================================================================
--==========================Triggers Tender===================================
IF NOT EXISTS (SELECT 1 FROM sys.triggers WHERE name = 'AfterDeleteTender')
BEGIN
    EXEC('
        CREATE TRIGGER AfterDeleteTender
        ON Tender
        AFTER DELETE
        AS
        BEGIN
            SET NOCOUNT ON;

            INSERT INTO DeletedRowsLog
            (TableID, CloudId, TableName, CreatedDate, isPost)
            SELECT ID, CloudId, ''Tender'', GETDATE(), 0
            FROM deleted
            WHERE CloudId IS NOT NULL;
        END
    ')
END
GO

--=============================================================================
--==========================Triggers StockJournal===================================
IF NOT EXISTS (SELECT 1 FROM sys.triggers WHERE name = 'AfterDeleteStockJournal')
BEGIN
    EXEC('
        CREATE TRIGGER AfterDeleteStockJournal
        ON StockJournal
        AFTER DELETE
        AS
        BEGIN
            SET NOCOUNT ON;

            INSERT INTO DeletedRowsLog
            (TableID, CloudId, TableName, CreatedDate, isPost)
            SELECT ID, CloudId, ''StockJournal'', GETDATE(), 0
            FROM deleted
            WHERE CloudId IS NOT NULL;
        END
    ')
END
GO

--=============================================================================
--==========================Triggers TenderTypes===================================
IF NOT EXISTS (SELECT 1 FROM sys.triggers WHERE name = 'AfterDeleteTenderTypes')
BEGIN
    EXEC('
        CREATE TRIGGER AfterDeleteTenderTypes
        ON TenderTypes
        AFTER DELETE
        AS
        BEGIN
            SET NOCOUNT ON;

            INSERT INTO DeletedRowsLog
            (TableID, CloudId, TableName, CreatedDate, isPost)
            SELECT ID, CloudId, ''TenderTypes'', GETDATE(), 0
            FROM deleted
            WHERE CloudId IS NOT NULL;
        END
    ')
END
GO
