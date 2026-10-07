-- 1. Rename Column only if it exists and hasn't been renamed yet
IF EXISTS (SELECT * FROM sys.columns 
           WHERE object_id = OBJECT_ID('dbo.ScannedBoardingPasses') 
           AND name = 'FlightDateJulian')
BEGIN
    EXEC sp_rename 'dbo.ScannedBoardingPasses.FlightDateJulian', 'FlightDate', 'COLUMN';
END
GO

-- 2. Drop Constraint only if it exists
IF EXISTS (SELECT * FROM sys.objects 
           WHERE object_id = OBJECT_ID(N'[dbo].[UQ_SingleUsePass]') 
           AND type = 'UQ')
BEGIN
    ALTER TABLE dbo.ScannedBoardingPasses DROP CONSTRAINT UQ_SingleUsePass;
END
GO

-- 3. Alter Column length (safe to run repeatedly)
ALTER TABLE dbo.ScannedBoardingPasses ALTER COLUMN FlightDate VARCHAR(10);
GO

-- 4. Re-add Constraint only if it doesn't already exist
IF NOT EXISTS (SELECT * FROM sys.objects 
               WHERE object_id = OBJECT_ID(N'[dbo].[UQ_SingleUsePass]') 
               AND type = 'UQ')
BEGIN
    ALTER TABLE dbo.ScannedBoardingPasses 
    ADD CONSTRAINT UQ_SingleUsePass UNIQUE (InvoiceID, PassengerName, FlightNumber, FlightDate);
END
GO



--------------------------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM [dbo].[POSFunctionSetup] WHERE [FunctionName] = 'Boarding Pass Sales')
BEGIN
    INSERT INTO [dbo].[POSFunctionSetup]([FunctionType], [FunctionName], [DisplayOrder], [IsVisible], [FunctionDescription], [CreatedBy], [CreatedOn], [LastChangedBy], [LastChangedOn], [ChangedByAdmin], [ChangedOnAdmin])
VALUES
    ('FunctionButton', 'Boarding Pass Sales', 50, 'Y', NULL, 0, GETDATE(), 0, GETDATE(), NULL, NULL);
END