-- ============================================================================
-- Migration Script: Add Sync Tracking Columns to All Tables
-- Adds: IsPost, PostDate, IsUpdated, UpdatedDate, CloudId, LastSyncDate
-- Only adds columns if they don't already exist
-- ============================================================================

-- Helper procedure to add column if not exists
IF OBJECT_ID('sp_AddColumnIfNotExists', 'P') IS NOT NULL
    DROP PROCEDURE sp_AddColumnIfNotExists;
GO

CREATE PROCEDURE sp_AddColumnIfNotExists
    @TableName NVARCHAR(128),
    @ColumnName NVARCHAR(128),
    @ColumnDefinition NVARCHAR(MAX)
AS
BEGIN
    IF NOT EXISTS (
        SELECT 1
        FROM INFORMATION_SCHEMA.COLUMNS
        WHERE TABLE_NAME = @TableName
        AND COLUMN_NAME = @ColumnName
    )
    BEGIN
        DECLARE @SQL NVARCHAR(MAX) = N'ALTER TABLE [dbo].[' + @TableName + N'] ADD ' + @ColumnName + N' ' + @ColumnDefinition;
        EXECUTE sp_executesql @SQL;
        PRINT N'✅ Added ' + @ColumnName + N' to ' + @TableName;
    END
    ELSE
    BEGIN
        PRINT N'⏭️  ' + @ColumnName + N' already exists in ' + @TableName;
    END
END;
GO

-- ============================================================================
-- REGISTRATION TABLE
-- ============================================================================
EXEC sp_AddColumnIfNotExists 'Registration', 'IsPost', 'BIT DEFAULT 0';
EXEC sp_AddColumnIfNotExists 'Registration', 'PostDate', 'DATETIME NULL';
EXEC sp_AddColumnIfNotExists 'Registration', 'IsUpdated', 'BIT DEFAULT 0';
EXEC sp_AddColumnIfNotExists 'Registration', 'UpdatedDate', 'DATETIME NULL';
EXEC sp_AddColumnIfNotExists 'Registration', 'CloudId', 'INT NULL';
EXEC sp_AddColumnIfNotExists 'Registration', 'LastSyncDate', 'DATETIME NULL';

-- ============================================================================
-- CASH FLOAT TABLE
-- ============================================================================
EXEC sp_AddColumnIfNotExists 'CashFloat', 'IsPost', 'BIT DEFAULT 0';
EXEC sp_AddColumnIfNotExists 'CashFloat', 'PostDate', 'DATETIME NULL';
EXEC sp_AddColumnIfNotExists 'CashFloat', 'IsUpdated', 'BIT DEFAULT 0';
EXEC sp_AddColumnIfNotExists 'CashFloat', 'UpdatedDate', 'DATETIME NULL';
EXEC sp_AddColumnIfNotExists 'CashFloat', 'CloudId', 'INT NULL';
EXEC sp_AddColumnIfNotExists 'CashFloat', 'LastSyncDate', 'DATETIME NULL';

-- ============================================================================
-- ATTENDANCE INFO TABLE
-- ============================================================================
EXEC sp_AddColumnIfNotExists 'AttendanceInfo', 'IsPost', 'BIT DEFAULT 0';
EXEC sp_AddColumnIfNotExists 'AttendanceInfo', 'PostDate', 'DATETIME NULL';
EXEC sp_AddColumnIfNotExists 'AttendanceInfo', 'IsUpdated', 'BIT DEFAULT 0';
EXEC sp_AddColumnIfNotExists 'AttendanceInfo', 'UpdatedDate', 'DATETIME NULL';
EXEC sp_AddColumnIfNotExists 'AttendanceInfo', 'CloudId', 'INT NULL';
EXEC sp_AddColumnIfNotExists 'AttendanceInfo', 'LastSyncDate', 'DATETIME NULL';

-- ============================================================================
-- SHIFT MASTER TABLE
-- ============================================================================
EXEC sp_AddColumnIfNotExists 'ShiftMaster', 'IsPost', 'BIT DEFAULT 0';
EXEC sp_AddColumnIfNotExists 'ShiftMaster', 'PostDate', 'DATETIME NULL';
EXEC sp_AddColumnIfNotExists 'ShiftMaster', 'IsUpdated', 'BIT DEFAULT 0';
EXEC sp_AddColumnIfNotExists 'ShiftMaster', 'UpdatedDate', 'DATETIME NULL';
EXEC sp_AddColumnIfNotExists 'ShiftMaster', 'CloudId', 'INT NULL';
EXEC sp_AddColumnIfNotExists 'ShiftMaster', 'LastSyncDate', 'DATETIME NULL';

