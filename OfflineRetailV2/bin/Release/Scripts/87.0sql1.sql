SET QUOTED_IDENTIFIER ON;
SET ANSI_NULLS ON;
GO

IF OBJECT_ID('dbo.GroupPermission', 'U') IS NULL
   OR OBJECT_ID('dbo.SecurityGroup', 'U') IS NULL
   OR OBJECT_ID('dbo.SecurityPermission', 'U') IS NULL
BEGIN
    RETURN;
END
GO

IF NOT EXISTS (SELECT 1 FROM dbo.SecurityPermission WHERE SecurityCode = '20y')
BEGIN
    RETURN;
END
GO

DECLARE @OwnerID INT;
DECLARE @gpcount INT;

SELECT @OwnerID = ID
FROM dbo.SecurityGroup
WHERE GroupName = 'Owner';

IF @OwnerID IS NOT NULL
BEGIN
    SELECT @gpcount = COUNT(*)
    FROM dbo.GroupPermission
    WHERE GroupID = @OwnerID
      AND SecurityCode = '20y';

    IF @gpcount = 0
    BEGIN
        INSERT INTO dbo.GroupPermission (GroupID, SecurityCode, PermissionFlag, CreatedBy, CreatedOn, LastChangedBy, LastChangedOn)
        VALUES (@OwnerID, '20y', 'Y', 0, GETDATE(), 0, GETDATE());
    END
END
GO
