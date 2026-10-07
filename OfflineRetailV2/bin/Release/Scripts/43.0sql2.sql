
IF NOT EXISTS (SELECT * FROM syscolumns
  WHERE ID=OBJECT_ID('[dbo].[Logs]') AND NAME='RefID')
  ALTER TABLE [dbo].[Logs] add [RefID] [varchar](20) NULL default '';
GO

