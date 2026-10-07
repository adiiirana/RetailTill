-- Create VoidTradeInv table
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[VoidTradeInv]') AND type in (N'U'))
BEGIN
    CREATE TABLE [dbo].[VoidTradeInv](
        [ID] [int] IDENTITY(1,1) NOT NULL,
        [TradeInvoiceNo] [int] NOT NULL,
        [VoidBy] [int] NOT NULL,
        [VoidOn] [datetime] NULL,
     CONSTRAINT [PK_VoidTradeInv] PRIMARY KEY CLUSTERED 
    (
        [ID] ASC
    )WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
    ) ON [PRIMARY]
END
GO

-----------------------------------------------------------------
-- Create sp_VoidTradeInvoice stored procedure
IF OBJECT_ID('dbo.sp_VoidTradeInvoice', 'P') IS NOT NULL
    DROP PROCEDURE [dbo].[sp_VoidTradeInvoice]
GO

CREATE PROCEDURE [dbo].[sp_VoidTradeInvoice]
    @TradeInvoiceId INT,
    @EmployeeID INT,
    @TerminalName NVARCHAR(50),
    @CurrentTradeCloseoutID INT
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        BEGIN TRANSACTION;

        -- Variables & Basic Validations
        DECLARE @CurrentStatus NVARCHAR(50);
        DECLARE @GrossTotal DECIMAL(18,2);
        DECLARE @TradeCustomerId INT;
        DECLARE @InvoiceNo NVARCHAR(50);
        
        DECLARE @CustIDStr NVARCHAR(50); 
        DECLARE @CustIDInt INT;          

        SELECT @CurrentStatus = Status, @GrossTotal = GrossTotal, @TradeCustomerId = TradeCustomerId, @InvoiceNo = InvoiceNo
        FROM TradeInvoices WHERE TradeInvoiceId = @TradeInvoiceId;

        IF @CurrentStatus = 'Voided'
        BEGIN
            THROW 50001, 'Invoice is already voided.', 1;
        END

        SELECT @CustIDStr = C.CustomerID, @CustIDInt = C.ID
        FROM TradeCustomers TC 
        INNER JOIN Customer C ON TC.CustomerID = C.ID 
        WHERE TC.TradeCustomerId = @TradeCustomerId;

        -- Mark Invoice as Voided & Insert into NEW VoidTradeInv
        UPDATE TradeInvoices 
        SET Status = 'Voided', LastChangedBy = @EmployeeID, LastChangedOn = GETDATE()
        WHERE TradeInvoiceId = @TradeInvoiceId;

        -- VoidTradeInv
        INSERT INTO VoidTradeInv (TradeInvoiceNo, VoidBy, VoidOn) 
        VALUES (@TradeInvoiceId, @EmployeeID, GETDATE());

        DECLARE @CurrentTime DATETIME = GETDATE();

        -- Restore Account Limit (Ledger)
        DECLARE @PrevLimit DECIMAL(18,2) = 0;
        SELECT TOP 1 @PrevLimit = NewLimit FROM TradeCustomerCreditJournal 
        WHERE TradeCustomerId = @CustIDStr ORDER BY TranDate DESC, ID DESC;

        DECLARE @NewLimit DECIMAL(18,2) = @PrevLimit + @GrossTotal;
        
        INSERT INTO TradeCustomerCreditJournal 
            (DocNo, DocDate, TradeCustomerId, TranType, TranSubType, Amount, NewLimit, TerminalName, EmpID, TranDate, TradeCloseoutID)
        VALUES 
            ('VOID-' + @InvoiceNo, @CurrentTime, @CustIDStr, 'Credit', 'Invoice Void', @GrossTotal, @NewLimit, @TerminalName, @EmployeeID, @CurrentTime, @CurrentTradeCloseoutID);

        -- Reverse Payments & Balances
        DECLARE @TotalPaid DECIMAL(18,2) = 0;
        SELECT @TotalPaid = ISNULL(SUM(TenderAmount), 0)
        FROM TradeTender TT INNER JOIN TradeTrans TR ON TT.TransactionNo = TR.ID
        WHERE TR.TransNoteNo = @TradeInvoiceId AND TR.TransType = 14;

        DECLARE @NextTime DATETIME = DATEADD(second, 1, @CurrentTime);

        IF @TotalPaid > 0
        BEGIN
            SET @PrevLimit = @NewLimit;
            SET @NewLimit = @PrevLimit - @TotalPaid;
            
            INSERT INTO TradeCustomerCreditJournal 
                (DocNo, DocDate, TradeCustomerId, TranType, TranSubType, Amount, NewLimit, TerminalName, EmpID, TranDate, TradeCloseoutID)
            VALUES 
                ('V-REV-' + @InvoiceNo, @NextTime, @CustIDStr, 'Debit', 'Payment Reversal Void', @TotalPaid, @NewLimit, @TerminalName, @EmployeeID, @NextTime, @CurrentTradeCloseoutID);
            
            DECLARE @RetailCloseoutID INT = (SELECT TOP 1 RetailCloseoutID FROM TradeCloseoutHeader WHERE ID = @CurrentTradeCloseoutID);
            
            DECLARE @NewTransId INT;
            INSERT INTO TradeTrans (TransType, EmployeeID, RegisterID, StoreID, CustomerID, TransDate, CloseoutID, TradeCloseoutID, TransNoteNo, CreatedBy, CreatedOn, LastChangedBy, LastChangedOn, TerminalName)
            VALUES (19, @EmployeeID, 1, 1, @CustIDInt, @NextTime, @RetailCloseoutID, @CurrentTradeCloseoutID, @TradeInvoiceId, @EmployeeID, @NextTime, @EmployeeID, @NextTime, @TerminalName);
            SET @NewTransId = SCOPE_IDENTITY();

            INSERT INTO TradeTender (TransactionNo, TenderType, TenderAmount, CreatedBy, CreatedOn, LastChangedBy, LastChangedOn)
            SELECT 
                @NewTransId, TT.TenderType, -TT.TenderAmount, @EmployeeID, @NextTime, @EmployeeID, @NextTime
            FROM TradeTender TT INNER JOIN TradeTrans TR ON TT.TransactionNo = TR.ID
            WHERE TR.TransNoteNo = @TradeInvoiceId AND TR.TransType = 14;

            -- STORE CREDIT REVERSAL
            DECLARE @StoreCreditTenderAmount DECIMAL(18,2) = 0;
            SELECT @StoreCreditTenderAmount = ISNULL(SUM(TT.TenderAmount), 0)
            FROM TradeTender TT 
            INNER JOIN TenderTypes TType ON TT.TenderType = TType.ID
            WHERE TT.TransactionNo = @NewTransId AND TType.Name = 'Store Credit';

            IF @StoreCreditTenderAmount < 0 
            BEGIN
                UPDATE Customer SET StoreCredit = StoreCredit - @StoreCreditTenderAmount WHERE ID = @CustIDInt;
            END
        END

        -- INVENTORY REVERSAL (Stock Journal & QtyOnHand Update)
        DECLARE @ItemID INT, @ProductID INT, @ProductType CHAR(1), @Qty NUMERIC(15,3), @Cost NUMERIC(15,3), @UOMCount NUMERIC(15,3);
        DECLARE @DocNo NVARCHAR(50), @UpdtQty NUMERIC(15,3), @Rout INT, @SJ INT;

        DECLARE vc CURSOR FOR 
        SELECT 
            tii.InvoiceItemId, 
            tii.ProductId, 
            ISNULL(p.ProductType, 'P'), 
            tii.Quantity, 
            ISNULL(p.Cost, 0), 
            1 AS UOMCount
        FROM TradeInvoiceItems tii
        INNER JOIN Product p ON tii.ProductId = p.ID
        WHERE tii.TradeInvoiceId = @TradeInvoiceId
          AND p.ProductType NOT IN ('G','B','A','X','Z','C','H');

        OPEN vc;
        FETCH NEXT FROM vc INTO @ItemID, @ProductID, @ProductType, @Qty, @Cost, @UOMCount;

        WHILE @@FETCH_STATUS = 0 
        BEGIN
            SET @UpdtQty = 0;
            SET @DocNo = 'TradeVoid / ' + CAST(@TradeInvoiceId AS VARCHAR(10)) + ' / ' + CAST(@ProductID AS VARCHAR(10));

            IF @ProductType = 'U' 
            BEGIN
                SET @UpdtQty = @Qty * @UOMCount;
                UPDATE Product SET QtyOnHand = QtyOnHand + @UpdtQty, LastChangedBy = @EmployeeID, LastChangedOn = GETDATE() WHERE ID = @ProductID;
                EXEC @SJ = sp_AddJournal @DocNo, @NextTime, @ProductID, 'Stock In', 'Trade Return', @UpdtQty, @Cost, @TerminalName, @EmployeeID, @NextTime, '', 'N', @Rout OUTPUT;
            END
            ELSE 
            BEGIN
                UPDATE Product SET QtyOnHand = QtyOnHand + @Qty, LastChangedBy = @EmployeeID, LastChangedOn = GETDATE() WHERE ID = @ProductID;
                EXEC @SJ = sp_AddJournal @DocNo, @NextTime, @ProductID, 'Stock In', 'Trade Return', @Qty, @Cost, @TerminalName, @EmployeeID, @NextTime, '', 'N', @Rout OUTPUT;
            END

            FETCH NEXT FROM vc INTO @ItemID, @ProductID, @ProductType, @Qty, @Cost, @UOMCount;
        END
        CLOSE vc;
        DEALLOCATE vc;

        -- POINTS REVERSAL
        DECLARE @TotalPoints INT = 0;
        SELECT @TotalPoints = ISNULL(SUM(CAST(p.Points * tii.Quantity AS INT)), 0)
        FROM TradeInvoiceItems tii
        INNER JOIN Product p ON tii.ProductId = p.ID
        WHERE tii.TradeInvoiceId = @TradeInvoiceId;

        IF @TotalPoints > 0
        BEGIN
            UPDATE Customer SET Points = Points - @TotalPoints WHERE ID = @CustIDInt;
        END

        COMMIT TRANSACTION;
        SELECT 'Success' AS Result;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION;
        SELECT ERROR_MESSAGE() AS Result;
    END CATCH
END
GO