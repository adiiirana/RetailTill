
IF NOT EXISTS (SELECT * FROM syscolumns
  WHERE ID=OBJECT_ID('[dbo].[CloseoutCurrencyCalculator]') AND NAME='Penny')
  ALTER TABLE [dbo].[CloseoutCurrencyCalculator] add [Penny] nvarchar(10) NULL;
GO

IF NOT EXISTS (SELECT * FROM syscolumns
  WHERE ID=OBJECT_ID('[dbo].[CloseoutCurrencyCalculator]') AND NAME='Nickel')
  ALTER TABLE [dbo].[CloseoutCurrencyCalculator] add [Nickel] nvarchar(10) NULL;
GO


IF NOT EXISTS (SELECT * FROM syscolumns
  WHERE ID=OBJECT_ID('[dbo].[CloseoutCurrencyCalculator]') AND NAME='Dime')
  ALTER TABLE [dbo].[CloseoutCurrencyCalculator] add [Dime] nvarchar(10) NULL;
GO


IF NOT EXISTS (SELECT * FROM syscolumns
  WHERE ID=OBJECT_ID('[dbo].[CloseoutCurrencyCalculator]') AND NAME='Quarter')
  ALTER TABLE [dbo].[CloseoutCurrencyCalculator] add [Quarter] nvarchar(10) NULL;
GO


IF NOT EXISTS (SELECT * FROM syscolumns
  WHERE ID=OBJECT_ID('[dbo].[CloseoutCurrencyCalculator]') AND NAME='Halve')
  ALTER TABLE [dbo].[CloseoutCurrencyCalculator] add [Halve] nvarchar(10) NULL;
GO


IF NOT EXISTS (SELECT * FROM syscolumns
  WHERE ID=OBJECT_ID('[dbo].[CloseoutCurrencyCalculator]') AND NAME='One')
  ALTER TABLE [dbo].[CloseoutCurrencyCalculator] add [One] nvarchar(10) NULL;
GO


IF NOT EXISTS (SELECT * FROM syscolumns
  WHERE ID=OBJECT_ID('[dbo].[CloseoutCurrencyCalculator]') AND NAME='Five')
  ALTER TABLE [dbo].[CloseoutCurrencyCalculator] add [Five] nvarchar(10) NULL;
GO


IF NOT EXISTS (SELECT * FROM syscolumns
  WHERE ID=OBJECT_ID('[dbo].[CloseoutCurrencyCalculator]') AND NAME='Ten')
  ALTER TABLE [dbo].[CloseoutCurrencyCalculator] add [Ten] nvarchar(10) NULL;
GO


IF NOT EXISTS (SELECT * FROM syscolumns
  WHERE ID=OBJECT_ID('[dbo].[CloseoutCurrencyCalculator]') AND NAME='Twenty')
  ALTER TABLE [dbo].[CloseoutCurrencyCalculator] add [Twenty] nvarchar(10) NULL;
GO


IF NOT EXISTS (SELECT * FROM syscolumns
  WHERE ID=OBJECT_ID('[dbo].[CloseoutCurrencyCalculator]') AND NAME='Fifty')
  ALTER TABLE [dbo].[CloseoutCurrencyCalculator] add [Fifty] nvarchar(10) NULL;
GO


IF NOT EXISTS (SELECT * FROM syscolumns
  WHERE ID=OBJECT_ID('[dbo].[CloseoutCurrencyCalculator]') AND NAME='Hundred')
  ALTER TABLE [dbo].[CloseoutCurrencyCalculator] add [Hundred] nvarchar(10) NULL;
GO


IF NOT EXISTS (SELECT * FROM syscolumns
  WHERE ID=OBJECT_ID('[dbo].[CloseoutCurrencyCalculator]') AND NAME='Two')
  ALTER TABLE [dbo].[CloseoutCurrencyCalculator] add [Two] nvarchar(10) NULL;
GO


IF NOT EXISTS (SELECT * FROM syscolumns
  WHERE ID=OBJECT_ID('[dbo].[CloseoutCurrencyCalculator]') AND NAME='TwoHundred')
  ALTER TABLE [dbo].[CloseoutCurrencyCalculator] add [TwoHundred] nvarchar(10) NULL;
GO

IF NOT EXISTS (SELECT * FROM syscolumns
  WHERE ID=OBJECT_ID('[dbo].[CloseoutCurrencyCalculator]') AND NAME='FiveHundred')
  ALTER TABLE [dbo].[CloseoutCurrencyCalculator] add [FiveHundred] nvarchar(10) NULL;
GO


IF NOT EXISTS (SELECT * FROM syscolumns
  WHERE ID=OBJECT_ID('[dbo].[CloseoutCurrencyCalculator]') AND NAME='TwoPenny')
  ALTER TABLE [dbo].[CloseoutCurrencyCalculator] add [TwoPenny] nvarchar(10) NULL;
GO


IF NOT EXISTS (SELECT * FROM syscolumns
  WHERE ID=OBJECT_ID('[dbo].[CloseoutCurrencyCalculator]') AND NAME='TwentyPenny')
  ALTER TABLE [dbo].[CloseoutCurrencyCalculator] add [TwentyPenny] nvarchar(10) NULL;
GO


IF NOT EXISTS (SELECT * FROM syscolumns
  WHERE ID=OBJECT_ID('[dbo].[CloseoutCurrencyCalculator]') AND NAME='OneThousand')
  ALTER TABLE [dbo].[CloseoutCurrencyCalculator] add [OneThousand] nvarchar(10) NULL;
GO





