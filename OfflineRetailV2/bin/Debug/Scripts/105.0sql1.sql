USE Retail2020DB
GO
--==========================ReceiptTemplateMaster========================

IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[ReceiptTemplateMaster]') 
	  AND NAME = 'isPost'
)
BEGIN
	ALTER TABLE [dbo].[ReceiptTemplateMaster] 
	ADD isPost BIT DeFAULT(0) NOT NULL;
END

IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[ReceiptTemplateMaster]') 
	  AND NAME = 'PostDate'
)
BEGIN
	ALTER TABLE [dbo].[ReceiptTemplateMaster] 
	ADD PostDate DATETIME ;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[ReceiptTemplateMaster]') 
	  AND NAME = 'isUpdated'
)
BEGIN
	ALTER TABLE [dbo].[ReceiptTemplateMaster] 
	ADD isUpdated BIT DEFAULT(1) NOT NULL ;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[ReceiptTemplateMaster]') 
	  AND NAME = 'UpdatedDate'
)
BEGIN
	ALTER TABLE [dbo].[ReceiptTemplateMaster] 
	ADD UpdatedDate DATETIME;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[ReceiptTemplateMaster]') 
	  AND NAME = 'CloudId'
)
BEGIN
	ALTER TABLE [dbo].ReceiptTemplateMaster 
	ADD CloudId INT NULL;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[ReceiptTemplateMaster]') 
	  AND NAME = 'LastSyncDate'
)
BEGIN
	ALTER TABLE [dbo].[ReceiptTemplateMaster] 
	ADD LastSyncDate DATETIME;
END

--==========================ReceiptTemplateLinkData========================

IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[ReceiptTemplateLinkData]') 
	  AND NAME = 'isPost'
)
BEGIN
	ALTER TABLE [dbo].[ReceiptTemplateLinkData] 
	ADD isPost BIT DeFAULT(0) NOT NULL;
END

IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[ReceiptTemplateLinkData]') 
	  AND NAME = 'PostDate'
)
BEGIN
	ALTER TABLE [dbo].[ReceiptTemplateLinkData] 
	ADD PostDate DATETIME ;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[ReceiptTemplateLinkData]') 
	  AND NAME = 'isUpdated'
)
BEGIN
	ALTER TABLE [dbo].[ReceiptTemplateLinkData] 
	ADD isUpdated BIT DEFAULT(1) NOT NULL ;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[ReceiptTemplateLinkData]') 
	  AND NAME = 'UpdatedDate'
)
BEGIN
	ALTER TABLE [dbo].[ReceiptTemplateLinkData] 
	ADD UpdatedDate DATETIME;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[ReceiptTemplateLinkData]') 
	  AND NAME = 'CloudId'
)
BEGIN
	ALTER TABLE [dbo].ReceiptTemplateLinkData 
	ADD CloudId INT NULL;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[ReceiptTemplateLinkData]') 
	  AND NAME = 'LastSyncDate'
)
BEGIN
	ALTER TABLE [dbo].[ReceiptTemplateLinkData] 
	ADD LastSyncDate DATETIME;
END
--==========================ReceiptTemplateActive========================

IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[ReceiptTemplateActive]') 
	  AND NAME = 'isPost'
)
BEGIN
	ALTER TABLE [dbo].[ReceiptTemplateActive] 
	ADD isPost BIT DeFAULT(0) NOT NULL;
END

IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[ReceiptTemplateActive]') 
	  AND NAME = 'PostDate'
)
BEGIN
	ALTER TABLE [dbo].[ReceiptTemplateActive] 
	ADD PostDate DATETIME ;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[ReceiptTemplateActive]') 
	  AND NAME = 'isUpdated'
)
BEGIN
	ALTER TABLE [dbo].[ReceiptTemplateActive] 
	ADD isUpdated BIT DEFAULT(1) NOT NULL ;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[ReceiptTemplateActive]') 
	  AND NAME = 'UpdatedDate'
)
BEGIN
	ALTER TABLE [dbo].[ReceiptTemplateActive] 
	ADD UpdatedDate DATETIME;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[ReceiptTemplateActive]') 
	  AND NAME = 'CloudId'
)
BEGIN
	ALTER TABLE [dbo].ReceiptTemplateActive 
	ADD CloudId INT NULL;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[ReceiptTemplateActive]') 
	  AND NAME = 'LastSyncDate'
)
BEGIN
	ALTER TABLE [dbo].[ReceiptTemplateActive] 
	ADD LastSyncDate DATETIME;
END

--==========================CloseOutReportMain========================

IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[CloseOutReportMain]') 
	  AND NAME = 'isPost'
)
BEGIN
	ALTER TABLE [dbo].[CloseOutReportMain] 
	ADD isPost BIT DeFAULT(0) NOT NULL;
END

IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[CloseOutReportMain]') 
	  AND NAME = 'PostDate'
)
BEGIN
	ALTER TABLE [dbo].[CloseOutReportMain] 
	ADD PostDate DATETIME ;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[CloseOutReportMain]') 
	  AND NAME = 'isUpdated'
)
BEGIN
	ALTER TABLE [dbo].[CloseOutReportMain] 
	ADD isUpdated BIT DEFAULT(1) NOT NULL ;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[CloseOutReportMain]') 
	  AND NAME = 'UpdatedDate'
)
BEGIN
	ALTER TABLE [dbo].[CloseOutReportMain] 
	ADD UpdatedDate DATETIME;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[CloseOutReportMain]') 
	  AND NAME = 'CloudId'
)
BEGIN
	ALTER TABLE [dbo].CloseOutReportMain 
	ADD CloudId INT NULL;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[CloseOutReportMain]') 
	  AND NAME = 'LastSyncDate'
)
BEGIN
	ALTER TABLE [dbo].[CloseOutReportMain] 
	ADD LastSyncDate DATETIME;
END