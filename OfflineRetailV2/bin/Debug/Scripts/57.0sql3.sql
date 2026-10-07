ALTER procedure [dbo].[sp_AddShopifyProduct]
					@id					varchar(20),
					@variant_id			varchar(20),
					@photo_id			varchar(20),
					@inventory_id			varchar(20),
					@title				varchar(150),
					@price				numeric(15,3),
					@qty				numeric(15,3),
					@sku				varchar(16),
					@product_category	varchar(30),
					@vendor				varchar(30),
					
					@photo				image,
					@product_type		char(1),
					@sale_zero_stock	char(1),
					@TerminalName			nvarchar(50),
					@cost				numeric(15,3),
					@ReturnID			int output	

as 
declare @sku_txt	varchar(16);
declare	@deptID		int;
declare @CategoryID	int;
declare @VendorID	int;

declare @dCnt		int;
declare @cCnt		int;
declare @vCnt		int;

declare @MaxDisplay  int;
declare @MaxPOSDisplay  int;
declare @docno			nvarchar(50);
declare @sj int;
declare @pId			int;
declare @rout			int;
declare @dt				datetime;

declare @cqty			numeric(15,3);

declare @catidcnt		int;
declare @vendidcnt		int;

declare @catidtxt		varchar(10);
declare @vendidtxt		varchar(10);

begin

  set @ReturnID = 0;

  set @dCnt = 0;
  set @cCnt = 0;
  set @vCnt = 0;

  set @sku_txt = '';


  if @sku != 0 set @sku_txt = @sku; else set @sku_txt = @id;

  select @dCnt = count(*) from dept where DepartmentID = 'SHOPIFY DEPARTMENT';

  if @dCnt > 0 begin
   select @deptID = ID from Dept where DepartmentID = 'SHOPIFY DEPARTMENT';
  end
  else begin
    insert into Dept (DepartmentID, [Description], CreatedBy, CreatedOn, LastChangedBy, LastChangedOn)
	values('SHOPIFY DEPARTMENT', 'SHOPIFY DEPARTMENT', 0, getdate(), 0, getdate())
	select @deptID = @@IDENTITY
  end

  select @cCnt = count(*) from Category where [Description] = @product_category;
  if @cCnt > 0 begin
   select @CategoryID = ID from Category where [Description] = @product_category;
  end
  else begin
    
    select @MaxDisplay = Max(POSDisplayOrder) + 1 from Category;
	select @catidcnt = count(*) + 1 from category where CategoryID like 'SHFY-%';
	set @catidtxt = 'SHFY-' + cast(@catidcnt as varchar(3));
    insert into Category (CategoryID, [Description], CreatedBy, CreatedOn, LastChangedBy, LastChangedOn,
	MaxItemsforPOS,POSDisplayOrder,POSBackground,POSScreenStyle,POSFontType,POSItemFontColor,POSScreenColor,POSFontColor)
	values(@catidtxt, @product_category, 0, getdate(), 0, getdate(),10,@MaxDisplay,'Skin','','Tahoma','0','0','0')
	select @CategoryID = @@IDENTITY
  end

  if @vendor <> '' begin
	select @vCnt = count(*) from Vendor where Name = @vendor;
	if @vCnt > 0 begin
		select @VendorID = ID from Vendor where Name = @vendor;
	end
	else begin
		select @vendidcnt = count(*) + 1 from Vendor where VendorID like 'SHFY-%';
		set @vendidtxt = 'SHFY-' + cast(@vendidcnt as varchar(3));
		insert into Vendor (VendorID, Name, CreatedBy, CreatedOn, LastChangedBy, LastChangedOn)
		values(@vendidtxt, @vendor, 0, getdate(), 0, getdate())
		select @VendorID = @@IDENTITY
	end
  end
  select @MaxPOSDisplay = isnull(Max(POSDisplayOrder),0) + 1 from Product where CategoryID = @CategoryID;

  insert into Product (SKU,[Description],ProductType, DepartmentID,CategoryID,PriceA,QtyOnHand, 
  POSBackground,POSScreenColor,POSScreenStyle,POSFontType,POSFontSize,POSFontColor,POSDisplayOrder,
  ProductPhoto,Cost,
  CreatedBy, CreatedOn, LastChangedBy, LastChangedOn)
  values(@sku_txt,@title,@product_type,@deptID,@CategoryID,@price,@qty,
  'Skin','0','','Tahoma',8,'0',@MaxPOSDisplay,@photo,@cost,
  0, getdate(), 0, getdate())
  select @ReturnID = @@IDENTITY

  if @ReturnID > 0 begin

    if @vendor <> '' begin
	  insert into VendPart(ProductID,VendorID,IsPrimary,CreatedBy, CreatedOn, LastChangedBy, LastChangedOn)
	  values(@ReturnID,@VendorID,'Y',0, getdate(), 0, getdate());
	end
    
	update product set ShopifyID = @id where ID = @ReturnID;

	if @product_type = 'P' begin
		update product set ShopifyVariantID = @variant_id where ID = @ReturnID;
		update product set ShopifyInventoryItemID = @inventory_id where ID = @ReturnID;
	end

	if @photo_id <> '0' begin
		update product set ShopifyImageID = @photo_id, ShopifyImageExportFlag = 'Y' where ID = @ReturnID;
	end
	 select  @cqty = qtyonhand from Product where ID = @ReturnID; 
	 set @sj = 0;
	 set @dt = getdate();
	 set @DocNo = 'New Product from Shopify Store/' + @sku_txt;
	 exec @sj = sp_AddJournal @DocNo, @dt, @ReturnID, 'Stock In', 'Opening Stock',@cqty,@cost,@TerminalName,0,@dt,'New Product from Shopify Store','N', @rout output

  end

end
					 
GO