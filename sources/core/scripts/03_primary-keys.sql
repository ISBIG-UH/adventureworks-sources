USE adventure_works;

-- ******************************************************
-- Person - Primary Keys
-- ******************************************************

ALTER TABLE Address
    ADD PRIMARY KEY (AddressId);

ALTER TABLE AddressType
    ADD PRIMARY KEY (AddressTypeId);
    
ALTER TABLE BusinessEntity
    ADD PRIMARY KEY (BusinessEntityId);

ALTER TABLE BusinessEntityAddress
    ADD PRIMARY KEY (BusinessEntityId, AddressId, AddressTypeId);

ALTER TABLE BusinessEntityContact
    ADD PRIMARY KEY (BusinessEntityId, PersonId, ContactTypeId);

ALTER TABLE ContactType
    ADD PRIMARY KEY (ContactTypeId);

ALTER TABLE CountryRegion
    ADD PRIMARY KEY (CountryRegionCode);

ALTER TABLE Password
    ADD PRIMARY KEY (BusinessEntityId);

ALTER TABLE Person
    ADD PRIMARY KEY (BusinessEntityId);

ALTER TABLE PersonCreditCard
    ADD PRIMARY KEY (BusinessEntityId, CreditCardId);

ALTER TABLE PersonPhone
    ADD PRIMARY KEY (BusinessEntityId, PhoneNumber, PhoneNumberTypeId);

ALTER TABLE PhoneNumberType
    ADD PRIMARY KEY (PhoneNumberTypeId);

ALTER TABLE StateProvince
    ADD PRIMARY KEY (StateProvinceId);


-- ******************************************************
-- Production - Primary Keys
-- ******************************************************

ALTER TABLE BillOfMaterials
    ADD PRIMARY KEY (BillOfMaterialsId);

ALTER TABLE Culture
    ADD PRIMARY KEY (CultureId);

ALTER TABLE Illustration
    ADD PRIMARY KEY (IllustrationId);

ALTER TABLE Location
    ADD PRIMARY KEY (LocationId);

ALTER TABLE Product
    ADD PRIMARY KEY (ProductId);

ALTER TABLE ProductCategory
    ADD PRIMARY KEY (ProductCategoryId);

ALTER TABLE ProductCostHistory
    ADD PRIMARY KEY (ProductId, StartDate);

ALTER TABLE ProductDescription
    ADD PRIMARY KEY (ProductDescriptionId);

ALTER TABLE ProductInventory
    ADD PRIMARY KEY (ProductId, LocationId);

ALTER TABLE ProductListPriceHistory
    ADD PRIMARY KEY (ProductId, StartDate);

ALTER TABLE ProductModel
    ADD PRIMARY KEY (ProductModelId);

ALTER TABLE ProductModelIllustration
    ADD PRIMARY KEY (ProductModelId, IllustrationId);

ALTER TABLE ProductModelProductDescriptionCulture
    ADD PRIMARY KEY (ProductModelId, ProductDescriptionId, CultureId);

ALTER TABLE ProductPhoto
    ADD PRIMARY KEY (ProductPhotoId);

ALTER TABLE ProductProductPhoto
    ADD PRIMARY KEY (ProductId, ProductPhotoId);


ALTER TABLE ProductSubcategory
    ADD PRIMARY KEY (ProductSubcategoryId);

ALTER TABLE ScrapReason
    ADD PRIMARY KEY (ScrapReasonId);

ALTER TABLE TransactionHistory
    ADD PRIMARY KEY (TransactionId);

ALTER TABLE TransactionHistoryArchive
    ADD PRIMARY KEY (TransactionId);

ALTER TABLE UnitMeasure
    ADD PRIMARY KEY (UnitMeasureCode);

ALTER TABLE WorkOrder
    ADD PRIMARY KEY (WorkOrderId);

ALTER TABLE WorkOrderRouting
    ADD PRIMARY KEY (WorkOrderId, ProductId, OperationSequence);


-- ******************************************************
-- Sales - Primary Keys
-- ******************************************************

ALTER TABLE CountryRegionCurrency
    ADD PRIMARY KEY (CountryRegionCode, CurrencyCode);

ALTER TABLE CreditCard
    ADD PRIMARY KEY (CreditCardId);

ALTER TABLE Currency
    ADD PRIMARY KEY (CurrencyCode);

ALTER TABLE CurrencyRate
    ADD PRIMARY KEY (CurrencyRateId);

ALTER TABLE Customer
    ADD PRIMARY KEY (CustomerId);

ALTER TABLE SalesOrderDetail
    ADD PRIMARY KEY (SalesOrderId, SalesOrderDetailId);

ALTER TABLE SalesOrderHeader
    ADD PRIMARY KEY (SalesOrderId);

ALTER TABLE SalesOrderHeaderSalesReason
    ADD PRIMARY KEY (SalesOrderId, SalesReasonId);

ALTER TABLE SalesPerson
    ADD PRIMARY KEY (BusinessEntityId);

ALTER TABLE SalesPersonQuotaHistory
    ADD PRIMARY KEY (BusinessEntityId, QuotaDate);

ALTER TABLE SalesReason
    ADD PRIMARY KEY (SalesReasonId);

ALTER TABLE SalesTaxRate
    ADD PRIMARY KEY (SalesTaxRateId);

ALTER TABLE SalesTerritory
    ADD PRIMARY KEY (TerritoryId);

ALTER TABLE SalesTerritoryHistory
    ADD PRIMARY KEY (BusinessEntityId, StartDate, TerritoryId);

