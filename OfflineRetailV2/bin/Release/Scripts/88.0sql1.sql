USE Retail2020DB
GO
--==========================DiscountMaster========================

IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[DiscountMaster]') 
	  AND NAME = 'isPost'
)
BEGIN
	ALTER TABLE [dbo].[DiscountMaster] 
	ADD isPost BIT DeFAULT(0) NOT NULL;
END

IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[DiscountMaster]') 
	  AND NAME = 'PostDate'
)
BEGIN
	ALTER TABLE [dbo].[DiscountMaster] 
	ADD PostDate DATETIME ;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[DiscountMaster]') 
	  AND NAME = 'isUpdated'
)
BEGIN
	ALTER TABLE [dbo].[DiscountMaster] 
	ADD isUpdated BIT DEFAULT(1) NOT NULL ;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[DiscountMaster]') 
	  AND NAME = 'UpdatedDate'
)
BEGIN
	ALTER TABLE [dbo].[DiscountMaster] 
	ADD UpdatedDate DATETIME;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[DiscountMaster]') 
	  AND NAME = 'CloudId'
)
BEGIN
	ALTER TABLE [dbo].DiscountMaster 
	ADD CloudId INT NULL;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[DiscountMaster]') 
	  AND NAME = 'LastSyncDate'
)
BEGIN
	ALTER TABLE [dbo].[DiscountMaster] 
	ADD LastSyncDate DATETIME;
END

--==========================TempDiscountID========================

IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[TempDiscountID]') 
	  AND NAME = 'isPost'
)
BEGIN
	ALTER TABLE [dbo].[TempDiscountID] 
	ADD isPost BIT DeFAULT(0) NOT NULL;
END

IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[TempDiscountID]') 
	  AND NAME = 'PostDate'
)
BEGIN
	ALTER TABLE [dbo].[TempDiscountID] 
	ADD PostDate DATETIME ;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[TempDiscountID]') 
	  AND NAME = 'isUpdated'
)
BEGIN
	ALTER TABLE [dbo].[TempDiscountID] 
	ADD isUpdated BIT DEFAULT(1) NOT NULL ;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[TempDiscountID]') 
	  AND NAME = 'UpdatedDate'
)
BEGIN
	ALTER TABLE [dbo].[TempDiscountID] 
	ADD UpdatedDate DATETIME;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[TempDiscountID]') 
	  AND NAME = 'CloudId'
)
BEGIN
	ALTER TABLE [dbo].TempDiscountID 
	ADD CloudId INT NULL;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[TempDiscountID]') 
	  AND NAME = 'LastSyncDate'
)
BEGIN
	ALTER TABLE [dbo].[TempDiscountID] 
	ADD LastSyncDate DATETIME;
END

--==========================BuyNGetFreeHeader========================

IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[BuyNGetFreeHeader]') 
	  AND NAME = 'isPost'
)
BEGIN
	ALTER TABLE [dbo].[BuyNGetFreeHeader] 
	ADD isPost BIT DeFAULT(0) NOT NULL;
END

IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[BuyNGetFreeHeader]') 
	  AND NAME = 'PostDate'
)
BEGIN
	ALTER TABLE [dbo].[BuyNGetFreeHeader] 
	ADD PostDate DATETIME ;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[BuyNGetFreeHeader]') 
	  AND NAME = 'isUpdated'
)
BEGIN
	ALTER TABLE [dbo].[BuyNGetFreeHeader] 
	ADD isUpdated BIT DEFAULT(1) NOT NULL ;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[BuyNGetFreeHeader]') 
	  AND NAME = 'UpdatedDate'
)
BEGIN
	ALTER TABLE [dbo].[BuyNGetFreeHeader] 
	ADD UpdatedDate DATETIME;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[BuyNGetFreeHeader]') 
	  AND NAME = 'CloudId'
)
BEGIN
	ALTER TABLE [dbo].BuyNGetFreeHeader 
	ADD CloudId INT NULL;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[BuyNGetFreeHeader]') 
	  AND NAME = 'LastSyncDate'
)
BEGIN
	ALTER TABLE [dbo].[BuyNGetFreeHeader] 
	ADD LastSyncDate DATETIME;
