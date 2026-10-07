BEGIN TRANSACTION;

IF EXISTS (
    SELECT 1
    FROM [Retail2020DB].[dbo].[Dept]
    WHERE DepartmentID = 'Pharmacy'
)
BEGIN
    DECLARE @NextNumber INT;

    -- Get next available numeric DepartmentID
    SELECT @NextNumber =
        ISNULL(
            MAX(TRY_CAST(DepartmentID AS INT)),
            0
        ) + 1
    FROM [Retail2020DB].[dbo].[Dept]
    WHERE TRY_CAST(DepartmentID AS INT) IS NOT NULL;

    -- Update ONLY the existing Pharmacy record
    UPDATE [Retail2020DB].[dbo].[Dept]
    SET 
        DepartmentID = CAST(@NextNumber AS NVARCHAR(20)),
        LastChangedOn = GETDATE()
    WHERE DepartmentID = 'Pharmacy';
END

COMMIT TRANSACTION;
