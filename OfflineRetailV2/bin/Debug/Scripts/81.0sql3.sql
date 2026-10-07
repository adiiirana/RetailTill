USE Retail2020DB
GO
--==========================Dept========================

IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[Dept]') 
	  AND NAME = 'isPost'
)
BEGIN
	ALTER TABLE [dbo].[Dept] 
	ADD isPost BIT DeFAULT(0) NOT NULL;
END

IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[Dept]') 
	  AND NAME = 'PostDate'
)
BEGIN
	ALTER TABLE [dbo].[Dept] 
	ADD PostDate DATETIME ;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[Dept]') 
	  AND NAME = 'isUpdated'
)
BEGIN
	ALTER TABLE [dbo].[Dept] 
	ADD isUpdated BIT DEFAULT(1) NOT NULL ;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[Dept]') 
	  AND NAME = 'UpdatedDate'
)
BEGIN
	ALTER TABLE [dbo].[Dept] 
	ADD UpdatedDate DATETIME;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[Dept]') 
	  AND NAME = 'CloudId'
)
BEGIN
	ALTER TABLE [dbo].Dept 
	ADD CloudId INT NULL;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[Dept]') 
	  AND NAME = 'LastSyncDate'
)
BEGIN
	ALTER TABLE [dbo].[Dept] 
	ADD LastSyncDate DATETIME;
END

--==============================Category================
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[Category]') 
	  AND NAME = 'isPost'
)
BEGIN
	ALTER TABLE [dbo].[Category] 
	ADD isPost BIT DeFAULT(0) NOT NULL;
END

IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[Category]') 
	  AND NAME = 'PostDate'
)
BEGIN
	ALTER TABLE [dbo].[Category] 
	ADD PostDate DATETIME ;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[Category]') 
	  AND NAME = 'isUpdated'
)
BEGIN
	ALTER TABLE [dbo].[Category] 
	ADD isUpdated BIT DEFAULT(1) NOT NULL ;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[Category]') 
	  AND NAME = 'UpdatedDate'
)
BEGIN
	ALTER TABLE [dbo].[Category] 
	ADD UpdatedDate DATETIME;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[Category]') 
	  AND NAME = 'CloudId'
)
BEGIN
	ALTER TABLE [dbo].[Category] 
	ADD CloudId INT NULL;
END

--==============================Product================
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[Product]') 
	  AND NAME = 'isPost'
)
BEGIN
	ALTER TABLE [dbo].[Product] 
	ADD isPost BIT DeFAULT(0) NOT NULL;
END

IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[Product]') 
	  AND NAME = 'PostDate'
)
BEGIN
	ALTER TABLE [dbo].[Product] 
	ADD PostDate DATETIME ;
END

IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[Product]') 
	  AND NAME = 'isUpdated'
)
BEGIN
	ALTER TABLE [dbo].[Product] 
	ADD isUpdated BIT DEFAULT(1) NOT NULL ;
END

IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[Product]') 
	  AND NAME = 'UpdatedDate'
)
BEGIN
	ALTER TABLE [dbo].[Product] 
	ADD UpdatedDate DATETIME;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[Product]') 
	  AND NAME = 'CloudId'
)
BEGIN
	ALTER TABLE [dbo].Product 
	ADD CloudId INT NULL;
END
--======================UOM======================


IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[UOM]') 
	  AND NAME = 'isPost'
)
BEGIN
	ALTER TABLE [dbo].[UOM] 
	ADD isPost BIT DeFAULT(0) NOT NULL;
END

IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[UOM]') 
	  AND NAME = 'PostDate'
)
BEGIN
	ALTER TABLE [dbo].[UOM] 
	ADD PostDate DATETIME ;
END

IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[UOM]') 
	  AND NAME = 'isUpdated'
)
BEGIN
	ALTER TABLE [dbo].[UOM] 
	ADD isUpdated BIT DEFAULT(1) NOT NULL ;
END

IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[UOM]') 
	  AND NAME = 'UpdatedDate'
)
BEGIN
	ALTER TABLE [dbo].[UOM] 
	ADD UpdatedDate DATETIME;
END

IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[UOM]') 
	  AND NAME = 'CloudId'
)
BEGIN
	ALTER TABLE [dbo].[UOM] 
	ADD CloudId INT NULL;
END
--=================================Customer================
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[Customer]') 
	  AND NAME = 'isPost'
)
BEGIN
	ALTER TABLE [dbo].[Customer] 
	ADD isPost BIT DeFAULT(0) NOT NULL;
END

IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[Customer]') 
	  AND NAME = 'PostDate'
)
BEGIN
	ALTER TABLE [dbo].[Customer] 
	ADD PostDate DATETIME ;
END

IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[Customer]') 
	  AND NAME = 'isUpdated'
)
BEGIN
	ALTER TABLE [dbo].[Customer] 
	ADD isUpdated BIT DEFAULT(1) NOT NULL ;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[Customer]') 
	  AND NAME = 'UpdatedDate'
)
BEGIN
	ALTER TABLE [dbo].[Customer] 
	ADD UpdatedDate DATETIME;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[Customer]') 
	  AND NAME = 'CloudId'
)
BEGIN
	ALTER TABLE [dbo].[Customer] 
	ADD  CloudId INT NULL;
END
--===============================Employee================
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[Employee]') 
	  AND NAME = 'isPost'
)
BEGIN
	ALTER TABLE [dbo].[Employee] 
	ADD isPost BIT DeFAULT(0) NOT NULL;
END

IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[Employee]') 
	  AND NAME = 'PostDate'
)
BEGIN
	ALTER TABLE [dbo].[Employee] 
	ADD PostDate DATETIME ;
END

IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[Employee]') 
	  AND NAME = 'CloudId'
)
BEGIN
	ALTER TABLE [dbo].[Employee] 
	ADD CloudId INT NULL;
END

IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[Employee]') 
	  AND NAME = 'isUpdated'
)
BEGIN
	ALTER TABLE [dbo].[Employee] 
	ADD isUpdated BIT DEFAULT(1) NOT NULL ;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[Employee]') 
	  AND NAME = 'UpdatedDate'
)
BEGIN
	ALTER TABLE [dbo].[Employee] 
	ADD UpdatedDate DATETIME;
END
--============================Invoice================
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[Invoice]') 
	  AND NAME = 'isPost'
)
BEGIN
	ALTER TABLE [dbo].[Invoice] 
	ADD isPost BIT DeFAULT(0) NOT NULL;
END

IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[Invoice]') 
	  AND NAME = 'PostDate'
)
BEGIN
	ALTER TABLE [dbo].[Invoice] 
	ADD PostDate DATETIME ;
END

IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[Invoice]') 
	  AND NAME = 'CloudId'
)
BEGIN
	ALTER TABLE [dbo].[Invoice] 
	ADD CloudId int NULL;
END

IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[Invoice]') 
	  AND NAME = 'isUpdated'
)
BEGIN
	ALTER TABLE [dbo].[Invoice] 
	ADD isUpdated BIT DEFAULT(1) NOT NULL ;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[Invoice]') 
	  AND NAME = 'UpdatedDate'
)
BEGIN
	ALTER TABLE [dbo].[Invoice] 
	ADD UpdatedDate DATETIME;
END

--============================Items================
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[Item]') 
	  AND NAME = 'isPost'
)
BEGIN
	ALTER TABLE [dbo].[Item] 
	ADD isPost BIT DeFAULT(0) NOT NULL;
END

IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[Item]') 
	  AND NAME = 'PostDate'
)
BEGIN
	ALTER TABLE [dbo].[Item] 
	ADD PostDate DATETIME ;
END


IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[Item]') 
	  AND NAME = 'isUpdated'
)
BEGIN
	ALTER TABLE [dbo].[Item] 
	ADD isUpdated BIT DEFAULT(1) NOT NULL ;
END


IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[Item]') 
	  AND NAME = 'CloudId'
)
BEGIN
	ALTER TABLE [dbo].[Item] 
	ADD CloudId INT NULL;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[Item]') 
	  AND NAME = 'UpdatedDate'
)
BEGIN
	ALTER TABLE [dbo].[Item] 
	ADD UpdatedDate DATETIME;
END

--============================Trans================

IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[Trans]') 
	  AND NAME = 'isPost'
)
BEGIN
	ALTER TABLE [dbo].[Trans] 
	ADD isPost BIT DeFAULT(0) NOT NULL;
END

IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[Trans]') 
	  AND NAME = 'PostDate'
)
BEGIN
	ALTER TABLE [dbo].[Trans] 
	ADD PostDate DATETIME ;
END


IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[Trans]') 
	  AND NAME = 'isUpdated'
)
BEGIN
	ALTER TABLE [dbo].[Trans] 
	ADD isUpdated BIT DEFAULT(1) NOT NULL ;
END


IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[Trans]') 
	  AND NAME = 'CloudId'
)
BEGIN
	ALTER TABLE [dbo].[Trans] 
	ADD CloudId INT NULL;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[Trans]') 
	  AND NAME = 'UpdatedDate'
)
BEGIN
	ALTER TABLE [dbo].[Trans] 
	ADD UpdatedDate DATETIME;
END

--============================Trans Types================
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[TransTypes]') 
	  AND NAME = 'isPost'
)
BEGIN
	ALTER TABLE [dbo].[TransTypes] 
	ADD isPost BIT DeFAULT(0) NOT NULL;
END

IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[TransTypes]') 
	  AND NAME = 'PostDate'
)
BEGIN
	ALTER TABLE [dbo].[TransTypes] 
	ADD PostDate DATETIME ;
END


IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[TransTypes]') 
	  AND NAME = 'isUpdated'
)
BEGIN
	ALTER TABLE [dbo].[TransTypes] 
	ADD isUpdated BIT DEFAULT(1) NOT NULL ;
END

IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[TransTypes]') 
	  AND NAME = 'UpdatedDate'
)
BEGIN
	ALTER TABLE [dbo].[TransTypes] 
	ADD UpdatedDate DATETIME;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[TransTypes]') 
	  AND NAME = 'CloudId'
)
BEGIN
	ALTER TABLE [dbo].[TransTypes] 
	ADD CloudId INT NULL;
END
--============================Tender================
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[Tender]') 
	  AND NAME = 'isPost'
)
BEGIN
	ALTER TABLE [dbo].[Tender] 
	ADD isPost BIT DeFAULT(0) NOT NULL;
END

IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[Tender]') 
	  AND NAME = 'PostDate'
)
BEGIN
	ALTER TABLE [dbo].[Tender] 
	ADD PostDate DATETIME ;
END

IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[Tender]') 
	  AND NAME = 'isUpdated'
)
BEGIN
	ALTER TABLE [dbo].[Tender] 
	ADD isUpdated BIT DEFAULT(1) NOT NULL ;
END

IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[Tender]') 
	  AND NAME = 'CloudId'
)
BEGIN
	ALTER TABLE [dbo].[Tender] 
	ADD CloudId INT NULL;
END

IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[Tender]') 
	  AND NAME = 'UpdatedDate'
)
BEGIN
	ALTER TABLE [dbo].[Tender] 
	ADD UpdatedDate DATETIME;
END
--============================StockJournal================
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[StockJournal]') 
	  AND NAME = 'isPost'
)
BEGIN
	ALTER TABLE [dbo].[StockJournal] 
	ADD isPost BIT DeFAULT(0) NOT NULL;
END

IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[StockJournal]') 
	  AND NAME = 'PostDate'
)
BEGIN
	ALTER TABLE [dbo].[StockJournal] 
	ADD PostDate DATETIME ;
END

IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[StockJournal]') 
	  AND NAME = 'isUpdated'
)
BEGIN
	ALTER TABLE [dbo].[StockJournal] 
	ADD isUpdated BIT DEFAULT(1) NOT NULL ;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[StockJournal]') 
	  AND NAME = 'CloudId'
)
BEGIN
	ALTER TABLE [dbo].[StockJournal] 
	ADD CloudId INT NULL;
END

IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[StockJournal]') 
	  AND NAME = 'UpdatedDate'
)
BEGIN
	ALTER TABLE [dbo].[StockJournal] 
	ADD UpdatedDate DATETIME;
END
--======================Tender Types=============================

IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[TenderTypes]') 
	  AND NAME = 'isPost'
)
BEGIN
	ALTER TABLE [dbo].[TenderTypes] 
	ADD isPost BIT DeFAULT(0) NOT NULL;
END

IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[TenderTypes]') 
	  AND NAME = 'PostDate'
)
BEGIN
	ALTER TABLE [dbo].[TenderTypes] 
	ADD PostDate DATETIME ;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[TenderTypes]') 
	  AND NAME = 'isUpdated'
)
BEGIN
	ALTER TABLE [dbo].[TenderTypes] 
	ADD isUpdated BIT DEFAULT(1) NOT NULL ;
END

IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[TenderTypes]') 
	  AND NAME = 'UpdatedDate'
)
BEGIN
	ALTER TABLE [dbo].[TenderTypes] 
	ADD UpdatedDate DATETIME;
END

IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[TenderTypes]') 
	  AND NAME = 'CloudId'
)
BEGIN
	ALTER TABLE [dbo].[TenderTypes] 
	ADD CloudId INT NULL;
END
--==========================GroupMaster========================

IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[GroupMaster]') 
	  AND NAME = 'isPost'
)
BEGIN
	ALTER TABLE [dbo].[GroupMaster] 
	ADD isPost BIT DeFAULT(0) NOT NULL;
END

IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[GroupMaster]') 
	  AND NAME = 'PostDate'
)
BEGIN
	ALTER TABLE [dbo].[GroupMaster] 
	ADD PostDate DATETIME ;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[GroupMaster]') 
	  AND NAME = 'isUpdated'
)
BEGIN
	ALTER TABLE [dbo].[GroupMaster] 
	ADD isUpdated BIT DEFAULT(1) NOT NULL ;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[GroupMaster]') 
	  AND NAME = 'UpdatedDate'
)
BEGIN
	ALTER TABLE [dbo].[GroupMaster] 
	ADD UpdatedDate DATETIME;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[GroupMaster]') 
	  AND NAME = 'CloudId'
)
BEGIN
	ALTER TABLE [dbo].GroupMaster 
	ADD CloudId INT NULL;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[GroupMaster]') 
	  AND NAME = 'LastSyncDate'
)
BEGIN
	ALTER TABLE [dbo].[GroupMaster] 
	ADD LastSyncDate DATETIME;
END
--==========================GroupPermission========================

IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[GroupPermission]') 
	  AND NAME = 'isPost'
)
BEGIN
	ALTER TABLE [dbo].[GroupPermission] 
	ADD isPost BIT DeFAULT(0) NOT NULL;
END

IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[GroupPermission]') 
	  AND NAME = 'PostDate'
)
BEGIN
	ALTER TABLE [dbo].[GroupPermission] 
	ADD PostDate DATETIME ;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[GroupPermission]') 
	  AND NAME = 'isUpdated'
)
BEGIN
	ALTER TABLE [dbo].[GroupPermission] 
	ADD isUpdated BIT DEFAULT(1) NOT NULL ;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[GroupPermission]') 
	  AND NAME = 'UpdatedDate'
)
BEGIN
	ALTER TABLE [dbo].[GroupPermission] 
	ADD UpdatedDate DATETIME;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[GroupPermission]') 
	  AND NAME = 'CloudId'
)
BEGIN
	ALTER TABLE [dbo].GroupPermission 
	ADD CloudId INT NULL;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[GroupPermission]') 
	  AND NAME = 'LastSyncDate'
)
BEGIN
	ALTER TABLE [dbo].[GroupPermission] 
	ADD LastSyncDate DATETIME;
END

--==========================ClassMaster========================

IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[ClassMaster]') 
	  AND NAME = 'isPost'
)
BEGIN
	ALTER TABLE [dbo].[ClassMaster] 
	ADD isPost BIT DeFAULT(0) NOT NULL;
END

IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[ClassMaster]') 
	  AND NAME = 'PostDate'
)
BEGIN
	ALTER TABLE [dbo].[ClassMaster] 
	ADD PostDate DATETIME ;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[ClassMaster]') 
	  AND NAME = 'isUpdated'
)
BEGIN
	ALTER TABLE [dbo].[ClassMaster] 
	ADD isUpdated BIT DEFAULT(1) NOT NULL ;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[ClassMaster]') 
	  AND NAME = 'UpdatedDate'
)
BEGIN
	ALTER TABLE [dbo].[ClassMaster] 
	ADD UpdatedDate DATETIME;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[ClassMaster]') 
	  AND NAME = 'CloudId'
)
BEGIN
	ALTER TABLE [dbo].ClassMaster 
	ADD CloudId INT NULL;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[ClassMaster]') 
	  AND NAME = 'LastSyncDate'
)
BEGIN
	ALTER TABLE [dbo].[ClassMaster] 
	ADD LastSyncDate DATETIME;
END

--==========================POHeader========================

IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[POHeader]') 
	  AND NAME = 'isPost'
)
BEGIN
	ALTER TABLE [dbo].[POHeader] 
	ADD isPost BIT DeFAULT(0) NOT NULL;
END

IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[POHeader]') 
	  AND NAME = 'PostDate'
)
BEGIN
	ALTER TABLE [dbo].[POHeader] 
	ADD PostDate DATETIME ;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[POHeader]') 
	  AND NAME = 'isUpdated'
)
BEGIN
	ALTER TABLE [dbo].[POHeader] 
	ADD isUpdated BIT DEFAULT(1) NOT NULL ;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[POHeader]') 
	  AND NAME = 'UpdatedDate'
)
BEGIN
	ALTER TABLE [dbo].[POHeader] 
	ADD UpdatedDate DATETIME;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[POHeader]') 
	  AND NAME = 'CloudId'
)
BEGIN
	ALTER TABLE [dbo].POHeader 
	ADD CloudId INT NULL;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[POHeader]') 
	  AND NAME = 'LastSyncDate'
)
BEGIN
	ALTER TABLE [dbo].[POHeader] 
	ADD LastSyncDate DATETIME;
END

--==========================BrandMaster========================

IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[BrandMaster]') 
	  AND NAME = 'isPost'
)
BEGIN
	ALTER TABLE [dbo].[BrandMaster] 
	ADD isPost BIT DeFAULT(0) NOT NULL;
END

IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[BrandMaster]') 
	  AND NAME = 'PostDate'
)
BEGIN
	ALTER TABLE [dbo].[BrandMaster] 
	ADD PostDate DATETIME ;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[BrandMaster]') 
	  AND NAME = 'isUpdated'
)
BEGIN
	ALTER TABLE [dbo].[BrandMaster] 
	ADD isUpdated BIT DEFAULT(1) NOT NULL ;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[BrandMaster]') 
	  AND NAME = 'UpdatedDate'
)
BEGIN
	ALTER TABLE [dbo].[BrandMaster] 
	ADD UpdatedDate DATETIME;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[BrandMaster]') 
	  AND NAME = 'CloudId'
)
BEGIN
	ALTER TABLE [dbo].BrandMaster 
	ADD CloudId INT NULL;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[BrandMaster]') 
	  AND NAME = 'LastSyncDate'
)
BEGIN
	ALTER TABLE [dbo].[BrandMaster] 
	ADD LastSyncDate DATETIME;
END

--==========================PODetail========================

IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[PODetail]') 
	  AND NAME = 'isPost'
)
BEGIN
	ALTER TABLE [dbo].[PODetail] 
	ADD isPost BIT DeFAULT(0) NOT NULL;
END

IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[PODetail]') 
	  AND NAME = 'PostDate'
)
BEGIN
	ALTER TABLE [dbo].[PODetail] 
	ADD PostDate DATETIME ;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[PODetail]') 
	  AND NAME = 'isUpdated'
)
BEGIN
	ALTER TABLE [dbo].[PODetail] 
	ADD isUpdated BIT DEFAULT(1) NOT NULL ;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[PODetail]') 
	  AND NAME = 'UpdatedDate'
)
BEGIN
	ALTER TABLE [dbo].[PODetail] 
	ADD UpdatedDate DATETIME;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[PODetail]') 
	  AND NAME = 'CloudId'
)
BEGIN
	ALTER TABLE [dbo].PODetail 
	ADD CloudId INT NULL;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[PODetail]') 
	  AND NAME = 'LastSyncDate'
)
BEGIN
	ALTER TABLE [dbo].[PODetail] 
	ADD LastSyncDate DATETIME;
END

--==========================Vendor========================
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[Vendor]') 
	  AND NAME = 'isPost'
)
BEGIN
	ALTER TABLE [dbo].[Vendor] 
	ADD isPost BIT DeFAULT(0) NOT NULL;
END

IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[Vendor]') 
	  AND NAME = 'PostDate'
)
BEGIN
	ALTER TABLE [dbo].[Vendor] 
	ADD PostDate DATETIME ;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[Vendor]') 
	  AND NAME = 'isUpdated'
)
BEGIN
	ALTER TABLE [dbo].[Vendor] 
	ADD isUpdated BIT DEFAULT(1) NOT NULL ;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[Vendor]') 
	  AND NAME = 'UpdatedDate'
)
BEGIN
	ALTER TABLE [dbo].[Vendor] 
	ADD UpdatedDate DATETIME;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[Vendor]') 
	  AND NAME = 'CloudId'
)
BEGIN
	ALTER TABLE [dbo].Vendor 
	ADD CloudId INT NULL;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[Vendor]') 
	  AND NAME = 'LastSyncDate'
)
BEGIN
	ALTER TABLE [dbo].[Vendor] 
	ADD LastSyncDate DATETIME;
END
--==========================VendPart========================
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[VendPart]') 
	  AND NAME = 'isPost'
)
BEGIN
	ALTER TABLE [dbo].[VendPart] 
	ADD isPost BIT DeFAULT(0) NOT NULL;
END

IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[VendPart]') 
	  AND NAME = 'PostDate'
)
BEGIN
	ALTER TABLE [dbo].[VendPart] 
	ADD PostDate DATETIME ;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[VendPart]') 
	  AND NAME = 'isUpdated'
)
BEGIN
	ALTER TABLE [dbo].[VendPart] 
	ADD isUpdated BIT DEFAULT(1) NOT NULL ;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[VendPart]') 
	  AND NAME = 'UpdatedDate'
)
BEGIN
	ALTER TABLE [dbo].[VendPart] 
	ADD UpdatedDate DATETIME;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[VendPart]') 
	  AND NAME = 'CloudId'
)
BEGIN
	ALTER TABLE [dbo].VendPart 
	ADD CloudId INT NULL;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[VendPart]') 
	  AND NAME = 'LastSyncDate'
)
BEGIN
	ALTER TABLE [dbo].[VendPart] 
	ADD LastSyncDate DATETIME;
END
--==========================ZipCode========================
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[ZipCode]') 
	  AND NAME = 'isPost'
)
BEGIN
	ALTER TABLE [dbo].[ZipCode] 
	ADD isPost BIT DeFAULT(0) NOT NULL;
END

IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[ZipCode]') 
	  AND NAME = 'PostDate'
)
BEGIN
	ALTER TABLE [dbo].[ZipCode] 
	ADD PostDate DATETIME ;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[ZipCode]') 
	  AND NAME = 'isUpdated'
)
BEGIN
	ALTER TABLE [dbo].[ZipCode] 
	ADD isUpdated BIT DEFAULT(1) NOT NULL ;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[ZipCode]') 
	  AND NAME = 'UpdatedDate'
)
BEGIN
	ALTER TABLE [dbo].[ZipCode] 
	ADD UpdatedDate DATETIME;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[ZipCode]') 
	  AND NAME = 'CloudId'
)
BEGIN
	ALTER TABLE [dbo].ZipCode 
	ADD CloudId INT NULL;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[ZipCode]') 
	  AND NAME = 'LastSyncDate'
)
BEGIN
	ALTER TABLE [dbo].[ZipCode] 
	ADD LastSyncDate DATETIME;
