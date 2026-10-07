alter table Customer alter column [State] nvarchar(30) null;
GO
alter table Customer alter column [ShipState] nvarchar(30) null;
GO
alter table ZipCode alter column [State] varchar(30) null;
GO