ALTER TABLE ShoppingCartItem
    ADD PRIMARY KEY (ShoppingCartItemId);

ALTER TABLE SpecialOffer
    ADD PRIMARY KEY (SpecialOfferId);

ALTER TABLE SpecialOfferProduct
    ADD PRIMARY KEY (SpecialOfferId, ProductId);

ALTER TABLE Store
    ADD PRIMARY KEY (BusinessEntityId);


-- ******************************************************
-- Purchasing - Primary Keys
-- ******************************************************

ALTER TABLE ProductVendor
    ADD PRIMARY KEY (ProductId, BusinessEntityId);

ALTER TABLE PurchaseOrderDetail
    ADD PRIMARY KEY (PurchaseOrderId, PurchaseOrderDetailId);

ALTER TABLE PurchaseOrderHeader
    ADD PRIMARY KEY (PurchaseOrderId);

ALTER TABLE ShipMethod
    ADD PRIMARY KEY (ShipMethodId);

ALTER TABLE Vendor
    ADD PRIMARY KEY (BusinessEntityId);


-- ******************************************************
-- HumanResources - Primary Keys
-- ******************************************************


ALTER TABLE Employee
    ADD PRIMARY KEY (BusinessEntityId);


ALTER TABLE JobCandidate
    ADD PRIMARY KEY (JobCandidateId);




-- ******************************************************
-- Add auto increment fields
-- ******************************************************


ALTER TABLE SalesTerritory
MODIFY COLUMN TerritoryId INT NOT NULL AUTO_INCREMENT;

ALTER TABLE StateProvince
MODIFY COLUMN StateProvinceId INT NOT NULL AUTO_INCREMENT;

ALTER TABLE Address
MODIFY COLUMN AddressId INT NOT NULL AUTO_INCREMENT;

ALTER TABLE AddressType
MODIFY COLUMN AddressTypeId INT NOT NULL AUTO_INCREMENT;

ALTER TABLE BusinessEntity
MODIFY COLUMN BusinessEntityId INT NOT NULL AUTO_INCREMENT;

ALTER TABLE ContactType
MODIFY COLUMN ContactTypeId INT NOT NULL AUTO_INCREMENT;

ALTER TABLE CreditCard
MODIFY COLUMN CreditCardId INT NOT NULL AUTO_INCREMENT;

ALTER TABLE CurrencyRate
MODIFY COLUMN CurrencyRateId INT NOT NULL AUTO_INCREMENT;



ALTER TABLE Location
MODIFY COLUMN LocationId SMALLINT NOT NULL AUTO_INCREMENT;

ALTER TABLE PhoneNumberType
MODIFY COLUMN PhoneNumberTypeId INT NOT NULL AUTO_INCREMENT;

ALTER TABLE ProductModel
MODIFY COLUMN ProductModelId INT NOT NULL AUTO_INCREMENT;

ALTER TABLE ProductCategory
MODIFY COLUMN ProductCategoryId INT NOT NULL AUTO_INCREMENT;

ALTER TABLE ProductSubcategory
MODIFY COLUMN ProductSubcategoryId INT NOT NULL AUTO_INCREMENT;

ALTER TABLE Product
MODIFY COLUMN ProductId INT NOT NULL AUTO_INCREMENT;

ALTER TABLE ProductDescription
MODIFY COLUMN ProductDescriptionId INT NOT NULL AUTO_INCREMENT;

ALTER TABLE Illustration
MODIFY COLUMN IllustrationId INT NOT NULL AUTO_INCREMENT;

ALTER TABLE ProductPhoto
MODIFY COLUMN ProductPhotoId INT NOT NULL AUTO_INCREMENT;


ALTER TABLE ShipMethod
MODIFY COLUMN ShipMethodId INT NOT NULL AUTO_INCREMENT;

ALTER TABLE PurchaseOrderHeader
MODIFY COLUMN PurchaseOrderId INT NOT NULL AUTO_INCREMENT;


ALTER TABLE Customer
MODIFY COLUMN CustomerId INT NOT NULL AUTO_INCREMENT;

ALTER TABLE SalesReason
MODIFY COLUMN SalesReasonId INT NOT NULL AUTO_INCREMENT;

ALTER TABLE SalesTaxRate
MODIFY COLUMN SalesTaxRateId INT NOT NULL AUTO_INCREMENT;

ALTER TABLE ScrapReason
MODIFY COLUMN ScrapReasonId SMALLINT NOT NULL AUTO_INCREMENT;

ALTER TABLE SpecialOffer
MODIFY COLUMN SpecialOfferId INT NOT NULL AUTO_INCREMENT;

ALTER TABLE WorkOrder
MODIFY COLUMN WorkOrderId INT NOT NULL AUTO_INCREMENT;

ALTER TABLE SalesOrderHeader
MODIFY COLUMN SalesOrderId INT NOT NULL AUTO_INCREMENT;

ALTER TABLE JobCandidate
MODIFY COLUMN JobCandidateId INT NOT NULL AUTO_INCREMENT;

ALTER TABLE BillOfMaterials
MODIFY COLUMN BillOfMaterialsId INT NOT NULL AUTO_INCREMENT;

ALTER TABLE ShoppingCartItem
MODIFY COLUMN ShoppingCartItemId INT NOT NULL AUTO_INCREMENT;

ALTER TABLE TransactionHistory
MODIFY COLUMN TransactionId INT NOT NULL AUTO_INCREMENT;