END
--==========================TaxHeader========================
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[TaxHeader]') 
	  AND NAME = 'isPost'
)
BEGIN
	ALTER TABLE [dbo].[TaxHeader] 
	ADD isPost BIT DeFAULT(0) NOT NULL;
END

IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[TaxHeader]') 
	  AND NAME = 'PostDate'
)
BEGIN
	ALTER TABLE [dbo].[TaxHeader] 
	ADD PostDate DATETIME ;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[TaxHeader]') 
	  AND NAME = 'isUpdated'
)
BEGIN
	ALTER TABLE [dbo].[TaxHeader] 
	ADD isUpdated BIT DEFAULT(1) NOT NULL ;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[TaxHeader]') 
	  AND NAME = 'UpdatedDate'
)
BEGIN
	ALTER TABLE [dbo].[TaxHeader] 
	ADD UpdatedDate DATETIME;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[TaxHeader]') 
	  AND NAME = 'CloudId'
)
BEGIN
	ALTER TABLE [dbo].TaxHeader 
	ADD CloudId INT NULL;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[TaxHeader]') 
	  AND NAME = 'LastSyncDate'
)
BEGIN
	ALTER TABLE [dbo].[TaxHeader] 
	ADD LastSyncDate DATETIME;
END
--==========================StoreCreditTransaction========================
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[StoreCreditTransaction]') 
	  AND NAME = 'isPost'
)
BEGIN
	ALTER TABLE [dbo].[StoreCreditTransaction] 
	ADD isPost BIT DeFAULT(0) NOT NULL;
END

IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[StoreCreditTransaction]') 
	  AND NAME = 'PostDate'
)
BEGIN
	ALTER TABLE [dbo].[StoreCreditTransaction] 
	ADD PostDate DATETIME ;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[StoreCreditTransaction]') 
	  AND NAME = 'isUpdated'
)
BEGIN
	ALTER TABLE [dbo].[StoreCreditTransaction] 
	ADD isUpdated BIT DEFAULT(1) NOT NULL ;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[StoreCreditTransaction]') 
	  AND NAME = 'UpdatedDate'
)
BEGIN
	ALTER TABLE [dbo].[StoreCreditTransaction] 
	ADD UpdatedDate DATETIME;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[StoreCreditTransaction]') 
	  AND NAME = 'CloudId'
)
BEGIN
	ALTER TABLE [dbo].StoreCreditTransaction 
	ADD CloudId INT NULL;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[StoreCreditTransaction]') 
	  AND NAME = 'LastSyncDate'
)
BEGIN
	ALTER TABLE [dbo].[StoreCreditTransaction] 
	ADD LastSyncDate DATETIME;
END
--==========================StocktakeDetail========================
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[StocktakeDetail]') 
	  AND NAME = 'isPost'
)
BEGIN
	ALTER TABLE [dbo].[StocktakeDetail] 
	ADD isPost BIT DeFAULT(0) NOT NULL;
END

IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[StocktakeDetail]') 
	  AND NAME = 'PostDate'
)
BEGIN
	ALTER TABLE [dbo].[StocktakeDetail] 
	ADD PostDate DATETIME ;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[StocktakeDetail]') 
	  AND NAME = 'isUpdated'
)
BEGIN
	ALTER TABLE [dbo].[StocktakeDetail] 
	ADD isUpdated BIT DEFAULT(1) NOT NULL ;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[StocktakeDetail]') 
	  AND NAME = 'UpdatedDate'
)
BEGIN
	ALTER TABLE [dbo].[StocktakeDetail] 
	ADD UpdatedDate DATETIME;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[StocktakeDetail]') 
	  AND NAME = 'CloudId'
)
BEGIN
	ALTER TABLE [dbo].StocktakeDetail 
	ADD CloudId INT NULL;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[StocktakeDetail]') 
	  AND NAME = 'LastSyncDate'
)
BEGIN
	ALTER TABLE [dbo].[StocktakeDetail] 
	ADD LastSyncDate DATETIME;
END
--==========================BrandMaster========================
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[BrandMaster]') 
	  AND NAME = 'isPost'
)
BEGIN
	ALTER TABLE [dbo].[BrandMaster] 
	ADD isPost BIT DeFAULT(0) NOT NULL;
END

IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[BrandMaster]') 
	  AND NAME = 'PostDate'
)
BEGIN
	ALTER TABLE [dbo].[BrandMaster] 
	ADD PostDate DATETIME ;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[BrandMaster]') 
	  AND NAME = 'isUpdated'
)
BEGIN
	ALTER TABLE [dbo].[BrandMaster] 
	ADD isUpdated BIT DEFAULT(1) NOT NULL ;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[BrandMaster]') 
	  AND NAME = 'UpdatedDate'
)
BEGIN
	ALTER TABLE [dbo].[BrandMaster] 
	ADD UpdatedDate DATETIME;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[BrandMaster]') 
	  AND NAME = 'CloudId'
)
BEGIN
	ALTER TABLE [dbo].BrandMaster 
	ADD CloudId INT NULL;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[BrandMaster]') 
	  AND NAME = 'LastSyncDate'
)
BEGIN
	ALTER TABLE [dbo].[BrandMaster] 
	ADD LastSyncDate DATETIME;
END
--==========================TaxDetail========================
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[TaxDetail]') 
	  AND NAME = 'isPost'
)
BEGIN
	ALTER TABLE [dbo].[TaxDetail] 
	ADD isPost BIT DeFAULT(0) NOT NULL;
END

IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[TaxDetail]') 
	  AND NAME = 'PostDate'
)
BEGIN
	ALTER TABLE [dbo].[TaxDetail] 
	ADD PostDate DATETIME ;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[TaxDetail]') 
	  AND NAME = 'isUpdated'
)
BEGIN
	ALTER TABLE [dbo].[TaxDetail] 
	ADD isUpdated BIT DEFAULT(1) NOT NULL ;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[TaxDetail]') 
	  AND NAME = 'UpdatedDate'
)
BEGIN
	ALTER TABLE [dbo].[TaxDetail] 
	ADD UpdatedDate DATETIME;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[TaxDetail]') 
	  AND NAME = 'CloudId'
)
BEGIN
	ALTER TABLE [dbo].TaxDetail 
	ADD CloudId INT NULL;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[TaxDetail]') 
	  AND NAME = 'LastSyncDate'
)
BEGIN
	ALTER TABLE [dbo].[TaxDetail] 
	ADD LastSyncDate DATETIME;
END
--==========================XeConnectLog========================
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[XeConnectLog]') 
	  AND NAME = 'isPost'
)
BEGIN
	ALTER TABLE [dbo].[XeConnectLog] 
	ADD isPost BIT DeFAULT(0) NOT NULL;
END

IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[XeConnectLog]') 
	  AND NAME = 'PostDate'
)
BEGIN
	ALTER TABLE [dbo].[XeConnectLog] 
	ADD PostDate DATETIME ;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[XeConnectLog]') 
	  AND NAME = 'isUpdated'
)
BEGIN
	ALTER TABLE [dbo].[XeConnectLog] 
	ADD isUpdated BIT DEFAULT(1) NOT NULL ;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[XeConnectLog]') 
	  AND NAME = 'UpdatedDate'
)
BEGIN
	ALTER TABLE [dbo].[XeConnectLog] 
	ADD UpdatedDate DATETIME;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[XeConnectLog]') 
	  AND NAME = 'CloudId'
)
BEGIN
	ALTER TABLE [dbo].XeConnectLog 
	ADD CloudId INT NULL;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[XeConnectLog]') 
	  AND NAME = 'LastSyncDate'
)
BEGIN
	ALTER TABLE [dbo].[XeConnectLog] 
	ADD LastSyncDate DATETIME;
