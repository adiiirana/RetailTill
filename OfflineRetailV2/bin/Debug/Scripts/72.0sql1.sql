-- Add EditableInvoicePrintSize column in Setup if not exists
IF NOT EXISTS (
    SELECT 1 
    FROM sys.columns 
    WHERE Name = 'EditableInvoicePrintSize'
      AND Object_ID = Object_ID('[Retail2020DB].[dbo].[Setup]')
)
BEGIN
    ALTER TABLE [Retail2020DB].[dbo].[Setup]
    ADD EditableInvoicePrintSize INT NOT NULL
        CONSTRAINT DF_Setup_EditableInvoicePrintSize DEFAULT (1);
END
GO