END

--==========================BuyNGetFreeDetails========================

IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[BuyNGetFreeDetails]') 
	  AND NAME = 'isPost'
)
BEGIN
	ALTER TABLE [dbo].[BuyNGetFreeDetails] 
	ADD isPost BIT DeFAULT(0) NOT NULL;
END

IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[BuyNGetFreeDetails]') 
	  AND NAME = 'PostDate'
)
BEGIN
	ALTER TABLE [dbo].[BuyNGetFreeDetails] 
	ADD PostDate DATETIME ;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[BuyNGetFreeDetails]') 
	  AND NAME = 'isUpdated'
)
BEGIN
	ALTER TABLE [dbo].[BuyNGetFreeDetails] 
	ADD isUpdated BIT DEFAULT(1) NOT NULL ;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[BuyNGetFreeDetails]') 
	  AND NAME = 'UpdatedDate'
)
BEGIN
	ALTER TABLE [dbo].[BuyNGetFreeDetails] 
	ADD UpdatedDate DATETIME;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[BuyNGetFreeDetails]') 
	  AND NAME = 'CloudId'
)
BEGIN
	ALTER TABLE [dbo].BuyNGetFreeDetails 
	ADD CloudId INT NULL;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[BuyNGetFreeDetails]') 
	  AND NAME = 'LastSyncDate'
)
BEGIN
	ALTER TABLE [dbo].[BuyNGetFreeDetails] 
	ADD LastSyncDate DATETIME;
END

--==========================MixNmatchHeader========================

IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[MixNmatchHeader]') 
	  AND NAME = 'isPost'
)
BEGIN
	ALTER TABLE [dbo].[MixNmatchHeader] 
	ADD isPost BIT DeFAULT(0) NOT NULL;
END

IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[MixNmatchHeader]') 
	  AND NAME = 'PostDate'
)
BEGIN
	ALTER TABLE [dbo].[MixNmatchHeader] 
	ADD PostDate DATETIME ;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[MixNmatchHeader]') 
	  AND NAME = 'isUpdated'
)
BEGIN
	ALTER TABLE [dbo].[MixNmatchHeader] 
	ADD isUpdated BIT DEFAULT(1) NOT NULL ;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[MixNmatchHeader]') 
	  AND NAME = 'UpdatedDate'
)
BEGIN
	ALTER TABLE [dbo].[MixNmatchHeader] 
	ADD UpdatedDate DATETIME;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[MixNmatchHeader]') 
	  AND NAME = 'CloudId'
)
BEGIN
	ALTER TABLE [dbo].MixNmatchHeader 
	ADD CloudId INT NULL;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[MixNmatchHeader]') 
	  AND NAME = 'LastSyncDate'
)
BEGIN
	ALTER TABLE [dbo].[MixNmatchHeader] 
	ADD LastSyncDate DATETIME;
END
--==========================SalePriceHeader========================

IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[SalePriceHeader]') 
	  AND NAME = 'isPost'
)
BEGIN
	ALTER TABLE [dbo].[SalePriceHeader] 
	ADD isPost BIT DeFAULT(0) NOT NULL;
END

IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[SalePriceHeader]') 
	  AND NAME = 'PostDate'
)
BEGIN
	ALTER TABLE [dbo].[SalePriceHeader] 
	ADD PostDate DATETIME ;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[SalePriceHeader]') 
	  AND NAME = 'isUpdated'
)
BEGIN
	ALTER TABLE [dbo].[SalePriceHeader] 
	ADD isUpdated BIT DEFAULT(1) NOT NULL ;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[SalePriceHeader]') 
	  AND NAME = 'UpdatedDate'
)
BEGIN
	ALTER TABLE [dbo].[SalePriceHeader] 
	ADD UpdatedDate DATETIME;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[SalePriceHeader]') 
	  AND NAME = 'CloudId'
)
BEGIN
	ALTER TABLE [dbo].SalePriceHeader 
	ADD CloudId INT NULL;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[SalePriceHeader]') 
	  AND NAME = 'LastSyncDate'
)
BEGIN
	ALTER TABLE [dbo].[SalePriceHeader] 
	ADD LastSyncDate DATETIME;
