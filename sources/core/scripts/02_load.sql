USE adventure_works;

-- ******************************************************
-- Person - Data Loading
-- ******************************************************


LOAD DATA INFILE '/var/lib/mysql-files/seed/Address.csv'
INTO TABLE Address  
CHARACTER SET utf8mb4 
FIELDS TERMINATED BY '\t'
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
(
    AddressId, AddressLine1, @AddressLine2, @City, StateProvinceId, PostalCode, SpatialLocation, rowguid, ModifiedDate

)
SET 
	AddressLine2 = NULLIF(@AddressLine2, ''), 
	City = NULLIF(@City, '');


LOAD DATA INFILE '/var/lib/mysql-files/seed/AddressType.csv'
INTO TABLE AddressType  
CHARACTER SET utf8mb4 
FIELDS TERMINATED BY '\t'
ENCLOSED BY '"'
LINES TERMINATED BY '\n';


LOAD DATA INFILE '/var/lib/mysql-files/seed/BusinessEntity.csv'
INTO TABLE BusinessEntity  
CHARACTER SET utf8mb4
FIELDS TERMINATED BY '\t'
ENCLOSED BY '"'
LINES TERMINATED BY '\n';


LOAD DATA INFILE '/var/lib/mysql-files/seed/BusinessEntityAddress.csv'
INTO TABLE BusinessEntityAddress  
CHARACTER SET utf8mb4
FIELDS TERMINATED BY '\t'
ENCLOSED BY '"'
LINES TERMINATED BY '\n';


LOAD DATA INFILE '/var/lib/mysql-files/seed/BusinessEntityContact.csv'
INTO TABLE BusinessEntityContact
CHARACTER SET utf8mb4
FIELDS TERMINATED BY '\t'
ENCLOSED BY '"'
LINES TERMINATED BY '\n';

LOAD DATA INFILE '/var/lib/mysql-files/seed/ContactType.csv'
INTO TABLE ContactType
CHARACTER SET utf8mb4
FIELDS TERMINATED BY '\t'
ENCLOSED BY '"'
LINES TERMINATED BY '\n';

LOAD DATA INFILE '/var/lib/mysql-files/seed/CountryRegion.csv'
INTO TABLE CountryRegion
CHARACTER SET utf8mb4
FIELDS TERMINATED BY '\t'
ENCLOSED BY '"'
LINES TERMINATED BY '\n';

LOAD DATA INFILE '/var/lib/mysql-files/seed/EmailAddress.csv'
INTO TABLE EmailAddress 
CHARACTER SET utf8mb4
FIELDS TERMINATED BY '\t'
ENCLOSED BY '"'
LINES TERMINATED BY '\n';

LOAD DATA INFILE '/var/lib/mysql-files/seed/Password.csv'
INTO TABLE Password
CHARACTER SET utf8mb4
FIELDS TERMINATED BY '\t'
ENCLOSED BY '"'
LINES TERMINATED BY '\n';


LOAD DATA INFILE '/var/lib/mysql-files/seed/Person.csv'
INTO TABLE Person
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ','
ENCLOSED BY '^'
LINES TERMINATED BY '\n'
(
BusinessEntityID, PersonType, NameStyle, @Title, FirstName, @MiddleName, LastName, @Suffix, EmailPromotion, @AdditionalContactInfo, @Demographics, rowguid, ModifiedDate
)
SET 
	Title = NULLIF(@Title, ''), 
	Suffix = NULLIF(@Suffix, ''),
	AdditionalContactInfo = NULLIF(@AdditionalContactInfo, ''), 
	Demographics = NULLIF(@Demographics, ''); 

LOAD DATA INFILE '/var/lib/mysql-files/seed/PersonCreditCard.csv'
INTO TABLE PersonCreditCard
CHARACTER SET utf8mb4
FIELDS TERMINATED BY '\t'
ENCLOSED BY '"'
LINES TERMINATED BY '\n';


LOAD DATA INFILE '/var/lib/mysql-files/seed/PersonPhone.csv'
INTO TABLE PersonPhone
CHARACTER SET utf8mb4
FIELDS TERMINATED BY '\t'
ENCLOSED BY '"'
LINES TERMINATED BY '\n';


