DROP DATABASE IF EXISTS adventure_works;
CREATE DATABASE adventure_works;
USE adventure_works;


-- ******************************************************
-- Person - Schema
-- ******************************************************


CREATE TABLE Address (
    AddressId INT NOT NULL,
    AddressLine1 VARCHAR(60) NOT NULL,
    AddressLine2 VARCHAR(60),
    City VARCHAR(30),
    StateProvinceId INT NOT NULL,
    PostalCode VARCHAR(15) NOT NULL,
    SpatialLocation VARCHAR(200),
    rowguid CHAR(36) NOT NULL DEFAULT(UUID()),
    ModifiedDate DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);
CREATE TABLE AddressType(
    AddressTypeId INT NOT NULL,
    Name VARCHAR(50) NOT NULL,
    rowguid CHAR(36) NOT NULL DEFAULT (UUID()),
    ModifiedDate DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);
CREATE TABLE BusinessEntity(
    BusinessEntityId INT NOT NULL,
    rowguid CHAR(36) NOT NULL DEFAULT (UUID()),
    ModifiedDate DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);
CREATE TABLE BusinessEntityAddress (
    BusinessEntityId INT NOT NULL,
    AddressId INT NOT NULL,
    AddressTypeId INT NOT NULL,
    rowguid CHAR(36) NOT NULL DEFAULT (UUID()),
    ModifiedDate DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);
CREATE TABLE BusinessEntityContact (
    BusinessEntityId INT NOT NULL,
    PersonId INT NOT NULL,
    ContactTypeId INT NOT NULL,
    rowguid CHAR(36) NOT NULL DEFAULT (UUID()),
    ModifiedDate DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);
CREATE TABLE ContactType(
    ContactTypeId INT NOT NULL,
    Name VARCHAR(50) NOT NULL,
    ModifiedDate DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);
CREATE TABLE CountryRegion(
    CountryRegionCode VARCHAR(3) NOT NULL,
    Name VARCHAR(50) NOT NULL,
    ModifiedDate DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);
CREATE TABLE EmailAddress(
    BusinessEntityId INT NOT NULL,
    EmailAddressId INT NOT NULL,
    EmailAddress VARCHAR(50),
    rowguid CHAR(36) NOT NULL DEFAULT(UUID()),
    ModifiedDate DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);
CREATE TABLE `Password` (
    BusinessEntityId INT NOT NULL,
    PasswordHash VARCHAR(128) NOT NULL,
    PasswordSalt VARCHAR(10) NOT NULL,
    rowguid CHAR(36) NOT NULL DEFAULT(UUID()),
    ModifiedDate DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);
CREATE TABLE Person (
    BusinessEntityId INT NOT NULL,
    PersonType CHAR(2) NOT NULL,
    NameStyle BOOLEAN NOT NULL DEFAULT FALSE,
    Title VARCHAR(8),
    FirstName VARCHAR(50) NOT NULL,
    MiddleName VARCHAR(50),
    LastName VARCHAR(50) NOT NULL,
    Suffix VARCHAR(10),
    EmailPromotion INT NOT NULL DEFAULT 0,
    AdditionalContactInfo TEXT,
    Demographics TEXT,
    rowguid CHAR(36) NOT NULL DEFAULT (UUID()),
    ModifiedDate DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT Chk_Person_EmailPromotion_Range CHECK (
        EmailPromotion BETWEEN 0 AND 2
    ),
    CONSTRAINT Chk_Person_PersonType CHECK (
        PersonType IS NULL
        OR UPPER(PersonType) IN ('SC', 'VC', 'IN', 'EM', 'SP', 'GC')
    )
);
CREATE TABLE PersonCreditCard(
    BusinessEntityId INT NOT NULL,
    CreditCardId INT NOT NULL,
    ModifiedDate DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);
CREATE TABLE PersonPhone(
    BusinessEntityId INT NOT NULL,
    PhoneNumber VARCHAR(25) NOT NULL,
    PhoneNumberTypeId INT NOT NULL,
    ModifiedDate DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);
CREATE TABLE PhoneNumberType(
    PhoneNumberTypeId INT NOT NULL,
    Name VARCHAR(50) NOT NULL,
    ModifiedDate DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);
