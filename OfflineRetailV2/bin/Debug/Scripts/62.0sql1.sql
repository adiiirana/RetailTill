IF NOT EXISTS (SELECT * FROM syscolumns
  WHERE ID=OBJECT_ID('[dbo].[Product]') AND NAME='ExpiryDate')
  ALTER TABLE [dbo].[Product] add [ExpiryDate] DateTime NULL;
  
GO
IF NOT EXISTS (SELECT * FROM syscolumns
  WHERE ID=OBJECT_ID('[dbo].[SerialDetail]') AND NAME='ExpiryDate')
  ALTER TABLE [dbo].[SerialDetail] add [ExpiryDate] DateTime NULL;
  
GO
