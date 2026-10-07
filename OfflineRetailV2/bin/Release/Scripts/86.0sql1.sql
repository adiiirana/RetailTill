USE Retail2020DB
GO

IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[BusinessInfo]') 
	  AND NAME = 'IsSync'
)
BEGIN
	ALTER TABLE [dbo].[BusinessInfo] 
	ADD IsSync Int DEFAULT(0) NOT NULL
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[BusinessInfo]') 
	  AND NAME = 'LastSyncDate'
)
BEGIN
	ALTER TABLE [dbo].[BusinessInfo] 
	ADD LastSyncDate DATETIME
END