CREATE TABLE StateProvince (
    StateProvinceId INT NOT NULL,
    StateProvinceCode CHAR(3) NOT NULL,
    CountryRegionCode VARCHAR(3) NOT NULL,
    IsOnlyStateProvinceFlag BOOL NOT NULL DEFAULT TRUE,
    Name VARCHAR(50) CHARACTER SET utf8mb4 NOT NULL,
    TerritoryId INT NOT NULL,
    rowguid CHAR(36) NOT NULL DEFAULT(UUID()),
    ModifiedDate DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);


-- ******************************************************
-- Production - Schema
-- ******************************************************


CREATE TABLE BillOfMaterials (
    BillOfMaterialsId INT NOT NULL,
    ProductAssemblyId INT NULL,
    ComponentId INT NOT NULL,
    StartDate DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    EndDate DATETIME NULL,
    UnitMeasureCode CHAR(3) NOT NULL,
    BOMLevel SMALLINT NOT NULL,
    PerAssemblyQty DECIMAL(8, 2) NOT NULL DEFAULT 1.00,
    ModifiedDate DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT Chk_BillOfMaterials_EndDate CHECK (
        EndDate > StartDate
        OR EndDate IS NULL
    ),
    CONSTRAINT Chk_BillOfMaterials_ProductAssemblyID CHECK (ProductAssemblyId <> ComponentId),
    CONSTRAINT Chk_BillOfMaterials_BOMLevel CHECK (
        (
            ProductAssemblyId IS NULL
            AND BOMLevel = 0
            AND PerAssemblyQty = 1.00
        )
        OR (
            ProductAssemblyId IS NOT NULL
            AND BOMLevel >= 1
        )
    ),
    CONSTRAINT Chk_BillOfMaterials_PerAssemblyQty CHECK (PerAssemblyQty >= 1.00)
);
CREATE TABLE Culture(
    CultureId CHAR(6) NOT NULL,
    Name VARCHAR(50) NOT NULL,
    ModifiedDate DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);
CREATE TABLE Illustration(
    IllustrationId INT NOT NULL,
    Diagram TEXT,
    ModifiedDate DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);
CREATE TABLE Location(
    LocationId SMALLINT NOT NULL,
    Name VARCHAR(50) NOT NULL,
    CostRate DECIMAL(19, 4) NOT NULL DEFAULT 0.00,
    Availability DECIMAL(8, 2) NOT NULL DEFAULT 0.00,
    ModifiedDate DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT Chk_Location_CostRate CHECK(CostRate >= 0),
    CONSTRAINT Chk_Location_Availability CHECK(Availability >= 0)
);
CREATE TABLE Product (
    ProductId INT NOT NULL,
    Name VARCHAR(50) NOT NULL,
    ProductNumber VARCHAR(25) NOT NULL,
    MakeFlag BOOLEAN NOT NULL DEFAULT TRUE,
    FinishedGoodsFlag BOOLEAN NOT NULL DEFAULT TRUE,
    Color VARCHAR(15),
    SafetyStockLevel SMALLINT NOT NULL,
    ReorderPoint SMALLINT NOT NULL,
    StandardCost DECIMAL(19, 4) NOT NULL,
    ListPrice DECIMAL(19, 4) NOT NULL,
    Size VARCHAR(5),
    SizeUnitMeasureCode CHAR(3),
    WeightUnitMeasureCode CHAR(3),
    Weight DECIMAL(8, 2),
    DaysToManufacture INT NOT NULL,
    ProductLine CHAR(2),
    Class CHAR(2),
    Style CHAR(2),
    ProductSubcategoryId INT,
    ProductModelId INT,
    SellStartDate DATETIME NOT NULL,
    SellEndDate DATETIME,
    DiscontinuedDate DATETIME,
    rowguid CHAR(36) NOT NULL DEFAULT (UUID()),
    ModifiedDate DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT Chk_Product_SafetyStockLevel CHECK (SafetyStockLevel > 0),
    CONSTRAINT Chk_Product_ReorderPoint CHECK (ReorderPoint > 0),
    CONSTRAINT Chk_Product_StandardCost CHECK (StandardCost >= 0.00),
    CONSTRAINT Chk_Product_ListPrice CHECK (ListPrice >= 0.00),
    CONSTRAINT Chk_Product_Weight CHECK (
        Weight > 0.00
        OR Weight IS NULL
    ),
    CONSTRAINT Chk_Product_DaysToManufacture CHECK (DaysToManufacture >= 0),
    CONSTRAINT Chk_Product_ProductLine CHECK (
        UPPER(ProductLine) IN ('S', 'T', 'M', 'R')
        OR ProductLine IS NULL
    ),
    CONSTRAINT Chk_Product_Class CHECK (
        UPPER(Class) IN ('L', 'M', 'H')
        OR Class IS NULL
    ),
    CONSTRAINT Chk_Product_Style CHECK (
        UPPER(Style) IN ('W', 'M', 'U')
        OR Style IS NULL
    ),
    CONSTRAINT Chk_Product_SellEndDate CHECK (
        SellEndDate >= SellStartDate
        OR SellEndDate IS NULL
    )
);
CREATE TABLE ProductCategory(
    ProductCategoryId INT NOT NULL,
    Name VARCHAR(50) NOT NULL,
    rowguid CHAR(36) NOT NULL DEFAULT(UUID()),
    ModifiedDate DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);
