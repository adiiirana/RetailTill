IF NOT EXISTS (SELECT * FROM syscolumns
  WHERE ID=OBJECT_ID('[dbo].[Invoice]') AND NAME='ShopifyID')
  ALTER TABLE [dbo].[Invoice] add [ShopifyID] bigint NULL default 0;
GO

update Invoice set ShopifyID = 0 where ShopifyID is null;
GO