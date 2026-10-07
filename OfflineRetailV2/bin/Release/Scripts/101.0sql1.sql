IF OBJECT_ID('dbo.AfterDeleteCloseout', 'TR') IS NOT NULL
BEGIN
    DROP TRIGGER dbo.AfterDeleteCloseout;
END
IF OBJECT_ID('dbo.AfterDeleteTrans', 'TR') IS NOT NULL
BEGIN
    DROP TRIGGER dbo.AfterDeleteTrans;
END
IF OBJECT_ID('dbo.AfterDeleteInvoice', 'TR') IS NOT NULL
BEGIN
    DROP TRIGGER dbo.AfterDeleteInvoice;
END
IF OBJECT_ID('dbo.AfterDeleteItem', 'TR') IS NOT NULL
BEGIN
    DROP TRIGGER dbo.AfterDeleteItem;
END
IF OBJECT_ID('dbo.AfterDeleteItem', 'TR') IS NOT NULL
BEGIN
    DROP TRIGGER dbo.AfterDeleteItem;
END
IF OBJECT_ID('dbo.AfterDeleteTender', 'TR') IS NOT NULL
BEGIN
    DROP TRIGGER dbo.AfterDeleteTender;
END
IF OBJECT_ID('dbo.AfterDeleteStockJournal', 'TR') IS NOT NULL
BEGIN
    DROP TRIGGER dbo.AfterDeleteStockJournal;
END