-- ============================================================================
-- HOLIDAY MASTER TABLE
-- ============================================================================
EXEC sp_AddColumnIfNotExists 'HolidayMaster', 'IsPost', 'BIT DEFAULT 0';
EXEC sp_AddColumnIfNotExists 'HolidayMaster', 'PostDate', 'DATETIME NULL';
EXEC sp_AddColumnIfNotExists 'HolidayMaster', 'IsUpdated', 'BIT DEFAULT 0';
EXEC sp_AddColumnIfNotExists 'HolidayMaster', 'UpdatedDate', 'DATETIME NULL';
EXEC sp_AddColumnIfNotExists 'HolidayMaster', 'CloudId', 'INT NULL';
EXEC sp_AddColumnIfNotExists 'HolidayMaster', 'LastSyncDate', 'DATETIME NULL';

-- ============================================================================
-- GIFT CERT TABLE
-- ============================================================================
EXEC sp_AddColumnIfNotExists 'GiftCert', 'IsPost', 'BIT DEFAULT 0';
EXEC sp_AddColumnIfNotExists 'GiftCert', 'PostDate', 'DATETIME NULL';
EXEC sp_AddColumnIfNotExists 'GiftCert', 'IsUpdated', 'BIT DEFAULT 0';
EXEC sp_AddColumnIfNotExists 'GiftCert', 'UpdatedDate', 'DATETIME NULL';
EXEC sp_AddColumnIfNotExists 'GiftCert', 'CloudId', 'INT NULL';
EXEC sp_AddColumnIfNotExists 'GiftCert', 'LastSyncDate', 'DATETIME NULL';

-- ============================================================================
-- CLOSEOUT TABLE
-- ============================================================================
EXEC sp_AddColumnIfNotExists 'CloseOut', 'IsPost', 'BIT DEFAULT 0';
EXEC sp_AddColumnIfNotExists 'CloseOut', 'PostDate', 'DATETIME NULL';
EXEC sp_AddColumnIfNotExists 'CloseOut', 'IsUpdated', 'BIT DEFAULT 0';
EXEC sp_AddColumnIfNotExists 'CloseOut', 'UpdatedDate', 'DATETIME NULL';
EXEC sp_AddColumnIfNotExists 'CloseOut', 'CloudId', 'INT NULL';
EXEC sp_AddColumnIfNotExists 'CloseOut', 'LastSyncDate', 'DATETIME NULL';

-- ============================================================================
-- DBVERSION TABLE
-- ============================================================================
EXEC sp_AddColumnIfNotExists 'Dbversion', 'IsPost', 'BIT DEFAULT 0';
EXEC sp_AddColumnIfNotExists 'Dbversion', 'PostDate', 'DATETIME NULL';
EXEC sp_AddColumnIfNotExists 'Dbversion', 'IsUpdated', 'BIT DEFAULT 0';
EXEC sp_AddColumnIfNotExists 'Dbversion', 'UpdatedDate', 'DATETIME NULL';
EXEC sp_AddColumnIfNotExists 'Dbversion', 'CloudId', 'INT NULL';
EXEC sp_AddColumnIfNotExists 'Dbversion', 'LastSyncDate', 'DATETIME NULL';

-- ============================================================================
-- CDDATASYNC TABLE
-- ============================================================================
EXEC sp_AddColumnIfNotExists 'CddataSync', 'IsPost', 'BIT DEFAULT 0';
EXEC sp_AddColumnIfNotExists 'CddataSync', 'PostDate', 'DATETIME NULL';
EXEC sp_AddColumnIfNotExists 'CddataSync', 'IsUpdated', 'BIT DEFAULT 0';
EXEC sp_AddColumnIfNotExists 'CddataSync', 'UpdatedDate', 'DATETIME NULL';
EXEC sp_AddColumnIfNotExists 'CddataSync', 'CloudId', 'INT NULL';
EXEC sp_AddColumnIfNotExists 'CddataSync', 'LastSyncDate', 'DATETIME NULL';

