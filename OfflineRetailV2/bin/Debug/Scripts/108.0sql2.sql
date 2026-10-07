/* Seed POS function button: Loyalty Check (Retail has no per-terminal RecordType pattern). */

IF OBJECT_ID('dbo.POSFunctionSetup', 'U') IS NULL
BEGIN
    RETURN;
END
GO

IF NOT EXISTS (
    SELECT 1
    FROM dbo.POSFunctionSetup
    WHERE FunctionType = 'FunctionButton'
      AND FunctionName = 'Loyalty Check'
)
BEGIN
    DECLARE @MaxOrder INT;
    SELECT @MaxOrder = ISNULL(MAX(DisplayOrder), 0)
    FROM dbo.POSFunctionSetup
    WHERE FunctionType = 'FunctionButton';

    IF COL_LENGTH('dbo.POSFunctionSetup', 'IsVisible') IS NOT NULL
    BEGIN
        INSERT INTO dbo.POSFunctionSetup
            (FunctionType, FunctionName, DisplayOrder, CreatedBy, CreatedOn, LastChangedBy, LastChangedOn, IsVisible)
        VALUES
            ('FunctionButton', 'Loyalty Check', @MaxOrder + 1, 0, GETDATE(), 0, GETDATE(), 'Y');
    END
    ELSE
    BEGIN
        INSERT INTO dbo.POSFunctionSetup
            (FunctionType, FunctionName, DisplayOrder, CreatedBy, CreatedOn, LastChangedBy, LastChangedOn)
        VALUES
            ('FunctionButton', 'Loyalty Check', @MaxOrder + 1, 0, GETDATE(), 0, GETDATE());
    END
END
GO

IF COL_LENGTH('dbo.POSFunctionSetup', 'IsVisible') IS NOT NULL
BEGIN
    UPDATE dbo.POSFunctionSetup
    SET IsVisible = 'Y',
        LastChangedOn = GETDATE()
    WHERE FunctionType = 'FunctionButton'
      AND FunctionName = 'Loyalty Check'
      AND ISNULL(IsVisible, 'N') <> 'Y';
END
GO
