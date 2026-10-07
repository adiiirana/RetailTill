USE [Retail2020DB];
GO

-- =============================================
-- Create table [dbo].[BusinessInfo] if not exists
-- =============================================

IF NOT EXISTS (
    SELECT * 
    FROM sysobjects 
    WHERE name = 'BusinessInfo' 
      AND xtype = 'U'
)
BEGIN
    SET ANSI_NULLS ON;
    SET QUOTED_IDENTIFIER ON;

    CREATE TABLE [dbo].[BusinessInfo](
        [ID] INT IDENTITY(1,1) NOT NULL,
        [BusinessName] VARCHAR(150) NULL,
        [Email] VARCHAR(50) NULL,
		[Token] VARCHAR(250) NULL,
        [BaseURL] VARCHAR(250) NULL,
        [Password] VARCHAR(50) NULL,
        [CreatedBy] INT NULL,
        [CreatedOn] DATETIME NULL,
        [LastChangedBy] INT NULL,
        [LastChangedOn] DATETIME NULL,
        [LogFileName] VARCHAR(30) NULL,
		[CloudId] INT,
        CONSTRAINT [PK_BusinessInfo] PRIMARY KEY CLUSTERED 
        (
            [ID] ASC
        ) WITH (
            PAD_INDEX = OFF, 
            STATISTICS_NORECOMPUTE = OFF, 
            IGNORE_DUP_KEY = OFF, 
            ALLOW_ROW_LOCKS = ON, 
            ALLOW_PAGE_LOCKS = ON
        ) ON [PRIMARY]
    ) ON [PRIMARY];

    
END

