IF NOT EXISTS (SELECT * FROM sys.columns 
  WHERE OBJECT_ID = OBJECT_ID('[dbo].[Category]') AND NAME = 'ParentCategory')
  ALTER TABLE [dbo].[Category] ADD [ParentCategory] INT NULL;
  
GO

IF NOT EXISTS (SELECT * FROM sys.columns 
  WHERE OBJECT_ID = OBJECT_ID('[dbo].[Category]') AND NAME = 'ParentCategoryLevel')
  ALTER TABLE [dbo].[Category] ADD [ParentCategoryLevel] INT NULL; 

GO

-- Update existing records
UPDATE [dbo].[Category] 
SET ParentCategory = 0, 
    ParentCategoryLevel = 1
WHERE ParentCategory IS NULL OR ParentCategoryLevel IS NULL;

GO
