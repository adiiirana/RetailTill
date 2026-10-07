UPDATE [dbo].[Setup]
SET ShowPlusButton = 1
WHERE ISNULL(ShowPlusButton,1) in(0, 1); 