LOAD DATA INFILE '/var/lib/mysql-files/seed/PhoneNumberType.csv'
INTO TABLE PhoneNumberType
CHARACTER SET utf8mb4
FIELDS TERMINATED BY '\t'
ENCLOSED BY '"'
LINES TERMINATED BY '\n';


LOAD DATA INFILE '/var/lib/mysql-files/seed/StateProvince.csv'
INTO TABLE StateProvince  
CHARACTER SET utf8mb4 
FIELDS TERMINATED BY '\t'
ENCLOSED BY '"'
LINES TERMINATED BY '\n';


-- ******************************************************
-- Production - Data loading
-- ******************************************************


    LOAD DATA INFILE '/var/lib/mysql-files/seed/BillOfMaterials.csv'
INTO TABLE BillOfMaterials 
CHARACTER SET utf8mb4
FIELDS TERMINATED BY '\t'
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
(
BillOfMaterialsId, @ProductAssemblyId, ComponentId, StartDate, @EndDate, UnitMeasureCode, BOMLevel, PerAssemblyQty, ModifiedDate
)
SET 
	ProductAssemblyId = NULLIF(@ProductAssemblyId, ''),
	EndDate = NULLIF(@EndDate, '');


LOAD DATA INFILE '/var/lib/mysql-files/seed/Culture.csv'
INTO TABLE Culture 
CHARACTER SET utf8mb4
FIELDS TERMINATED BY '\t'
ENCLOSED BY '"'
LINES TERMINATED BY '\n';

    LOAD DATA INFILE '/var/lib/mysql-files/seed/Illustration.csv'
INTO TABLE Illustration
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ','
ENCLOSED BY '^'
LINES TERMINATED BY '\n'
(IllustrationId, @Diagram, ModifiedDate)
SET 
	Diagram = NULLIF(@Diagram, '');


LOAD DATA INFILE '/var/lib/mysql-files/seed/Location.csv'
INTO TABLE Location
CHARACTER SET utf8mb4
FIELDS TERMINATED BY '\t'
ENCLOSED BY '"'
LINES TERMINATED BY '\n';


LOAD DATA INFILE '/var/lib/mysql-files/seed/Product.csv'
INTO TABLE Product
FIELDS TERMINATED BY '\t'
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
(ProductId, Name, ProductNumber, MakeFlag, FinishedGoodsFlag, Color, SafetyStockLevel, ReorderPoint,
 StandardCost, ListPrice, Size, @SizeUnitMeasureCode, @WeightUnitMeasureCode, @Weight, DaysToManufacture,
 @ProductLine, @Class, @Style, @ProductSubcategoryId, @ProductModelId, SellStartDate, @SellEndDate,
 @DiscontinuedDate, rowguid, ModifiedDate)
SET 
	Weight = NULLIF(@Weight, ''),
    SizeUnitMeasureCode = NULLIF(@SizeUnitMeasureCode, ''),
    WeightUnitMeasureCode = NULLIF(@WeightUnitMeasureCode, ''),
	ProductSubcategoryId = NULLIF(@ProductSubcategoryId, ''), 
	ProductModelId = NULLIF(@ProductModelId, ''),
	SellEndDate = NULLIF(@SellEndDate, ''),
	DiscontinuedDate = NULLIF(@DiscontinuedDate, ''),
	ProductLine = NULLIF(@ProductLine, ''),
	Class = NULLIF(@Class, ''),
	Style = NULLIF(@Style, '');

LOAD DATA INFILE '/var/lib/mysql-files/seed/ProductCategory.csv'
INTO TABLE ProductCategory
CHARACTER SET utf8mb4
FIELDS TERMINATED BY '\t'
ENCLOSED BY '"'
LINES TERMINATED BY '\n';

    LOAD DATA INFILE '/var/lib/mysql-files/seed/ProductCostHistory.csv'
INTO TABLE ProductCostHistory
CHARACTER SET utf8mb4
FIELDS TERMINATED BY '\t'
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
(ProductId, StartDate, @EndDate, StandardCost, ModifiedDate)
SET 
	EndDate = NULLIF(@EndDate, '');


LOAD DATA INFILE '/var/lib/mysql-files/seed/ProductDescription.csv'
INTO TABLE ProductDescription 
CHARACTER SET utf8mb4
FIELDS TERMINATED BY '\t'
ENCLOSED BY '"'
LINES TERMINATED BY '\n';


    LOAD DATA INFILE '/var/lib/mysql-files/seed/ProductInventory.csv'