END
--==========================XeConnectTransactions========================
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[XeConnectTransactions]') 
	  AND NAME = 'isPost'
)
BEGIN
	ALTER TABLE [dbo].[XeConnectTransactions] 
	ADD isPost BIT DeFAULT(0) NOT NULL;
END

IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[XeConnectTransactions]') 
	  AND NAME = 'PostDate'
)
BEGIN
	ALTER TABLE [dbo].[XeConnectTransactions] 
	ADD PostDate DATETIME ;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[XeConnectTransactions]') 
	  AND NAME = 'isUpdated'
)
BEGIN
	ALTER TABLE [dbo].[XeConnectTransactions] 
	ADD isUpdated BIT DEFAULT(1) NOT NULL ;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[XeConnectTransactions]') 
	  AND NAME = 'UpdatedDate'
)
BEGIN
	ALTER TABLE [dbo].[XeConnectTransactions] 
	ADD UpdatedDate DATETIME;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[XeConnectTransactions]') 
	  AND NAME = 'CloudId'
)
BEGIN
	ALTER TABLE [dbo].XeConnectTransactions 
	ADD CloudId INT NULL;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[XeConnectTransactions]') 
	  AND NAME = 'LastSyncDate'
)
BEGIN
	ALTER TABLE [dbo].[XeConnectTransactions] 
	ADD LastSyncDate DATETIME;
END
--==========================TransferHeader========================
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[TransferHeader]') 
	  AND NAME = 'isPost'
)
BEGIN
	ALTER TABLE [dbo].[TransferHeader] 
	ADD isPost BIT DeFAULT(0) NOT NULL;
END

IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[TransferHeader]') 
	  AND NAME = 'PostDate'
)
BEGIN
	ALTER TABLE [dbo].[TransferHeader] 
	ADD PostDate DATETIME ;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[TransferHeader]') 
	  AND NAME = 'isUpdated'
)
BEGIN
	ALTER TABLE [dbo].[TransferHeader] 
	ADD isUpdated BIT DEFAULT(1) NOT NULL ;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[TransferHeader]') 
	  AND NAME = 'UpdatedDate'
)
BEGIN
	ALTER TABLE [dbo].[TransferHeader] 
	ADD UpdatedDate DATETIME;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[TransferHeader]') 
	  AND NAME = 'CloudId'
)
BEGIN
	ALTER TABLE [dbo].TransferHeader 
	ADD CloudId INT NULL;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[TransferHeader]') 
	  AND NAME = 'LastSyncDate'
)
BEGIN
	ALTER TABLE [dbo].[TransferHeader] 
	ADD LastSyncDate DATETIME;
END
--==========================TransferDetail========================
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[TransferDetail]') 
	  AND NAME = 'isPost'
)
BEGIN
	ALTER TABLE [dbo].[TransferDetail] 
	ADD isPost BIT DeFAULT(0) NOT NULL;
END

IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[TransferDetail]') 
	  AND NAME = 'PostDate'
)
BEGIN
	ALTER TABLE [dbo].[TransferDetail] 
	ADD PostDate DATETIME ;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[TransferDetail]') 
	  AND NAME = 'isUpdated'
)
BEGIN
	ALTER TABLE [dbo].[TransferDetail] 
	ADD isUpdated BIT DEFAULT(1) NOT NULL ;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[TransferDetail]') 
	  AND NAME = 'UpdatedDate'
)
BEGIN
	ALTER TABLE [dbo].[TransferDetail] 
	ADD UpdatedDate DATETIME;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[TransferDetail]') 
	  AND NAME = 'CloudId'
)
BEGIN
	ALTER TABLE [dbo].TransferDetail 
	ADD CloudId INT NULL;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[TransferDetail]') 
	  AND NAME = 'LastSyncDate'
)
BEGIN
	ALTER TABLE [dbo].[TransferDetail] 
	ADD LastSyncDate DATETIME;
END
--==========================stocktakeheader========================
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[stocktakeheader]') 
	  AND NAME = 'isPost'
)
BEGIN
	ALTER TABLE [dbo].[stocktakeheader] 
	ADD isPost BIT DeFAULT(0) NOT NULL;
END

IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[stocktakeheader]') 
	  AND NAME = 'PostDate'
)
BEGIN
	ALTER TABLE [dbo].[stocktakeheader] 
	ADD PostDate DATETIME ;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[stocktakeheader]') 
	  AND NAME = 'isUpdated'
)
BEGIN
	ALTER TABLE [dbo].[stocktakeheader] 
	ADD isUpdated BIT DEFAULT(1) NOT NULL ;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[stocktakeheader]') 
	  AND NAME = 'UpdatedDate'
)
BEGIN
	ALTER TABLE [dbo].[stocktakeheader] 
	ADD UpdatedDate DATETIME;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[stocktakeheader]') 
	  AND NAME = 'CloudId'
)
BEGIN
	ALTER TABLE [dbo].stocktakeheader 
	ADD CloudId INT NULL;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[stocktakeheader]') 
	  AND NAME = 'LastSyncDate'
)
BEGIN
	ALTER TABLE [dbo].[stocktakeheader] 
	ADD LastSyncDate DATETIME;
END
--==========================WorkOrder========================
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[WorkOrder]') 
	  AND NAME = 'isPost'
)
BEGIN
	ALTER TABLE [dbo].[WorkOrder] 
	ADD isPost BIT DeFAULT(0) NOT NULL;
END

IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[WorkOrder]') 
	  AND NAME = 'PostDate'
)
BEGIN
	ALTER TABLE [dbo].[WorkOrder] 
	ADD PostDate DATETIME ;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[WorkOrder]') 
	  AND NAME = 'isUpdated'
)
BEGIN
	ALTER TABLE [dbo].[WorkOrder] 
	ADD isUpdated BIT DEFAULT(1) NOT NULL ;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[WorkOrder]') 
	  AND NAME = 'UpdatedDate'
)
BEGIN
	ALTER TABLE [dbo].[WorkOrder] 
	ADD UpdatedDate DATETIME;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[WorkOrder]') 
	  AND NAME = 'CloudId'
)
BEGIN
	ALTER TABLE [dbo].WorkOrder 
	ADD CloudId INT NULL;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[WorkOrder]') 
	  AND NAME = 'LastSyncDate'
)
BEGIN
	ALTER TABLE [dbo].[WorkOrder] 
	ADD LastSyncDate DATETIME;
END
--==========================ItemGroup========================
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[ItemGroup]') 
	  AND NAME = 'isPost'
)
BEGIN
	ALTER TABLE [dbo].[ItemGroup] 
	ADD isPost BIT DeFAULT(0) NOT NULL;
END

IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[ItemGroup]') 
	  AND NAME = 'PostDate'
)
BEGIN
	ALTER TABLE [dbo].[ItemGroup] 
	ADD PostDate DATETIME ;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[ItemGroup]') 
	  AND NAME = 'isUpdated'
)
BEGIN
	ALTER TABLE [dbo].[ItemGroup] 
	ADD isUpdated BIT DEFAULT(1) NOT NULL ;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[ItemGroup]') 
	  AND NAME = 'UpdatedDate'
)
BEGIN
	ALTER TABLE [dbo].[ItemGroup] 
	ADD UpdatedDate DATETIME;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[ItemGroup]') 
	  AND NAME = 'CloudId'
)
BEGIN
	ALTER TABLE [dbo].ItemGroup 
	ADD CloudId INT NULL;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[ItemGroup]') 
	  AND NAME = 'LastSyncDate'
)
BEGIN
	ALTER TABLE [dbo].[ItemGroup] 
	ADD LastSyncDate DATETIME;
END
--==========================TradeTrans========================
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[TradeTrans]') 
	  AND NAME = 'isPost'
)
BEGIN
	ALTER TABLE [dbo].[TradeTrans] 
	ADD isPost BIT DeFAULT(0) NOT NULL;
