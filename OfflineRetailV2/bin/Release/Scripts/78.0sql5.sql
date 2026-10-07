USE [Retail2020DB]

IF NOT EXISTS (
    SELECT 
        CONSTRAINT_NAME
    FROM 
        INFORMATION_SCHEMA.TABLE_CONSTRAINTS
    WHERE 
        TABLE_NAME = 'StockJournal' 
        AND CONSTRAINT_TYPE = 'PRIMARY KEY'
)
BEGIN
    -- Add the primary key if it does not exist
    ALTER TABLE StockJournal
    ADD PRIMARY KEY (ID);
END