INTO TABLE ProductInventory
CHARACTER SET utf8mb4
FIELDS TERMINATED BY '\t'
ENCLOSED BY '"'
LINES TERMINATED BY '\n';


LOAD DATA INFILE '/var/lib/mysql-files/seed/ProductListPriceHistory.csv'
INTO TABLE ProductListPriceHistory 
CHARACTER SET utf8mb4
FIELDS TERMINATED BY '\t'
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
(ProductId, StartDate, @EndDate, ListPrice, ModifiedDate)
SET 
	EndDate = NULLIF(@EndDate, '');


LOAD DATA INFILE '/var/lib/mysql-files/seed/ProductModel.csv'
INTO TABLE ProductModel
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ','
ENCLOSED BY '^'
LINES TERMINATED BY '\n'
(
    ProductModelId, Name, @CatalogDescription, @Instructions, rowguid, ModifiedDate

)
SET
    CatalogDescription = NULLIF(@CatalogDescription, ''),
    Instructions = NULLIF(@Instructions, '');


    LOAD DATA INFILE '/var/lib/mysql-files/seed/ProductModelIllustration.csv'
INTO TABLE ProductModelIllustration 
CHARACTER SET utf8mb4
FIELDS TERMINATED BY '\t'
ENCLOSED BY '"'
LINES TERMINATED BY '\n';


LOAD DATA INFILE '/var/lib/mysql-files/seed/ProductModelProductDescriptionCulture.csv'
INTO TABLE ProductModelProductDescriptionCulture
CHARACTER SET utf8mb4
FIELDS TERMINATED BY '\t'
ENCLOSED BY '"'
LINES TERMINATED BY '\n';


LOAD DATA INFILE '/var/lib/mysql-files/seed/ProductPhoto.csv'
INTO TABLE ProductPhoto 
CHARACTER SET utf8mb4
FIELDS TERMINATED BY '\t'
ENCLOSED BY '"'
LINES TERMINATED BY '\n';



LOAD DATA INFILE '/var/lib/mysql-files/seed/ProductProductPhoto.csv'
INTO TABLE ProductProductPhoto 
CHARACTER SET utf8mb4
FIELDS TERMINATED BY '\t'
ENCLOSED BY '"'
LINES TERMINATED BY '\n';



LOAD DATA INFILE '/var/lib/mysql-files/seed/ProductSubcategory.csv'
INTO TABLE ProductSubcategory 
CHARACTER SET utf8mb4
FIELDS TERMINATED BY '\t'
ENCLOSED BY '"'
LINES TERMINATED BY '\n';

LOAD DATA INFILE '/var/lib/mysql-files/seed/ScrapReason.csv'
INTO TABLE ScrapReason  
CHARACTER SET utf8mb4
FIELDS TERMINATED BY '\t'
ENCLOSED BY '"'
LINES TERMINATED BY '\n';


LOAD DATA INFILE '/var/lib/mysql-files/seed/TransactionHistory.csv'
INTO TABLE TransactionHistory
CHARACTER SET utf8mb4
FIELDS TERMINATED BY '\t'
ENCLOSED BY '"'
LINES TERMINATED BY '\n';


LOAD DATA INFILE '/var/lib/mysql-files/seed/TransactionHistoryArchive.csv'
INTO TABLE TransactionHistoryArchive
CHARACTER SET utf8mb4
FIELDS TERMINATED BY '\t'
ENCLOSED BY '"'
LINES TERMINATED BY '\n';

    LOAD DATA INFILE '/var/lib/mysql-files/seed/UnitMeasure.csv'
INTO TABLE UnitMeasure 
CHARACTER SET utf8mb4
FIELDS TERMINATED BY '\t'
ENCLOSED BY '"'
LINES TERMINATED BY '\n';


LOAD DATA INFILE '/var/lib/mysql-files/seed/WorkOrder.csv'
INTO TABLE WorkOrder  
CHARACTER SET utf8mb4
FIELDS TERMINATED BY '\t'
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
(
WorkOrderId, ProductId, OrderQty, ScrappedQty, StockedQty, StartDate, @EndDate, DueDate, @ScrapReasonId, ModifiedDate
)
SET EndDate = NULLIF(@EndDate, ''), ScrapReasonId = NULLIF(@ScrapReasonId, '');