CREATE TABLE ProductCostHistory(
    ProductId INT NOT NULL,
    StartDate DATETIME NOT NULL,
    EndDate DATETIME NULL,
    StandardCost DECIMAL(19, 4) NOT NULL,
    ModifiedDate DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);
CREATE TABLE ProductDescription(
    ProductDescriptionId INT NOT NULL,
    Description VARCHAR(400) NOT NULL,
    rowguid CHAR(36) NOT NULL DEFAULT (UUID()),
    ModifiedDate DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);
CREATE TABLE ProductInventory(
    ProductId INT NOT NULL,
    LocationId SMALLINT NOT NULL,
    Shelf VARCHAR(10) NOT NULL,
    Bin TINYINT NOT NULL,
    Quantity SMALLINT NOT NULL DEFAULT 0,
    rowguid CHAR(36) NOT NULL DEFAULT (UUID()),
    ModifiedDate DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);
CREATE TABLE ProductListPriceHistory(
    ProductId INT NOT NULL,
    StartDate DATETIME NOT NULL,
    EndDate DATETIME,
    ListPrice DECIMAL(19, 4) NOT NULL,
    ModifiedDate DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT Chk_ProductListPriceHistory_EndDate CHECK(
        EndDate >= StartDate
        OR EndDate IS NULL
    ),
    CONSTRAINT Chk_ProductListPriceHistory_ListPrice CHECK(ListPrice > 0)
);
CREATE TABLE ProductModel(
    ProductModelId INT NOT NULL,
    Name VARCHAR(50) NOT NULL,
    CatalogDescription TEXT,
    Instructions TEXT,
    rowguid CHAR(36) NOT NULL DEFAULT(UUID()),
    ModifiedDate DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);
CREATE TABLE ProductModelIllustration(
    ProductModelId INT NOT NULL,
    IllustrationId INT NOT NULL,
    ModifiedDate DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);
CREATE TABLE ProductModelProductDescriptionCulture (
    ProductModelId INT NOT NULL,
    ProductDescriptionId INT NOT NULL,
    CultureId CHAR(6) NOT NULL,
    ModifiedDate DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);
CREATE TABLE ProductPhoto(
    ProductPhotoId INT NOT NULL,
    ThumbNailPhoto TEXT,
    ThumbNailPhotoFileName VARCHAR(50),
    LargePhoto TEXT,
    LargePhotoFileName VARCHAR(50),
    ModifiedDate DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);
CREATE TABLE ProductProductPhoto(
    ProductId INT NOT NULL,
    ProductPhotoId INT NOT NULL,
    `Primary` BOOL NOT NULL DEFAULT FALSE,
    ModifiedDate DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);
CREATE TABLE ProductSubcategory(
    ProductSubcategoryId INT NOT NULL,
    ProductCategoryId INT NOT NULL,
    Name VARCHAR(50) NOT NULL,
    rowguid CHAR(36) NOT NULL DEFAULT(UUID()),
    ModifiedDate DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);
CREATE TABLE ScrapReason (
    ScrapReasonId SMALLINT NOT NULL,
    Name VARCHAR(50) NOT NULL,
    ModifiedDate DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);
