IF NOT EXISTS (SELECT * FROM syscolumns
  WHERE ID=OBJECT_ID('[dbo].[Invoice]') AND NAME='WooCommID')
  ALTER TABLE [dbo].[Invoice] add [WooCommID] int NULL default 0;
GO

IF NOT EXISTS (SELECT * FROM syscolumns
  WHERE ID=OBJECT_ID('[dbo].[Invoice]') AND NAME='XeroID')
  ALTER TABLE [dbo].[Invoice] add [XeroID] varchar(100) NULL ;
GO

IF NOT EXISTS (SELECT * FROM syscolumns
  WHERE ID=OBJECT_ID('[dbo].[Invoice]') AND NAME='QuickBooksCloudFlag')
  ALTER TABLE [dbo].[Invoice] add [QuickBooksCloudFlag] [char](1) NULL default 'N';
GO

IF NOT EXISTS (SELECT * FROM syscolumns
  WHERE ID=OBJECT_ID('[dbo].[Invoice]') AND NAME='QBTrnID')
  ALTER TABLE [dbo].[Invoice] add [QBTrnID] varchar(50) null;
GO