
IF  NOT EXISTS (SELECT * FROM sys.objects 
WHERE object_id = OBJECT_ID(N'[dbo].[ReceiptTemplateDummyData]') AND type in (N'U'))

BEGIN
CREATE TABLE [dbo].[ReceiptTemplateDummyData](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[TemplateType] [varchar](20) NULL,
	[GroupName] [varchar](50) NULL,
	[TemplateWidth] [int] NULL Default 0,
	[TemplateHeight] [int] NULL Default 0,
	[GroupData] [nvarchar](200) NULL,
	[TextAlign] [varchar](6) NULL,
	[TextStyle] [varchar](6) NULL,
	[FontSize] [int] NULL Default 0,
	[CtrlWidth] [int] NULL Default 0,
	[CtrlHeight] [int] NULL Default 0,
	[ShowHeader1] [char](1) NULL Default 'N',
	[ShowHeader2] [char](1) NULL Default 'N',
	[ShowHeader3] [char](1) NULL Default 'N',
	[ShowHeader4] [char](1) NULL Default 'N',
	[Header1Caption] [nvarchar](20) NULL,
	[Header2Caption] [nvarchar](20) NULL,
	[Header3Caption] [nvarchar](20) NULL,
	[Header4Caption] [nvarchar](20) NULL,
	[SL] [int] NULL Default 0,
	[CtrlPositionTop] [int] NULL Default 0,
 CONSTRAINT [PK_ReceiptTemplateDummyData] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)
) ON [PRIMARY]
END
GO

IF NOT EXISTS (SELECT * FROM syscolumns
  WHERE ID=OBJECT_ID('[dbo].[ReceiptTemplateActive]') AND NAME='GiftReceiptTemplate')
  ALTER TABLE [dbo].[ReceiptTemplateActive] add [GiftReceiptTemplate] [int] NULL default 0;
GO

IF EXISTS(SELECT 1 FROM ReceiptTemplateDefaultData where TemplateType = 'Closeout' and GroupName = 'House Account Payment' and SLNO = 60)
BEGIN
   DELETE FROM ReceiptTemplateDefaultData where TemplateType = 'Closeout' and GroupName = 'House Account Payment' and SLNO = 60;
END
GO
