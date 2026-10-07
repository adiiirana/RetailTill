IF OBJECT_ID(N'dbo.ScannedBoardingPasses', N'U') IS NULL
BEGIN
    CREATE TABLE dbo.ScannedBoardingPasses (
        ScanID INT PRIMARY KEY IDENTITY(1,1),
        InvoiceID NVARCHAR(50) NOT NULL,
        PassengerName NVARCHAR(100) NOT NULL,
        AirlineCode CHAR(3) NOT NULL,
        FlightNumber NVARCHAR(10) NOT NULL,
        FlightDateJulian CHAR(4) NOT NULL,
        OriginAirport CHAR(3) NOT NULL,
        DestinationAirport CHAR(3),
        CabinType NVARCHAR(20),
        SequenceNumber CHAR(5),
        PassengerType CHAR(1),
        ScanTimestamp DATETIME DEFAULT GETDATE(),
        CONSTRAINT UQ_SingleUsePass UNIQUE (FlightDateJulian, AirlineCode, FlightNumber, SequenceNumber)
    );
END
GO

IF COL_LENGTH('dbo.Setup', 'IsBoardingPassEnabled') IS NULL
BEGIN
    ALTER TABLE dbo.Setup
    ADD IsBoardingPassEnabled INT NOT NULL
        CONSTRAINT DF_Setup_IsBoardingPassEnabled DEFAULT (0);
END
GO