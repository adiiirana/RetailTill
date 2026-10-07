IF NOT EXISTS (
	SELECT *
	FROM syscolumns
	WHERE ID = OBJECT_ID('[dbo].[Customer]')
    AND NAME = 'LastSyncDate'
)
BEGIN
	ALTER TABLE [dbo].[Customer]
	ADD LastSyncDate DATETIME;
END