-- ============================================================================
-- DASHBOARD TABLE
-- ============================================================================
EXEC sp_AddColumnIfNotExists 'Dashboard', 'IsPost', 'BIT DEFAULT 0';
EXEC sp_AddColumnIfNotExists 'Dashboard', 'PostDate', 'DATETIME NULL';
EXEC sp_AddColumnIfNotExists 'Dashboard', 'IsUpdated', 'BIT DEFAULT 0';
EXEC sp_AddColumnIfNotExists 'Dashboard', 'UpdatedDate', 'DATETIME NULL';
EXEC sp_AddColumnIfNotExists 'Dashboard', 'CloudId', 'INT NULL';
EXEC sp_AddColumnIfNotExists 'Dashboard', 'LastSyncDate', 'DATETIME NULL';

-- ============================================================================
-- TRANSTYPE TABLE
-- ============================================================================
EXEC sp_AddColumnIfNotExists 'TransTypes', 'IsPost', 'BIT DEFAULT 0';
EXEC sp_AddColumnIfNotExists 'TransTypes', 'PostDate', 'DATETIME NULL';
EXEC sp_AddColumnIfNotExists 'TransTypes', 'IsUpdated', 'BIT DEFAULT 0';
EXEC sp_AddColumnIfNotExists 'TransTypes', 'UpdatedDate', 'DATETIME NULL';
EXEC sp_AddColumnIfNotExists 'TransTypes', 'CloudId', 'INT NULL';
EXEC sp_AddColumnIfNotExists 'TransTypes', 'LastSyncDate', 'DATETIME NULL';

-- ============================================================================
-- NOTE TABLE
-- ============================================================================
EXEC sp_AddColumnIfNotExists 'Notes', 'IsPost', 'BIT DEFAULT 0';
EXEC sp_AddColumnIfNotExists 'Notes', 'PostDate', 'DATETIME NULL';
EXEC sp_AddColumnIfNotExists 'Notes', 'IsUpdated', 'BIT DEFAULT 0';
EXEC sp_AddColumnIfNotExists 'Notes', 'UpdatedDate', 'DATETIME NULL';
EXEC sp_AddColumnIfNotExists 'Notes', 'CloudId', 'INT NULL';
EXEC sp_AddColumnIfNotExists 'Notes', 'LastSyncDate', 'DATETIME NULL';

-- ============================================================================
-- ORDER HEADER TABLE
-- ============================================================================
EXEC sp_AddColumnIfNotExists 'OrderHeader', 'IsPost', 'BIT DEFAULT 0';
EXEC sp_AddColumnIfNotExists 'OrderHeader', 'PostDate', 'DATETIME NULL';
EXEC sp_AddColumnIfNotExists 'OrderHeader', 'IsUpdated', 'BIT DEFAULT 0';
EXEC sp_AddColumnIfNotExists 'OrderHeader', 'UpdatedDate', 'DATETIME NULL';
EXEC sp_AddColumnIfNotExists 'OrderHeader', 'CloudId', 'INT NULL';
EXEC sp_AddColumnIfNotExists 'OrderHeader', 'LastSyncDate', 'DATETIME NULL';

-- ============================================================================
-- ORDER DETAIL TABLE
-- ============================================================================
EXEC sp_AddColumnIfNotExists 'OrderDetails', 'IsPost', 'BIT DEFAULT 0';
EXEC sp_AddColumnIfNotExists 'OrderDetails', 'PostDate', 'DATETIME NULL';
EXEC sp_AddColumnIfNotExists 'OrderDetails', 'IsUpdated', 'BIT DEFAULT 0';
EXEC sp_AddColumnIfNotExists 'OrderDetails', 'UpdatedDate', 'DATETIME NULL';
EXEC sp_AddColumnIfNotExists 'OrderDetails', 'CloudId', 'INT NULL';
EXEC sp_AddColumnIfNotExists 'OrderDetails', 'LastSyncDate', 'DATETIME NULL';

-- ============================================================================
-- PORT COMMAND TABLE
-- ============================================================================
EXEC sp_AddColumnIfNotExists 'PortCommand', 'IsPost', 'BIT DEFAULT 0';
EXEC sp_AddColumnIfNotExists 'PortCommand', 'PostDate', 'DATETIME NULL';
EXEC sp_AddColumnIfNotExists 'PortCommand', 'IsUpdated', 'BIT DEFAULT 0';
EXEC sp_AddColumnIfNotExists 'PortCommand', 'UpdatedDate', 'DATETIME NULL';
EXEC sp_AddColumnIfNotExists 'PortCommand', 'CloudId', 'INT NULL';
EXEC sp_AddColumnIfNotExists 'PortCommand', 'LastSyncDate', 'DATETIME NULL';