END

IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[TradeTrans]') 
	  AND NAME = 'PostDate'
)
BEGIN
	ALTER TABLE [dbo].[TradeTrans] 
	ADD PostDate DATETIME ;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[TradeTrans]') 
	  AND NAME = 'isUpdated'
)
BEGIN
	ALTER TABLE [dbo].[TradeTrans] 
	ADD isUpdated BIT DEFAULT(1) NOT NULL ;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[TradeTrans]') 
	  AND NAME = 'UpdatedDate'
)
BEGIN
	ALTER TABLE [dbo].[TradeTrans] 
	ADD UpdatedDate DATETIME;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[TradeTrans]') 
	  AND NAME = 'CloudId'
)
BEGIN
	ALTER TABLE [dbo].TradeTrans 
	ADD CloudId INT NULL;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[TradeTrans]') 
	  AND NAME = 'LastSyncDate'
)
BEGIN
	ALTER TABLE [dbo].[TradeTrans] 
	ADD LastSyncDate DATETIME;
END
--==========================TradeCustomers========================
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[TradeCustomers]') 
	  AND NAME = 'isPost'
)
BEGIN
	ALTER TABLE [dbo].[TradeCustomers] 
	ADD isPost BIT DeFAULT(0) NOT NULL;
END

IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[TradeCustomers]') 
	  AND NAME = 'PostDate'
)
BEGIN
	ALTER TABLE [dbo].[TradeCustomers] 
	ADD PostDate DATETIME ;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[TradeCustomers]') 
	  AND NAME = 'isUpdated'
)
BEGIN
	ALTER TABLE [dbo].[TradeCustomers] 
	ADD isUpdated BIT DEFAULT(1) NOT NULL ;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[TradeCustomers]') 
	  AND NAME = 'UpdatedDate'
)
BEGIN
	ALTER TABLE [dbo].[TradeCustomers] 
	ADD UpdatedDate DATETIME;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[TradeCustomers]') 
	  AND NAME = 'CloudId'
)
BEGIN
	ALTER TABLE [dbo].TradeCustomers 
	ADD CloudId INT NULL;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[TradeCustomers]') 
	  AND NAME = 'LastSyncDate'
)
BEGIN
	ALTER TABLE [dbo].[TradeCustomers] 
	ADD LastSyncDate DATETIME;
END
--==========================TradeTender========================
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[TradeTender]') 
	  AND NAME = 'isPost'
)
BEGIN
	ALTER TABLE [dbo].[TradeTender] 
	ADD isPost BIT DeFAULT(0) NOT NULL;
END

IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[TradeTender]') 
	  AND NAME = 'PostDate'
)
BEGIN
	ALTER TABLE [dbo].[TradeTender] 
	ADD PostDate DATETIME ;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[TradeTender]') 
	  AND NAME = 'isUpdated'
)
BEGIN
	ALTER TABLE [dbo].[TradeTender] 
	ADD isUpdated BIT DEFAULT(1) NOT NULL ;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[TradeTender]') 
	  AND NAME = 'UpdatedDate'
)
BEGIN
	ALTER TABLE [dbo].[TradeTender] 
	ADD UpdatedDate DATETIME;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[TradeTender]') 
	  AND NAME = 'CloudId'
)
BEGIN
	ALTER TABLE [dbo].TradeTender 
	ADD CloudId INT NULL;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[TradeTender]') 
	  AND NAME = 'LastSyncDate'
)
BEGIN
	ALTER TABLE [dbo].[TradeTender] 
	ADD LastSyncDate DATETIME;
END
--==========================TradeInvoiceTemplateLayout========================
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[TradeInvoiceTemplateLayout]') 
	  AND NAME = 'isPost'
)
BEGIN
	ALTER TABLE [dbo].[TradeInvoiceTemplateLayout] 
	ADD isPost BIT DeFAULT(0) NOT NULL;
END

IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[TradeInvoiceTemplateLayout]') 
	  AND NAME = 'PostDate'
)
BEGIN
	ALTER TABLE [dbo].[TradeInvoiceTemplateLayout] 
	ADD PostDate DATETIME ;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[TradeInvoiceTemplateLayout]') 
	  AND NAME = 'isUpdated'
)
BEGIN
	ALTER TABLE [dbo].[TradeInvoiceTemplateLayout] 
	ADD isUpdated BIT DEFAULT(1) NOT NULL ;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[TradeInvoiceTemplateLayout]') 
	  AND NAME = 'UpdatedDate'
)
BEGIN
	ALTER TABLE [dbo].[TradeInvoiceTemplateLayout] 
	ADD UpdatedDate DATETIME;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[TradeInvoiceTemplateLayout]') 
	  AND NAME = 'CloudId'
)
BEGIN
	ALTER TABLE [dbo].TradeInvoiceTemplateLayout 
	ADD CloudId INT NULL;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[TradeInvoiceTemplateLayout]') 
	  AND NAME = 'LastSyncDate'
)
BEGIN
	ALTER TABLE [dbo].[TradeInvoiceTemplateLayout] 
	ADD LastSyncDate DATETIME;
END
--==========================TradeCustomerCreditJournal========================
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[TradeCustomerCreditJournal]') 
	  AND NAME = 'isPost'
)
BEGIN
	ALTER TABLE [dbo].[TradeCustomerCreditJournal] 
	ADD isPost BIT DeFAULT(0) NOT NULL;
END

IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[TradeCustomerCreditJournal]') 
	  AND NAME = 'PostDate'
)
BEGIN
	ALTER TABLE [dbo].[TradeCustomerCreditJournal] 
	ADD PostDate DATETIME ;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[TradeCustomerCreditJournal]') 
	  AND NAME = 'isUpdated'
)
BEGIN
	ALTER TABLE [dbo].[TradeCustomerCreditJournal] 
	ADD isUpdated BIT DEFAULT(1) NOT NULL ;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[TradeCustomerCreditJournal]') 
	  AND NAME = 'UpdatedDate'
)
BEGIN
	ALTER TABLE [dbo].[TradeCustomerCreditJournal] 
	ADD UpdatedDate DATETIME;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[TradeCustomerCreditJournal]') 
	  AND NAME = 'CloudId'
)
BEGIN
	ALTER TABLE [dbo].TradeCustomerCreditJournal 
	ADD CloudId INT NULL;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[TradeCustomerCreditJournal]') 
	  AND NAME = 'LastSyncDate'
)
BEGIN
	ALTER TABLE [dbo].[TradeCustomerCreditJournal] 
	ADD LastSyncDate DATETIME;
END
--==========================TradeInvoiceTemplates========================
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[TradeInvoiceTemplates]') 
	  AND NAME = 'isPost'
)
BEGIN
	ALTER TABLE [dbo].[TradeInvoiceTemplates] 
	ADD isPost BIT DeFAULT(0) NOT NULL;
END

IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[TradeInvoiceTemplates]') 
	  AND NAME = 'PostDate'
)
BEGIN
	ALTER TABLE [dbo].[TradeInvoiceTemplates] 
	ADD PostDate DATETIME ;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[TradeInvoiceTemplates]') 
	  AND NAME = 'isUpdated'
)
BEGIN
	ALTER TABLE [dbo].[TradeInvoiceTemplates] 
	ADD isUpdated BIT DEFAULT(1) NOT NULL ;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[TradeInvoiceTemplates]') 
	  AND NAME = 'UpdatedDate'
)
BEGIN
	ALTER TABLE [dbo].[TradeInvoiceTemplates] 
	ADD UpdatedDate DATETIME;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[TradeInvoiceTemplates]') 
	  AND NAME = 'CloudId'
)
BEGIN
	ALTER TABLE [dbo].TradeInvoiceTemplates 
	ADD CloudId INT NULL;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[TradeInvoiceTemplates]') 
	  AND NAME = 'LastSyncDate'
)
BEGIN
	ALTER TABLE [dbo].[TradeInvoiceTemplates] 
	ADD LastSyncDate DATETIME;
