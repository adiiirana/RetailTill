

IF NOT EXISTS (SELECT * FROM syscolumns
  WHERE ID=OBJECT_ID('[dbo].[Setup]') AND NAME='SMPTServer')
  ALTER TABLE [dbo].[Setup] add [SMPTServer] int NULL default 0;
GO

