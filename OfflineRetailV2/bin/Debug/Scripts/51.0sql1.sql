
IF  NOT EXISTS (SELECT * FROM sys.objects 
WHERE object_id = OBJECT_ID(N'[dbo].[SummaryDataTender]') AND type in (N'U'))

BEGIN
CREATE TABLE [dbo].[SummaryDataTender](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[TerminalName] [nvarchar](50) NULL,
	[TransType] [int] NULL,
	[TenderID] [int] NULL,
	[TenderName] [varchar](40) NULL,
	[TenderAmount] [numeric](15, 3) NULL default 0,
 CONSTRAINT [PK_SummaryDataTender] PRIMARY KEY CLUSTERED(
	[ID] ASC
)
) ON [PRIMARY]
END
GO

