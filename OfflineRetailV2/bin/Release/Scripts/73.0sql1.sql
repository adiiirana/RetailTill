IF NOT EXISTS (
	SELECT *
	FROM syscolumns
	WHERE ID = OBJECT_ID('[dbo].[Setup]')
	AND NAME = 'ShowPlusButton'
)
BEGIN
	ALTER TABLE [dbo].[Setup]
	ADD ShowPlusButton INT NULL;
END

UPDATE [dbo].[Setup]
SET ShowPlusButton = 0
WHERE ISNULL(ShowPlusButton,0) in(1, 0); 
