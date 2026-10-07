USE Retail2020DB
GO

IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[Dept]') 
	  AND NAME = 'IsDepartmentSale'
)
BEGIN
	ALTER TABLE [dbo].[Dept] 
	ADD IsDepartmentSale BIT DEFAULT(0) NOT NULL
END
