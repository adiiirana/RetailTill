
IF NOT EXISTS(SELECT 1 FROM ReceiptTemplateDummyData)
BEGIN

Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,TemplateWidth,TemplateHeight,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight,CtrlPositionTop)
values('1 Up Label','Item Name',1,280,125,'Item 1', 'left', 'normal',12, 0, 0,2 );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,TemplateWidth,TemplateHeight,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight,CtrlPositionTop)
values('1 Up Label','Item Price',2,280,125,'10.00', 'right', 'normal',20, 0, 0,26);
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,TemplateWidth,TemplateHeight,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight,CtrlPositionTop)
values('1 Up Label','Barcode',3,280,125,'Barcode', 'center', 'normal',8, 180, 30,60);
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,TemplateWidth,TemplateHeight,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight,CtrlPositionTop)
values('1 Up Label','SKU',4,280,125,'1234567890', 'left', 'normal',10, 0, 0,96);

Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('No Sale','Business Name',1,'Business Name', 'left', 'normal',12, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('No Sale','Business Address',2,'Business Address', 'left', 'normal',10, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('No Sale','Separator',3,'---- S E P A R A T O R ----', 'center', 'normal',8, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('No Sale','No Sale Caption',4,'** No Sale **', 'center', 'bold',12, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('No Sale','Separator',5,'---- S E P A R A T O R ----', 'center', 'normal',8, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('No Sale','Receipt Date',6,'Receipt Date', 'left', 'normal',10, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('No Sale','User Name',7,'User Name', 'left', 'normal',8, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('No Sale','Till Name',8,'Till Name', 'left', 'normal',8, 0, 0  );

Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Paid Out','Business Name',1,'Business Name', 'left', 'normal',12, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Paid Out','Business Address',2,'Business Address', 'left', 'normal',10, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Paid Out','Separator',3,'---- S E P A R A T O R ----', 'center', 'normal',8, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Paid Out','Paid Out Caption',4,'** Paid Out **', 'center', 'bold',12, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Paid Out','Paid Out Explanation',5,'paid out explanation', 'left', 'normal',11, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Paid Out','Paid Out Amount',6,'200.00', 'left', 'normal',14, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Paid Out','Separator',7,'---- S E P A R A T O R ----', 'center', 'normal',8, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Paid Out','Receipt Date',8,'Receipt Date', 'left', 'normal',10, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Paid Out','User Name',9,'User Name', 'left', 'normal',8, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Paid Out','Till Name',10,'Till Name', 'left', 'normal',8, 0, 0  );

Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Paid In','Business Name',1,'Business Name', 'left', 'normal',12, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Paid In','Business Address',2,'Business Address', 'left', 'normal',10, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Paid In','Separator',3,'---- S E P A R A T O R ----', 'center', 'normal',8, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Paid In','Paid In Caption',4,'** Paid In **', 'center', 'bold',12, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Paid In','Paid In Explanation',5,'Paid In Explanation', 'left', 'normal',11, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Paid In','Paid In Amount',6,'100.00', 'left', 'normal',14, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Paid In','Separator',7,'---- S E P A R A T O R ----', 'center', 'normal',8, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Paid In','Receipt Date',8,'Receipt Date', 'left', 'normal',10, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Paid In','User Name',9,'User Name', 'left', 'normal',8, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Paid In','Till Name',10,'Till Name', 'left', 'normal',8, 0, 0  );

Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Safe Drop','Business Name',1,'Business Name', 'left', 'normal',12, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Safe Drop','Business Address',2,'Business Address', 'left', 'normal',10, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Safe Drop','Separator',3,'---- S E P A R A T O R ----', 'center', 'normal',8, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Safe Drop','Safe Drop Caption',4,'** Safe Drop **', 'center', 'bold',12, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Safe Drop','Safe Drop Amount',5,'100.00', 'left', 'normal',14, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Safe Drop','Separator',6,'---- S E P A R A T O R ----', 'center', 'normal',8, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Safe Drop','Receipt Date',7,'Receipt Date', 'left', 'normal',10, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Safe Drop','User Name',8,'User Name', 'left', 'normal',8, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Safe Drop','Till Name',9,'Till Name', 'left', 'normal',8, 0, 0  );

Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Lotto Payout','Business Name',1,'Business Name', 'left', 'normal',12, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Lotto Payout','Business Address',2,'Business Address', 'left', 'normal',10, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Lotto Payout','Separator',3,'---- S E P A R A T O R ----', 'center', 'normal',8, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Lotto Payout','Lotto Payout Caption',4,'** Lotto Payout **', 'center', 'bold',12, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Lotto Payout','Lotto Payout Explanation',5,'Paid In Explanation', 'left', 'normal',11, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Lotto Payout','Lotto Payout Amount',6,'100.00', 'left', 'normal',14, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Lotto Payout','Separator',7,'---- S E P A R A T O R ----', 'center', 'normal',8, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Lotto Payout','Receipt Date',8,'Receipt Date', 'left', 'normal',10, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Lotto Payout','User Name',9,'User Name', 'left', 'normal',8, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Lotto Payout','Till Name',10,'Till Name', 'left', 'normal',8, 0, 0  );

Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Customer Label','Customer Company',1,'Customer Company', 'left', 'normal',10, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Customer Label','Customer Mail Address',2,'Customer Mail Address', 'left', 'normal',10, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Customer Label','Customer Name',3,'Customer Name', 'left', 'normal',12, 0, 0  );


Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Gift Receipt','Gift Receipt Caption',1,'**Gift Receipt**', 'center', 'normal',12, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Gift Receipt','Logo',2,'Logo', 'center', 'normal',10, 90, 90  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Gift Receipt','Business Name',3,'Business Name', 'left', 'normal',12, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Gift Receipt','Business Address',4,'Business Address', 'left', 'normal',10, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Gift Receipt','Separator',5,'---- S E P A R A T O R ----', 'center', 'normal',8, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Gift Receipt','Receipt Number',6,'Receipt Number: 6547', 'left', 'normal',12, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Gift Receipt','Separator',7,'---- S E P A R A T O R ----', 'center', 'normal',8, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Gift Receipt','Customer Name',8,'Customer Name', 'left', 'normal',10, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Gift Receipt','Customer Address',9,'Customer Address', 'left', 'normal',10, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Gift Receipt','Separator',10,'---- S E P A R A T O R ----', 'center', 'normal',8, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Gift Receipt','Details',11,'Details', 'left', 'normal',11, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Gift Receipt','Separator',12,'---- S E P A R A T O R ----', 'center', 'normal',8, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Gift Receipt','Receipt Date',13,'Receipt Date', 'left', 'normal',10, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Gift Receipt','User Name',14,'User Name', 'left', 'normal',8, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Gift Receipt','Till Name',15,'Till Name', 'left', 'normal',8, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Gift Receipt','Receipt Footer',16,'Receipt Footer', 'left', 'italic',9, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Gift Receipt','Barcode',17,'Barcode', 'center', 'normal',12, 180, 40  );


Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Receipt','Logo',1,'Logo', 'center', 'normal',10, 90, 90  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Receipt','Business Name',2,'Business Name', 'left', 'normal',12, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Receipt','Business Address',3,'Business Address', 'left', 'normal',10, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Receipt','Separator',4,'---- S E P A R A T O R ----', 'center', 'normal',8, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Receipt','Receipt Number',5,'Receipt Number: 6547', 'left', 'normal',12, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Receipt','Separator',6,'---- S E P A R A T O R ----', 'center', 'normal',8, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Receipt','Customer Name',7,'Customer Name', 'left', 'normal',10, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Receipt','Customer Address',8,'Customer Address', 'left', 'normal',10, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Receipt','Separator',9,'---- S E P A R A T O R ----', 'center', 'normal',8, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight,
ShowHeader1,ShowHeader2,ShowHeader3,Header1Caption,Header2Caption,Header3Caption)
values('Receipt','Item/Price Header',10,'Unit Price     Net Wt/Ct     Total Price', 'center', 'bold',10, 0, 0,'Y','Y','Y','Unit Price','Net Wt/Ct','Total Price'  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Receipt','Separator',11,'---- S E P A R A T O R ----', 'center', 'normal',8, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Receipt','Item/Price Line',12,'Item 1   6.00       2       12.00', 'center', 'normal',10, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Receipt','Separator',13,'---- S E P A R A T O R ----', 'center', 'normal',8, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Receipt','Subtotal Amount',14,'Sub Total: £10.25', 'right', 'normal',11, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Receipt','Discount Amount',15,'Discount: £0.00', 'right', 'normal',10, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Receipt','Tax Amount',16,'Tax: £0.00', 'right', 'normal',10, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Receipt','Total Amount',17,'Total Amount', 'right', 'bold',13, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Receipt','Tender Amount',18,'Tender Amount', 'left', 'normal',10, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Receipt','Change Due Amount',19,'Change Due Amount', 'right', 'normal',11, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Receipt','Receipt Date',20,'Receipt Date', 'left', 'normal',10, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Receipt','User Name',21,'User Name', 'left', 'normal',8, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Receipt','Till Name',22,'Till Name', 'left', 'normal',8, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Receipt','Receipt Footer',23,'Receipt Footer', 'left', 'italic',9, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Receipt','Barcode',24,'Barcode', 'center', 'normal',12, 180, 40  );

Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Layaway','Logo',1,'Logo', 'center', 'normal',10, 90, 90  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Layaway','Business Name',2,'Business Name', 'left', 'normal',12, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Layaway','Business Address',3,'Business Address', 'left', 'normal',10, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Layaway','Separator',4,'---- S E P A R A T O R ----', 'center', 'normal',8, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Layaway','Receipt/Layaway Number',5,'Layaway Number: 6547', 'left', 'normal',12, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Layaway','Separator',6,'---- S E P A R A T O R ----', 'center', 'normal',8, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Layaway','Customer Name',7,'Customer Name', 'left', 'normal',10, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Layaway','Customer Address',8,'Customer Address', 'left', 'normal',10, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Layaway','Separator',9,'---- S E P A R A T O R ----', 'center', 'normal',8, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Layaway','Item/Price Line',10,'Item 1   6.00       2       12.00', 'center', 'normal',10, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Layaway','Separator',11,'---- S E P A R A T O R ----', 'center', 'normal',8, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Layaway','Subtotal Amount',12,'Sub Total: £10.25', 'right', 'normal',11, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Layaway','Discount Amount',13,'Discount: £0.00', 'right', 'normal',10, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Layaway','Tax Amount',14,'Tax: £0.00', 'right', 'normal',10, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Layaway','Total Amount',15,'Total Amount', 'right', 'bold',13, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Layaway','Layaway Payment Details',16,'Payment: £10.00', 'left', 'normal',10, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Layaway','Balance Due Amount',17,'Balance Due: £0.00', 'right', 'normal',10, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Layaway','Due Date',18,'Due Date: 10/10/2024', 'right', 'normal',10, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Layaway','Tender Amount',19,'Tender Amount', 'left', 'normal',10, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Layaway','Receipt Date',20,'Receipt Date', 'left', 'normal',10, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Layaway','User Name',21,'User Name', 'left', 'normal',8, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Layaway','Till Name',22,'Till Name', 'left', 'normal',8, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Layaway','Layaway Policy',23,'Layaway Policy', 'left', 'italic',9, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Layaway','Barcode',24,'Barcode', 'center', 'normal',12, 180, 40  );

Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Item','Business Name',1,'Business Name', 'left', 'normal',12, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Item','Business Address',2,'Business Address', 'left', 'normal',10, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Item','Separator',3,'---- S E P A R A T O R ----', 'center', 'normal',8, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Item','Invoice Number',4,'Invoice Number: 6547', 'left', 'normal',12, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Item','Date',5,'Date: 10-10-2023', 'left', 'normal',12, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Item','Separator',6,'---- S E P A R A T O R ----', 'center', 'normal',8, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Item','Printer Name',7,'Printer', 'center', 'normal',10, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Item','Item and Qty',8,'Item and Qty', 'center', 'normal',10, 0, 0  );


Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Suspend Receipt','Logo',1,'Logo', 'center', 'normal',10, 90, 90  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Suspend Receipt','Business Name',2,'Business Name', 'left', 'normal',12, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Suspend Receipt','Business Address',3,'Business Address', 'left', 'normal',10, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Suspend Receipt','Separator',4,'---- S E P A R A T O R ----', 'center', 'normal',8, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Suspend Receipt','Suspended Number',5,'Suspended Number: 6547', 'left', 'normal',12, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Suspend Receipt','Separator',6,'---- S E P A R A T O R ----', 'center', 'normal',8, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Suspend Receipt','Customer Name',7,'Customer Name', 'left', 'normal',10, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Suspend Receipt','Separator',8,'---- S E P A R A T O R ----', 'center', 'normal',8, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Suspend Receipt','Item/Price Line',9,'Item 1   6.00       2       12.00', 'center', 'normal',10, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Suspend Receipt','Separator',10,'---- S E P A R A T O R ----', 'center', 'normal',8, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Suspend Receipt','Subtotal Amount',11,'Sub Total: £10.25', 'right', 'normal',11, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Suspend Receipt','Discount Amount',12,'Discount: £0.00', 'right', 'normal',10, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Suspend Receipt','Tax Amount',13,'Tax: £0.00', 'right', 'normal',10, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Suspend Receipt','Total Amount',14,'Total Amount', 'right', 'bold',13, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Suspend Receipt','Receipt Date',15,'Receipt Date', 'left', 'normal',10, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Suspend Receipt','User Name',16,'User Name', 'left', 'normal',8, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Suspend Receipt','Till Name',17,'Till Name', 'left', 'normal',8, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Suspend Receipt','Receipt Footer',18,'Receipt Footer', 'left', 'italic',9, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Suspend Receipt','Barcode',19,'Barcode', 'center', 'normal',12, 180, 40  );



Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('WorkOrder','Logo',1,'Logo', 'center', 'normal',10, 90, 90  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('WorkOrder','Business Name',2,'Business Name', 'left', 'normal',12, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('WorkOrder','Business Address',3,'Business Address', 'left', 'normal',10, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('WorkOrder','Separator',4,'---- S E P A R A T O R ----', 'center', 'normal',8, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('WorkOrder','Work Order Number',5,'Work Order Number: 6547', 'left', 'normal',12, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('WorkOrder','Separator',6,'---- S E P A R A T O R ----', 'center', 'normal',8, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('WorkOrder','Customer Name',7,'Customer Name', 'left', 'normal',10, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('WorkOrder','Separator',8,'---- S E P A R A T O R ----', 'center', 'normal',8, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('WorkOrder','Item/Price Line',9,'Item 1   6.00       2       12.00', 'center', 'normal',10, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('WorkOrder','Separator',10,'---- S E P A R A T O R ----', 'center', 'normal',8, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('WorkOrder','Subtotal Amount',11,'Sub Total: £10.25', 'right', 'normal',11, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('WorkOrder','Discount Amount',12,'Discount: £0.00', 'right', 'normal',10, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('WorkOrder','Tax Amount',13,'Tax: £0.00', 'right', 'normal',10, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('WorkOrder','Total Amount',14,'Total Amount', 'right', 'bold',13, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('WorkOrder','Receipt Date',15,'Receipt Date', 'left', 'normal',10, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('WorkOrder','User Name',16,'User Name', 'left', 'normal',8, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('WorkOrder','Till Name',17,'Till Name', 'left', 'normal',8, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('WorkOrder','Receipt Footer',18,'Receipt Footer', 'left', 'italic',9, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('WorkOrder','Barcode',19,'Barcode', 'center', 'normal',12, 180, 40  );



Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Rent Item Issue','Logo',1,'Logo', 'center', 'normal',10, 90, 90  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Rent Item Issue','Business Name',2,'Business Name', 'left', 'normal',12, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Rent Item Issue','Business Address',3,'Business Address', 'left', 'normal',10, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Rent Item Issue','Rent Issue Caption',4,'Rent Issue', 'right', 'normal',12, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Rent Item Issue','Separator',5,'---- S E P A R A T O R ----', 'center', 'normal',8, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Rent Item Issue','Receipt Number',6,'Receipt Number: 6547', 'left', 'normal',12, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Rent Item Issue','Separator',7,'---- S E P A R A T O R ----', 'center', 'normal',8, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Rent Item Issue','Customer Name',8,'Customer Name', 'left', 'normal',10, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Rent Item Issue','Customer Address',9,'Customer Address', 'left', 'normal',10, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Rent Item Issue','Separator',10,'---- S E P A R A T O R ----', 'center', 'normal',8, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Rent Item Issue','Details',11,'Item 1   6.00       2       12.00', 'center', 'normal',10, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Rent Item Issue','Separator',12,'---- S E P A R A T O R ----', 'center', 'normal',8, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Rent Item Issue','Subtotal Amount',13,'Sub Total: £10.25', 'right', 'normal',11, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Rent Item Issue','Discount Amount',14,'Discount: £0.00', 'right', 'normal',10, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Rent Item Issue','Tax Amount',15,'Tax: £0.00', 'right', 'normal',10, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Rent Item Issue','Security Deposit Amount',16,'Tax: £5.00', 'right', 'normal',10, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Rent Item Issue','Total Amount',17,'Total Amount', 'right', 'bold',13, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Rent Item Issue','Tender Amount',18,'Tender Amount', 'left', 'normal',10, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Rent Item Issue','Change Due Amount',19,'Change Due Amount', 'right', 'normal',11, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Rent Item Issue','Receipt Date',20,'Receipt Date', 'left', 'normal',10, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Rent Item Issue','User Name',21,'User Name', 'left', 'normal',8, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Rent Item Issue','Till Name',22,'Till Name', 'left', 'normal',8, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Rent Item Issue','Receipt Footer',23,'Receipt Footer', 'left', 'italic',9, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Rent Item Issue','Barcode',24,'Barcode', 'center', 'normal',12, 180, 40  );

Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Rent Item Return','Logo',1,'Logo', 'center', 'normal',10, 90, 90  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Rent Item Return','Business Name',2,'Business Name', 'left', 'normal',12, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Rent Item Return','Business Address',3,'Business Address', 'left', 'normal',10, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Rent Item Return','Rent Return Caption',4,'Rent Return', 'right', 'normal',12, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Rent Item Return','Separator',5,'---- S E P A R A T O R ----', 'center', 'normal',8, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Rent Item Return','Receipt Number',6,'Receipt Number: 6547', 'left', 'normal',12, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Rent Item Return','Reference Invoice Number',7,'Ref. Invoice Number: 32', 'left', 'normal',12, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Rent Item Return','Separator',8,'---- S E P A R A T O R ----', 'center', 'normal',8, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Rent Item Return','Customer Name',9,'Customer Name', 'left', 'normal',10, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Rent Item Return','Customer Address',10,'Customer Address', 'left', 'normal',10, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Rent Item Return','Separator',11,'---- S E P A R A T O R ----', 'center', 'normal',8, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Rent Item Return','Details',12,'Item 1   6.00       2       12.00', 'center', 'normal',10, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Rent Item Return','Separator',13,'---- S E P A R A T O R ----', 'center', 'normal',8, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Rent Item Return','Tax Amount',14,'Tax: £0.00', 'right', 'normal',10, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Rent Item Return','Security Deposit Amount',15,'Security Amt: £5.00', 'right', 'normal',10, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Rent Item Return','Return Deposit Amount',16,'Return Deposit: £10.25', 'right', 'normal',11, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Rent Item Return','Due Amount',17,'Due: £0.00', 'right', 'normal',10, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Rent Item Return','Total Amount',18,'Total Amount', 'right', 'bold',13, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Rent Item Return','Tender Amount',19,'Tender Amount', 'left', 'normal',10, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Rent Item Return','Change Due Amount',20,'Change Due Amount', 'right', 'normal',11, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Rent Item Return','Receipt Date',21,'Receipt Date', 'left', 'normal',10, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Rent Item Return','User Name',22,'User Name', 'left', 'normal',8, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Rent Item Return','Till Name',23,'Till Name', 'left', 'normal',8, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Rent Item Return','Receipt Footer',24,'Receipt Footer', 'left', 'italic',9, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Rent Item Return','Barcode',25,'Barcode', 'center', 'normal',12, 180, 40  );


Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Repair Item Receive','Logo',1,'Logo', 'center', 'normal',10, 90, 90  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Repair Item Receive','Business Name',2,'Business Name', 'left', 'normal',12, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Repair Item Receive','Business Address',3,'Business Address', 'left', 'normal',10, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Repair Item Receive','Repair Issue Caption',4,'Repair Issue', 'right', 'normal',12, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Repair Item Receive','Separator',5,'---- S E P A R A T O R ----', 'center', 'normal',8, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Repair Item Receive','Receipt Number',6,'Receipt Number: 6547', 'left', 'normal',12, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Repair Item Receive','Separator',7,'---- S E P A R A T O R ----', 'center', 'normal',8, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Repair Item Receive','Date In',8,'Date In: 10-10-2023', 'left', 'normal',10, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Repair Item Receive','Delivery Date',9,'Delivery Date: 20-10-2023', 'left', 'normal',10, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Repair Item Receive','Notified Date',10,'Notified Date: 15-10-2023', 'left', 'normal',10, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Repair Item Receive','Separator',11,'---- S E P A R A T O R ----', 'center', 'normal',8, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Repair Item Receive','Customer Name',12,'Customer Name', 'left', 'normal',10, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Repair Item Receive','Customer Phone',13,'Customer Phone', 'left', 'normal',10, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Repair Item Receive','Separator',14,'---- S E P A R A T O R ----', 'center', 'normal',8, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Repair Item Receive','Repair Item Name',15,'Repair Item Name', 'left', 'normal',10, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Repair Item Receive','Repair Item Serial No',16,'Repair Item Serial No', 'left', 'normal',10, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Repair Item Receive','Repair Item Problem',17,'Repair Item Problem', 'left', 'normal',9, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Repair Item Receive','Separator',18,'---- S E P A R A T O R ----', 'center', 'normal',8, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Repair Item Receive','Details',19,'Item 1   6.00       2       12.00', 'center', 'normal',10, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Repair Item Receive','Separator',20,'---- S E P A R A T O R ----', 'center', 'normal',8, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Repair Item Receive','Subtotal Amount',21,'Sub Total: £10.25', 'right', 'normal',11, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Repair Item Receive','Discount Amount',22,'Discount: £0.00', 'right', 'normal',10, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Repair Item Receive','Tax Amount',23,'Tax: £0.00', 'right', 'normal',10, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Repair Item Receive','Total Amount',24,'Total Amount', 'right', 'bold',13, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Repair Item Receive','Transaction/ Advance Amount',25,'Advance: £0.00', 'right', 'normal',10, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Repair Item Receive','Due Amount',26,'Due: £0.00', 'right', 'normal',10, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Repair Item Receive','Tender Amount',27,'Tender Amount', 'left', 'normal',10, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Repair Item Receive','Change Due Amount',28,'Change Due Amount', 'right', 'normal',11, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Repair Item Receive','Repair Agree Line',29,'Repair Agree Details', 'left', 'normal',9, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Repair Item Receive','Separator',30,'---- S E P A R A T O R ----', 'center', 'normal',8, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Repair Item Receive','Repair Signature Line',31,'S I G N A T U R E', 'right', 'normal',8, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Repair Item Receive','Receipt Date',32,'Receipt Date', 'left', 'normal',10, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Repair Item Receive','User Name',33,'User Name', 'left', 'normal',8, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Repair Item Receive','Till Name',34,'Till Name', 'left', 'normal',8, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Repair Item Receive','Receipt Footer',35,'Receipt Footer', 'left', 'italic',9, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Repair Item Receive','Barcode',36,'Barcode', 'center', 'normal',12, 180, 40  );



Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Repair Item Return','Logo',1,'Logo', 'center', 'normal',10, 90, 90  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Repair Item Return','Business Name',2,'Business Name', 'left', 'normal',12, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Repair Item Return','Business Address',3,'Business Address', 'left', 'normal',10, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Repair Item Return','Repair Deliver Caption',4,'Repair Deliver', 'right', 'normal',12, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Repair Item Return','Separator',5,'---- S E P A R A T O R ----', 'center', 'normal',8, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Repair Item Return','Receipt Number',6,'Receipt Number: 6547', 'left', 'normal',12, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Repair Item Return','Reference Invoice Number',7,'Ref. Invoice Number: 45', 'left', 'normal',12, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Repair Item Return','Separator',8,'---- S E P A R A T O R ----', 'center', 'normal',8, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Repair Item Return','Customer Name',9,'Customer Name', 'left', 'normal',10, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Repair Item Return','Customer Phone',10,'Customer Phone', 'left', 'normal',10, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Repair Item Return','Separator',11,'---- S E P A R A T O R ----', 'center', 'normal',8, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Repair Item Return','Repair Item Name',12,'Repair Item Name', 'left', 'normal',10, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Repair Item Return','Repair Item Serial No',13,'Repair Item Serial No', 'left', 'normal',10, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Repair Item Return','Separator',14,'---- S E P A R A T O R ----', 'center', 'normal',8, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Repair Item Return','Details',15,'Item 1   6.00       2       12.00', 'center', 'normal',10, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Repair Item Return','Separator',16,'---- S E P A R A T O R ----', 'center', 'normal',8, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Repair Item Return','Subtotal Amount',17,'Sub Total: £10.25', 'right', 'normal',11, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Repair Item Return','Discount Amount',18,'Discount: £0.00', 'right', 'normal',10, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Repair Item Return','Tax Amount',19,'Tax: £0.00', 'right', 'normal',10, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Repair Item Return','Total Amount',20,'Total Amount', 'right', 'bold',13, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Repair Item Return','Security Deposit Amount',21,'Advance: £0.00', 'right', 'normal',10, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Repair Item Return','Due Amount',22,'Due: £0.00', 'right', 'normal',10, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Repair Item Return','Tender Amount',23,'Tender Amount', 'left', 'normal',10, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Repair Item Return','Change Due Amount',24,'Change Due Amount', 'right', 'normal',11, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Repair Item Return','Repair Problem',25,'Problem : Battery Not working', 'left', 'normal',9, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Repair Item Return','Repair Notes',26,'Repair Notes : Battery replaced', 'left', 'normal',9, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Repair Item Return','Separator',27,'---- S E P A R A T O R ----', 'center', 'normal',8, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Repair Item Return','Repair Signature Line',28,'S I G N A T U R E', 'right', 'normal',8, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Repair Item Return','Receipt Date',29,'Receipt Date', 'left', 'normal',10, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Repair Item Return','User Name',30,'User Name', 'left', 'normal',8, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Repair Item Return','Till Name',31,'Till Name', 'left', 'normal',8, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Repair Item Return','Receipt Footer/Repair Disclaimer',32,'Receipt Footer', 'left', 'italic',9, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Repair Item Return','Barcode',33,'Barcode', 'center', 'normal',12, 180, 40  );

Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Closeout','Business Name',1,'Business Name', 'left', 'normal',12, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Closeout','Business Address',2,'Business Address', 'left', 'normal',10, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Closeout','Separator',3,'---- S E P A R A T O R ----', 'center', 'normal',8, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Closeout','Closeout Report Caption',4,'Closeout Report', 'left', 'normal',14, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Closeout','Closeout Type',5,'Closeout Type', 'left', 'normal',12, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Closeout','Separator',6,'---- S E P A R A T O R ----', 'center', 'normal',8, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Closeout','Transaction Summary',7,'Transaction Summary', 'left', 'normal',12, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Closeout','Separator',8,'---- S E P A R A T O R ----', 'center', 'normal',8, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Closeout','Closeout Begin Date/Time',9,'Start Date:', 'left', 'normal',10, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Closeout','Closeout End Date/Time',10,'End Date:', 'left', 'normal',10, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Closeout','Closeout Number',11,'Data', 'left', 'normal',10, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Closeout','Closeout Notes',12,'Data', 'left', 'normal',10, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Closeout','Separator',13,'---- S E P A R A T O R ----', 'center', 'normal',8, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Closeout','Sales Caption',14,'Data', 'left', 'normal',12, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Closeout','No of Invoices (Sales)',15,'Data', 'left', 'normal',10, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Closeout','Product Sales Amount',16,'Data', 'left', 'normal',10, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Closeout','Product Sales Amount(Taxed)',17,'Data', 'left', 'normal',10, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Closeout','Product Sales Amount(Non Taxed)',18,'Data', 'left', 'normal',10, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Closeout','Service Sales Amount',19,'Data', 'left', 'normal',10, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Closeout','Service Sales Amount(Taxed)',20,'Data', 'left', 'normal',10, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Closeout','Service Sales Amount(Non Taxed)',21,'Data', 'left', 'normal',10, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Closeout','Other Sales Amount',22,'Data', 'left', 'normal',10, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Closeout','Other Sales Amount(Taxed)',23,'Data', 'left', 'normal',10, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Closeout','Other Sales Amount(Non Taxed)',24,'Data', 'left', 'normal',10, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Closeout','Tax Details (Sales)',25,'Data', 'left', 'normal',10, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Closeout','Discount Caption (Sales)',26,'Data', 'left', 'normal',10, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Closeout','Discount Details (Sales)',27,'Data', 'left', 'normal',10, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Closeout','Rent Caption',28,'Data', 'left', 'normal',10, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Closeout','No of Invoices (Rent)',29,'Data', 'left', 'normal',10, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Closeout','Net Issued (Rent)',30,'Data', 'left', 'normal',10, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Closeout','Tax Details (Rent)',31,'Data', 'left', 'normal',10, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Closeout','Rent Deposit Amount',32,'Data', 'left', 'normal',10, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Closeout','Rent Deposit Return Amount',33,'Data', 'left', 'normal',10, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Closeout','Discount Caption (Rent)',34,'Data', 'left', 'normal',10, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Closeout','Discount Details (Rent)',35,'Data', 'left', 'normal',10, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Closeout','Fees Amount (Rent)',36,'Data', 'left', 'normal',10, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Closeout','Repair Caption',37,'Data', 'left', 'normal',10, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Closeout','No of Invoices (Repair)',38,'Data', 'left', 'normal',10, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Closeout','Sales Amount (Repair)',39,'Data', 'left', 'normal',10, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Closeout','Tax Details (Repair)',40,'Data', 'left', 'normal',10, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Closeout','Repair Deposit Amount',41,'Data', 'left', 'normal',10, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Closeout','Discount Caption (Repair)',42,'Data', 'left', 'normal',10, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Closeout','Discount Details (Repair)',43,'Data', 'left', 'normal',10, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Closeout','Fees Amount (Repair)',44,'Data', 'left', 'normal',10, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Closeout','Separator',45,'---- S E P A R A T O R ----', 'center', 'normal',8, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Closeout','Non Sales Caption',46,'Data', 'left', 'normal',12, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Closeout','Separator',47,'---- S E P A R A T O R ----', 'center', 'normal',8, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Closeout','Layaway Deposit',48,'Data', 'left', 'normal',10, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Closeout','Layaway Refund',49,'Data', 'left', 'normal',10, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Closeout','Layaway Payment',50,'Data', 'left', 'normal',10, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Closeout','Layaway Sales Posted',51,'Data', 'left', 'normal',10, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Closeout','Number of No Sale',52,'Data', 'left', 'normal',10, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Closeout','Paid Out',53,'Data', 'left', 'normal',10, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Closeout','Lotto Payout',54,'Data', 'left', 'normal',10, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Closeout','Gift Certificate Sold',55,'Data', 'left', 'normal',10, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Closeout','House Account Payment',56,'Data', 'left', 'normal',10, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Closeout','Bottle Refund',57,'Data', 'left', 'normal',10, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Closeout','Store Credit Caption',58,'Data', 'left', 'normal',12, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Closeout','Store Credit Issued',59,'Data', 'left', 'normal',10, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Closeout','Store Credit Redeemed',60,'Data', 'left', 'normal',10, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Closeout','House Account Caption',61,'Data', 'left', 'normal',10, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Closeout','House Account Charged',62,'Data', 'left', 'normal',10, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Closeout','House Account Payment',63,'Data', 'left', 'normal',10, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Closeout','Tips Details',64,'Data', 'left', 'normal',10, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Closeout','Return Items',65,'Data', 'left', 'normal',10, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Closeout','Separator',66,'---- S E P A R A T O R ----', 'center', 'normal',8, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Closeout','Total Amount',67,'Data', 'left', 'normal',10, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Closeout','Separator',68,'---- S E P A R A T O R ----', 'center', 'normal',8, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Closeout','Tender Details',69,'Data', 'left', 'normal',10, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Closeout','Separator',70,'---- S E P A R A T O R ----', 'center', 'normal',8, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Closeout','Tender Count Details',71,'Data', 'left', 'normal',10, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Closeout','Separator',72,'---- S E P A R A T O R ----', 'center', 'normal',8, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Closeout','Tender Over/Short Details',73,'Data', 'left', 'normal',10, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Closeout','Separator',74,'---- S E P A R A T O R ----', 'center', 'normal',8, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Closeout','Sales by Hour Caption',75,'Data', 'left', 'normal',10, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Closeout','Separator',76,'---- S E P A R A T O R ----', 'center', 'normal',8, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Closeout','Closeout Type (Sales by Hour)',77,'Data', 'left', 'normal',10, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Closeout','Closeout Begin Date/Time (Sales by Hour)',78,'Data', 'left', 'normal',10, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Closeout','Closeout End Date/Time (Sales by Hour)',79,'Data', 'left', 'normal',10, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Closeout','Closeout Number (Sales by Hour)',80,'Data', 'left', 'normal',10, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Closeout','Closeout Notes (Sales by Hour)',81,'Data', 'left', 'normal',10, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Closeout','Separator',3,'---- S E P A R A T O R ----', 'center', 'normal',82, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Closeout','Sales by Hour Details',83,'Data', 'left', 'normal',10, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Closeout','Sales by Hour Total Amount',84,'Data', 'left', 'normal',10, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Closeout','Separator',85,'---- S E P A R A T O R ----', 'center', 'normal',8, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Closeout','Sales by Department Caption',86,'Data', 'left', 'normal',10, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Closeout','Separator',87,'---- S E P A R A T O R ----', 'center', 'normal',8, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Closeout','Closeout Type (Sales by Department)',88,'Data', 'left', 'normal',10, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Closeout','Closeout Begin Date/Time (Sales by Department)',89,'Data', 'left', 'normal',10, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Closeout','Closeout End Date/Time (Sales by Department)',90,'Data', 'left', 'normal',10, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Closeout','Closeout Number (Sales by Department)',91,'Data', 'left', 'normal',10, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Closeout','Closeout Notes (Sales by Department)',92,'Data', 'left', 'normal',10, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Closeout','Separator',93,'---- S E P A R A T O R ----', 'center', 'normal',8, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Closeout','Sales by Department Details',94,'Data', 'left', 'normal',10, 0, 0  );
Insert into ReceiptTemplateDummyData(TemplateType,GroupName,SL,GroupData,TextAlign,TextStyle,FontSize,CtrlWidth,CtrlHeight)
values('Closeout','Sales by Department Total Amount',95,'Data', 'left', 'normal',10, 0, 0  );

END
GO