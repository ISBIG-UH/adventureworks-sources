USE adventure_works;

-- ****************************************
-- Create Foreign key constraints
-- ****************************************

-- Person
ALTER TABLE Address
    ADD CONSTRAINT FK_Address_StateProvince_StateProvinceId FOREIGN KEY (StateProvinceId)
    REFERENCES StateProvince(StateProvinceId);

ALTER TABLE BusinessEntityAddress 
    ADD CONSTRAINT FK_BusinessEntityAddress_Address_AddressId FOREIGN KEY (AddressId)
        REFERENCES Address(AddressId),
    ADD CONSTRAINT FK_BusinessEntityAddress_AddressType_AddressTypeId FOREIGN KEY (AddressTypeId)
        REFERENCES AddressType(AddressTypeId),
    ADD CONSTRAINT FK_BusinessEntityAddress_BusinessEntity_BusinessEntityId FOREIGN KEY (BusinessEntityId)
        REFERENCES BusinessEntity(BusinessEntityId);

ALTER TABLE BusinessEntityContact 
    ADD CONSTRAINT FK_BusinessEntityContact_Person_PersonId FOREIGN KEY (PersonId)
        REFERENCES Person(BusinessEntityId),
    ADD CONSTRAINT FK_BusinessEntityContact_ContactType_ContactTypeId FOREIGN KEY (ContactTypeId)
        REFERENCES ContactType(ContactTypeId),
    ADD CONSTRAINT FK_BusinessEntityContact_BusinessEntity_BusinessEntityId FOREIGN KEY (BusinessEntityId)
        REFERENCES BusinessEntity(BusinessEntityId);

ALTER TABLE EmailAddress 
    ADD CONSTRAINT FK_EmailAddress_Person_BusinessEntityId FOREIGN KEY (BusinessEntityId)
        REFERENCES Person(BusinessEntityId);

ALTER TABLE Password 
    ADD CONSTRAINT FK_Password_Person_BusinessEntityId FOREIGN KEY (BusinessEntityId)
        REFERENCES Person(BusinessEntityId);

ALTER TABLE Person 
    ADD CONSTRAINT FK_Person_BusinessEntity_BusinessEntityId FOREIGN KEY (BusinessEntityId)
        REFERENCES BusinessEntity(BusinessEntityId);

ALTER TABLE PersonCreditCard 
    ADD CONSTRAINT FK_PersonCreditCard_Person_BusinessEntityId FOREIGN KEY (BusinessEntityId)
        REFERENCES Person(BusinessEntityId),
    ADD CONSTRAINT FK_PersonCreditCard_CreditCard_CreditCardId FOREIGN KEY (CreditCardId)
        REFERENCES CreditCard(CreditCardId);

ALTER TABLE PersonPhone 
    ADD CONSTRAINT FK_PersonPhone_Person_BusinessEntityId FOREIGN KEY (BusinessEntityId)
        REFERENCES Person(BusinessEntityId),
    ADD CONSTRAINT FK_PersonPhone_PhoneNumberType_PhoneNumberTypeId FOREIGN KEY (PhoneNumberTypeId)
        REFERENCES PhoneNumberType(PhoneNumberTypeId);

ALTER TABLE StateProvince 
    ADD CONSTRAINT FK_StateProvince_CountryRegion_CountryRegionCode FOREIGN KEY (CountryRegionCode)
        REFERENCES CountryRegion(CountryRegionCode),
    ADD CONSTRAINT FK_StateProvince_SalesTerritory_TerritoryId FOREIGN KEY (TerritoryId)
        REFERENCES SalesTerritory(TerritoryId);

-- Production
ALTER TABLE BillOfMaterials 
    ADD CONSTRAINT FK_BillOfMaterials_Product_ProductAssemblyId FOREIGN KEY (ProductAssemblyId)
        REFERENCES Product(ProductId),
    ADD CONSTRAINT FK_BillOfMaterials_Product_ComponentId FOREIGN KEY (ComponentId)
        REFERENCES Product(ProductId),
    ADD CONSTRAINT FK_BillOfMaterials_UnitMeasure_UnitMeasureCode FOREIGN KEY (UnitMeasureCode)
        REFERENCES UnitMeasure(UnitMeasureCode);