CREATE TABLE TransactionHistory (
    TransactionId INT NOT NULL,
    ProductId INT NOT NULL,
    ReferenceOrderId INT NOT NULL,
    ReferenceOrderLineId INT NOT NULL DEFAULT 0,
    TransactionDate DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    TransactionType CHAR(1) NOT NULL,
    Quantity INT NOT NULL,
    ActualCost DECIMAL(19, 4) NOT NULL,
    ModifiedDate DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT Chk_TransactionHistory_TransactionType CHECK (UPPER(TransactionType) IN ('W', 'S', 'P'))
);
CREATE TABLE TransactionHistoryArchive (
    TransactionId INT NOT NULL,
    ProductId INT NOT NULL,
    ReferenceOrderId INT NOT NULL,
    ReferenceOrderLineId INT NOT NULL DEFAULT 0,
    TransactionDate DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    TransactionType CHAR(1) NOT NULL,
    Quantity INT NOT NULL,
    ActualCost DECIMAL(19, 4) NOT NULL,
    ModifiedDate DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT Chk_TransactionHistoryArchive_TransactionType CHECK (UPPER(TransactionType) IN ('W', 'S', 'P'))
);
CREATE TABLE UnitMeasure(
    UnitMeasureCode CHAR(3) NOT NULL,
    Name VARCHAR(50) NOT NULL,
    ModifiedDate DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);
CREATE TABLE WorkOrder (
    WorkOrderId INT NOT NULL,
    ProductId INT NOT NULL,
    OrderQty INT NOT NULL,
    ScrappedQty INT NOT NULL,
    StockedQty INT GENERATED ALWAYS AS (GREATEST(OrderQty - ScrappedQty, 0)) STORED,
    StartDate DATETIME NOT NULL,
    EndDate DATETIME NULL,
    DueDate DATETIME NOT NULL,
    ScrapReasonId SMALLINT,
    ModifiedDate DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT Chk_WorkOrder_OrderQty CHECK (OrderQty > 0),
    CONSTRAINT Chk_WorkOrder_ScrappedQty CHECK (ScrappedQty >= 0),
    CONSTRAINT Chk_WorkOrder_EndDate CHECK (
        EndDate >= StartDate
        OR EndDate IS NULL
    )
);
CREATE TABLE WorkOrderRouting (
    WorkOrderId INT NOT NULL,
    ProductId INT NOT NULL,
    OperationSequence SMALLINT NOT NULL,
    LocationId SMALLINT NOT NULL,
    ScheduledStartDate DATETIME NOT NULL,
    ScheduledEndDate DATETIME NOT NULL,
    ActualStartDate DATETIME,
    ActualEndDate DATETIME,
    ActualResourceHrs DECIMAL(9, 4),
    PlannedCost DECIMAL(19, 4) NOT NULL,
    ActualCost DECIMAL(19, 4),
    ModifiedDate DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT Chk_WorkOrderRouting_ScheduledEndDate CHECK (ScheduledEndDate >= ScheduledStartDate),
    CONSTRAINT Chk_WorkOrderRouting_ActualEndDate CHECK (
        ActualEndDate >= ActualStartDate
        OR ActualEndDate IS NULL
        OR ActualStartDate IS NULL
    ),
    CONSTRAINT Chk_WorkOrderRouting_ActualResourceHrs CHECK (
        ActualResourceHrs IS NULL
        OR ActualResourceHrs >= 0.0000
    ),
    CONSTRAINT Chk_WorkOrderRouting_PlannedCost CHECK (PlannedCost > 0.00),
    CONSTRAINT Chk_WorkOrderRouting_ActualCost CHECK (
        ActualCost > 0.00
        OR ActualCost IS NULL
    )
);


-- ******************************************************
-- Sales - Schema
-- ******************************************************


CREATE TABLE CountryRegionCurrency(
    CountryRegionCode VARCHAR(3) NOT NULL,
    CurrencyCode CHAR(3) NOT NULL,
    ModifiedDate DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);
CREATE TABLE CreditCard(
    CreditCardId INT NOT NULL,
    CardType VARCHAR(50) NOT NULL,
    CardNumber VARCHAR(25) NOT NULL,
    ExpMonth TINYINT NOT NULL,
    ExpYear SMALLINT NOT NULL,
    ModifiedDate DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);
CREATE TABLE Currency(
    CurrencyCode CHAR(3) NOT NULL,
    Name VARCHAR(50) NOT NULL,
    ModifiedDate DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);
