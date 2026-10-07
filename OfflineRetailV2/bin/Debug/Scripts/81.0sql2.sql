USE [Retail2020DB];
GO

-- =============================================
-- Create table [dbo].[UpdatedRowsLog] if not exists
-- =============================================

IF NOT EXISTS (
    SELECT * 
    FROM sysobjects 
    WHERE name = 'UpdatedRowsLog' 
      AND xtype = 'U'
)
BEGIN
    SET ANSI_NULLS ON;
    SET QUOTED_IDENTIFIER ON;

    CREATE TABLE UpdatedRowsLog (
    ID INT IDENTITY(1,1) NOT NULL PRIMARY KEY,  -- ID column as primary key
    TableId INT,
    TableName VARCHAR(255),
    CloudId INT,   
    CreatedDate DATETIME,
    isPost BIT NOT NULL,
    PostDate DATETIME NULL
    )

    
END

-- =============================================
-- Create table [dbo].[DeletedRowsLog] if not exists
-- =============================================

IF NOT EXISTS (
    SELECT * 
    FROM sysobjects 
    WHERE name = 'DeletedRowsLog' 
      AND xtype = 'U'
)
BEGIN
    SET ANSI_NULLS ON;
    SET QUOTED_IDENTIFIER ON;

    CREATE TABLE DeletedRowsLog (
    ID INT IDENTITY(1,1) NOT NULL PRIMARY KEY,  -- ID column as primary key
    TableId INT,
    TableName VARCHAR(255),
    CloudId INT,   
    CreatedDate DATETIME,
    isPost BIT NOT NULL,
    PostDate DATETIME NULL
    )

    
END
