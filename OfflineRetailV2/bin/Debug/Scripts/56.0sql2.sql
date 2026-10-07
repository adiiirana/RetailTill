IF EXISTS(SELECT * FROM sys.indexes WHERE object_id = object_id('dbo.category') AND NAME ='IX_category_maxitemsforpos_addtoposscreen') BEGIN

 DROP INDEX IX_category_maxitemsforpos_addtoposscreen ON dbo.category;

END
GO

CREATE NONCLUSTERED INDEX [IX_category_maxitemsforpos_addtoposscreen] ON [dbo].[category]
(
	[maxitemsforpos] ASC,
	[addtoposscreen] ASC
) ON [PRIMARY]
GO


IF EXISTS(SELECT * FROM sys.indexes WHERE object_id = object_id('dbo.Product') AND NAME ='IX_Product_CategoryID_ProductStatus_POSVisible_LinkSKU') BEGIN

 DROP INDEX IX_Product_CategoryID_ProductStatus_POSVisible_LinkSKU ON dbo.Product;

END
GO


CREATE NONCLUSTERED INDEX [IX_Product_CategoryID_ProductStatus_POSVisible_LinkSKU] ON [dbo].[Product]
(
	[CategoryID] ASC,
	[ProductStatus] ASC,
	[POSVisible] ASC,
	[LinkSKU] ASC
) ON [PRIMARY]
GO

IF EXISTS(SELECT * FROM sys.indexes WHERE object_id = object_id('dbo.Product') AND NAME ='IX_Product_CategoryID_ProductStatus_AddtoPOSScreen_LinkSKU') BEGIN

 DROP INDEX IX_Product_CategoryID_ProductStatus_AddtoPOSScreen_LinkSKU ON dbo.Product;

END
GO




CREATE NONCLUSTERED INDEX [IX_Product_CategoryID_ProductStatus_AddtoPOSScreen_LinkSKU] ON [dbo].[Product]
(
	[CategoryID] ASC,
	[ProductStatus] ASC,
	[AddtoPOSScreen] ASC,
	[LinkSKU] ASC
) ON [PRIMARY]
GO

IF EXISTS(SELECT * FROM sys.indexes WHERE object_id = object_id('dbo.Product') AND NAME ='IX_Product_CategoryID_ProductStatus_AddtoPOSCategoryScreen_LinkSKU') BEGIN

 DROP INDEX IX_Product_CategoryID_ProductStatus_AddtoPOSCategoryScreen_LinkSKU ON dbo.Product;

END
GO



CREATE NONCLUSTERED INDEX [IX_Product_CategoryID_ProductStatus_AddtoPOSCategoryScreen_LinkSKU] ON [dbo].[Product]
(
	[CategoryID] ASC,
	[ProductStatus] ASC,
	[AddtoPOSCategoryScreen] ASC,
	[LinkSKU] ASC
) ON [PRIMARY]
GO

IF EXISTS(SELECT * FROM sys.indexes WHERE object_id = object_id('dbo.Product') AND NAME ='IX_Product_ID_ProductStatus') BEGIN

 DROP INDEX IX_Product_ID_ProductStatus ON dbo.Product;

END
GO



CREATE NONCLUSTERED INDEX [IX_Product_ID_ProductStatus] ON [dbo].[Product]
(
	[ID] ASC,
	[ProductStatus] ASC
) ON [PRIMARY]
GO

IF EXISTS(SELECT * FROM sys.indexes WHERE object_id = object_id('dbo.Product') AND NAME ='IX_Product_ID_ProductStatus_AddtoPOSScreen') BEGIN

 DROP INDEX IX_Product_ID_ProductStatus_AddtoPOSScreen ON dbo.Product;

END
GO


CREATE NONCLUSTERED INDEX [IX_Product_ID_ProductStatus_AddtoPOSScreen] ON [dbo].[Product]
(
	[ID] ASC,
	[ProductStatus] ASC,
	[AddtoPOSScreen] ASC
) ON [PRIMARY]
GO


IF EXISTS(SELECT * FROM sys.indexes WHERE object_id = object_id('dbo.POSFunctionSetup') AND NAME ='IX_POSFunctionSetup_FunctionType') BEGIN

 DROP INDEX IX_POSFunctionSetup_FunctionType ON dbo.POSFunctionSetup;

END
GO




CREATE NONCLUSTERED INDEX [IX_POSFunctionSetup_FunctionType] ON [dbo].[POSFunctionSetup]
(
	[FunctionType] ASC
) ON [PRIMARY]
GO


