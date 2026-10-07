
IF NOT EXISTS (SELECT * FROM syscolumns
  WHERE ID=OBJECT_ID('[dbo].[setup]') AND NAME='AppointmentEmailBody')
  ALTER TABLE [dbo].[setup] add [AppointmentEmailBody] [varchar](500) NULL;
GO