CREATE TABLE CurrencyRate(
    CurrencyRateId INT NOT NULL,
    CurrencyRateDate DATETIME NOT NULL,
    FromCurrencyCode CHAR(3) NOT NULL,
    ToCurrencyCode CHAR(3) NOT NULL,
    AverageRate DECIMAL(19, 4) NOT NULL DEFAULT 0.00,
    EndOfDayRate DECIMAL(19, 4) NOT NULL DEFAULT 0.00,
    ModifiedDate DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);
CREATE TABLE Customer (
    CustomerId INT NOT NULL,
    PersonId INT,
    StoreId INT,
    TerritoryId INT,
    AccountNumber VARCHAR(20) NOT NULL,
    rowguid CHAR(36) NOT NULL DEFAULT (UUID()),
    ModifiedDate DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);
CREATE TABLE SalesOrderDetail (
    SalesOrderId INT NOT NULL,
    SalesOrderDetailId INT NOT NULL,
    CarrierTrackingNumber VARCHAR(25),
    OrderQty SMALLINT NOT NULL,
    ProductId INT NOT NULL,
    SpecialOfferId INT NOT NULL,
    UnitPrice DECIMAL(19, 4) NOT NULL,
    UnitPriceDiscount DECIMAL(19, 4) NOT NULL DEFAULT 0.0,
    LineTotal DECIMAL(19, 4) GENERATED ALWAYS AS (
        IFNULL(
            UnitPrice * (1.0 - UnitPriceDiscount) * OrderQty,
            0.0
        )
    ) STORED,
    rowguid CHAR(36) NOT NULL DEFAULT (UUID()),
    ModifiedDate DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT Chk_SalesOrderDetail_OrderQty CHECK (OrderQty > 0),
    CONSTRAINT Chk_SalesOrderDetail_UnitPrice CHECK (UnitPrice >= 0.00),
    CONSTRAINT Chk_SalesOrderDetail_UnitPriceDiscount CHECK (UnitPriceDiscount >= 0.00)
);
CREATE TABLE SalesOrderHeader (
    SalesOrderId INT NOT NULL,
    RevisionNumber TINYINT NOT NULL DEFAULT 0,
    OrderDate DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    DueDate DATETIME NOT NULL,
    ShipDate DATETIME,
    Status TINYINT NOT NULL DEFAULT 1,
    OnlineOrderFlag BOOLEAN NOT NULL DEFAULT TRUE,
    SalesOrderNumber VARCHAR(50) NOT NULL,
    PurchaseOrderNumber VARCHAR(25),
    AccountNumber VARCHAR(25),
    CustomerId INT NOT NULL,
    SalesPersonId INT,
    TerritoryId INT,
    BillToAddressId INT NOT NULL,
    ShipToAddressId INT NOT NULL,
    ShipMethodId INT NOT NULL,
    CreditCardId INT,
    CreditCardApprovalCode VARCHAR(15),
    CurrencyRateId INT,
    SubTotal DECIMAL(19, 4) NOT NULL DEFAULT 0.00,
    TaxAmt DECIMAL(19, 4) NOT NULL DEFAULT 0.00,
    Freight DECIMAL(19, 4) NOT NULL DEFAULT 0.00,
    TotalDue DECIMAL(19, 4) GENERATED ALWAYS AS (IFNULL(SubTotal + TaxAmt + Freight, 0)) STORED,
    Comment VARCHAR(128),
    rowguid CHAR(36) NOT NULL DEFAULT (UUID()),
    ModifiedDate DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT Chk_SalesOrderHeader_Status CHECK (
        Status BETWEEN 0 AND 8
    ),
    CONSTRAINT Chk_SalesOrderHeader_DueDate CHECK (DueDate >= OrderDate),
    CONSTRAINT Chk_SalesOrderHeader_ShipDate CHECK (
        ShipDate >= OrderDate
        OR ShipDate IS NULL
    ),
    CONSTRAINT Chk_SalesOrderHeader_SubTotal CHECK (SubTotal >= 0.00),
    CONSTRAINT Chk_SalesOrderHeader_TaxAmt CHECK (TaxAmt >= 0.00),
    CONSTRAINT Chk_SalesOrderHeader_Freight CHECK (Freight >= 0.00)
);
CREATE TABLE SalesOrderHeaderSalesReason (
    SalesOrderId INT NOT NULL,
    SalesReasonId INT NOT NULL,
    ModifiedDate DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);
