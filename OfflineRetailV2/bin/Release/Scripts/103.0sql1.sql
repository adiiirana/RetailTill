-- Employee.EmployeeType - distinguish cloud vs till employees

IF NOT EXISTS (
	SELECT *
	FROM syscolumns
	WHERE ID = OBJECT_ID('[dbo].[Employee]')
	  AND NAME = 'EmployeeType'
)
BEGIN
	ALTER TABLE [dbo].[Employee]
	ADD [EmployeeType] NVARCHAR(10) NULL CONSTRAINT DF_Employee_EmployeeType DEFAULT ('till')
END
GO

UPDATE [dbo].[Employee]
SET [EmployeeType] = 'till'
WHERE [EmployeeType] IS NULL OR LTRIM(RTRIM([EmployeeType])) = ''
GO
