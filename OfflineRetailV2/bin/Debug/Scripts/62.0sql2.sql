IF NOT EXISTS (SELECT * FROM syscolumns
  WHERE ID=OBJECT_ID('[dbo].[setup]') AND NAME='ItemExpiryAlertDay')
  ALTER TABLE [dbo].[setup] add [ItemExpiryAlertDay] int NULL default 90;
  
GO
update setup set ItemExpiryAlertDay = 90 where ItemExpiryAlertDay is null;
  
GO