CREATE TABLE SalesPerson (
    BusinessEntityId INT NOT NULL,
    TerritoryId INT,
    SalesQuota DECIMAL(19, 4),
    Bonus DECIMAL(19, 4) NOT NULL DEFAULT 0.00,
    CommissionPct DECIMAL(10, 4) NOT NULL DEFAULT 0.00,
    SalesYTD DECIMAL(19, 4) NOT NULL DEFAULT 0.00,
    SalesLastYear DECIMAL(19, 4) NOT NULL DEFAULT 0.00,
    rowguid CHAR(36) NOT NULL DEFAULT (UUID()),
    ModifiedDate DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT Chk_SalesPerson_SalesQuota CHECK (
        SalesQuota > 0.00
        OR SalesQuota IS NULL
    ),
    CONSTRAINT Chk_SalesPerson_Bonus CHECK (Bonus >= 0.00),
    CONSTRAINT Chk_SalesPerson_CommissionPct CHECK (CommissionPct >= 0.00),
    CONSTRAINT Chk_SalesPerson_SalesYTD CHECK (SalesYTD >= 0.00),
    CONSTRAINT Chk_SalesPerson_SalesLastYear CHECK (SalesLastYear >= 0.00)
);
CREATE TABLE SalesPersonQuotaHistory (
    BusinessEntityId INT NOT NULL,
    QuotaDate DATETIME NOT NULL,
    SalesQuota DECIMAL(19, 4) NOT NULL,
    rowguid CHAR(36) NOT NULL DEFAULT (UUID()),
    ModifiedDate DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT Chk_SalesPersonQuotaHistory_SalesQuota CHECK (SalesQuota > 0.00)
);
CREATE TABLE SalesReason (
    SalesReasonId INT NOT NULL,
    Name VARCHAR(50) NOT NULL,
    ReasonType VARCHAR(50) NOT NULL,
    ModifiedDate DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);
CREATE TABLE SalesTaxRate (
    SalesTaxRateId INT NOT NULL,
    StateProvinceId INT NOT NULL,
    TaxType TINYINT NOT NULL,
    TaxRate DECIMAL(10, 4) NOT NULL DEFAULT 0.00,
    Name VARCHAR(50) NOT NULL,
    rowguid CHAR(36) NOT NULL DEFAULT (UUID()),
    ModifiedDate DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT Chk_SalesTaxRate_TaxType CHECK (
        TaxType BETWEEN 1 AND 3
    )
);
CREATE TABLE SalesTerritory (
    TerritoryId INT NOT NULL,
    Name VARCHAR(50) NOT NULL,
    CountryRegionCode VARCHAR(3) NOT NULL,
    `Group` VARCHAR(50) NOT NULL,
    SalesYTD DECIMAL(19, 4) NOT NULL DEFAULT 0.00,
    SalesLastYear DECIMAL(19, 4) NOT NULL DEFAULT 0.00,
    CostYTD DECIMAL(19, 4) NOT NULL DEFAULT 0.00,
    CostLastYear DECIMAL(19, 4) NOT NULL DEFAULT 0.00,
    rowguid CHAR(36) NOT NULL DEFAULT(UUID()),
    ModifiedDate DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT Chk_SalesTerritory_SalesYTD CHECK(
        SalesYTD >= 0.00
        AND SalesLastYear >= 0
        AND CostYTD >= 0
        AND CostLastYear >= 0
    )
);
CREATE TABLE SalesTerritoryHistory (
    BusinessEntityId INT NOT NULL,
    TerritoryId INT NOT NULL,
    StartDate DATETIME NOT NULL,
    EndDate DATETIME NULL,
    rowguid CHAR(36) NOT NULL DEFAULT (UUID()),
    ModifiedDate DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT Chk_SalesTerritoryHistory_EndDate CHECK (
        EndDate >= StartDate
        OR EndDate IS NULL
    )
);
CREATE TABLE ShoppingCartItem (
    ShoppingCartItemId INT NOT NULL,
    ShoppingCartId VARCHAR(50) NOT NULL,
    Quantity INT NOT NULL DEFAULT 1,
    ProductId INT NOT NULL,
    DateCreated DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    ModifiedDate DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT Chk_ShoppingCartItem_Quantity CHECK (Quantity >= 1)
);
CREATE TABLE SpecialOffer (
    SpecialOfferId INT NOT NULL,
    Description VARCHAR(255) NOT NULL,
    DiscountPct DECIMAL(10, 4) NOT NULL DEFAULT 0.00,
    Type VARCHAR(50) NOT NULL,
    Category VARCHAR(50) NOT NULL,
    StartDate DATETIME NOT NULL,
    EndDate DATETIME NOT NULL,
    MinQty INT NOT NULL DEFAULT 0,
    MaxQty INT,
    rowguid CHAR(36) NOT NULL DEFAULT (UUID()),
    ModifiedDate DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT Chk_SpecialOffer_EndDate CHECK (EndDate >= StartDate),
    CONSTRAINT Chk_SpecialOffer_DiscountPct CHECK (DiscountPct >= 0.00),
    CONSTRAINT Chk_SpecialOffer_MinQty CHECK (MinQty >= 0),
    CONSTRAINT Chk_SpecialOffer_MaxQty CHECK (
        MaxQty >= 0
        OR MaxQty IS NULL
    )
);
CREATE TABLE SpecialOfferProduct (
    SpecialOfferId INT NOT NULL,
    ProductId INT NOT NULL,
    rowguid CHAR(36) NOT NULL DEFAULT (UUID()),
    ModifiedDate DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);
