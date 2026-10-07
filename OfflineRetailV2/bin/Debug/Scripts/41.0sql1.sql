
IF NOT EXISTS (SELECT * FROM syscolumns
  WHERE ID=OBJECT_ID('[dbo].[Setup]') AND NAME='PrintDuplicateGiftCertSaleReceipt')
  ALTER TABLE [dbo].[Setup] add [PrintDuplicateGiftCertSaleReceipt] [char](1) NULL default 'N';
GO