ALTER TABLE Product 
    ADD CONSTRAINT FK_Product_UnitMeasure_SizeUnitMeasureCode FOREIGN KEY (SizeUnitMeasureCode)
        REFERENCES UnitMeasure(UnitMeasureCode),
    ADD CONSTRAINT FK_Product_UnitMeasure_WeightUnitMeasureCode FOREIGN KEY (WeightUnitMeasureCode)
        REFERENCES UnitMeasure(UnitMeasureCode),
    ADD CONSTRAINT FK_Product_ProductModel_ProductModelId FOREIGN KEY (ProductModelId)
        REFERENCES ProductModel(ProductModelId),
    ADD CONSTRAINT FK_Product_ProductSubcategory_ProductSubcategoryId FOREIGN KEY (ProductSubcategoryId)
        REFERENCES ProductSubcategory(ProductSubcategoryId);

ALTER TABLE ProductCostHistory 
    ADD CONSTRAINT FK_ProductCostHistory_Product_ProductId FOREIGN KEY (ProductId)
        REFERENCES Product(ProductId);


ALTER TABLE ProductInventory 
    ADD CONSTRAINT FK_ProductInventory_Location_LocationId FOREIGN KEY (LocationId)
        REFERENCES Location(LocationId),
    ADD CONSTRAINT FK_ProductInventory_Product_ProductId FOREIGN KEY (ProductId)
        REFERENCES Product(ProductId);

ALTER TABLE ProductListPriceHistory 
    ADD CONSTRAINT FK_ProductListPriceHistory_Product_ProductId FOREIGN KEY (ProductId)
        REFERENCES Product(ProductId);

ALTER TABLE ProductModelIllustration 
    ADD CONSTRAINT FK_ProductModelIllustration_ProductModel_ProductModelId FOREIGN KEY (ProductModelId)
        REFERENCES ProductModel(ProductModelId),
    ADD CONSTRAINT FK_ProductModelIllustration_Illustration_IllustrationId FOREIGN KEY (IllustrationId)
        REFERENCES Illustration(IllustrationId);

ALTER TABLE ProductModelProductDescriptionCulture 
    ADD CONSTRAINT FK_ProductModelProductDescriptionCulture_ProductDescriptionId FOREIGN KEY (ProductDescriptionId)
        REFERENCES ProductDescription(ProductDescriptionId),
    ADD CONSTRAINT FK_ProductModelProductDescriptionCulture_Culture_CultureId FOREIGN KEY (CultureId)
        REFERENCES Culture(CultureId),
    ADD CONSTRAINT FK_ProductModelProductDescriptionCulture_ProductModelId FOREIGN KEY (ProductModelId)
        REFERENCES ProductModel(ProductModelId);

ALTER TABLE ProductProductPhoto 
    ADD CONSTRAINT FK_ProductProductPhoto_Product_ProductId FOREIGN KEY (ProductId)
        REFERENCES Product(ProductId),
    ADD CONSTRAINT FK_ProductProductPhoto_ProductPhoto_ProductPhotoId FOREIGN KEY (ProductPhotoId)
        REFERENCES ProductPhoto(ProductPhotoId);


ALTER TABLE ProductSubcategory 
    ADD CONSTRAINT FK_ProductSubcategory_ProductCategory_ProductCategoryId FOREIGN KEY (ProductCategoryId)
        REFERENCES ProductCategory(ProductCategoryId);

ALTER TABLE TransactionHistory 
    ADD CONSTRAINT FK_TransactionHistory_Product_ProductId FOREIGN KEY (ProductId)
        REFERENCES Product(ProductId);

ALTER TABLE WorkOrder 
    ADD CONSTRAINT FK_WorkOrder_Product_ProductId FOREIGN KEY (ProductId)
        REFERENCES Product(ProductId),
    ADD CONSTRAINT FK_WorkOrder_ScrapReason_ScrapReasonId FOREIGN KEY (ScrapReasonId)
        REFERENCES ScrapReason(ScrapReasonId);

ALTER TABLE WorkOrderRouting 
    ADD CONSTRAINT FK_WorkOrderRouting_Location_LocationId FOREIGN KEY (LocationId)
        REFERENCES Location(LocationId),
    ADD CONSTRAINT FK_WorkOrderRouting_WorkOrder_WorkOrderId FOREIGN KEY (WorkOrderId)
        REFERENCES WorkOrder(WorkOrderId);

-- Purchasing
ALTER TABLE ProductVendor 
    ADD CONSTRAINT FK_ProductVendor_Product_ProductId FOREIGN KEY (ProductId)
        REFERENCES Product(ProductId),
    ADD CONSTRAINT FK_ProductVendor_UnitMeasure_UnitMeasureCode FOREIGN KEY (UnitMeasureCode)
        REFERENCES UnitMeasure(UnitMeasureCode),
    ADD CONSTRAINT FK_ProductVendor_Vendor_BusinessEntityId FOREIGN KEY (BusinessEntityId)
        REFERENCES Vendor(BusinessEntityId);

