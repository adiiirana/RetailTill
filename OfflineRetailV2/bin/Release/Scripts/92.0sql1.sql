-- Product.SKU -> NVARCHAR(50)
IF EXISTS (
    SELECT 1
    FROM INFORMATION_SCHEMA.COLUMNS
    WHERE TABLE_NAME = 'Product'
      AND COLUMN_NAME = 'SKU'
      AND (
            DATA_TYPE <> 'nvarchar'
         OR CHARACTER_MAXIMUM_LENGTH <> 50
      )
)
BEGIN
    ALTER TABLE Product
    ALTER COLUMN SKU NVARCHAR(50);
END
GO

-- Category.Description -> NVARCHAR(500)
IF EXISTS (
    SELECT 1
    FROM INFORMATION_SCHEMA.COLUMNS
    WHERE TABLE_NAME = 'Category'
      AND COLUMN_NAME = 'Description'
      AND (
            DATA_TYPE <> 'nvarchar'
         OR CHARACTER_MAXIMUM_LENGTH <> 500
      )
)
BEGIN
    ALTER TABLE Category
    ALTER COLUMN Description NVARCHAR(500);
END
GO