LOAD DATA INFILE '/var/lib/mysql-files/seed/WorkOrderRouting.csv'
INTO TABLE WorkOrderRouting  
CHARACTER SET utf8mb4
FIELDS TERMINATED BY '\t'
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
(
WorkOrderId, ProductId, OperationSequence, LocationId, ScheduledStartDate, ScheduledEndDate, @ActualStartDate, @ActualEndDate, @ActualResourceHrs, PlannedCost, @ActualCost, ModifiedDate

)
SET 
	ActualStartDate = NULLIF(@ActualStartDate, ''), 
	ActualEndDate = NULLIF(@ActualEndDate, ''),
	ActualResourceHrs = NULLIF(@ActualResourceHrs, ''),
	ActualCost = NULLIF(@ActualCost, '');

-- ******************************************************
-- Sales - Data loading
-- ******************************************************


LOAD DATA INFILE '/var/lib/mysql-files/seed/CountryRegionCurrency.csv'
INTO TABLE CountryRegionCurrency 
CHARACTER SET utf8mb4
FIELDS TERMINATED BY '\t'
ENCLOSED BY '"'
LINES TERMINATED BY '\n';


LOAD DATA INFILE '/var/lib/mysql-files/seed/CreditCard.csv'
INTO TABLE CreditCard 
CHARACTER SET utf8mb4
FIELDS TERMINATED BY '\t'
ENCLOSED BY '"'
LINES TERMINATED BY '\n';

LOAD DATA INFILE '/var/lib/mysql-files/seed/Currency.csv'
INTO TABLE Currency
CHARACTER SET utf8mb4
FIELDS TERMINATED BY '\t'
ENCLOSED BY '"'
LINES TERMINATED BY '\n';


LOAD DATA INFILE '/var/lib/mysql-files/seed/CurrencyRate.csv'
INTO TABLE CurrencyRate 
CHARACTER SET utf8mb4
FIELDS TERMINATED BY '\t'
ENCLOSED BY '"'
LINES TERMINATED BY '\n';



    LOAD DATA INFILE '/var/lib/mysql-files/seed/Customer.csv'
INTO TABLE Customer
CHARACTER SET utf8mb4
FIELDS TERMINATED BY '\t'
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
(
CustomerId, @PersonId, @StoreId, @TerritoryId, AccountNumber, rowguid, ModifiedDate
)
SET 
	PersonId = NULLIF(@PersonId, ''),
	TerritoryId = NULLIF(@TerritoryId, ''),
	StoreId = NULLIF(@StoreId, '');



LOAD DATA INFILE '/var/lib/mysql-files/seed/SalesOrderDetail.csv'
INTO TABLE SalesOrderDetail  
CHARACTER SET utf8mb4
FIELDS TERMINATED BY '\t'
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
(
SalesOrderId, SalesOrderDetailId, @CarrierTrackingNumber, OrderQty, ProductId, 
SpecialOfferId, UnitPrice, UnitPriceDiscount, LineTotal, rowguid, ModifiedDate
)
SET CarrierTrackingNumber = NULLIF(@CarrierTrackingNumber, '');




    LOAD DATA INFILE '/var/lib/mysql-files/seed/SalesOrderHeader.csv'
INTO TABLE SalesOrderHeader  
CHARACTER SET utf8mb4
FIELDS TERMINATED BY '\t'
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
(
SalesOrderId, RevisionNumber, OrderDate, DueDate, @ShipDate, Status, OnlineOrderFlag, 
SalesOrderNumber, @PurchaseOrderNumber, @AccountNumber, CustomerId, @SalesPersonId, 
@TerritoryId, BillToAddressId, ShipToAddressId, ShipMethodId, @CreditCardId, @CreditCardApprovalCode, 
@CurrencyRateId, SubTotal, TaxAmt, Freight, TotalDue, @Comment, rowguid, ModifiedDate
)
SET 
	ShipDate = NULLIF(@ShipDate, ''),
PurchaseOrderNumber = NULLIF(@PurchaseOrderNumber, ''),
AccountNumber = NULLIF(@AccountNumber, ''),
SalesPersonId = NULLIF(@SalesPersonId, ''),
TerritoryId = NULLIF(@TerritoryId, ''),
CreditCardId = NULLIF(@CreditCardId, ''),
CreditCardApprovalCode = NULLIF(@CreditCardApprovalCode, ''),
CurrencyRateId = NULLIF(@CurrencyRateId, ''),
Comment = NULLIF(@Comment, '');

