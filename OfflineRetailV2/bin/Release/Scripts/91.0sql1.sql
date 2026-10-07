IF NOT EXISTS (
    SELECT 1
    FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS
    WHERE TABLE_NAME = 'TempDiscountID'
      AND CONSTRAINT_TYPE = 'PRIMARY KEY'
)
BEGIN
    -- Make ID column NOT NULL before adding primary key
    
    -- Add primary key
    ALTER TABLE TempDiscountID
    ADD CONSTRAINT PK_TempDiscountID PRIMARY KEY (ID);
END