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
        [isSync] BIT NOT NULL Default ((0)),
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

IF NOT EXISTS (
    SELECT * 
    FROM sysobjects 
    WHERE name = 'ItemGroup' 
      AND xtype = 'U'
)
BEGIN
    SET ANSI_NULLS ON;
    SET QUOTED_IDENTIFIER ON;
CREATE TABLE [dbo].[ItemGroup](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[GroupID] [varchar](10) NULL,
	[GroupDescription] [varchar](30) NULL,
	[Enabled] [char](1) NOT NULL,
	[CreatedBy] [int] NULL,
	[CreatedOn] [datetime] NULL,
	[LastChangedBy] [int] NULL,
	[LastChangedOn] [datetime] NULL,
	[ParentCategory] [int] NULL,
	[ParentCategoryLevel] [int] NULL,
	[isPost] [bit] NOT NULL,
	[PostDate] [datetime] NULL,
	[isUpdated] [bit] NOT NULL,
	[UpdatedDate] [datetime] NULL,
	[CloudId] [int] NULL,
	[LastSyncDate] [datetime] NULL,
 CONSTRAINT [PK_ItemGroup] PRIMARY KEY CLUSTERED
(
	[ID] ASC
)
) ON [PRIMARY]


ALTER TABLE [dbo].[ItemGroup] ADD  CONSTRAINT [DF_ItemGroup_Enabled]  DEFAULT ('Y') FOR [Enabled]


ALTER TABLE [dbo].[ItemGroup] ADD  CONSTRAINT [DF_ItemGroup_CreatedBy]  DEFAULT ((0)) FOR [CreatedBy]


ALTER TABLE [dbo].[ItemGroup] ADD  CONSTRAINT [DF_ItemGroup_LastChangedBy]  DEFAULT ((0)) FOR [LastChangedBy]

ALTER TABLE [dbo].[ItemGroup] ADD  DEFAULT ((0)) FOR [ParentCategory]

ALTER TABLE [dbo].[ItemGroup] ADD  DEFAULT ((1)) FOR [ParentCategoryLevel]


ALTER TABLE [dbo].[ItemGroup] ADD  DEFAULT ((0)) FOR [isPost]


ALTER TABLE [dbo].[ItemGroup] ADD  DEFAULT ((1)) FOR [isUpdated]
End