LOAD DATA INFILE '/var/lib/mysql-files/seed/SalesOrderHeaderSalesReason.csv'
INTO TABLE SalesOrderHeaderSalesReason  
CHARACTER SET utf8mb4
FIELDS TERMINATED BY '\t'
ENCLOSED BY '"'
LINES TERMINATED BY '\n';

LOAD DATA INFILE '/var/lib/mysql-files/seed/SalesPerson.csv'
INTO TABLE SalesPerson
CHARACTER SET utf8mb4
FIELDS TERMINATED BY '\t'
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
(
BusinessEntityId, @TerritoryId, @SalesQuota, Bonus, CommissionPct, SalesYTD, SalesLastYear, rowguid, ModifiedDate
)
SET 
	TerritoryId = NULLIF(@TerritoryId, ''),
		SalesQuota = NULLIF(@SalesQuota, '');


LOAD DATA INFILE '/var/lib/mysql-files/seed/SalesPersonQuotaHistory.csv'
INTO TABLE SalesPersonQuotaHistory
CHARACTER SET utf8mb4
FIELDS TERMINATED BY '\t'
ENCLOSED BY '"'
LINES TERMINATED BY '\n';


LOAD DATA INFILE '/var/lib/mysql-files/seed/SalesReason.csv'
INTO TABLE SalesReason 
CHARACTER SET utf8mb4
FIELDS TERMINATED BY '\t'
ENCLOSED BY '"'
LINES TERMINATED BY '\n';


LOAD DATA INFILE '/var/lib/mysql-files/seed/SalesTaxRate.csv'
INTO TABLE SalesTaxRate  
CHARACTER SET utf8mb4
FIELDS TERMINATED BY '\t'
ENCLOSED BY '"'
LINES TERMINATED BY '\n';


LOAD DATA INFILE '/var/lib/mysql-files/seed/SalesTerritory.csv'
INTO TABLE SalesTerritory 
FIELDS TERMINATED BY '\t'
ENCLOSED BY '"'
LINES TERMINATED BY '\n';

LOAD DATA INFILE '/var/lib/mysql-files/seed/SalesTerritoryHistory.csv'
INTO TABLE SalesTerritoryHistory  
CHARACTER SET utf8mb4
FIELDS TERMINATED BY '\t'
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
(
BusinessEntityId, TerritoryId, StartDate, @EndDate, rowguid, ModifiedDate
)
SET EndDate = NULLIF(@EndDate, '');


LOAD DATA INFILE '/var/lib/mysql-files/seed/ShoppingCartItem.csv'
INTO TABLE ShoppingCartItem
CHARACTER SET utf8mb4
FIELDS TERMINATED BY '\t'
ENCLOSED BY '"'
LINES TERMINATED BY '\n';


LOAD DATA INFILE '/var/lib/mysql-files/seed/SpecialOffer.csv'
INTO TABLE SpecialOffer  
CHARACTER SET utf8mb4
FIELDS TERMINATED BY '\t'
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
(
SpecialOfferId, Description, DiscountPct, Type, Category, StartDate, EndDate, MinQty, @MaxQty, rowguid, ModifiedDate
)
SET MaxQty = NULLIF(@MaxQty, '');



LOAD DATA INFILE '/var/lib/mysql-files/seed/SpecialOfferProduct.csv'
INTO TABLE SpecialOfferProduct  
CHARACTER SET utf8mb4
FIELDS TERMINATED BY '\t'
ENCLOSED BY '"'
LINES TERMINATED BY '\n';


        LOAD DATA INFILE '/var/lib/mysql-files/seed/Store.csv'
INTO TABLE Store
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ','
ENCLOSED BY '^'
LINES TERMINATED BY '\n'
(
BusinessEntityId, Name, @SalesPersonId, @Demographics, rowguid, ModifiedDate
)
SET 
	SalesPersonId = NULLIF(@SalesPersonId, ''), 
	Demographics = NULLIF(@Demographics, '');


-- ******************************************************
-- Purchasing - Data loading
-- ******************************************************


