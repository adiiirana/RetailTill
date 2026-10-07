USE Retail2020DB
GO

IF NOT EXISTS (
	SELECT *
	FROM syscolumns
	WHERE ID = OBJECT_ID('[dbo].[Item]')
	  AND NAME = 'SaleType'
)
BEGIN
	ALTER TABLE [dbo].[Item]
	ADD [SaleType] NVARCHAR(20) NULL
END
GO

-- Backfill existing rows
UPDATE [dbo].[Item]
SET SaleType = 'Product'
WHERE ProductType = 'P'
  AND (SaleType IS NULL OR SaleType = '')
GO

UPDATE i
SET i.SaleType = 'Department'
FROM [dbo].[Item] i
WHERE i.ProductType = 'B'
  AND (i.SaleType IS NULL OR i.SaleType = '')
  AND EXISTS (SELECT 1 FROM [dbo].[Dept] d WHERE d.ID = i.ProductID)
GO

UPDATE i
SET i.SaleType = 'Misc'
FROM [dbo].[Item] i
WHERE i.ProductType = 'B'
  AND (i.SaleType IS NULL OR i.SaleType = '')
  AND NOT EXISTS (SELECT 1 FROM [dbo].[Dept] d WHERE d.ID = i.ProductID)
GO
