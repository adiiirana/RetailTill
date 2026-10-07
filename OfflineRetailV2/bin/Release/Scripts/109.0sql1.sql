IF NOT EXISTS (
	SELECT *
	FROM syscolumns
	WHERE ID = OBJECT_ID('[dbo].[Product]')
	  AND NAME = 'ShowOnlyPhoto'
)
BEGIN
	ALTER TABLE [dbo].[Product]
	ADD ShowOnlyPhoto BIT DEFAULT(0) NOT NULL;
END
GO

IF NOT EXISTS (
	SELECT *
	FROM syscolumns
	WHERE ID = OBJECT_ID('[dbo].[Category]')
	  AND NAME = 'ShowOnlyPhoto'
)
BEGIN
	ALTER TABLE [dbo].[Category]
	ADD ShowOnlyPhoto BIT DEFAULT(0) NOT NULL;
END
GO

IF NOT EXISTS (
	SELECT *
	FROM syscolumns
	WHERE ID = OBJECT_ID('[dbo].[Dept]')
	  AND NAME = 'ShowOnlyPhoto'
)
BEGIN
	ALTER TABLE [dbo].[Dept]
	ADD ShowOnlyPhoto BIT DEFAULT(0) NOT NULL;
END
GO
