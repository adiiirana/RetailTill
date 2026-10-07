
--==========================TaxMapping========================

IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[TaxMapping]') 
	  AND NAME = 'isPost'
)
BEGIN
	ALTER TABLE [dbo].[TaxMapping] 
	ADD isPost BIT DeFAULT(0) NOT NULL;
END

IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[TaxMapping]') 
	  AND NAME = 'PostDate'
)
BEGIN
	ALTER TABLE [dbo].[TaxMapping] 
	ADD PostDate DATETIME ;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[TaxMapping]') 
	  AND NAME = 'isUpdated'
)
BEGIN
	ALTER TABLE [dbo].[TaxMapping] 
	ADD isUpdated BIT DEFAULT(1) NOT NULL ;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[TaxMapping]') 
	  AND NAME = 'UpdatedDate'
)
BEGIN
	ALTER TABLE [dbo].[TaxMapping] 
	ADD UpdatedDate DATETIME;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[TaxMapping]') 
	  AND NAME = 'CloudId'
)
BEGIN
	ALTER TABLE [dbo].TaxMapping 
	ADD CloudId INT NULL;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[TaxMapping]') 
	  AND NAME = 'LastSyncDate'
)
BEGIN
	ALTER TABLE [dbo].[TaxMapping] 
	ADD LastSyncDate DATETIME;
END


--==========================Matrix========================

IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[Matrix]') 
	  AND NAME = 'isPost'
)
BEGIN
	ALTER TABLE [dbo].[Matrix] 
	ADD isPost BIT DeFAULT(0) NOT NULL;
END

IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[Matrix]') 
	  AND NAME = 'PostDate'
)
BEGIN
	ALTER TABLE [dbo].[Matrix] 
	ADD PostDate DATETIME ;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[Matrix]') 
	  AND NAME = 'isUpdated'
)
BEGIN
	ALTER TABLE [dbo].[Matrix] 
	ADD isUpdated BIT DEFAULT(1) NOT NULL ;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[Matrix]') 
	  AND NAME = 'UpdatedDate'
)
BEGIN
	ALTER TABLE [dbo].[Matrix] 
	ADD UpdatedDate DATETIME;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[Matrix]') 
	  AND NAME = 'CloudId'
)
BEGIN
	ALTER TABLE [dbo].Matrix 
	ADD CloudId INT NULL;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[Matrix]') 
	  AND NAME = 'LastSyncDate'
)
BEGIN
	ALTER TABLE [dbo].[Matrix] 
	ADD LastSyncDate DATETIME;
END


--==========================servicemapping========================

IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[servicemapping]') 
	  AND NAME = 'isPost'
)
BEGIN
	ALTER TABLE [dbo].[servicemapping] 
	ADD isPost BIT DeFAULT(0) NOT NULL;
END

IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[servicemapping]') 
	  AND NAME = 'PostDate'
)
BEGIN
	ALTER TABLE [dbo].[servicemapping] 
	ADD PostDate DATETIME ;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[servicemapping]') 
	  AND NAME = 'isUpdated'
)
BEGIN
	ALTER TABLE [dbo].[servicemapping] 
	ADD isUpdated BIT DEFAULT(1) NOT NULL ;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[servicemapping]') 
	  AND NAME = 'UpdatedDate'
)
BEGIN
	ALTER TABLE [dbo].[servicemapping] 
	ADD UpdatedDate DATETIME;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[servicemapping]') 
	  AND NAME = 'CloudId'
)
BEGIN
	ALTER TABLE [dbo].servicemapping 
	ADD CloudId INT NULL;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[servicemapping]') 
	  AND NAME = 'LastSyncDate'
)
BEGIN
	ALTER TABLE [dbo].[servicemapping] 
	ADD LastSyncDate DATETIME;
END


--==========================ExportBookingServiceMapping========================

IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[ExportBookingServiceMapping]') 
	  AND NAME = 'isPost'
)
BEGIN
	ALTER TABLE [dbo].[ExportBookingServiceMapping] 
	ADD isPost BIT DeFAULT(0) NOT NULL;
END

IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[ExportBookingServiceMapping]') 
	  AND NAME = 'PostDate'
)
BEGIN
	ALTER TABLE [dbo].[ExportBookingServiceMapping] 
	ADD PostDate DATETIME ;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[ExportBookingServiceMapping]') 
	  AND NAME = 'isUpdated'
)
BEGIN
	ALTER TABLE [dbo].[ExportBookingServiceMapping] 
	ADD isUpdated BIT DEFAULT(1) NOT NULL ;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[ExportBookingServiceMapping]') 
	  AND NAME = 'UpdatedDate'
)
BEGIN
	ALTER TABLE [dbo].[ExportBookingServiceMapping] 
	ADD UpdatedDate DATETIME;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[ExportBookingServiceMapping]') 
	  AND NAME = 'CloudId'
)
BEGIN
	ALTER TABLE [dbo].ExportBookingServiceMapping 
	ADD CloudId INT NULL;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[ExportBookingServiceMapping]') 
	  AND NAME = 'LastSyncDate'
)
BEGIN
	ALTER TABLE [dbo].[ExportBookingServiceMapping] 
	ADD LastSyncDate DATETIME;
END

--==========================ProductModifier========================

IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[ProductModifier]') 
	  AND NAME = 'isPost'
)
BEGIN
	ALTER TABLE [dbo].[ProductModifier] 
	ADD isPost BIT DeFAULT(0) NOT NULL;
END

IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[ProductModifier]') 
	  AND NAME = 'PostDate'
)
BEGIN
	ALTER TABLE [dbo].[ProductModifier] 
	ADD PostDate DATETIME ;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[ProductModifier]') 
	  AND NAME = 'isUpdated'
)
BEGIN
	ALTER TABLE [dbo].[ProductModifier] 
	ADD isUpdated BIT DEFAULT(1) NOT NULL ;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[ProductModifier]') 
	  AND NAME = 'UpdatedDate'
)
BEGIN
	ALTER TABLE [dbo].[ProductModifier] 
	ADD UpdatedDate DATETIME;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[ProductModifier]') 
	  AND NAME = 'CloudId'
)
BEGIN
	ALTER TABLE [dbo].ProductModifier 
	ADD CloudId INT NULL;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[ProductModifier]') 
	  AND NAME = 'LastSyncDate'
)
BEGIN
	ALTER TABLE [dbo].[ProductModifier] 
	ADD LastSyncDate DATETIME;
END

--==========================MatrixOptions========================

IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[MatrixOptions]') 
	  AND NAME = 'isPost'
)
BEGIN
	ALTER TABLE [dbo].[MatrixOptions] 
	ADD isPost BIT DeFAULT(0) NOT NULL;
END

IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[MatrixOptions]') 
	  AND NAME = 'PostDate'
)
BEGIN
	ALTER TABLE [dbo].[MatrixOptions] 
	ADD PostDate DATETIME ;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[MatrixOptions]') 
	  AND NAME = 'isUpdated'
)
BEGIN
	ALTER TABLE [dbo].[MatrixOptions] 
	ADD isUpdated BIT DEFAULT(1) NOT NULL ;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[MatrixOptions]') 
	  AND NAME = 'UpdatedDate'
)
BEGIN
	ALTER TABLE [dbo].[MatrixOptions] 
	ADD UpdatedDate DATETIME;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[MatrixOptions]') 
	  AND NAME = 'CloudId'
)
BEGIN
	ALTER TABLE [dbo].MatrixOptions 
	ADD CloudId INT NULL;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[MatrixOptions]') 
	  AND NAME = 'LastSyncDate'
)
BEGIN
	ALTER TABLE [dbo].[MatrixOptions] 
	ADD LastSyncDate DATETIME;
END


--==========================Kit========================

IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[Kit]') 
	  AND NAME = 'isPost'
)
BEGIN
	ALTER TABLE [dbo].[Kit] 
	ADD isPost BIT DeFAULT(0) NOT NULL;
END

IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[Kit]') 
	  AND NAME = 'PostDate'
)
BEGIN
	ALTER TABLE [dbo].[Kit] 
	ADD PostDate DATETIME ;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[Kit]') 
	  AND NAME = 'isUpdated'
)
BEGIN
	ALTER TABLE [dbo].[Kit] 
	ADD isUpdated BIT DEFAULT(1) NOT NULL ;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[Kit]') 
	  AND NAME = 'UpdatedDate'
)
BEGIN
	ALTER TABLE [dbo].[Kit] 
	ADD UpdatedDate DATETIME;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[Kit]') 
	  AND NAME = 'CloudId'
)
BEGIN
	ALTER TABLE [dbo].Kit 
	ADD CloudId INT NULL;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[Kit]') 
	  AND NAME = 'LastSyncDate'
)
BEGIN
	ALTER TABLE [dbo].[Kit] 
	ADD LastSyncDate DATETIME;
END

--==========================StoreCreditTransaction========================

IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[StoreCreditTransaction]') 
	  AND NAME = 'isPost'
)
BEGIN
	ALTER TABLE [dbo].[StoreCreditTransaction] 
	ADD isPost BIT DeFAULT(0) NOT NULL;
END

IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[StoreCreditTransaction]') 
	  AND NAME = 'PostDate'
)
BEGIN
	ALTER TABLE [dbo].[StoreCreditTransaction] 
	ADD PostDate DATETIME ;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[StoreCreditTransaction]') 
	  AND NAME = 'isUpdated'
)
BEGIN
	ALTER TABLE [dbo].[StoreCreditTransaction] 
	ADD isUpdated BIT DEFAULT(1) NOT NULL ;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[StoreCreditTransaction]') 
	  AND NAME = 'UpdatedDate'
)
BEGIN
	ALTER TABLE [dbo].[StoreCreditTransaction] 
	ADD UpdatedDate DATETIME;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[StoreCreditTransaction]') 
	  AND NAME = 'CloudId'
)
BEGIN
	ALTER TABLE [dbo].StoreCreditTransaction 
	ADD CloudId INT NULL;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[StoreCreditTransaction]') 
	  AND NAME = 'LastSyncDate'
)
BEGIN
	ALTER TABLE [dbo].[StoreCreditTransaction] 
	ADD LastSyncDate DATETIME;
END


--==========================SerialDetail========================

IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[SerialDetail]') 
	  AND NAME = 'isPost'
)
BEGIN
	ALTER TABLE [dbo].[SerialDetail] 
	ADD isPost BIT DeFAULT(0) NOT NULL;
END

IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[SerialDetail]') 
	  AND NAME = 'PostDate'
)
BEGIN
	ALTER TABLE [dbo].[SerialDetail] 
	ADD PostDate DATETIME ;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[SerialDetail]') 
	  AND NAME = 'isUpdated'
)
BEGIN
	ALTER TABLE [dbo].[SerialDetail] 
	ADD isUpdated BIT DEFAULT(1) NOT NULL ;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[SerialDetail]') 
	  AND NAME = 'UpdatedDate'
)
BEGIN
	ALTER TABLE [dbo].[SerialDetail] 
	ADD UpdatedDate DATETIME;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[SerialDetail]') 
	  AND NAME = 'CloudId'
)
BEGIN
	ALTER TABLE [dbo].SerialDetail 
	ADD CloudId INT NULL;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[SerialDetail]') 
	  AND NAME = 'LastSyncDate'
)
BEGIN
	ALTER TABLE [dbo].[SerialDetail] 
	ADD LastSyncDate DATETIME;
END


--==========================CentralExportDiscounts========================

IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[CentralExportDiscounts]') 
	  AND NAME = 'isPost'
)
BEGIN
	ALTER TABLE [dbo].[CentralExportDiscounts] 
	ADD isPost BIT DeFAULT(0) NOT NULL;
END

IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[CentralExportDiscounts]') 
	  AND NAME = 'PostDate'
)
BEGIN
	ALTER TABLE [dbo].[CentralExportDiscounts] 
	ADD PostDate DATETIME ;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[CentralExportDiscounts]') 
	  AND NAME = 'isUpdated'
)
BEGIN
	ALTER TABLE [dbo].[CentralExportDiscounts] 
	ADD isUpdated BIT DEFAULT(1) NOT NULL ;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[CentralExportDiscounts]') 
	  AND NAME = 'UpdatedDate'
)
BEGIN
	ALTER TABLE [dbo].[CentralExportDiscounts] 
	ADD UpdatedDate DATETIME;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[CentralExportDiscounts]') 
	  AND NAME = 'CloudId'
)
BEGIN
	ALTER TABLE [dbo].CentralExportDiscounts 
	ADD CloudId INT NULL;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[CentralExportDiscounts]') 
	  AND NAME = 'LastSyncDate'
)
BEGIN
	ALTER TABLE [dbo].[CentralExportDiscounts] 
	ADD LastSyncDate DATETIME;
END

--==========================SerialHeader========================

IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[SerialHeader]') 
	  AND NAME = 'isPost'
)
BEGIN
	ALTER TABLE [dbo].[SerialHeader] 
	ADD isPost BIT DeFAULT(0) NOT NULL;
END

IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[SerialHeader]') 
	  AND NAME = 'PostDate'
)
BEGIN
	ALTER TABLE [dbo].[SerialHeader] 
	ADD PostDate DATETIME ;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[SerialHeader]') 
	  AND NAME = 'isUpdated'
)
BEGIN
	ALTER TABLE [dbo].[SerialHeader] 
	ADD isUpdated BIT DEFAULT(1) NOT NULL ;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[SerialHeader]') 
	  AND NAME = 'UpdatedDate'
)
BEGIN
	ALTER TABLE [dbo].[SerialHeader] 
	ADD UpdatedDate DATETIME;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[SerialHeader]') 
	  AND NAME = 'CloudId'
)
BEGIN
	ALTER TABLE [dbo].SerialHeader 
	ADD CloudId INT NULL;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[SerialHeader]') 
	  AND NAME = 'LastSyncDate'
)
BEGIN
	ALTER TABLE [dbo].[SerialHeader] 
	ADD LastSyncDate DATETIME;
END

--==========================MatrixValues========================

IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[MatrixValues]') 
	  AND NAME = 'isPost'
)
BEGIN
	ALTER TABLE [dbo].[MatrixValues] 
	ADD isPost BIT DeFAULT(0) NOT NULL;
END

IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[MatrixValues]') 
	  AND NAME = 'PostDate'
)
BEGIN
	ALTER TABLE [dbo].[MatrixValues] 
	ADD PostDate DATETIME ;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[MatrixValues]') 
	  AND NAME = 'isUpdated'
)
BEGIN
	ALTER TABLE [dbo].[MatrixValues] 
	ADD isUpdated BIT DEFAULT(1) NOT NULL ;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[MatrixValues]') 
	  AND NAME = 'UpdatedDate'
)
BEGIN
	ALTER TABLE [dbo].[MatrixValues] 
	ADD UpdatedDate DATETIME;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[MatrixValues]') 
	  AND NAME = 'CloudId'
)
BEGIN
	ALTER TABLE [dbo].MatrixValues 
	ADD CloudId INT NULL;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[MatrixValues]') 
	  AND NAME = 'LastSyncDate'
)
BEGIN
	ALTER TABLE [dbo].[MatrixValues] 
	ADD LastSyncDate DATETIME;
END

--==========================EmpPassword========================

IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[EmpPassword]') 
	  AND NAME = 'isPost'
)
BEGIN
	ALTER TABLE [dbo].[EmpPassword] 
	ADD isPost BIT DeFAULT(0) NOT NULL;
END

IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[EmpPassword]') 
	  AND NAME = 'PostDate'
)
BEGIN
	ALTER TABLE [dbo].[EmpPassword] 
	ADD PostDate DATETIME ;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[EmpPassword]') 
	  AND NAME = 'isUpdated'
)
BEGIN
	ALTER TABLE [dbo].[EmpPassword] 
	ADD isUpdated BIT DEFAULT(1) NOT NULL ;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[EmpPassword]') 
	  AND NAME = 'UpdatedDate'
)
BEGIN
	ALTER TABLE [dbo].[EmpPassword] 
	ADD UpdatedDate DATETIME;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[EmpPassword]') 
	  AND NAME = 'CloudId'
)
BEGIN
	ALTER TABLE [dbo].EmpPassword 
	ADD CloudId INT NULL;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[EmpPassword]') 
	  AND NAME = 'LastSyncDate'
)
BEGIN
	ALTER TABLE [dbo].[EmpPassword] 
	ADD LastSyncDate DATETIME;
