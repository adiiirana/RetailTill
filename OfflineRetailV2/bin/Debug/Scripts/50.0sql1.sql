
IF NOT EXISTS (SELECT * FROM syscolumns
  WHERE ID=OBJECT_ID('[dbo].[CentralExportSalesHeader]') AND NAME='GiftAid')
  ALTER TABLE [dbo].[CentralExportSalesHeader] add [GiftAid] [numeric](15,3) NULL default 0;
GO


IF EXISTS(SELECT 1 FROM CentralExportSalesHeader where GiftAid is null)
BEGIN
update CentralExportSalesHeader set GiftAid = 0 where GiftAid is null
END
GO
