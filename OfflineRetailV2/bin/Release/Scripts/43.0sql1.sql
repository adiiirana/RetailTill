
IF NOT EXISTS (SELECT * FROM syscolumns
  WHERE ID=OBJECT_ID('[dbo].[ReceiptTemplateMaster]') AND NAME='LabelTemplateWidth')
  ALTER TABLE [dbo].[ReceiptTemplateMaster] add [LabelTemplateWidth] [int] NULL default 0;
GO

IF NOT EXISTS (SELECT * FROM syscolumns
  WHERE ID=OBJECT_ID('[dbo].[ReceiptTemplateMaster]') AND NAME='LabelTemplateHeight')
  ALTER TABLE [dbo].[ReceiptTemplateMaster] add [LabelTemplateHeight] [int] NULL default 0;
GO

IF NOT EXISTS (SELECT * FROM syscolumns
  WHERE ID=OBJECT_ID('[dbo].[ReceiptTemplateLinkData]') AND NAME='CtrlPositionTop')
  ALTER TABLE [dbo].[ReceiptTemplateLinkData] add [CtrlPositionTop] [int] NULL default 0;
GO

IF NOT EXISTS(SELECT 1 FROM ReceiptTemplateDefaultData where TemplateType = '1 Up Label')
BEGIN
INSERT [dbo].[ReceiptTemplateDefaultData] ( [GroupName], [SlNo], [TemplateType]) VALUES ( N'SKU', 1, N'1 Up Label')
INSERT [dbo].[ReceiptTemplateDefaultData] ( [GroupName], [SlNo], [TemplateType]) VALUES ( N'Item Name', 2, N'1 Up Label')
INSERT [dbo].[ReceiptTemplateDefaultData] ( [GroupName], [SlNo], [TemplateType]) VALUES ( N'Barcode', 3, N'1 Up Label')
INSERT [dbo].[ReceiptTemplateDefaultData] ( [GroupName], [SlNo], [TemplateType]) VALUES ( N'Item Price', 4, N'1 Up Label')
END
GO
