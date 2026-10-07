IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[Employee]') 
	  AND NAME = 'LastSyncDate'
)
BEGIN
	ALTER TABLE [dbo].[Employee] 
	ADD LastSyncDate DATETIME
END

IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[Category]') 
	  AND NAME = 'LastSyncDate'
)
BEGIN
	ALTER TABLE [dbo].[Category] 
	ADD LastSyncDate DATETIME
END

IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[Product]') 
	  AND NAME = 'LastSyncDate'
)
BEGIN
	ALTER TABLE [dbo].[Product] 
	ADD LastSyncDate DATETIME
END


IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[UOM]') 
	  AND NAME = 'LastSyncDate'
)
BEGIN
	ALTER TABLE [dbo].[UOM] 
	ADD LastSyncDate DATETIME
END

IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[UOM]') 
	  AND NAME = 'LastSyncDate'
)
BEGIN
	ALTER TABLE [dbo].[UOM] 
	ADD LastSyncDate DATETIME
END

IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[Invoice]') 
	  AND NAME = 'LastSyncDate'
)
BEGIN
	ALTER TABLE [dbo].[Invoice] 
	ADD LastSyncDate DATETIME ;
END

IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[Item]') 
	  AND NAME = 'LastSyncDate'
)
BEGIN
	ALTER TABLE [dbo].[Item] 
	ADD LastSyncDate DATETIME;
END

IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[Trans]') 
	  AND NAME = 'LastSyncDate'
)
BEGIN
	ALTER TABLE [dbo].[Trans] 
	ADD LastSyncDate DATETIME;
END

IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[TransTypes]') 
	  AND NAME = 'LastSyncDate'
)
BEGIN
	ALTER TABLE [dbo].[TransTypes] 
	ADD LastSyncDate DATETIME;
END

IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[Tender]') 
	  AND NAME = 'LastSyncDate'
)
BEGIN
	ALTER TABLE [dbo].[Tender] 
	ADD LastSyncDate DATETIME;
END

IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[StockJournal]') 
	  AND NAME = 'LastSyncDate'
)
BEGIN
	ALTER TABLE [dbo].[StockJournal] 
	ADD LastSyncDate DATETIME;
END

IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[TenderTypes]') 
	  AND NAME = 'LastSyncDate'
)
BEGIN
	ALTER TABLE [dbo].[TenderTypes] 
	ADD LastSyncDate DATETIME;
END