LOAD DATA INFILE '/var/lib/mysql-files/seed/ProductVendor.csv'
INTO TABLE ProductVendor
CHARACTER SET utf8mb4
FIELDS TERMINATED BY '\t'
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
(ProductID, BusinessEntityID, AverageLeadTime, StandardPrice, 
@LastReceiptCost, @LastReceiptDate, MinOrderQty, MaxOrderQty, @OnOrderQty, UnitMeasureCode, ModifiedDate)
SET 
	LastReceiptCost = NULLIF(@LastReceiptCost, ''),
	LastReceiptDate = NULLIF(@LastReceiptDate, ''),
	OnOrderQty = NULLIF(@OnOrderQty, '');

LOAD DATA INFILE '/var/lib/mysql-files/seed/PurchaseOrderDetail.csv'
INTO TABLE PurchaseOrderDetail
CHARACTER SET utf8mb4
FIELDS TERMINATED BY '\t'
ENCLOSED BY '"'
LINES TERMINATED BY '\n';

LOAD DATA INFILE '/var/lib/mysql-files/seed/PurchaseOrderHeader.csv'
INTO TABLE PurchaseOrderHeader
CHARACTER SET utf8mb4
FIELDS TERMINATED BY '\t'
ENCLOSED BY '"'
LINES TERMINATED BY '\n';

LOAD DATA INFILE '/var/lib/mysql-files/seed/ShipMethod.csv'
INTO TABLE ShipMethod 
CHARACTER SET utf8mb4
FIELDS TERMINATED BY '\t'
ENCLOSED BY '"'
LINES TERMINATED BY '\n';


    LOAD DATA INFILE '/var/lib/mysql-files/seed/Vendor.csv'
INTO TABLE Vendor
CHARACTER SET utf8mb4
FIELDS TERMINATED BY '\t'
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
(
BusinessEntityID, AccountNumber, Name, CreditRating, PreferredVendorStatus, ActiveFlag, @PurchasingWebServiceURL, ModifiedDate
)
SET 
	PurchasingWebServiceURL = NULLIF(@PurchasingWebServiceURL, '');

-- ******************************************************
-- HumanResources - Data loading
-- ******************************************************

LOAD DATA INFILE '/var/lib/mysql-files/seed/Department.csv'
INTO TABLE Department 
CHARACTER SET utf8mb4
FIELDS TERMINATED BY '\t'
ENCLOSED BY '"'
LINES TERMINATED BY '\n';




    LOAD DATA INFILE '/var/lib/mysql-files/seed/Employee.csv'
INTO TABLE Employee
CHARACTER SET utf8mb4
FIELDS TERMINATED BY '\t'
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
(
BusinessEntityId, NationalIdNumber, LoginId, @OrganizationNode, @OrganizationLevel, 
JobTitle, BirthDate, MaritalStatus, Gender, HireDate, SalariedFlag, VacationHours, 
SickLeaveHours, CurrentFlag, rowguid, ModifiedDate
)
SET 
	OrganizationNode = NULLIF(@OrganizationNode, ''),
	OrganizationLevel = NULLIF(@OrganizationLevel, '');


LOAD DATA INFILE '/var/lib/mysql-files/seed/EmployeeDepartmentHistory.csv'
INTO TABLE EmployeeDepartmentHistory
CHARACTER SET utf8mb4
FIELDS TERMINATED BY '\t'
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
(
BusinessEntityId, DepartmentId, ShiftId, StartDate, @EndDate, ModifiedDate
)
SET 
	EndDate = NULLIF(@EndDate, '');

LOAD DATA INFILE '/var/lib/mysql-files/seed/EmployeePayHistory.csv'
INTO TABLE EmployeePayHistory
CHARACTER SET utf8mb4
FIELDS TERMINATED BY '\t'
ENCLOSED BY '"'
LINES TERMINATED BY '\n';


LOAD DATA INFILE '/var/lib/mysql-files/seed/JobCandidate.csv'
INTO TABLE JobCandidate  
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ','
ENCLOSED BY '^'
LINES TERMINATED BY '\n'
(
JobCandidateId, @BusinessEntityId, @Resume, ModifiedDate
)
SET 
	BusinessEntityId = NULLIF(@BusinessEntityId, ''),
	Resume = NULLIF(@Resume, '');



LOAD DATA INFILE '/var/lib/mysql-files/seed/Shift.csv'
INTO TABLE Shift
CHARACTER SET utf8mb4
FIELDS TERMINATED BY '\t'
ENCLOSED BY '"'
LINES TERMINATED BY '\n';