IF EXISTS(SELECT * FROM sys.indexes WHERE object_id = object_id('dbo.POSFunctionSetup') AND NAME ='IX_POSFunctionSetup_FunctionType_Isvisible') BEGIN

 DROP INDEX IX_POSFunctionSetup_FunctionType_Isvisible ON dbo.POSFunctionSetup;

END
GO



CREATE NONCLUSTERED INDEX [IX_POSFunctionSetup_FunctionType_Isvisible] ON [dbo].[POSFunctionSetup]
(
	[FunctionType] ASC,
	[Isvisible] ASC
) ON [PRIMARY]
GO

IF EXISTS(SELECT * FROM sys.indexes WHERE object_id = object_id('dbo.POSFunctionSetup') AND NAME ='IX_POSFunctionSetup_FunctionType_Isvisible_FunctionName') BEGIN

 DROP INDEX IX_POSFunctionSetup_FunctionType_Isvisible_FunctionName ON dbo.POSFunctionSetup;

END
GO


CREATE NONCLUSTERED INDEX [IX_POSFunctionSetup_FunctionType_Isvisible_FunctionName] ON [dbo].[POSFunctionSetup]
(
	[FunctionType] ASC,
	[Isvisible] ASC,
	[FunctionName] ASC
) ON [PRIMARY]
GO

IF EXISTS(SELECT * FROM sys.indexes WHERE object_id = object_id('dbo.GiftCert') AND NAME ='IX_GiftCert_GiftCertID') BEGIN

 DROP INDEX IX_GiftCert_GiftCertID ON dbo.GiftCert;

END
GO

CREATE NONCLUSTERED INDEX [IX_GiftCert_GiftCertID] ON [dbo].[GiftCert]
(
	[GiftCertID] ASC
) ON [PRIMARY]
GO


IF EXISTS(SELECT * FROM sys.indexes WHERE object_id = object_id('dbo.GiftCert') AND NAME ='IX_GiftCert_GiftCertID_IssueStore') BEGIN

 DROP INDEX IX_GiftCert_GiftCertID_IssueStore ON dbo.GiftCert;

END
GO


CREATE NONCLUSTERED INDEX [IX_GiftCert_GiftCertID_IssueStore] ON [dbo].[GiftCert]
(
	[GiftCertID] ASC,
	[IssueStore] ASC
) ON [PRIMARY]
GO

IF EXISTS(SELECT * FROM sys.indexes WHERE object_id = object_id('dbo.GiftCert') AND NAME ='IX_GiftCert_GiftCertID_IssueStore_tenderno') BEGIN

 DROP INDEX IX_GiftCert_GiftCertID_IssueStore_tenderno ON dbo.GiftCert;

END
GO

CREATE NONCLUSTERED INDEX [IX_GiftCert_GiftCertID_IssueStore_tenderno] ON [dbo].[GiftCert]
(
	[GiftCertID] ASC,
	[IssueStore] ASC,
	[tenderno] ASC
) ON [PRIMARY]
GO

IF EXISTS(SELECT * FROM sys.indexes WHERE object_id = object_id('dbo.AcctRecv') AND NAME ='IX_AcctRecv_CustomerID') BEGIN

 DROP INDEX IX_AcctRecv_CustomerID ON dbo.AcctRecv;

END
GO


CREATE NONCLUSTERED INDEX [IX_AcctRecv_CustomerID] ON [dbo].[AcctRecv]
(
	[CustomerID] ASC
) ON [PRIMARY]
GO

IF EXISTS(SELECT * FROM sys.indexes WHERE object_id = object_id('dbo.AcctRecv') AND NAME ='IX_AcctRecv_CustomerID_invoiceno_TranType') BEGIN

 DROP INDEX IX_AcctRecv_CustomerID_invoiceno_TranType ON dbo.AcctRecv;

END
GO


CREATE NONCLUSTERED INDEX [IX_AcctRecv_CustomerID_invoiceno_TranType] ON [dbo].[AcctRecv]
(
	[CustomerID] ASC,
	[invoiceno] ASC,
	[TranType] ASC
) ON [PRIMARY]
GO


IF EXISTS(SELECT * FROM sys.indexes WHERE object_id = object_id('dbo.cardauthorisation') AND NAME ='IX_cardauthorisation_invoiceno') BEGIN

 DROP INDEX IX_cardauthorisation_invoiceno ON dbo.cardauthorisation;