-- ============================================================================
-- APPLICATION LOG TABLE
-- ============================================================================
EXEC sp_AddColumnIfNotExists 'ApplicationLogs', 'IsPost', 'BIT DEFAULT 0';
EXEC sp_AddColumnIfNotExists 'ApplicationLogs', 'PostDate', 'DATETIME NULL';
EXEC sp_AddColumnIfNotExists 'ApplicationLogs', 'IsUpdated', 'BIT DEFAULT 0';
EXEC sp_AddColumnIfNotExists 'ApplicationLogs', 'UpdatedDate', 'DATETIME NULL';
EXEC sp_AddColumnIfNotExists 'ApplicationLogs', 'CloudId', 'INT NULL';
EXEC sp_AddColumnIfNotExists 'ApplicationLogs', 'LastSyncDate', 'DATETIME NULL';

-- ============================================================================
-- ACCT RECV TABLE
-- ============================================================================
EXEC sp_AddColumnIfNotExists 'AcctRecv', 'IsPost', 'BIT DEFAULT 0';
EXEC sp_AddColumnIfNotExists 'AcctRecv', 'PostDate', 'DATETIME NULL';
EXEC sp_AddColumnIfNotExists 'AcctRecv', 'IsUpdated', 'BIT DEFAULT 0';
EXEC sp_AddColumnIfNotExists 'AcctRecv', 'UpdatedDate', 'DATETIME NULL';
EXEC sp_AddColumnIfNotExists 'AcctRecv', 'CloudId', 'INT NULL';
EXEC sp_AddColumnIfNotExists 'AcctRecv', 'LastSyncDate', 'DATETIME NULL';

-- ============================================================================
-- ATTACH TAG TABLE
-- ============================================================================
EXEC sp_AddColumnIfNotExists 'AttachTag', 'IsPost', 'BIT DEFAULT 0';
EXEC sp_AddColumnIfNotExists 'AttachTag', 'PostDate', 'DATETIME NULL';
EXEC sp_AddColumnIfNotExists 'AttachTag', 'IsUpdated', 'BIT DEFAULT 0';
EXEC sp_AddColumnIfNotExists 'AttachTag', 'UpdatedDate', 'DATETIME NULL';
EXEC sp_AddColumnIfNotExists 'AttachTag', 'CloudId', 'INT NULL';
EXEC sp_AddColumnIfNotExists 'AttachTag', 'LastSyncDate', 'DATETIME NULL';

-- ============================================================================
-- APPOINTMENT TABLE
-- ============================================================================
EXEC sp_AddColumnIfNotExists 'Appointments', 'IsPost', 'BIT DEFAULT 0';
EXEC sp_AddColumnIfNotExists 'Appointments', 'PostDate', 'DATETIME NULL';
EXEC sp_AddColumnIfNotExists 'Appointments', 'IsUpdated', 'BIT DEFAULT 0';
EXEC sp_AddColumnIfNotExists 'Appointments', 'UpdatedDate', 'DATETIME NULL';
EXEC sp_AddColumnIfNotExists 'Appointments', 'CloudId', 'INT NULL';
EXEC sp_AddColumnIfNotExists 'Appointments', 'LastSyncDate', 'DATETIME NULL';

-- ============================================================================
-- PRINTER MAPPING TABLE
-- ============================================================================
EXEC sp_AddColumnIfNotExists 'PrinterMapping', 'IsPost', 'BIT DEFAULT 0';
EXEC sp_AddColumnIfNotExists 'PrinterMapping', 'PostDate', 'DATETIME NULL';
EXEC sp_AddColumnIfNotExists 'PrinterMapping', 'IsUpdated', 'BIT DEFAULT 0';
EXEC sp_AddColumnIfNotExists 'PrinterMapping', 'UpdatedDate', 'DATETIME NULL';
EXEC sp_AddColumnIfNotExists 'PrinterMapping', 'CloudId', 'INT NULL';
EXEC sp_AddColumnIfNotExists 'PrinterMapping', 'LastSyncDate', 'DATETIME NULL';