CREATE TABLE Store (
    BusinessEntityId INT NOT NULL,
    Name VARCHAR(50) NOT NULL,
    SalesPersonId INT,
    Demographics TEXT,
    rowguid CHAR(36) NOT NULL DEFAULT (UUID()),
    ModifiedDate DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);


-- ******************************************************
-- Purchasing - Schema
-- ******************************************************


CREATE TABLE ProductVendor (
    ProductId INT NOT NULL,
    BusinessEntityId INT NOT NULL,
    AverageLeadTime INT NOT NULL,
    StandardPrice DECIMAL(19, 4) NOT NULL,
    LastReceiptCost DECIMAL(19, 4),
    LastReceiptDate DATETIME,
    MinOrderQty INT NOT NULL,
    MaxOrderQty INT NOT NULL,
    OnOrderQty INT,
    UnitMeasureCode CHAR(3) NOT NULL,
    ModifiedDate DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT Chk_ProductVendor_AverageLeadTime CHECK (AverageLeadTime >= 1),
    CONSTRAINT Chk_ProductVendor_StandardPrice CHECK (StandardPrice > 0.00),
    CONSTRAINT Chk_ProductVendor_LastReceiptCost CHECK (
        LastReceiptCost > 0.00
        OR LastReceiptCost IS NULL
    ),
    CONSTRAINT Chk_ProductVendor_MinOrderQty CHECK (MinOrderQty >= 1),
    CONSTRAINT Chk_ProductVendor_MaxOrderQty CHECK (MaxOrderQty >= 1),
    CONSTRAINT Chk_ProductVendor_OnOrderQty CHECK (
        OnOrderQty >= 0
        OR OnOrderQty IS NULL
    )
);
CREATE TABLE PurchaseOrderDetail (
    PurchaseOrderId INT NOT NULL,
    PurchaseOrderDetailId INT NOT NULL,
    DueDate DATETIME NOT NULL,
    OrderQty SMALLINT NOT NULL,
    ProductId INT NOT NULL,
    UnitPrice DECIMAL(19, 4) NOT NULL,
    LineTotal DECIMAL(19, 4) GENERATED ALWAYS AS (IFNULL(OrderQty * UnitPrice, 0.00)) STORED,
    ReceivedQty DECIMAL(8, 2) NOT NULL,
    RejectedQty DECIMAL(8, 2) NOT NULL,
    StockedQty DECIMAL(8, 2) GENERATED ALWAYS AS (
        IFNULL(ReceivedQty - RejectedQty, 0.00)
    ) STORED,
    ModifiedDate DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT Chk_PurchaseOrderDetail_OrderQty CHECK (OrderQty > 0),
    CONSTRAINT Chk_PurchaseOrderDetail_UnitPrice CHECK (UnitPrice >= 0.00),
    CONSTRAINT Chk_PurchaseOrderDetail_ReceivedQty CHECK (ReceivedQty >= 0.00),
    CONSTRAINT Chk_PurchaseOrderDetail_RejectedQty CHECK (RejectedQty >= 0.00)
);
CREATE TABLE PurchaseOrderHeader (
    PurchaseOrderId INT NOT NULL,
    RevisionNumber TINYINT NOT NULL DEFAULT 0,
    Status TINYINT NOT NULL DEFAULT 1,
    EmployeeId INT NOT NULL,
    VendorId INT NOT NULL,
    ShipMethodId INT NOT NULL,
    OrderDate DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    ShipDate DATETIME,
    SubTotal DECIMAL(19, 4) NOT NULL DEFAULT 0.00,
    TaxAmt DECIMAL(19, 4) NOT NULL DEFAULT 0.00,
    Freight DECIMAL(19, 4) NOT NULL DEFAULT 0.00,
    TotalDue DECIMAL(19, 4) GENERATED ALWAYS AS (
        IFNULL(SubTotal + TaxAmt + Freight, 0)
    ) STORED NOT NULL,
    ModifiedDate DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT Chk_PurchaseOrderHeader_Status CHECK (
        Status BETWEEN 1 AND 4
    ),
    CONSTRAINT Chk_PurchaseOrderHeader_ShipDate CHECK (
        ShipDate >= OrderDate
        OR ShipDate IS NULL
    ),
    CONSTRAINT Chk_PurchaseOrderHeader_SubTotal CHECK (SubTotal >= 0.00),
    CONSTRAINT Chk_PurchaseOrderHeader_TaxAmt CHECK (TaxAmt >= 0.00),
    CONSTRAINT Chk_PurchaseOrderHeader_Freight CHECK (Freight >= 0.00)
);
CREATE TABLE ShipMethod (
    ShipMethodId INT NOT NULL,
    Name VARCHAR(50) NOT NULL,
    ShipBase DECIMAL(19, 4) NOT NULL DEFAULT 0.00,
    ShipRate DECIMAL(19, 4) NOT NULL DEFAULT 0.00,
    rowguid CHAR(36) NOT NULL DEFAULT (UUID()),
    ModifiedDate DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT Chk_ShipMethod_ShipBase CHECK (ShipBase > 0.00),
    CONSTRAINT Chk_ShipMethod_ShipRate CHECK (ShipRate > 0.00)
);
CREATE TABLE Vendor (
    BusinessEntityId INT NOT NULL,
    AccountNumber VARCHAR(20) NOT NULL,
    Name VARCHAR(100) NOT NULL,
    CreditRating TINYINT NOT NULL,
    PreferredVendorStatus BOOLEAN NOT NULL DEFAULT TRUE,
    ActiveFlag BOOLEAN NOT NULL DEFAULT TRUE,
    PurchasingWebServiceURL VARCHAR(1024),
    ModifiedDate DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT Chk_Vendor_CreditRating CHECK (
        CreditRating BETWEEN 1 AND 5
    )
);


