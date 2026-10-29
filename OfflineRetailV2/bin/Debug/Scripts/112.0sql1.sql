-- SumUp card reader integration settings (General Settings > SumUp tab)

IF OBJECT_ID('dbo.SumUpInfo', 'U') IS NULL
BEGIN
    CREATE TABLE [dbo].[SumUpInfo](
        [ID] [int] IDENTITY(1,1) NOT NULL,
        [IsActive] [char](1) NOT NULL CONSTRAINT [DF_SumUpInfo_IsActive] DEFAULT ('N'),
        [ApiKey] [nvarchar](200) NOT NULL CONSTRAINT [DF_SumUpInfo_ApiKey] DEFAULT (''),
        [MerchantCode] [nvarchar](50) NOT NULL CONSTRAINT [DF_SumUpInfo_MerchantCode] DEFAULT (''),
        [AffiliateKey] [nvarchar](200) NOT NULL CONSTRAINT [DF_SumUpInfo_AffiliateKey] DEFAULT (''),
        [AppId] [nvarchar](100) NOT NULL CONSTRAINT [DF_SumUpInfo_AppId] DEFAULT (''),
        [Currency] [nvarchar](3) NOT NULL CONSTRAINT [DF_SumUpInfo_Currency] DEFAULT ('GBP'),
        [ReaderId] [nvarchar](64) NOT NULL CONSTRAINT [DF_SumUpInfo_ReaderId] DEFAULT (''),
        [ReaderName] [nvarchar](100) NOT NULL CONSTRAINT [DF_SumUpInfo_ReaderName] DEFAULT (''),
        CONSTRAINT [PK_SumUpInfo] PRIMARY KEY CLUSTERED ([ID] ASC)
    )
END
GO