END
--==========================TradeInvoices========================
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[TradeInvoices]') 
	  AND NAME = 'isPost'
)
BEGIN
	ALTER TABLE [dbo].[TradeInvoices] 
	ADD isPost BIT DeFAULT(0) NOT NULL;
END

IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[TradeInvoices]') 
	  AND NAME = 'PostDate'
)
BEGIN
	ALTER TABLE [dbo].[TradeInvoices] 
	ADD PostDate DATETIME ;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[TradeInvoices]') 
	  AND NAME = 'isUpdated'
)
BEGIN
	ALTER TABLE [dbo].[TradeInvoices] 
	ADD isUpdated BIT DEFAULT(1) NOT NULL ;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[TradeInvoices]') 
	  AND NAME = 'UpdatedDate'
)
BEGIN
	ALTER TABLE [dbo].[TradeInvoices] 
	ADD UpdatedDate DATETIME;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[TradeInvoices]') 
	  AND NAME = 'CloudId'
)
BEGIN
	ALTER TABLE [dbo].TradeInvoices 
	ADD CloudId INT NULL;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[TradeInvoices]') 
	  AND NAME = 'LastSyncDate'
)
BEGIN
	ALTER TABLE [dbo].[TradeInvoices] 
	ADD LastSyncDate DATETIME;
END
--==========================TradeInvoiceItems========================
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[TradeInvoiceItems]') 
	  AND NAME = 'isPost'
)
BEGIN
	ALTER TABLE [dbo].[TradeInvoiceItems] 
	ADD isPost BIT DeFAULT(0) NOT NULL;
END

IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[TradeInvoiceItems]') 
	  AND NAME = 'PostDate'
)
BEGIN
	ALTER TABLE [dbo].[TradeInvoiceItems] 
	ADD PostDate DATETIME ;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[TradeInvoiceItems]') 
	  AND NAME = 'isUpdated'
)
BEGIN
	ALTER TABLE [dbo].[TradeInvoiceItems] 
	ADD isUpdated BIT DEFAULT(1) NOT NULL ;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[TradeInvoiceItems]') 
	  AND NAME = 'UpdatedDate'
)
BEGIN
	ALTER TABLE [dbo].[TradeInvoiceItems] 
	ADD UpdatedDate DATETIME;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[TradeInvoiceItems]') 
	  AND NAME = 'CloudId'
)
BEGIN
	ALTER TABLE [dbo].TradeInvoiceItems 
	ADD CloudId INT NULL;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[TradeInvoiceItems]') 
	  AND NAME = 'LastSyncDate'
)
BEGIN
	ALTER TABLE [dbo].[TradeInvoiceItems] 
	ADD LastSyncDate DATETIME;
END
--==========================TradeCloseoutTender========================
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[TradeCloseoutTender]') 
	  AND NAME = 'isPost'
)
BEGIN
	ALTER TABLE [dbo].[TradeCloseoutTender] 
	ADD isPost BIT DeFAULT(0) NOT NULL;
END

IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[TradeCloseoutTender]') 
	  AND NAME = 'PostDate'
)
BEGIN
	ALTER TABLE [dbo].[TradeCloseoutTender] 
	ADD PostDate DATETIME ;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[TradeCloseoutTender]') 
	  AND NAME = 'isUpdated'
)
BEGIN
	ALTER TABLE [dbo].[TradeCloseoutTender] 
	ADD isUpdated BIT DEFAULT(1) NOT NULL ;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[TradeCloseoutTender]') 
	  AND NAME = 'UpdatedDate'
)
BEGIN
	ALTER TABLE [dbo].[TradeCloseoutTender] 
	ADD UpdatedDate DATETIME;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[TradeCloseoutTender]') 
	  AND NAME = 'CloudId'
)
BEGIN
	ALTER TABLE [dbo].TradeCloseoutTender 
	ADD CloudId INT NULL;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[TradeCloseoutTender]') 
	  AND NAME = 'LastSyncDate'
)
BEGIN
	ALTER TABLE [dbo].[TradeCloseoutTender] 
	ADD LastSyncDate DATETIME;
END
--==========================TradeCloseoutHeader========================
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[TradeCloseoutHeader]') 
	  AND NAME = 'isPost'
)
BEGIN
	ALTER TABLE [dbo].[TradeCloseoutHeader] 
	ADD isPost BIT DeFAULT(0) NOT NULL;
END

IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[TradeCloseoutHeader]') 
	  AND NAME = 'PostDate'
)
BEGIN
	ALTER TABLE [dbo].[TradeCloseoutHeader] 
	ADD PostDate DATETIME ;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[TradeCloseoutHeader]') 
	  AND NAME = 'isUpdated'
)
BEGIN
	ALTER TABLE [dbo].[TradeCloseoutHeader] 
	ADD isUpdated BIT DEFAULT(1) NOT NULL ;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[TradeCloseoutHeader]') 
	  AND NAME = 'UpdatedDate'
)
BEGIN
	ALTER TABLE [dbo].[TradeCloseoutHeader] 
	ADD UpdatedDate DATETIME;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[TradeCloseoutHeader]') 
	  AND NAME = 'CloudId'
)
BEGIN
	ALTER TABLE [dbo].TradeCloseoutHeader 
	ADD CloudId INT NULL;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[TradeCloseoutHeader]') 
	  AND NAME = 'LastSyncDate'
)
BEGIN
	ALTER TABLE [dbo].[TradeCloseoutHeader] 
	ADD LastSyncDate DATETIME;
END
--==========================TradeCloseoutCustomerSummary========================
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[TradeCloseoutCustomerSummary]') 
	  AND NAME = 'isPost'
)
BEGIN
	ALTER TABLE [dbo].[TradeCloseoutCustomerSummary] 
	ADD isPost BIT DeFAULT(0) NOT NULL;
END

IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[TradeCloseoutCustomerSummary]') 
	  AND NAME = 'PostDate'
)
BEGIN
	ALTER TABLE [dbo].[TradeCloseoutCustomerSummary] 
	ADD PostDate DATETIME ;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[TradeCloseoutCustomerSummary]') 
	  AND NAME = 'isUpdated'
)
BEGIN
	ALTER TABLE [dbo].[TradeCloseoutCustomerSummary] 
	ADD isUpdated BIT DEFAULT(1) NOT NULL ;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[TradeCloseoutCustomerSummary]') 
	  AND NAME = 'UpdatedDate'
)
BEGIN
	ALTER TABLE [dbo].[TradeCloseoutCustomerSummary] 
	ADD UpdatedDate DATETIME;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[TradeCloseoutCustomerSummary]') 
	  AND NAME = 'CloudId'
)
BEGIN
	ALTER TABLE [dbo].TradeCloseoutCustomerSummary 
	ADD CloudId INT NULL;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[TradeCloseoutCustomerSummary]') 
	  AND NAME = 'LastSyncDate'
)
BEGIN
	ALTER TABLE [dbo].[TradeCloseoutCustomerSummary] 
	ADD LastSyncDate DATETIME;
END

--==========================Setup========================
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[Setup]') 
	  AND NAME = 'isPost'
)
BEGIN
	ALTER TABLE [dbo].[Setup] 
	ADD isPost BIT DeFAULT(0) NOT NULL;
END

IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[Setup]') 
	  AND NAME = 'PostDate'
)
BEGIN
	ALTER TABLE [dbo].[Setup] 
	ADD PostDate DATETIME ;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[Setup]') 
	  AND NAME = 'isUpdated'
)
BEGIN
	ALTER TABLE [dbo].[Setup] 
	ADD isUpdated BIT DEFAULT(1) NOT NULL ;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[Setup]') 
	  AND NAME = 'UpdatedDate'
)
BEGIN
	ALTER TABLE [dbo].[Setup] 
	ADD UpdatedDate DATETIME;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[Setup]') 
	  AND NAME = 'CloudId'
)
BEGIN
	ALTER TABLE [dbo].Setup 
	ADD CloudId INT NULL;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[Setup]') 
	  AND NAME = 'LastSyncDate'
)
BEGIN
	ALTER TABLE [dbo].[Setup] 
	ADD LastSyncDate DATETIME;
