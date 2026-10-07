IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[CloseOutReportMain]') 
	  AND NAME = 'ID'
)
BEGIN
ALTER TABLE CloseOutReportMain
ADD ID INT IDENTITY(1,1) NOT NULL;
END
IF NOT EXISTS (
    SELECT 1
    FROM sys.key_constraints
    WHERE type = 'PK'
      AND parent_object_id = OBJECT_ID('dbo.CloseOutReportMain')
      AND name = 'PK_CloseOutReportMain_ID'
)
BEGIN
    ALTER TABLE CloseOutReportMain
    ADD CONSTRAINT PK_CloseOutReportMain_ID PRIMARY KEY (ID);
END
