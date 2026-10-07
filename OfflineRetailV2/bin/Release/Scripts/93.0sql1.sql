IF NOT EXISTS (
    SELECT 1
    FROM sys.columns
    WHERE object_id = OBJECT_ID(N'StoreInfo')
      AND name = 'businessinfo'
)
BEGIN
    ALTER TABLE StoreInfo
    ADD businessinfo VARCHAR(50) NULL;
END