END


--==========================DiscountDate========================

IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[DiscountDate]') 
	  AND NAME = 'isPost'
)
BEGIN
	ALTER TABLE [dbo].[DiscountDate] 
	ADD isPost BIT DeFAULT(0) NOT NULL;
END

IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[DiscountDate]') 
	  AND NAME = 'PostDate'
)
BEGIN
	ALTER TABLE [dbo].[DiscountDate] 
	ADD PostDate DATETIME ;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[DiscountDate]') 
	  AND NAME = 'isUpdated'
)
BEGIN
	ALTER TABLE [dbo].[DiscountDate] 
	ADD isUpdated BIT DEFAULT(1) NOT NULL ;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[DiscountDate]') 
	  AND NAME = 'UpdatedDate'
)
BEGIN
	ALTER TABLE [dbo].[DiscountDate] 
	ADD UpdatedDate DATETIME;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[DiscountDate]') 
	  AND NAME = 'CloudId'
)
BEGIN
	ALTER TABLE [dbo].DiscountDate 
	ADD CloudId INT NULL;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[DiscountDate]') 
	  AND NAME = 'LastSyncDate'
)
BEGIN
	ALTER TABLE [dbo].[DiscountDate] 
	ADD LastSyncDate DATETIME;
END

--==========================DiscountTime========================

IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[DiscountTime]') 
	  AND NAME = 'isPost'
)
BEGIN
	ALTER TABLE [dbo].[DiscountTime] 
	ADD isPost BIT DeFAULT(0) NOT NULL;
END

IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[DiscountTime]') 
	  AND NAME = 'PostDate'
)
BEGIN
	ALTER TABLE [dbo].[DiscountTime] 
	ADD PostDate DATETIME ;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[DiscountTime]') 
	  AND NAME = 'isUpdated'
)
BEGIN
	ALTER TABLE [dbo].[DiscountTime] 
	ADD isUpdated BIT DEFAULT(1) NOT NULL ;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[DiscountTime]') 
	  AND NAME = 'UpdatedDate'
)
BEGIN
	ALTER TABLE [dbo].[DiscountTime] 
	ADD UpdatedDate DATETIME;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[DiscountTime]') 
	  AND NAME = 'CloudId'
)
BEGIN
	ALTER TABLE [dbo].DiscountTime 
	ADD CloudId INT NULL;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[DiscountTime]') 
	  AND NAME = 'LastSyncDate'
)
BEGIN
	ALTER TABLE [dbo].[DiscountTime] 
	ADD LastSyncDate DATETIME;
END


--==========================CardTrans========================

IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[CardTrans]') 
	  AND NAME = 'isPost'
)
BEGIN
	ALTER TABLE [dbo].[CardTrans] 
	ADD isPost BIT DeFAULT(0) NOT NULL;
END

IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[CardTrans]') 
	  AND NAME = 'PostDate'
)
BEGIN
	ALTER TABLE [dbo].[CardTrans] 
	ADD PostDate DATETIME ;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[CardTrans]') 
	  AND NAME = 'isUpdated'
)
BEGIN
	ALTER TABLE [dbo].[CardTrans] 
	ADD isUpdated BIT DEFAULT(1) NOT NULL ;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[CardTrans]') 
	  AND NAME = 'UpdatedDate'
)
BEGIN
	ALTER TABLE [dbo].[CardTrans] 
	ADD UpdatedDate DATETIME;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[CardTrans]') 
	  AND NAME = 'CloudId'
)
BEGIN
	ALTER TABLE [dbo].CardTrans 
	ADD CloudId INT NULL;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[CardTrans]') 
	  AND NAME = 'LastSyncDate'
)
BEGIN
	ALTER TABLE [dbo].[CardTrans] 
	ADD LastSyncDate DATETIME;
END


--==========================CentralExportCardAuthorisation========================

IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[CentralExportCardAuthorisation]') 
	  AND NAME = 'isPost'
)
BEGIN
	ALTER TABLE [dbo].[CentralExportCardAuthorisation] 
	ADD isPost BIT DeFAULT(0) NOT NULL;
END

IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[CentralExportCardAuthorisation]') 
	  AND NAME = 'PostDate'
)
BEGIN
	ALTER TABLE [dbo].[CentralExportCardAuthorisation] 
	ADD PostDate DATETIME ;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[CentralExportCardAuthorisation]') 
	  AND NAME = 'isUpdated'
)
BEGIN
	ALTER TABLE [dbo].[CentralExportCardAuthorisation] 
	ADD isUpdated BIT DEFAULT(1) NOT NULL ;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[CentralExportCardAuthorisation]') 
	  AND NAME = 'UpdatedDate'
)
BEGIN
	ALTER TABLE [dbo].[CentralExportCardAuthorisation] 
	ADD UpdatedDate DATETIME;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[CentralExportCardAuthorisation]') 
	  AND NAME = 'CloudId'
)
BEGIN
	ALTER TABLE [dbo].CentralExportCardAuthorisation 
	ADD CloudId INT NULL;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[CentralExportCardAuthorisation]') 
	  AND NAME = 'LastSyncDate'
)
BEGIN
	ALTER TABLE [dbo].[CentralExportCardAuthorisation] 
	ADD LastSyncDate DATETIME;
END


--==========================CardAuthorisation========================

IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[CardAuthorisation]') 
	  AND NAME = 'isPost'
)
BEGIN
	ALTER TABLE [dbo].[CardAuthorisation] 
	ADD isPost BIT DeFAULT(0) NOT NULL;
END

IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[CardAuthorisation]') 
	  AND NAME = 'PostDate'
)
BEGIN
	ALTER TABLE [dbo].[CardAuthorisation] 
	ADD PostDate DATETIME ;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[CardAuthorisation]') 
	  AND NAME = 'isUpdated'
)
BEGIN
	ALTER TABLE [dbo].[CardAuthorisation] 
	ADD isUpdated BIT DEFAULT(1) NOT NULL ;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[CardAuthorisation]') 
	  AND NAME = 'UpdatedDate'
)
BEGIN
	ALTER TABLE [dbo].[CardAuthorisation] 
	ADD UpdatedDate DATETIME;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[CardAuthorisation]') 
	  AND NAME = 'CloudId'
)
BEGIN
	ALTER TABLE [dbo].CardAuthorisation 
	ADD CloudId INT NULL;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[CardAuthorisation]') 
	  AND NAME = 'LastSyncDate'
)
BEGIN
	ALTER TABLE [dbo].[CardAuthorisation] 
	ADD LastSyncDate DATETIME;
END

--==========================Closeout========================

IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[Closeout]') 
	  AND NAME = 'isPost'
)
BEGIN
	ALTER TABLE [dbo].[Closeout] 
	ADD isPost BIT DeFAULT(0) NOT NULL;
END

IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[Closeout]') 
	  AND NAME = 'PostDate'
)
BEGIN
	ALTER TABLE [dbo].[Closeout] 
	ADD PostDate DATETIME ;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[Closeout]') 
	  AND NAME = 'isUpdated'
)
BEGIN
	ALTER TABLE [dbo].[Closeout] 
	ADD isUpdated BIT DEFAULT(1) NOT NULL ;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[Closeout]') 
	  AND NAME = 'UpdatedDate'
)
BEGIN
	ALTER TABLE [dbo].[Closeout] 
	ADD UpdatedDate DATETIME;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[Closeout]') 
	  AND NAME = 'CloudId'
)
BEGIN
	ALTER TABLE [dbo].Closeout 
	ADD CloudId INT NULL;
END
IF NOT EXISTS (
	SELECT * 
	FROM syscolumns 
	WHERE ID = OBJECT_ID('[dbo].[Closeout]') 
	  AND NAME = 'LastSyncDate'
)
BEGIN
	ALTER TABLE [dbo].[Closeout] 
	ADD LastSyncDate DATETIME;
END