-- ============================================================================
-- PRINTER TABLE
-- ============================================================================
EXEC sp_AddColumnIfNotExists 'Printers', 'IsPost', 'BIT DEFAULT 0';
EXEC sp_AddColumnIfNotExists 'Printers', 'PostDate', 'DATETIME NULL';
EXEC sp_AddColumnIfNotExists 'Printers', 'IsUpdated', 'BIT DEFAULT 0';
EXEC sp_AddColumnIfNotExists 'Printers', 'UpdatedDate', 'DATETIME NULL';
EXEC sp_AddColumnIfNotExists 'Printers', 'CloudId', 'INT NULL';
EXEC sp_AddColumnIfNotExists 'Printers', 'LastSyncDate', 'DATETIME NULL';

-- ============================================================================
-- PRINTER TYPE TABLE
-- ============================================================================
EXEC sp_AddColumnIfNotExists 'PrinterTypes', 'IsPost', 'BIT DEFAULT 0';
EXEC sp_AddColumnIfNotExists 'PrinterTypes', 'PostDate', 'DATETIME NULL';
EXEC sp_AddColumnIfNotExists 'PrinterTypes', 'IsUpdated', 'BIT DEFAULT 0';
EXEC sp_AddColumnIfNotExists 'PrinterTypes', 'UpdatedDate', 'DATETIME NULL';
EXEC sp_AddColumnIfNotExists 'PrinterTypes', 'CloudId', 'INT NULL';
EXEC sp_AddColumnIfNotExists 'PrinterTypes', 'LastSyncDate', 'DATETIME NULL';

-- ============================================================================
-- PRINT LABEL TABLE
-- ============================================================================
EXEC sp_AddColumnIfNotExists 'PrintLabel', 'IsPost', 'BIT DEFAULT 0';
EXEC sp_AddColumnIfNotExists 'PrintLabel', 'PostDate', 'DATETIME NULL';
EXEC sp_AddColumnIfNotExists 'PrintLabel', 'IsUpdated', 'BIT DEFAULT 0';
EXEC sp_AddColumnIfNotExists 'PrintLabel', 'UpdatedDate', 'DATETIME NULL';
EXEC sp_AddColumnIfNotExists 'PrintLabel', 'CloudId', 'INT NULL';
EXEC sp_AddColumnIfNotExists 'PrintLabel', 'LastSyncDate', 'DATETIME NULL';

-- ============================================================================
-- CARD AUTHORISATION TABLE
-- ============================================================================
EXEC sp_AddColumnIfNotExists 'CardAuthorisation', 'IsPost', 'BIT DEFAULT 0';
EXEC sp_AddColumnIfNotExists 'CardAuthorisation', 'PostDate', 'DATETIME NULL';
EXEC sp_AddColumnIfNotExists 'CardAuthorisation', 'IsUpdated', 'BIT DEFAULT 0';
EXEC sp_AddColumnIfNotExists 'CardAuthorisation', 'UpdatedDate', 'DATETIME NULL';
EXEC sp_AddColumnIfNotExists 'CardAuthorisation', 'CloudId', 'INT NULL';
EXEC sp_AddColumnIfNotExists 'CardAuthorisation', 'LastSyncDate', 'DATETIME NULL';

-- ============================================================================
-- VOID INV TABLE
-- ============================================================================
EXEC sp_AddColumnIfNotExists 'VoidInv', 'IsPost', 'BIT DEFAULT 0';
EXEC sp_AddColumnIfNotExists 'VoidInv', 'PostDate', 'DATETIME NULL';
EXEC sp_AddColumnIfNotExists 'VoidInv', 'IsUpdated', 'BIT DEFAULT 0';
EXEC sp_AddColumnIfNotExists 'VoidInv', 'UpdatedDate', 'DATETIME NULL';
EXEC sp_AddColumnIfNotExists 'VoidInv', 'CloudId', 'INT NULL';
EXEC sp_AddColumnIfNotExists 'VoidInv', 'LastSyncDate', 'DATETIME NULL';

