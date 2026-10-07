IF NOT EXISTS (SELECT * FROM syscolumns
  WHERE ID=OBJECT_ID('[dbo].[Shopify]') AND NAME='PremiumPlan')
  ALTER TABLE [dbo].[Shopify] add [PremiumPlan] char(1) NULL default 'N';
GO

update Shopify set PremiumPlan = 'N' where PremiumPlan is null;
GO