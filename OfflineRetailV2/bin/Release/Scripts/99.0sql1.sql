-- Setup.EditableInvoicePrintSize: required by Settings load and Cloud Sync (Setup row).
-- 0 = standard receipt/invoice print
-- 1 = A4 editable invoice format

IF COL_LENGTH('dbo.Setup', 'EditableInvoicePrintSize') IS NULL
BEGIN
    ALTER TABLE [dbo].[Setup]
    ADD [EditableInvoicePrintSize] INT NOT NULL
        CONSTRAINT [DF_Setup_EditableInvoicePrintSize] DEFAULT (0);
END
GO
