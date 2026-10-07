IF NOT EXISTS (
	SELECT *
	FROM syscolumns
	WHERE ID = OBJECT_ID('[dbo].[Setup]')
	 AND NAME = 'CatSale'
)
BEGIN
	ALTER TABLE [dbo].[Setup]
	ADD CatSale INT NULL;
END