END
GO


CREATE NONCLUSTERED INDEX [IX_cardauthorisation_invoiceno] ON [dbo].[cardauthorisation]
(
	[invoiceno] ASC
) ON [PRIMARY]
GO

IF EXISTS(SELECT * FROM sys.indexes WHERE object_id = object_id('dbo.cardauthorisation') AND NAME ='IX_cardauthorisation_invoiceno') BEGIN

 DROP INDEX IX_cardauthorisation_invoiceno ON dbo.cardauthorisation;

END
GO


CREATE NONCLUSTERED INDEX [IX_cardauthorisation_invoiceno] ON [dbo].[cardauthorisation]
(
	[invoiceno] ASC
) ON [PRIMARY]
GO

IF EXISTS(SELECT * FROM sys.indexes WHERE object_id = object_id('dbo.Invoice') AND NAME ='IX_Invoice_TransactionNo') BEGIN

 DROP INDEX IX_Invoice_TransactionNo ON dbo.Invoice;

END
GO


CREATE NONCLUSTERED INDEX [IX_Invoice_TransactionNo] ON [dbo].[Invoice]
(
	[TransactionNo] ASC
) ON [PRIMARY]
GO

IF EXISTS(SELECT * FROM sys.indexes WHERE object_id = object_id('dbo.Item') AND NAME ='IX_Item_InvoiceNo') BEGIN

 DROP INDEX IX_Item_InvoiceNo ON dbo.Item;

END
GO


CREATE NONCLUSTERED INDEX [IX_Item_InvoiceNo] ON [dbo].[Item]
(
	[InvoiceNo] ASC
) ON [PRIMARY]
GO

IF EXISTS(SELECT * FROM sys.indexes WHERE object_id = object_id('dbo.Item') AND NAME ='IX_Item_InvoiceNo_producttype_tagged_ServiceType') BEGIN

 DROP INDEX IX_Item_InvoiceNo_producttype_tagged_ServiceType ON dbo.Item;

END
GO


CREATE NONCLUSTERED INDEX [IX_Item_InvoiceNo_producttype_tagged_ServiceType] ON [dbo].[Item]
(
	[InvoiceNo] ASC,
[producttype] ASC,
[tagged] ASC,
[ServiceType] ASC
) ON [PRIMARY]
GO


IF EXISTS(SELECT * FROM sys.indexes WHERE object_id = object_id('dbo.Customer') AND NAME ='IX_Customer_CustomerID_IssueStore') BEGIN

 DROP INDEX IX_Customer_CustomerID_IssueStore ON dbo.Customer;

END
GO


CREATE NONCLUSTERED INDEX [IX_Customer_CustomerID_IssueStore] ON [dbo].[Customer]
(
	[CustomerID] ASC,
[IssueStore] ASC
) ON [PRIMARY]
GO


IF EXISTS(SELECT * FROM sys.indexes WHERE object_id = object_id('dbo.appointments') AND NAME ='IX_appointments_customerid_apptstatus') BEGIN

 DROP INDEX IX_appointments_customerid_apptstatus ON dbo.appointments;

END
GO


CREATE NONCLUSTERED INDEX [IX_appointments_customerid_apptstatus] ON [dbo].[appointments]
(
	[customerid] ASC,
[apptstatus] ASC
) ON [PRIMARY]
GO

IF EXISTS(SELECT * FROM sys.indexes WHERE object_id = object_id('dbo.appointments') AND NAME ='IX_appointments_ScheduleTime_apptstatus') BEGIN

 DROP INDEX IX_appointments_ScheduleTime_apptstatus ON dbo.appointments;

END
GO


CREATE NONCLUSTERED INDEX [IX_appointments_ScheduleTime_apptstatus] ON [dbo].[appointments]
(
	[ScheduleTime] ASC,
[apptstatus] ASC
) ON [PRIMARY]
GO

IF EXISTS(SELECT * FROM sys.indexes WHERE object_id = object_id('dbo.ServiceMapping') AND NAME ='IX_ServiceMapping_MappingType_apptstatus') BEGIN

 DROP INDEX IX_ServiceMapping_MappingType_apptstatus ON dbo.ServiceMapping;

END
GO


CREATE NONCLUSTERED INDEX [IX_ServiceMapping_MappingType_apptstatus] ON [dbo].[ServiceMapping]
(
	[MappingType] ASC,
[MappingID] ASC
) ON [PRIMARY]
GO


