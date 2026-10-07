
update ReceiptTemplateMaster set TemplateType = 'Label - 1 Up' where TemplateType = '1 Up Label';
GO
update ReceiptTemplateDefaultData set TemplateType = 'Label - 1 Up' where TemplateType = '1 Up Label';
GO
alter table ReceiptTemplateMaster alter column TemplateName nvarchar(50);
GO
alter table ReceiptTemplateMaster alter column TemplateType varchar(50);
GO
alter table ReceiptTemplateDefaultData alter column TemplateType varchar(50);
GO