END

--==========================SalePriceDetails========================

IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[SalePriceDetails]') 
	  AND NAME = 'isPost'
)
BEGIN
	ALTER TABLE [dbo].[SalePriceDetails] 
	ADD isPost BIT DeFAULT(0) NOT NULL;
END

IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[SalePriceDetails]') 
	  AND NAME = 'PostDate'
)
BEGIN
	ALTER TABLE [dbo].[SalePriceDetails] 
	ADD PostDate DATETIME ;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[SalePriceDetails]') 
	  AND NAME = 'isUpdated'
)
BEGIN
	ALTER TABLE [dbo].[SalePriceDetails] 
	ADD isUpdated BIT DEFAULT(1) NOT NULL ;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[SalePriceDetails]') 
	  AND NAME = 'UpdatedDate'
)
BEGIN
	ALTER TABLE [dbo].[SalePriceDetails] 
	ADD UpdatedDate DATETIME;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[SalePriceDetails]') 
	  AND NAME = 'CloudId'
)
BEGIN
	ALTER TABLE [dbo].SalePriceDetails 
	ADD CloudId INT NULL;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[SalePriceDetails]') 
	  AND NAME = 'LastSyncDate'
)
BEGIN
	ALTER TABLE [dbo].[SalePriceDetails] 
	ADD LastSyncDate DATETIME;
END
--==========================FuturePriceHeader========================

IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[FuturePriceHeader]') 
	  AND NAME = 'isPost'
)
BEGIN
	ALTER TABLE [dbo].[FuturePriceHeader] 
	ADD isPost BIT DeFAULT(0) NOT NULL;
END

IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[FuturePriceHeader]') 
	  AND NAME = 'PostDate'
)
BEGIN
	ALTER TABLE [dbo].[FuturePriceHeader] 
	ADD PostDate DATETIME ;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[FuturePriceHeader]') 
	  AND NAME = 'isUpdated'
)
BEGIN
	ALTER TABLE [dbo].[FuturePriceHeader] 
	ADD isUpdated BIT DEFAULT(1) NOT NULL ;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[FuturePriceHeader]') 
	  AND NAME = 'UpdatedDate'
)
BEGIN
	ALTER TABLE [dbo].[FuturePriceHeader] 
	ADD UpdatedDate DATETIME;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[FuturePriceHeader]') 
	  AND NAME = 'CloudId'
)
BEGIN
	ALTER TABLE [dbo].FuturePriceHeader 
	ADD CloudId INT NULL;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[FuturePriceHeader]') 
	  AND NAME = 'LastSyncDate'
)
BEGIN
	ALTER TABLE [dbo].[FuturePriceHeader] 
	ADD LastSyncDate DATETIME;
END
--==========================FuturePriceDetails========================

IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[FuturePriceDetails]') 
	  AND NAME = 'isPost'
)
BEGIN
	ALTER TABLE [dbo].[FuturePriceDetails] 
	ADD isPost BIT DeFAULT(0) NOT NULL;
END

IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[FuturePriceDetails]') 
	  AND NAME = 'PostDate'
)
BEGIN
	ALTER TABLE [dbo].[FuturePriceDetails] 
	ADD PostDate DATETIME ;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[FuturePriceDetails]') 
	  AND NAME = 'isUpdated'
)
BEGIN
	ALTER TABLE [dbo].[FuturePriceDetails] 
	ADD isUpdated BIT DEFAULT(1) NOT NULL ;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[FuturePriceDetails]') 
	  AND NAME = 'UpdatedDate'
)
BEGIN
	ALTER TABLE [dbo].[FuturePriceDetails] 
	ADD UpdatedDate DATETIME;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[FuturePriceDetails]') 
	  AND NAME = 'CloudId'
)
BEGIN
	ALTER TABLE [dbo].FuturePriceDetails 
	ADD CloudId INT NULL;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[FuturePriceDetails]') 
	  AND NAME = 'LastSyncDate'
)
BEGIN
	ALTER TABLE [dbo].[FuturePriceDetails] 
	ADD LastSyncDate DATETIME;
