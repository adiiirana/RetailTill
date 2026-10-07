
create procedure [dbo].[sp_CloseoutReportReturnItem_HostSync]
			@CloseoutType	char(1),
			@CloseoutID	int
			
as

declare @LocalCloseoutType		char(1);
declare @LocalCloseoutID		int;
declare @ReturnSKU		nvarchar(16);
declare @ReturnInvoiceNo		int;
declare @ReturnAmount		numeric(15,3);
declare @countvoid			int;

begin

  set @LocalCloseoutType = @CloseoutType;
  set @LocalCloseoutID	= @CloseoutID;
  

  
  if @LocalCloseoutType = 'E' or @LocalCloseoutType = 'T' begin

   
    declare sc9 cursor
    for select inv.ID,i.SKU,i.Price*i.Qty from item i 
               left outer join invoice inv on i.invoiceNo=inv.ID
               left outer join trans t on t.ID=inv.TransactionNo where t.CloseOutID = @LocalCloseoutID 
               and i.ReturnedItemID <> 0 and i.Qty < 0 and inv.ID not in ( select invoiceno from VoidInv) 
               and i.Tagged <> 'X' and i.ServiceType = 'Sales'
    open sc9
    fetch next from sc9 into @ReturnInvoiceNo,@ReturnSKU,@ReturnAmount
    while @@fetch_status = 0 begin

   
	 insert into CentralExportCloseoutReturn (ReturnSKU,ReturnInvoiceNo,ReturnAmount,CloseoutID,CloseoutType) 
     values(@ReturnSKU,@ReturnInvoiceNo,@ReturnAmount,@CloseoutID,@CloseoutType)
      
     
     fetch next from sc9 into @ReturnInvoiceNo,@ReturnSKU,@ReturnAmount

    end
    close sc9
    deallocate sc9 
  
  end

  if @LocalCloseoutType = 'C' begin

   
    declare csc9 cursor
    for select inv.ID,i.SKU,i.Price*i.Qty from item i 
               left outer join invoice inv on i.invoiceNo=inv.ID
               left outer join trans t on t.ID=inv.TransactionNo where t.CloseOutID 
               in (select cls.ID from closeout cls where cls.consolidatedID = @LocalCloseoutID) 
               and i.ReturnedItemID <> 0 and i.Qty < 0 
               and i.Tagged <> 'X' and i.ServiceType = 'Sales'

    open csc9
    fetch next from csc9 into @ReturnInvoiceNo,@ReturnSKU,@ReturnAmount
    while @@fetch_status = 0 begin

	  if @ReturnInvoiceNo > 0 begin

	   set @countvoid = 0;

	   select @countvoid = count(*) from VoidInv where invoiceno = @ReturnInvoiceNo;

	   if @countvoid = 0 begin
    
        
	 insert into CentralExportCloseoutReturn (ReturnSKU,ReturnInvoiceNo,ReturnAmount,CloseoutID,CloseoutType) 
     values(@ReturnSKU,@ReturnInvoiceNo,@ReturnAmount,@CloseoutID,@CloseoutType)
     
	   end

	 end

      fetch next from csc9 into @ReturnInvoiceNo,@ReturnSKU,@ReturnAmount
     
    end
    close csc9
    deallocate csc9 
  
  end

end

GO