ALTER TABLE PurchaseOrderDetail 
    ADD CONSTRAINT FK_PurchaseOrderDetail_Product_ProductId FOREIGN KEY (ProductId)
        REFERENCES Product(ProductId),
    ADD CONSTRAINT FK_PurchaseOrderDetail_PurchaseOrderHeader_PurchaseOrderId FOREIGN KEY (PurchaseOrderId)
        REFERENCES PurchaseOrderHeader(PurchaseOrderId);

ALTER TABLE PurchaseOrderHeader 
    ADD CONSTRAINT FK_PurchaseOrderHeader_Employee_EmployeeId FOREIGN KEY (EmployeeId)
        REFERENCES Employee(BusinessEntityId),
    ADD CONSTRAINT FK_PurchaseOrderHeader_Vendor_VendorId FOREIGN KEY (VendorId)
        REFERENCES Vendor(BusinessEntityId),
    ADD CONSTRAINT FK_PurchaseOrderHeader_ShipMethod_ShipMethodId FOREIGN KEY (ShipMethodId)
        REFERENCES ShipMethod(ShipMethodId);

ALTER TABLE Vendor 
    ADD CONSTRAINT FK_Vendor_BusinessEntity_BusinessEntityId FOREIGN KEY (BusinessEntityId)
        REFERENCES BusinessEntity(BusinessEntityId);

-- HumanResources
ALTER TABLE Employee 
    ADD CONSTRAINT FK_Employee_Person_BusinessEntityId FOREIGN KEY (BusinessEntityId)
        REFERENCES Person(BusinessEntityId);


ALTER TABLE JobCandidate 
    ADD CONSTRAINT FK_JobCandidate_Employee_BusinessEntityId FOREIGN KEY (BusinessEntityId)
        REFERENCES Employee(BusinessEntityId);

-- Sales
ALTER TABLE CountryRegionCurrency 
    ADD CONSTRAINT FK_CountryRegionCurrency_CountryRegion_CountryRegionCode FOREIGN KEY (CountryRegionCode)
        REFERENCES CountryRegion(CountryRegionCode),
    ADD CONSTRAINT FK_CountryRegionCurrency_Currency_CurrencyCode FOREIGN KEY (CurrencyCode)
        REFERENCES Currency(CurrencyCode);

ALTER TABLE CurrencyRate 
    ADD CONSTRAINT FK_CurrencyRate_Currency_FromCurrencyCode FOREIGN KEY (FromCurrencyCode)
        REFERENCES Currency(CurrencyCode),
    ADD CONSTRAINT FK_CurrencyRate_Currency_ToCurrencyCode FOREIGN KEY (ToCurrencyCode)
        REFERENCES Currency(CurrencyCode);

ALTER TABLE Customer 
    ADD CONSTRAINT FK_Customer_Person_PersonId FOREIGN KEY (PersonId)
        REFERENCES Person(BusinessEntityId),
    ADD CONSTRAINT FK_Customer_Store_StoreId FOREIGN KEY (StoreId)
        REFERENCES Store(BusinessEntityId),
    ADD CONSTRAINT FK_Customer_SalesTerritory_TerritoryId FOREIGN KEY (TerritoryId)
        REFERENCES SalesTerritory(TerritoryId);


ALTER TABLE SalesOrderDetail 
    ADD CONSTRAINT FK_SalesOrderDetail_SalesOrderHeader_SalesOrderId FOREIGN KEY (SalesOrderId)
        REFERENCES SalesOrderHeader(SalesOrderId) ON DELETE CASCADE,
    ADD CONSTRAINT FK_SalesOrderDetail_SpecialOfferProduct_SpecialOfferIdProductId FOREIGN KEY (SpecialOfferId, ProductId)
        REFERENCES SpecialOfferProduct(SpecialOfferId, ProductId);

