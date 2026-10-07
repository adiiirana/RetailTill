-- Correct Cloud Sync (20y) default grants:
-- Keep enabled only for Admin / Administrator profiles.
-- Revoke from all other profiles (enable via Security Permissions if needed).

IF NOT EXISTS (
    SELECT 1
    FROM [dbo].[SecurityPermission]
    WHERE [SecurityCode] = '20y'
)
BEGIN
    INSERT INTO [dbo].[SecurityPermission]
        ([SlNo], [GroupSlNo], [SecurityGroup], [SecurityCode], [SecurityDesc], [CreatedOn])
    VALUES
        (208, 20, 'Setup', '20y', 'XEPOS Cloud Sync', GETDATE());
END
GO

INSERT INTO [dbo].[GroupPermission]
    ([GroupID], [SecurityCode], [PermissionFlag], [CreatedBy], [CreatedOn], [LastChangedBy], [LastChangedOn])
SELECT
    sg.[ID],
    '20y',
    'Y',
    0,
    GETDATE(),
    0,
    GETDATE()
FROM [dbo].[SecurityGroup] sg
WHERE LOWER(LTRIM(RTRIM(sg.[GroupName]))) IN ('admin', 'administrator')
  AND NOT EXISTS (
        SELECT 1
        FROM [dbo].[GroupPermission] gp2
        WHERE gp2.[GroupID] = sg.[ID]
          AND gp2.[SecurityCode] = '20y'
    )
GO

UPDATE gp
SET gp.[PermissionFlag] = 'Y',
    gp.[LastChangedOn] = GETDATE()
FROM [dbo].[GroupPermission] gp
INNER JOIN [dbo].[SecurityGroup] sg ON sg.[ID] = gp.[GroupID]
WHERE gp.[SecurityCode] = '20y'
  AND LOWER(LTRIM(RTRIM(sg.[GroupName]))) IN ('admin', 'administrator')
GO

UPDATE gp
SET gp.[PermissionFlag] = 'N',
    gp.[LastChangedOn] = GETDATE()
FROM [dbo].[GroupPermission] gp
INNER JOIN [dbo].[SecurityGroup] sg ON sg.[ID] = gp.[GroupID]
WHERE gp.[SecurityCode] = '20y'
  AND LOWER(LTRIM(RTRIM(sg.[GroupName]))) NOT IN ('admin', 'administrator')
GO
