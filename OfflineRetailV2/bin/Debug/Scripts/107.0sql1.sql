ALTER TABLE StoreInfo ADD isPost bit NOT NULL CONSTRAINT DF_StoreInfo_isPost DEFAULT 0;
ALTER TABLE StoreInfo ADD PostDate datetime NULL;
ALTER TABLE StoreInfo ADD isUpdated bit NOT NULL CONSTRAINT DF_StoreInfo_isUpdated DEFAULT 0;
ALTER TABLE StoreInfo ADD UpdatedDate datetime NULL;
ALTER TABLE StoreInfo ADD LastSyncDate datetime NULL;