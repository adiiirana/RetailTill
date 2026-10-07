--Query for DeptPhoto
IF NOT EXISTS (
    SELECT 1
    FROM sys.columns
    WHERE Name = N'DeptPhoto'
      AND Object_ID = Object_ID(N'[Retail2020DB].[dbo].[Dept]')
)
BEGIN
    ALTER TABLE [Retail2020DB].[dbo].[Dept]
    ADD DeptPhoto IMAGE NULL;
END

--Query for CategoryPhoto
IF NOT EXISTS (
    SELECT 1
    FROM sys.columns
    WHERE Name = N'CategoryPhoto'
      AND Object_ID = Object_ID(N'[Retail2020DB].[dbo].[Category]')
)
BEGIN
    ALTER TABLE [Retail2020DB].[dbo].[Category]
    ADD CategoryPhoto IMAGE NULL;
END
GO