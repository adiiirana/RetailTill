DECLARE @sql NVARCHAR(MAX) = 'UPDATE [Setup]'

-- Check if each column exists and build the UPDATE statement dynamically
IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'Setup' AND COLUMN_NAME = 'Currency1Name')
    SET @sql = @sql + 'SET Currency1Name = ''£ 1'', ';

IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'Setup' AND COLUMN_NAME = 'Currency3Name')
    SET @sql = @sql + 'Currency3Name = ''£ 5'', ';

IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'Setup' AND COLUMN_NAME = 'Currency4Name')
    SET @sql = @sql + 'Currency4Name = ''£ 10'', ';

IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'Setup' AND COLUMN_NAME = 'Currency6Name')
    SET @sql = @sql + 'Currency6Name = ''£ 50'', ';

IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'Setup' AND COLUMN_NAME = 'Currency8Name')
    SET @sql = @sql + 'Currency8Name = ''200'', ';

IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'Setup' AND COLUMN_NAME = 'Currency9Name')
    SET @sql = @sql + 'Currency9Name = ''500'', ';

IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'Setup' AND COLUMN_NAME = 'Currency1QuickTender')
    SET @sql = @sql + 'Currency1QuickTender = ''Y'', ';

IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'Setup' AND COLUMN_NAME = 'Currency3QuickTender')
    SET @sql = @sql + 'Currency3QuickTender = ''Y'', ';

IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'Setup' AND COLUMN_NAME = 'Currency4QuickTender')
    SET @sql = @sql + 'Currency4QuickTender = ''Y'', ';

IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'Setup' AND COLUMN_NAME = 'Currency6QuickTender')
    SET @sql = @sql + 'Currency6QuickTender = ''Y'', ';

IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'Setup' AND COLUMN_NAME = 'Currency8QuickTender')
    SET @sql = @sql + 'Currency8QuickTender = ''Y'', ';

IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'Setup' AND COLUMN_NAME = 'Currency9QuickTender')
    SET @sql = @sql + 'Currency9QuickTender = ''Y'', ';

-- Remove trailing comma and space if any
SET @sql = LEFT(@sql, LEN(@sql) - 1);

PRINT @sql
-- If @sql is not empty, execute the dynamic SQL
IF LEN(@sql) > 0
    EXEC sp_executesql @sql;
