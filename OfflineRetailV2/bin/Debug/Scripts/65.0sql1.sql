USE Retail2020DB
GO

IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[Setup]') 
	  AND NAME = 'POSShowBalanceDialog'
)
BEGIN
	ALTER TABLE [dbo].[Setup]
	ADD [POSShowBalanceDialog] [int] NULL
END