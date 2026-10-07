USE Retail2020DB
GO

IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[StoreInfo]') 
	  AND NAME = 'StoreCode'
)
BEGIN
	ALTER TABLE [dbo].[StoreInfo] 
	ADD StoreCode VARCHAR(150)
END

IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[StoreInfo]') 
	  AND NAME = 'StoreName'
)
BEGIN
	ALTER TABLE [dbo].[StoreInfo] 
	ADD StoreName VARCHAR(250)
END

IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[StoreInfo]') 
	  AND NAME = 'CloudId'
)
BEGIN
	ALTER TABLE [dbo].[StoreInfo] 
	ADD CloudId int
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[StoreInfo]') 
	  AND NAME = 'ManagerName'
)
BEGIN
	ALTER TABLE [dbo].[StoreInfo] 
	ADD ManagerName VARCHAR(250)
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[StoreInfo]') 
	  AND NAME = 'Enable'
)
BEGIN
	ALTER TABLE [dbo].[StoreInfo] 
	ADD Enable CHAR(1)
END

IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[StoreInfo]') 
	  AND NAME = 'isConnect'
)
BEGIN
	ALTER TABLE [dbo].[StoreInfo] 
	ADD isConnect BIT DEFAULT(0)
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[StoreInfo]') 
	  AND NAME = 'ConnectedDate'
)
BEGIN
	ALTER TABLE [dbo].[StoreInfo] 
	ADD ConnectedDate DATETIME
END
