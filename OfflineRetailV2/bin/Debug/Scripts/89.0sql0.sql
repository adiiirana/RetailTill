USE [Retail2020DB]
GO

IF NOT EXISTS (
    SELECT 1
    FROM sys.tables
    WHERE name = 'CDDataSync'
      AND schema_id = SCHEMA_ID('dbo')
)
BEGIN
    CREATE TABLE [dbo].[CDDataSync](
        [ID] [int] IDENTITY(1,1) NOT NULL,
        [RepeatFlag] [char](1) NOT NULL,
        [SyncDateTime] [datetime] NOT NULL,
        [IsPost] [bit] NULL,
        [PostDate] [datetime] NULL,
        [IsUpdated] [bit] NULL,
        [UpdatedDate] [datetime] NULL,
        [CloudId] [int] NULL,
        [LastSyncDate] [datetime] NULL
    ) ON [PRIMARY]

    ALTER TABLE [dbo].[CDDataSync]
        ADD CONSTRAINT DF_CDDataSync_IsPost
        DEFAULT ((0)) FOR [IsPost]

    ALTER TABLE [dbo].[CDDataSync]
        ADD CONSTRAINT DF_CDDataSync_IsUpdated
        DEFAULT ((0)) FOR [IsUpdated]
END
GO