END
--==========================FeesMaster========================

IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[FeesMaster]') 
	  AND NAME = 'isPost'
)
BEGIN
	ALTER TABLE [dbo].[FeesMaster] 
	ADD isPost BIT DeFAULT(0) NOT NULL;
END

IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[FeesMaster]') 
	  AND NAME = 'PostDate'
)
BEGIN
	ALTER TABLE [dbo].[FeesMaster] 
	ADD PostDate DATETIME ;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[FeesMaster]') 
	  AND NAME = 'isUpdated'
)
BEGIN
	ALTER TABLE [dbo].[FeesMaster] 
	ADD isUpdated BIT DEFAULT(1) NOT NULL ;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[FeesMaster]') 
	  AND NAME = 'UpdatedDate'
)
BEGIN
	ALTER TABLE [dbo].[FeesMaster] 
	ADD UpdatedDate DATETIME;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[FeesMaster]') 
	  AND NAME = 'CloudId'
)
BEGIN
	ALTER TABLE [dbo].FeesMaster 
	ADD CloudId INT NULL;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[FeesMaster]') 
	  AND NAME = 'LastSyncDate'
)
BEGIN
	ALTER TABLE [dbo].[FeesMaster] 
	ADD LastSyncDate DATETIME;
END
--==========================FeesRestrictedItems========================

IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[FeesRestrictedItems]') 
	  AND NAME = 'isPost'
)
BEGIN
	ALTER TABLE [dbo].[FeesRestrictedItems] 
	ADD isPost BIT DeFAULT(0) NOT NULL;
END

IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[FeesRestrictedItems]') 
	  AND NAME = 'PostDate'
)
BEGIN
	ALTER TABLE [dbo].[FeesRestrictedItems] 
	ADD PostDate DATETIME ;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[FeesRestrictedItems]') 
	  AND NAME = 'isUpdated'
)
BEGIN
	ALTER TABLE [dbo].[FeesRestrictedItems] 
	ADD isUpdated BIT DEFAULT(1) NOT NULL ;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[FeesRestrictedItems]') 
	  AND NAME = 'UpdatedDate'
)
BEGIN
	ALTER TABLE [dbo].[FeesRestrictedItems] 
	ADD UpdatedDate DATETIME;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[FeesRestrictedItems]') 
	  AND NAME = 'CloudId'
)
BEGIN
	ALTER TABLE [dbo].FeesRestrictedItems 
	ADD CloudId INT NULL;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[FeesRestrictedItems]') 
	  AND NAME = 'LastSyncDate'
)
BEGIN
	ALTER TABLE [dbo].[FeesRestrictedItems] 
	ADD LastSyncDate DATETIME;
END
--==========================SecurityPermission========================

IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[SecurityPermission]') 
	  AND NAME = 'isPost'
)
BEGIN
	ALTER TABLE [dbo].[SecurityPermission] 
	ADD isPost BIT DeFAULT(0) NOT NULL;
END

IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[SecurityPermission]') 
	  AND NAME = 'PostDate'
)
BEGIN
	ALTER TABLE [dbo].[SecurityPermission] 
	ADD PostDate DATETIME ;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[SecurityPermission]') 
	  AND NAME = 'isUpdated'
)
BEGIN
	ALTER TABLE [dbo].[SecurityPermission] 
	ADD isUpdated BIT DEFAULT(1) NOT NULL ;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[SecurityPermission]') 
	  AND NAME = 'UpdatedDate'
)
BEGIN
	ALTER TABLE [dbo].[SecurityPermission] 
	ADD UpdatedDate DATETIME;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[SecurityPermission]') 
	  AND NAME = 'CloudId'
)
BEGIN
	ALTER TABLE [dbo].SecurityPermission 
	ADD CloudId INT NULL;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[SecurityPermission]') 
	  AND NAME = 'LastSyncDate'
)
BEGIN
	ALTER TABLE [dbo].[SecurityPermission] 
	ADD LastSyncDate DATETIME;
END