ALTER TABLE SalesOrderHeader 
    ADD CONSTRAINT FK_SalesOrderHeader_Address_BillToAddressId FOREIGN KEY (BillToAddressId)
        REFERENCES Address(AddressId),
    ADD CONSTRAINT FK_SalesOrderHeader_Address_ShipToAddressId FOREIGN KEY (ShipToAddressId)
        REFERENCES Address(AddressId),
    ADD CONSTRAINT FK_SalesOrderHeader_CreditCard_CreditCardId FOREIGN KEY (CreditCardId)
        REFERENCES CreditCard(CreditCardId),
    ADD CONSTRAINT FK_SalesOrderHeader_CurrencyRate_CurrencyRateId FOREIGN KEY (CurrencyRateId)
        REFERENCES CurrencyRate(CurrencyRateId),
    ADD CONSTRAINT FK_SalesOrderHeader_Customer_CustomerId FOREIGN KEY (CustomerId)
        REFERENCES Customer(CustomerId),
    ADD CONSTRAINT FK_SalesOrderHeader_SalesPerson_SalesPersonId FOREIGN KEY (SalesPersonId)
        REFERENCES SalesPerson(BusinessEntityId),
    ADD CONSTRAINT FK_SalesOrderHeader_ShipMethod_ShipMethodId FOREIGN KEY (ShipMethodId)
        REFERENCES ShipMethod(ShipMethodId),
    ADD CONSTRAINT FK_SalesOrderHeader_SalesTerritory_TerritoryId FOREIGN KEY (TerritoryId)
        REFERENCES SalesTerritory(TerritoryId);

ALTER TABLE SalesOrderHeaderSalesReason 
    ADD CONSTRAINT FK_SalesOrderHeaderSalesReason_SalesReason_SalesReasonId FOREIGN KEY (SalesReasonId)
        REFERENCES SalesReason(SalesReasonId),
    ADD CONSTRAINT FK_SalesOrderHeaderSalesReason_SalesOrderHeader_SalesOrderId FOREIGN KEY (SalesOrderId)
        REFERENCES SalesOrderHeader(SalesOrderId) ON DELETE CASCADE;

ALTER TABLE SalesPerson 
    ADD CONSTRAINT FK_SalesPerson_Employee_BusinessEntityId FOREIGN KEY (BusinessEntityId)
        REFERENCES Employee(BusinessEntityId),
    ADD CONSTRAINT FK_SalesPerson_SalesTerritory_TerritoryId FOREIGN KEY (TerritoryId)
        REFERENCES SalesTerritory(TerritoryId);

ALTER TABLE SalesPersonQuotaHistory 
    ADD CONSTRAINT FK_SalesPersonQuotaHistory_SalesPerson_BusinessEntityId FOREIGN KEY (BusinessEntityId)
        REFERENCES SalesPerson(BusinessEntityId);

ALTER TABLE SalesTaxRate 
    ADD CONSTRAINT FK_SalesTaxRate_StateProvince_StateProvinceId FOREIGN KEY (StateProvinceId)
        REFERENCES StateProvince(StateProvinceId);

ALTER TABLE SalesTerritory 
    ADD CONSTRAINT FK_SalesTerritory_CountryRegion_CountryRegionCode FOREIGN KEY (CountryRegionCode)
        REFERENCES CountryRegion(CountryRegionCode);

ALTER TABLE SalesTerritoryHistory 
    ADD CONSTRAINT FK_SalesTerritoryHistory_SalesPerson_BusinessEntityId FOREIGN KEY (BusinessEntityId)
        REFERENCES SalesPerson(BusinessEntityId),
    ADD CONSTRAINT FK_SalesTerritoryHistory_SalesTerritory_TerritoryId FOREIGN KEY (TerritoryId)
        REFERENCES SalesTerritory(TerritoryId);

ALTER TABLE ShoppingCartItem 
    ADD CONSTRAINT FK_ShoppingCartItem_Product_ProductId FOREIGN KEY (ProductId)
        REFERENCES Product(ProductId);

ALTER TABLE SpecialOfferProduct 
    ADD CONSTRAINT FK_SpecialOfferProduct_Product_ProductId FOREIGN KEY (ProductId)
        REFERENCES Product(ProductId),
    ADD CONSTRAINT FK_SpecialOfferProduct_SpecialOffer_SpecialOfferId FOREIGN KEY (SpecialOfferId)
        REFERENCES SpecialOffer(SpecialOfferId);

ALTER TABLE Store 
    ADD CONSTRAINT FK_Store_BusinessEntity_BusinessEntityId FOREIGN KEY (BusinessEntityId)
        REFERENCES BusinessEntity(BusinessEntityId),
    ADD CONSTRAINT FK_Store_SalesPerson_SalesPersonId FOREIGN KEY (SalesPersonId)
        REFERENCES SalesPerson(BusinessEntityId);
