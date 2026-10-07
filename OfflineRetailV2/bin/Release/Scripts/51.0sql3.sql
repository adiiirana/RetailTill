
IF NOT EXISTS(SELECT 1 FROM ReceiptTemplateDefaultData where TemplateType = 'Paid Out' and GroupName = 'Tender Amount')
BEGIN
INSERT [dbo].[ReceiptTemplateDefaultData] ( [GroupName], [SlNo], [TemplateType]) VALUES ( N'Tender Amount', 14, N'Paid Out')
END
GO

IF NOT EXISTS(SELECT 1 FROM ReceiptTemplateDefaultData where TemplateType = 'Paid In' and GroupName = 'Tender Amount')
BEGIN
INSERT [dbo].[ReceiptTemplateDefaultData] ( [GroupName], [SlNo], [TemplateType]) VALUES ( N'Tender Amount', 14, N'Paid In')
END
GO

IF NOT EXISTS(SELECT 1 FROM ReceiptTemplateDefaultData where TemplateType = 'Safe Drop' and GroupName = 'Tender Amount')
BEGIN
INSERT [dbo].[ReceiptTemplateDefaultData] ( [GroupName], [SlNo], [TemplateType]) VALUES ( N'Tender Amount', 13, N'Safe Drop')
END
GO

IF NOT EXISTS(SELECT 1 FROM ReceiptTemplateDefaultData where TemplateType = 'Closeout' and GroupName = 'Net Over/Short')
BEGIN
INSERT [dbo].[ReceiptTemplateDefaultData] ( [GroupName], [SlNo], [TemplateType]) VALUES ( N'Net Over/Short', 90, N'Closeout')
END
GO



