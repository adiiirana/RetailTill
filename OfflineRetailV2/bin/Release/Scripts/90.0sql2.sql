--==========================TaxMapping===============================================
IF NOT EXISTS (
    SELECT 1
    FROM sys.triggers
    WHERE name = 'AfterDeleteTaxMapping'
)
BEGIN
    EXEC('
        CREATE TRIGGER AfterDeleteTaxMapping
        ON TaxMapping
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
                ''TaxMapping'',
                GETDATE(),
                0
            FROM deleted
            WHERE CloudId IS NOT NULL;
        END
    ')
END
GO
--==========================Matrix===============================================
IF NOT EXISTS (
    SELECT 1
    FROM sys.triggers
    WHERE name = 'AfterDeleteMatrix'
)
BEGIN
    EXEC('
        CREATE TRIGGER AfterDeleteMatrix
        ON Matrix
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
                ''Matrix'',
                GETDATE(),
                0
            FROM deleted
            WHERE CloudId IS NOT NULL;
        END
    ')
END
GO
--==========================servicemapping===============================================
IF NOT EXISTS (
    SELECT 1
    FROM sys.triggers
    WHERE name = 'AfterDeleteservicemapping'
)
BEGIN
    EXEC('
        CREATE TRIGGER AfterDeleteservicemapping
        ON servicemapping
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
                ''servicemapping'',
                GETDATE(),
                0
            FROM deleted
            WHERE CloudId IS NOT NULL;
        END
    ')
END
GO

--==========================ExportBookingServiceMapping===============================================
IF NOT EXISTS (
    SELECT 1
    FROM sys.triggers
    WHERE name = 'AfterDeleteExportBookingServiceMapping'
)
BEGIN
    EXEC('
        CREATE TRIGGER AfterDeleteExportBookingServiceMapping
        ON ExportBookingServiceMapping
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
                ''ExportBookingServiceMapping'',
                GETDATE(),
                0
            FROM deleted
            WHERE CloudId IS NOT NULL;
        END
    ')
END
GO
--==========================ProductModifier===============================================
IF NOT EXISTS (
    SELECT 1
    FROM sys.triggers
    WHERE name = 'AfterDeleteProductModifier'
)
BEGIN
    EXEC('
        CREATE TRIGGER AfterDeleteProductModifier
        ON ProductModifier
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
                ''ProductModifier'',
                GETDATE(),
                0
            FROM deleted
            WHERE CloudId IS NOT NULL;
        END
    ')
END
GO
--==========================MatrixOptions===============================================
IF NOT EXISTS (
    SELECT 1
    FROM sys.triggers
    WHERE name = 'AfterDeleteMatrixOptions'
)
BEGIN
    EXEC('
        CREATE TRIGGER AfterDeleteMatrixOptions
        ON MatrixOptions
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
                ''MatrixOptions'',
                GETDATE(),
                0
            FROM deleted
            WHERE CloudId IS NOT NULL;
        END
    ')
END
GO
--==========================Kit===============================================
IF NOT EXISTS (
    SELECT 1
    FROM sys.triggers
    WHERE name = 'AfterDeleteKit'
)
BEGIN
    EXEC('
        CREATE TRIGGER AfterDeleteKit
        ON Kit
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
                ''Kit'',
                GETDATE(),
                0
            FROM deleted
            WHERE CloudId IS NOT NULL;
        END
    ')
END
GO
--==========================StoreCreditTransaction===============================================
IF NOT EXISTS (
    SELECT 1
    FROM sys.triggers
    WHERE name = 'AfterDeleteStoreCreditTransaction'
)
BEGIN
    EXEC('
        CREATE TRIGGER AfterDeleteStoreCreditTransaction
        ON StoreCreditTransaction
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
                ''StoreCreditTransaction'',
                GETDATE(),
                0
            FROM deleted
            WHERE CloudId IS NOT NULL;
        END
    ')
END
GO
--==========================SerialDetail===============================================
IF NOT EXISTS (
    SELECT 1
    FROM sys.triggers
    WHERE name = 'AfterDeleteSerialDetail'
)
BEGIN
    EXEC('
        CREATE TRIGGER AfterDeleteSerialDetail
        ON SerialDetail
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
                ''SerialDetail'',
                GETDATE(),
                0
            FROM deleted
            WHERE CloudId IS NOT NULL;
        END
    ')
END
GO
--==========================CentralExportDiscounts===============================================
IF NOT EXISTS (
    SELECT 1
    FROM sys.triggers
    WHERE name = 'AfterDeleteCentralExportDiscounts'
)
BEGIN
    EXEC('
        CREATE TRIGGER AfterDeleteCentralExportDiscounts
        ON CentralExportDiscounts
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
                ''CentralExportDiscounts'',
                GETDATE(),
                0
            FROM deleted
            WHERE CloudId IS NOT NULL;
        END
    ')
END
GO

--==========================SerialHeader===============================================
IF NOT EXISTS (
    SELECT 1
    FROM sys.triggers
    WHERE name = 'AfterDeleteSerialHeader'
)
BEGIN
    EXEC('
        CREATE TRIGGER AfterDeleteSerialHeader
        ON SerialHeader
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
                ''SerialHeader'',
                GETDATE(),
                0
            FROM deleted
            WHERE CloudId IS NOT NULL;
        END
    ')
END
GO
--==========================MatrixValues===============================================
IF NOT EXISTS (
    SELECT 1
    FROM sys.triggers
    WHERE name = 'AfterDeleteMatrixValues'
)
BEGIN
    EXEC('
        CREATE TRIGGER AfterDeleteMatrixValues
        ON MatrixValues
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
                ''MatrixValues'',
                GETDATE(),
                0
            FROM deleted
            WHERE CloudId IS NOT NULL;
        END
    ')
END
GO

--==========================EmpPassword===============================================
IF NOT EXISTS (
    SELECT 1
    FROM sys.triggers
    WHERE name = 'AfterDeleteEmpPassword'
)
BEGIN
    EXEC('
        CREATE TRIGGER AfterDeleteEmpPassword
        ON EmpPassword
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
                ''EmpPassword'',
                GETDATE(),
                0
            FROM deleted
            WHERE CloudId IS NOT NULL;
        END
    ')
END
GO

--==========================DiscountDate===============================================
IF NOT EXISTS (
    SELECT 1
    FROM sys.triggers
    WHERE name = 'AfterDeleteDiscountDate'
)
BEGIN
    EXEC('
        CREATE TRIGGER AfterDeleteDiscountDate
        ON DiscountDate
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
                ''DiscountDate'',
                GETDATE(),
                0
            FROM deleted
            WHERE CloudId IS NOT NULL;
        END
    ')
END
GO

--==========================DiscountTime===============================================
IF NOT EXISTS (
    SELECT 1
    FROM sys.triggers
    WHERE name = 'AfterDeleteDiscountTime'
)
BEGIN
    EXEC('
        CREATE TRIGGER AfterDeleteDiscountTime
        ON DiscountTime
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
                ''DiscountTime'',
                GETDATE(),
                0
            FROM deleted
            WHERE CloudId IS NOT NULL;
        END
    ')
END
GO
--==========================CardTrans===============================================
IF NOT EXISTS (
    SELECT 1
    FROM sys.triggers
    WHERE name = 'AfterDeleteCardTrans'
)
BEGIN
    EXEC('
        CREATE TRIGGER AfterDeleteCardTrans
        ON CardTrans
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
                ''CardTrans'',
                GETDATE(),
                0
            FROM deleted
            WHERE CloudId IS NOT NULL;
        END
    ')
END
GO
--==========================CentralExportCardAuthorisation===============================================
IF NOT EXISTS (
    SELECT 1
    FROM sys.triggers
    WHERE name = 'AfterDeleteCentralExportCardAuthorisation'
)
BEGIN
    EXEC('
        CREATE TRIGGER AfterDeleteCentralExportCardAuthorisation
        ON CentralExportCardAuthorisation
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
                ''CentralExportCardAuthorisation'',
                GETDATE(),
                0
            FROM deleted
            WHERE CloudId IS NOT NULL;
        END
    ')
END
GO
--==========================CardAuthorisation===============================================
IF NOT EXISTS (
    SELECT 1
    FROM sys.triggers
    WHERE name = 'AfterDeleteCardAuthorisation'
)
BEGIN
    EXEC('
        CREATE TRIGGER AfterDeleteCardAuthorisation
        ON CardAuthorisation
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
                ''CardAuthorisation'',
                GETDATE(),
                0
            FROM deleted
            WHERE CloudId IS NOT NULL;
        END
    ')
END
GO
--==========================Closeout===============================================
IF NOT EXISTS (
    SELECT 1
    FROM sys.triggers
    WHERE name = 'AfterDeleteCloseout'
)
BEGIN
    EXEC('
        CREATE TRIGGER AfterDeleteCloseout
        ON Closeout
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
                ''Closeout'',
                GETDATE(),
                0
            FROM deleted
            WHERE CloudId IS NOT NULL;
        END
    ')
END
GO

