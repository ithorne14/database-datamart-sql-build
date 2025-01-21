-- Publication date: January 2024

-- Create the database.

IF NOT EXISTS(SELECT * FROM sys.databases
	WHERE NAME = N'CarpenterShop')
	CREATE DATABASE CarpenterShop
GO
USE CarpenterShop

-- Drop existing tables.

IF EXISTS(
	SELECT *
	FROM sys.tables
	WHERE NAME = N'OrderProduct'
       )
	DROP TABLE OrderProduct;

IF EXISTS(
	SELECT *
	FROM sys.tables
	WHERE NAME = N'Order'
       )
	DROP TABLE [Order];

IF EXISTS(
	SELECT *
	FROM sys.tables
	WHERE NAME = N'Customer'
       )
	DROP TABLE Customer;

IF EXISTS(
	SELECT *
	FROM sys.tables
	WHERE NAME = N'Product'
       )
	DROP TABLE Product;

IF EXISTS(
	SELECT *
	FROM sys.tables
	WHERE NAME = N'Carpenter'
       )
	DROP TABLE Carpenter;

IF EXISTS(
	SELECT *
	FROM sys.tables
	WHERE NAME = N'CarpenterLevel'
       )
	DROP TABLE CarpenterLevel;

IF EXISTS(
	SELECT *
	FROM sys.tables
	WHERE NAME = N'State'
       )
	DROP TABLE [State];

IF EXISTS(
	SELECT *
	FROM sys.tables
	WHERE NAME = N'Region'
       )
	DROP TABLE Region;

-- Create the tables.

CREATE TABLE Region (
	RegionCode			NVARCHAR(2) CONSTRAINT pk_region_code PRIMARY KEY,
	RegionName			NVARCHAR(100) CONSTRAINT nn_region_name NOT NULL
	);

CREATE TABLE [State] (
	StateCode			NVARCHAR(2) CONSTRAINT pk_state_code PRIMARY KEY,
	StateName			NVARCHAR(100) CONSTRAINT nn_state_name NOT NULL,
	RegionCode			NVARCHAR(2) CONSTRAINT fk_state_region FOREIGN KEY REFERENCES Region(RegionCode)
	);

CREATE TABLE CarpenterLevel (
	CarpenterLevelID	INT IDENTITY CONSTRAINT pk_carpenter_level_id PRIMARY KEY,
	CarpenterLevelName	NVARCHAR(55) CONSTRAINT nn_carpenter_level_name NOT NULL
	);

CREATE TABLE Carpenter (
	CarpenterID			INT IDENTITY CONSTRAINT pk_carpenter_id PRIMARY KEY,
	FirstName			NVARCHAR(100) CONSTRAINT nn_carpenter_first_name NOT NULL,
	LastName			NVARCHAR(100) CONSTRAINT nn_carpenter_last_name NOT NULL,
	Birthdate			DATE CONSTRAINT nn_carpenter_birthdate NOT NULL,
	Gender				NVARCHAR(100) CONSTRAINT nn_carpenter_gender NOT NULL,
	[Address]			NVARCHAR(100) CONSTRAINT nn_carpenter_address NOT NULL,
	City				NVARCHAR(100) CONSTRAINT nn_carpenter_city NOT NULL,
	StateCode			NVARCHAR(2) CONSTRAINT fk_carpenter_state FOREIGN KEY REFERENCES [State](StateCode),
	PostalCode			NVARCHAR(5) CONSTRAINT nn_carpenter_postal_code NOT NULL,
	Telephone			NVARCHAR(10) CONSTRAINT nn_carpenter_telephone NOT NULL,
	Email				NVARCHAR(100) CONSTRAINT nn_carpenter_email NOT NULL,
	CarpenterLevelID	INT CONSTRAINT fk_carpenter_level FOREIGN KEY REFERENCES CarpenterLevel(CarpenterLevelID)		
	);

CREATE TABLE Product (
	ProductID			INT IDENTITY CONSTRAINT pk_product_id PRIMARY KEY,
	ProductName			NVARCHAR(100) CONSTRAINT nn_product_name NOT NULL,
	Price				MONEY CONSTRAINT nn_product_price NOT NULL
	);

CREATE TABLE Customer (
	CustomerID			INT IDENTITY CONSTRAINT pk_customer_id PRIMARY KEY,
	FirstName			NVARCHAR(100) CONSTRAINT nn_customer_first_name NOT NULL,
	LastName			NVARCHAR(100) CONSTRAINT nn_customer_last_name NOT NULL,
	Birthdate			DATE CONSTRAINT nn_customer_birthdate NOT NULL,
	Gender				NVARCHAR(100) CONSTRAINT nn_customer_gender NOT NULL,
	[Address]			NVARCHAR(100) CONSTRAINT nn_customer_address NOT NULL,
	City				NVARCHAR(100) CONSTRAINT nn_customer_city NOT NULL,
	StateCode			NVARCHAR(2) CONSTRAINT fk_customer_state FOREIGN KEY REFERENCES [State](StateCode),
	PostalCode			NVARCHAR(5) CONSTRAINT nn_customer_postal_code NOT NULL,
	Telephone			NVARCHAR(10) CONSTRAINT nn_customer_telephone NOT NULL,
	Email				NVARCHAR(100) CONSTRAINT nn_customer_email NOT NULL,
	Veteran				BIT CONSTRAINT nn_customer_activty_duty NOT NULL,
	FirstResponder		BIT CONSTRAINT nn_customer_first_responder NOT NULL,
	Teacher				BIT CONSTRAINT nn_customer_teacher NOT NULL
	);