-- ============================================================================
-- CARD TRAN TABLE
-- ============================================================================
EXEC sp_AddColumnIfNotExists 'CardTrans', 'IsPost', 'BIT DEFAULT 0';
EXEC sp_AddColumnIfNotExists 'CardTrans', 'PostDate', 'DATETIME NULL';
EXEC sp_AddColumnIfNotExists 'CardTrans', 'IsUpdated', 'BIT DEFAULT 0';
EXEC sp_AddColumnIfNotExists 'CardTrans', 'UpdatedDate', 'DATETIME NULL';
EXEC sp_AddColumnIfNotExists 'CardTrans', 'CloudId', 'INT NULL';
EXEC sp_AddColumnIfNotExists 'CardTrans', 'LastSyncDate', 'DATETIME NULL';

-- ============================================================================
-- CLOSEOUT RETURN TABLE
-- ============================================================================
EXEC sp_AddColumnIfNotExists 'CloseOutReturn', 'IsPost', 'BIT DEFAULT 0';
EXEC sp_AddColumnIfNotExists 'CloseOutReturn', 'PostDate', 'DATETIME NULL';
EXEC sp_AddColumnIfNotExists 'CloseOutReturn', 'IsUpdated', 'BIT DEFAULT 0';
EXEC sp_AddColumnIfNotExists 'CloseOutReturn', 'UpdatedDate', 'DATETIME NULL';
EXEC sp_AddColumnIfNotExists 'CloseOutReturn', 'CloudId', 'INT NULL';
EXEC sp_AddColumnIfNotExists 'CloseOutReturn', 'LastSyncDate', 'DATETIME NULL';

-- ============================================================================
-- CLOSEOUT SALES DEPT TABLE
-- ============================================================================
EXEC sp_AddColumnIfNotExists 'CloseOutSalesDept', 'IsPost', 'BIT DEFAULT 0';
EXEC sp_AddColumnIfNotExists 'CloseOutSalesDept', 'PostDate', 'DATETIME NULL';
EXEC sp_AddColumnIfNotExists 'CloseOutSalesDept', 'IsUpdated', 'BIT DEFAULT 0';
EXEC sp_AddColumnIfNotExists 'CloseOutSalesDept', 'UpdatedDate', 'DATETIME NULL';
EXEC sp_AddColumnIfNotExists 'CloseOutSalesDept', 'CloudId', 'INT NULL';
EXEC sp_AddColumnIfNotExists 'CloseOutSalesDept', 'LastSyncDate', 'DATETIME NULL';

-- ============================================================================
-- CLOSEOUT TENDER TABLE
-- ============================================================================
EXEC sp_AddColumnIfNotExists 'CloseOutTender', 'IsPost', 'BIT DEFAULT 0';
EXEC sp_AddColumnIfNotExists 'CloseOutTender', 'PostDate', 'DATETIME NULL';
EXEC sp_AddColumnIfNotExists 'CloseOutTender', 'IsUpdated', 'BIT DEFAULT 0';
EXEC sp_AddColumnIfNotExists 'CloseOutTender', 'UpdatedDate', 'DATETIME NULL';
EXEC sp_AddColumnIfNotExists 'CloseOutTender', 'CloudId', 'INT NULL';
EXEC sp_AddColumnIfNotExists 'CloseOutTender', 'LastSyncDate', 'DATETIME NULL';

-- ============================================================================
-- CLOSEOUT CURRENCY CALCULATOR TABLE
-- ============================================================================
EXEC sp_AddColumnIfNotExists 'CloseOutCurrencyCalculator', 'IsPost', 'BIT DEFAULT 0';
EXEC sp_AddColumnIfNotExists 'CloseOutCurrencyCalculator', 'PostDate', 'DATETIME NULL';
EXEC sp_AddColumnIfNotExists 'CloseOutCurrencyCalculator', 'IsUpdated', 'BIT DEFAULT 0';
EXEC sp_AddColumnIfNotExists 'CloseOutCurrencyCalculator', 'UpdatedDate', 'DATETIME NULL';
EXEC sp_AddColumnIfNotExists 'CloseOutCurrencyCalculator', 'CloudId', 'INT NULL';
EXEC sp_AddColumnIfNotExists 'CloseOutCurrencyCalculator', 'LastSyncDate', 'DATETIME NULL';

