IF NOT EXISTS (
    SELECT 1
    FROM sys.columns
    WHERE Name = N'IsConvenienceViewEnabled'
      AND Object_ID = OBJECT_ID(N'dbo.Setup')
)
BEGIN
    ALTER TABLE [dbo].[Setup]
    ADD [IsConvenienceViewEnabled] INT NOT NULL
        CONSTRAINT DF_Setup_IsConvenienceViewEnabled DEFAULT (0);
END
GO