CREATE TABLE [Order] (
	OrderID				INT IDENTITY CONSTRAINT pk_order_id PRIMARY KEY,
	OrderDate			DATE CONSTRAINT nn_order_date NOT NULL,
	CustomerID			INT CONSTRAINT fk_order_customer FOREIGN KEY REFERENCES Customer(CustomerID),
	CarpenterID			INT CONSTRAINT fk_order_carpenter FOREIGN KEY REFERENCES Carpenter(CarpenterID)
	);

CREATE TABLE OrderProduct (
	OrderProductID		INT IDENTITY CONSTRAINT pk_order_product_product_id PRIMARY KEY,
	OrderID				INT CONSTRAINT fk_order_product_order_id FOREIGN KEY REFERENCES [Order](OrderID),
	ProductID			INT CONSTRAINT fk_order_product_product_id FOREIGN KEY REFERENCES Product(ProductID),
	Quantity			INT CONSTRAINT nn_quantity NOT NULL
	);

-- Load base data into the Region table.

INSERT INTO Region VALUES ('NE', 'Northeast');
INSERT INTO Region VALUES ('SE', 'Southeast');
INSERT INTO Region VALUES ('MW', 'Midwest');
INSERT INTO Region VALUES ('WE', 'West');
INSERT INTO Region VALUES ('SW', 'Southwest');

-- Load base data into the State table.

INSERT INTO [State] VALUES ('AL', 'Alabama', 'SE');
INSERT INTO [State] VALUES ('AK', 'Alaska', 'WE');
INSERT INTO [State] VALUES ('AZ', 'Arizona', 'SW');
INSERT INTO [State] VALUES ('AR', 'Arkansas', 'SE');
INSERT INTO [State] VALUES ('CA', 'California', 'WE');
INSERT INTO [State] VALUES ('CO', 'Colorado', 'WE');
INSERT INTO [State] VALUES ('CT', 'Connecticut', 'NE');
INSERT INTO [State] VALUES ('DE', 'Delaware', 'SE');
INSERT INTO [State] VALUES ('DC', 'District of Columbia', 'SE');
INSERT INTO [State] VALUES ('FL', 'Florida', 'SE');
INSERT INTO [State] VALUES ('GA', 'Georgia', 'SE');
INSERT INTO [State] VALUES ('HI', 'Hawaii', 'WE');
INSERT INTO [State] VALUES ('ID', 'Idaho', 'WE');
INSERT INTO [State] VALUES ('IL', 'Illinois', 'MW');
INSERT INTO [State] VALUES ('IN', 'Indiana', 'MW');
INSERT INTO [State] VALUES ('IA', 'Iowa', 'MW');
INSERT INTO [State] VALUES ('KS', 'Kansas', 'MW');
INSERT INTO [State] VALUES ('KY', 'Kentucky', 'SE');
INSERT INTO [State] VALUES ('LA', 'Louisiana', 'SE');
INSERT INTO [State] VALUES ('ME', 'Maine', 'NE');
INSERT INTO [State] VALUES ('MD', 'Maryland', 'NE');
INSERT INTO [State] VALUES ('MA', 'Massachusetts', 'NE');
INSERT INTO [State] VALUES ('MI', 'Michigan', 'MW');
INSERT INTO [State] VALUES ('MN', 'Minnesota', 'MW');
INSERT INTO [State] VALUES ('MS', 'Mississippi', 'SE');
INSERT INTO [State] VALUES ('MO', 'Missouri', 'SE');
INSERT INTO [State] VALUES ('MT', 'Montana', 'MW');
INSERT INTO [State] VALUES ('NE', 'Nebraska', 'MW');
INSERT INTO [State] VALUES ('NV', 'Nevada', 'MW');
INSERT INTO [State] VALUES ('NH', 'New Hampshire', 'NE');
INSERT INTO [State] VALUES ('NJ', 'New Jersey', 'NE');
INSERT INTO [State] VALUES ('NM', 'New Mexico', 'SW');
INSERT INTO [State] VALUES ('NY', 'New York', 'NE');
INSERT INTO [State] VALUES ('NC', 'North Carolina', 'SE');
INSERT INTO [State] VALUES ('ND', 'North Dakota', 'WE');
INSERT INTO [State] VALUES ('OH', 'Ohio', 'MW');
INSERT INTO [State] VALUES ('OK', 'Oklahoma', 'SW');
INSERT INTO [State] VALUES ('OR', 'Oregon', 'WE');
INSERT INTO [State] VALUES ('PA', 'Pennsylvania', 'NE');
INSERT INTO [State] VALUES ('RI', 'Rhode Island', 'NE');
INSERT INTO [State] VALUES ('SC', 'South Carolina', 'SE');
INSERT INTO [State] VALUES ('SD', 'South Dakota', 'WE');
INSERT INTO [State] VALUES ('TN', 'Tennessee', 'SE');
INSERT INTO [State] VALUES ('TX', 'Texas', 'SW');
INSERT INTO [State] VALUES ('UT', 'Utah', 'WE');
INSERT INTO [State] VALUES ('VT', 'Vermont', 'NE');
INSERT INTO [State] VALUES ('VA', 'Virginia', 'SE');
INSERT INTO [State] VALUES ('WA', 'Washington', 'WE');
INSERT INTO [State] VALUES ('WV', 'West Virginia', 'SE');
INSERT INTO [State] VALUES ('WI', 'Wisconsin', 'MW');
INSERT INTO [State] VALUES ('WY', 'Wyoming', 'WE');