-- ============================================================================
-- CLOSEOUT SALES HOUR TABLE
-- ============================================================================
EXEC sp_AddColumnIfNotExists 'CloseOutSalesHour', 'IsPost', 'BIT DEFAULT 0';
EXEC sp_AddColumnIfNotExists 'CloseOutSalesHour', 'PostDate', 'DATETIME NULL';
EXEC sp_AddColumnIfNotExists 'CloseOutSalesHour', 'IsUpdated', 'BIT DEFAULT 0';
EXEC sp_AddColumnIfNotExists 'CloseOutSalesHour', 'UpdatedDate', 'DATETIME NULL';
EXEC sp_AddColumnIfNotExists 'CloseOutSalesHour', 'CloudId', 'INT NULL';
EXEC sp_AddColumnIfNotExists 'CloseOutSalesHour', 'LastSyncDate', 'DATETIME NULL';

-- ============================================================================
-- CLOSEOUT REPORT TENDER TABLE
-- ============================================================================
EXEC sp_AddColumnIfNotExists 'CloseOutReportTender', 'IsPost', 'BIT DEFAULT 0';
EXEC sp_AddColumnIfNotExists 'CloseOutReportTender', 'PostDate', 'DATETIME NULL';
EXEC sp_AddColumnIfNotExists 'CloseOutReportTender', 'IsUpdated', 'BIT DEFAULT 0';
EXEC sp_AddColumnIfNotExists 'CloseOutReportTender', 'UpdatedDate', 'DATETIME NULL';
EXEC sp_AddColumnIfNotExists 'CloseOutReportTender', 'CloudId', 'INT NULL';
EXEC sp_AddColumnIfNotExists 'CloseOutReportTender', 'LastSyncDate', 'DATETIME NULL';

-- ============================================================================
-- CLOSEOUT REPORT MAIN TABLE
-- ============================================================================
EXEC sp_AddColumnIfNotExists 'CloseOutReportMain', 'IsPost', 'BIT DEFAULT 0';
EXEC sp_AddColumnIfNotExists 'CloseOutReportMain', 'PostDate', 'DATETIME NULL';
EXEC sp_AddColumnIfNotExists 'CloseOutReportMain', 'IsUpdated', 'BIT DEFAULT 0';
EXEC sp_AddColumnIfNotExists 'CloseOutReportMain', 'UpdatedDate', 'DATETIME NULL';
EXEC sp_AddColumnIfNotExists 'CloseOutReportMain', 'CloudId', 'INT NULL';
EXEC sp_AddColumnIfNotExists 'CloseOutReportMain', 'LastSyncDate', 'DATETIME NULL';

-- ============================================================================
-- MIX N MATCH DETAIL TABLE
-- ============================================================================
EXEC sp_AddColumnIfNotExists 'MixNmatchDetails', 'IsPost', 'BIT DEFAULT 0';
EXEC sp_AddColumnIfNotExists 'MixNmatchDetails', 'PostDate', 'DATETIME NULL';
EXEC sp_AddColumnIfNotExists 'MixNmatchDetails', 'IsUpdated', 'BIT DEFAULT 0';
EXEC sp_AddColumnIfNotExists 'MixNmatchDetails', 'UpdatedDate', 'DATETIME NULL';
EXEC sp_AddColumnIfNotExists 'MixNmatchDetails', 'CloudId', 'INT NULL';
EXEC sp_AddColumnIfNotExists 'MixNmatchDetails', 'LastSyncDate', 'DATETIME NULL';

-- ============================================================================
-- DISCOUNT RESTRICTED ITEM TABLE
-- ============================================================================
EXEC sp_AddColumnIfNotExists 'DiscountRestrictedItems', 'IsPost', 'BIT DEFAULT 0';
EXEC sp_AddColumnIfNotExists 'DiscountRestrictedItems', 'PostDate', 'DATETIME NULL';
EXEC sp_AddColumnIfNotExists 'DiscountRestrictedItems', 'IsUpdated', 'BIT DEFAULT 0';
EXEC sp_AddColumnIfNotExists 'DiscountRestrictedItems', 'UpdatedDate', 'DATETIME NULL';
EXEC sp_AddColumnIfNotExists 'DiscountRestrictedItems', 'CloudId', 'INT NULL';
EXEC sp_AddColumnIfNotExists 'DiscountRestrictedItems', 'LastSyncDate', 'DATETIME NULL';

-- ============================================================================
-- Cleanup
-- ============================================================================
DROP PROCEDURE sp_AddColumnIfNotExists;
PRINT N'✅ Migration completed successfully!';