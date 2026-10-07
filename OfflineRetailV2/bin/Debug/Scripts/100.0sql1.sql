IF NOT EXISTS (
	SELECT *
	FROM syscolumns
	WHERE ID = OBJECT_ID('[dbo].[Setup]')
	  AND NAME = 'IsNewLiveWeightScaleEnabled'
)
BEGIN
	ALTER TABLE [dbo].[Setup]
	ADD [IsNewLiveWeightScaleEnabled] INT NULL DEFAULT 0
END
GO

UPDATE [dbo].[Setup]
SET [IsNewLiveWeightScaleEnabled] = 0
WHERE [IsNewLiveWeightScaleEnabled] IS NULL
GO