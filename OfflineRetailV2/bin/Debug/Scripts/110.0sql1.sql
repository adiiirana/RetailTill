-- Setup.IsWholesaleActive: required by General Settings insert/update.
-- 0 = wholesale mode off, 1 = wholesale mode on

IF COL_LENGTH('dbo.Setup', 'IsWholesaleActive') IS NULL
BEGIN
    ALTER TABLE [dbo].[Setup]
    ADD [IsWholesaleActive] INT NOT NULL
        CONSTRAINT [DF_Setup_IsWholesaleActive] DEFAULT (0);
END
GO
