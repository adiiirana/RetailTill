IF NOT EXISTS (SELECT * FROM syscolumns
  WHERE ID=OBJECT_ID('[dbo].[product]') AND NAME='HideOnReceipt')
  ALTER TABLE [dbo].[product] add [HideOnReceipt] [char](1) NULL Default 'N';
GO

IF EXISTS(SELECT 1 FROM product where HideOnReceipt is null)
BEGIN
 update product set HideOnReceipt = 'N' where HideOnReceipt is null
END
GO
