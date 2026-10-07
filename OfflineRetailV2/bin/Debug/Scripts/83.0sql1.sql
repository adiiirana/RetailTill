IF EXISTS (SELECT * FROM sys.objects 
           WHERE name = 'UQ_SingleUsePass' 
           AND type = 'UQ' 
           AND parent_object_id = OBJECT_ID('ScannedBoardingPasses'))
BEGIN
    ALTER TABLE ScannedBoardingPasses
    DROP CONSTRAINT UQ_SingleUsePass;
    
    PRINT 'Constraint UQ_SingleUsePass successfully dropped.';
END
ELSE
BEGIN
    PRINT 'Constraint UQ_SingleUsePass does not exist or was already dropped.';
END