-- Load base data into the Product table.

INSERT INTO Product VALUES ('End Table', 500);
INSERT INTO Product VALUES ('Coffee Table', 900);
INSERT INTO Product VALUES ('Media Console', 1300);
INSERT INTO Product VALUES ('Rocking Chair', 600)
INSERT INTO Product VALUES ('Console Table', 400);
INSERT INTO Product VALUES ('Dining Table', 1500);
INSERT INTO Product VALUES ('Hutch', 2000);
INSERT INTO Product VALUES ('Side Table', 500);
INSERT INTO Product VALUES ('Dining Chair', 250);
INSERT INTO Product VALUES ('Kitchen Table', 1000);
INSERT INTO Product VALUES ('Bistro Table', 800);
INSERT INTO Product VALUES ('Counter Stool', 450);
INSERT INTO Product VALUES ('Bed Frame', 2000);
INSERT INTO Product VALUES ('Chest of Drawers', 1300);
INSERT INTO Product VALUES ('Nightstand', 1000);

-- Load base data into the CarpenterLevel table.

INSERT INTO CarpenterLevel VALUES ('Apprentice');
INSERT INTO CarpenterLevel VALUES ('Journeyperson');
INSERT INTO CarpenterLevel VALUES ('Master');

-- Load external data into the Customer table.

BULK INSERT CarpenterShop.dbo.Customer FROM 'C:\Users\name\Downloads\CarpenterShop\CarpenterShop\Customer.csv'
WITH (
	CHECK_CONSTRAINTS,
	FIELDTERMINATOR = ',',
	ROWTERMINATOR = '\n',
	FIRSTROW = 2
)

-- Load external data into the Carpenter table.

BULK INSERT CarpenterShop.dbo.Carpenter FROM 'C:\Users\name\Downloads\CarpenterShop\CarpenterShop\Carpenter.csv'
WITH (
	CHECK_CONSTRAINTS,
	FIELDTERMINATOR = ',',
	ROWTERMINATOR = '\n',
	FIRSTROW = 2
)

-- Load external data into the Order table.

BULK INSERT CarpenterShop.dbo.[Order] FROM 'C:\Users\name\Downloads\CarpenterShop\CarpenterShop\Order.csv'
WITH (
	CHECK_CONSTRAINTS,
	FIELDTERMINATOR = ',',
	ROWTERMINATOR = '\n',
	FIRSTROW = 2
)

-- Load external data into the OrderProduct table.

BULK INSERT CarpenterShop.dbo.OrderProduct FROM 'C:\Users\name\Downloads\CarpenterShop\CarpenterShop\OrderProduct.csv'
WITH (
	CHECK_CONSTRAINTS,
	FIELDTERMINATOR = ',',
	ROWTERMINATOR = '\n',
	FIRSTROW = 2
)

-- Check record counts for each table.

GO
SET NOCOUNT ON
SELECT 'OrderProduct' AS "Table",	COUNT(*) AS "Rows"	FROM OrderProduct		UNION
SELECT 'Order',						COUNT(*)			FROM [Order]			UNION
SELECT 'Customer',					COUNT(*)			FROM Customer			UNION
SELECT 'Carpenter',					COUNT(*)			FROM Carpenter			UNION
SELECT 'CarpenterLevel',			COUNT(*)			FROM CarpenterLevel		UNION
SELECT 'Product',					COUNT(*)			FROM Product			UNION
SELECT 'State',						COUNT(*)			FROM [State]			UNION
SELECT 'Region',					COUNT(*)			FROM Region				
SET NOCOUNT OFF
GO