END

--==========================POSFunctionSetup========================
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[POSFunctionSetup]') 
	  AND NAME = 'isPost'
)
BEGIN
	ALTER TABLE [dbo].[POSFunctionSetup] 
	ADD isPost BIT DeFAULT(0) NOT NULL;
END

IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[POSFunctionSetup]') 
	  AND NAME = 'PostDate'
)
BEGIN
	ALTER TABLE [dbo].[POSFunctionSetup] 
	ADD PostDate DATETIME ;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[POSFunctionSetup]') 
	  AND NAME = 'isUpdated'
)
BEGIN
	ALTER TABLE [dbo].[POSFunctionSetup] 
	ADD isUpdated BIT DEFAULT(1) NOT NULL ;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[POSFunctionSetup]') 
	  AND NAME = 'UpdatedDate'
)
BEGIN
	ALTER TABLE [dbo].[POSFunctionSetup] 
	ADD UpdatedDate DATETIME;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[POSFunctionSetup]') 
	  AND NAME = 'CloudId'
)
BEGIN
	ALTER TABLE [dbo].POSFunctionSetup 
	ADD CloudId INT NULL;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[POSFunctionSetup]') 
	  AND NAME = 'LastSyncDate'
)
BEGIN
	ALTER TABLE [dbo].[POSFunctionSetup] 
	ADD LastSyncDate DATETIME;
END

--==========================LocalSetup========================
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[LocalSetup]') 
	  AND NAME = 'isPost'
)
BEGIN
	ALTER TABLE [dbo].[LocalSetup] 
	ADD isPost BIT DeFAULT(0) NOT NULL;
END

IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[LocalSetup]') 
	  AND NAME = 'PostDate'
)
BEGIN
	ALTER TABLE [dbo].[LocalSetup] 
	ADD PostDate DATETIME ;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[LocalSetup]') 
	  AND NAME = 'isUpdated'
)
BEGIN
	ALTER TABLE [dbo].[LocalSetup] 
	ADD isUpdated BIT DEFAULT(1) NOT NULL ;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[LocalSetup]') 
	  AND NAME = 'UpdatedDate'
)
BEGIN
	ALTER TABLE [dbo].[LocalSetup] 
	ADD UpdatedDate DATETIME;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[LocalSetup]') 
	  AND NAME = 'CloudId'
)
BEGIN
	ALTER TABLE [dbo].LocalSetup 
	ADD CloudId INT NULL;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[LocalSetup]') 
	  AND NAME = 'LastSyncDate'
)
BEGIN
	ALTER TABLE [dbo].[LocalSetup] 
	ADD LastSyncDate DATETIME;
END
--==========================ExportBookingSetup========================
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[ExportBookingSetup]') 
	  AND NAME = 'isPost'
)
BEGIN
	ALTER TABLE [dbo].[ExportBookingSetup] 
	ADD isPost BIT DeFAULT(0) NOT NULL;
END

IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[ExportBookingSetup]') 
	  AND NAME = 'PostDate'
)
BEGIN
	ALTER TABLE [dbo].[ExportBookingSetup] 
	ADD PostDate DATETIME ;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[ExportBookingSetup]') 
	  AND NAME = 'isUpdated'
)
BEGIN
	ALTER TABLE [dbo].[ExportBookingSetup] 
	ADD isUpdated BIT DEFAULT(1) NOT NULL ;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[ExportBookingSetup]') 
	  AND NAME = 'UpdatedDate'
)
BEGIN
	ALTER TABLE [dbo].[ExportBookingSetup] 
	ADD UpdatedDate DATETIME;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[ExportBookingSetup]') 
	  AND NAME = 'CloudId'
)
BEGIN
	ALTER TABLE [dbo].ExportBookingSetup 
	ADD CloudId INT NULL;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[ExportBookingSetup]') 
	  AND NAME = 'LastSyncDate'
)
BEGIN
	ALTER TABLE [dbo].[ExportBookingSetup] 
	ADD LastSyncDate DATETIME;
END
--==========================GeneralMapping========================
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[GeneralMapping]') 
	  AND NAME = 'isPost'
)
BEGIN
	ALTER TABLE [dbo].[GeneralMapping] 
	ADD isPost BIT DeFAULT(0) NOT NULL;
END

IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[GeneralMapping]') 
	  AND NAME = 'PostDate'
)
BEGIN
	ALTER TABLE [dbo].[GeneralMapping] 
	ADD PostDate DATETIME ;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[GeneralMapping]') 
	  AND NAME = 'isUpdated'
)
BEGIN
	ALTER TABLE [dbo].[GeneralMapping] 
	ADD isUpdated BIT DEFAULT(1) NOT NULL ;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[GeneralMapping]') 
	  AND NAME = 'UpdatedDate'
)
BEGIN
	ALTER TABLE [dbo].[GeneralMapping] 
	ADD UpdatedDate DATETIME;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[GeneralMapping]') 
	  AND NAME = 'CloudId'
)
BEGIN
	ALTER TABLE [dbo].GeneralMapping 
	ADD CloudId INT NULL;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[GeneralMapping]') 
	  AND NAME = 'LastSyncDate'
)
BEGIN
	ALTER TABLE [dbo].[GeneralMapping] 
	ADD LastSyncDate DATETIME;
END

--==========================GeneralLog========================
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[GeneralLog]') 
	  AND NAME = 'isPost'
)
BEGIN
	ALTER TABLE [dbo].[GeneralLog] 
	ADD isPost BIT DeFAULT(0) NOT NULL;
END

IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[GeneralLog]') 
	  AND NAME = 'PostDate'
)
BEGIN
	ALTER TABLE [dbo].[GeneralLog] 
	ADD PostDate DATETIME ;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[GeneralLog]') 
	  AND NAME = 'isUpdated'
)
BEGIN
	ALTER TABLE [dbo].[GeneralLog] 
	ADD isUpdated BIT DEFAULT(1) NOT NULL ;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[GeneralLog]') 
	  AND NAME = 'UpdatedDate'
)
BEGIN
	ALTER TABLE [dbo].[GeneralLog] 
	ADD UpdatedDate DATETIME;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[GeneralLog]') 
	  AND NAME = 'CloudId'
)
BEGIN
	ALTER TABLE [dbo].GeneralLog 
	ADD CloudId INT NULL;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[GeneralLog]') 
	  AND NAME = 'LastSyncDate'
)
BEGIN
	ALTER TABLE [dbo].[GeneralLog] 
	ADD LastSyncDate DATETIME;
END

--==========================SecurityGroup========================
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[SecurityGroup]') 
	  AND NAME = 'isPost'
)
BEGIN
	ALTER TABLE [dbo].[SecurityGroup] 
	ADD isPost BIT DeFAULT(0) NOT NULL;
END

IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[SecurityGroup]') 
	  AND NAME = 'PostDate'
)
BEGIN
	ALTER TABLE [dbo].[SecurityGroup] 
	ADD PostDate DATETIME ;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[SecurityGroup]') 
	  AND NAME = 'isUpdated'
)
BEGIN
	ALTER TABLE [dbo].[SecurityGroup] 
	ADD isUpdated BIT DEFAULT(1) NOT NULL ;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[SecurityGroup]') 
	  AND NAME = 'UpdatedDate'
)
BEGIN
	ALTER TABLE [dbo].[SecurityGroup] 
	ADD UpdatedDate DATETIME;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[SecurityGroup]') 
	  AND NAME = 'CloudId'
)
BEGIN
	ALTER TABLE [dbo].SecurityGroup 
	ADD CloudId INT NULL;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[SecurityGroup]') 
	  AND NAME = 'LastSyncDate'
)
BEGIN
	ALTER TABLE [dbo].[SecurityGroup] 
	ADD LastSyncDate DATETIME;
END