-- ******************************************************
-- HumanResources - Schema
-- ******************************************************



CREATE TABLE Employee (
    BusinessEntityId INT NOT NULL,
    NationalIdNumber VARCHAR(15) NOT NULL UNIQUE,
    LoginId VARCHAR(256) NOT NULL UNIQUE,
    OrganizationNode VARCHAR(255),
    OrganizationLevel INT,
    JobTitle VARCHAR(50) NOT NULL,
    BirthDate DATE NOT NULL,
    MaritalStatus CHAR(1) NOT NULL,
    Gender CHAR(1) NOT NULL,
    HireDate DATE NOT NULL,
    SalariedFlag BOOLEAN NOT NULL DEFAULT TRUE,
    VacationHours SMALLINT NOT NULL DEFAULT 0,
    SickLeaveHours SMALLINT NOT NULL DEFAULT 0,
    CurrentFlag BOOLEAN NOT NULL DEFAULT TRUE,
    rowguid CHAR(36) NOT NULL DEFAULT (UUID()),
    ModifiedDate DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT Chk_Employee_MaritalStatus CHECK (UPPER(MaritalStatus) IN ('M', 'S')),
    CONSTRAINT Chk_Employee_Gender CHECK (UPPER(Gender) IN ('M', 'F')),
    CONSTRAINT Chk_Employee_VacationHours CHECK (
        VacationHours BETWEEN -40 AND 240
    ),
    CONSTRAINT Chk_Employee_SickLeaveHours CHECK (
        SickLeaveHours BETWEEN 0 AND 120
    )
);
CREATE TABLE JobCandidate (
    JobCandidateId INT NOT NULL,
    BusinessEntityId INT NULL,
    Resume TEXT NULL,
    ModifiedDate DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);