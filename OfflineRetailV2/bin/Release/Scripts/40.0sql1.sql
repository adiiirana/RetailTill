
IF NOT EXISTS (SELECT * FROM syscolumns
  WHERE ID=OBJECT_ID('[dbo].[Setup]') AND NAME='AutoGC')
  ALTER TABLE [dbo].[Setup] add [AutoGC] [char](1) NULL default 'N';
GO
IF NOT EXISTS (SELECT * FROM syscolumns
  WHERE ID=OBJECT_ID('[dbo].[Setup]') AND NAME='SingleGC')
  ALTER TABLE [dbo].[Setup] add [SingleGC] [char](1) NULL default 'N';
GO