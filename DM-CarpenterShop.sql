-- Create the data mart.

IF NOT EXISTS(SELECT * FROM sys.databases
	WHERE NAME = N'CarpenterShopDM')
	CREATE DATABASE CarpenterShopDM
GO
USE CarpenterShopDM

-- Delete existing tables.

IF EXISTS(
	SELECT *
	FROM sys.tables
	WHERE NAME = N'FactOrder'
       )
	DROP TABLE FactOrder;

IF EXISTS(
	SELECT *
	FROM sys.tables
	WHERE NAME = N'DimProduct'
       )
	DROP TABLE DimProduct;

IF EXISTS(
	SELECT *
	FROM sys.tables
	WHERE NAME = N'DimCarpenter'
       )
	DROP TABLE DimCarpenter;

IF EXISTS(
	SELECT *
	FROM sys.tables
	WHERE NAME = N'DimCustomer'
       )
	DROP TABLE DimCustomer;

IF EXISTS(
	SELECT *
	FROM sys.tables
	WHERE NAME = N'DimDate'
       )
	DROP TABLE DimDate;

-- Create the tables.

CREATE TABLE DimDate
	(
	Date_SK				INT CONSTRAINT pk_date_key PRIMARY KEY, 
	Date				DATE,
	FullDate			NCHAR(10),-- Date in MM-dd-yyyy format
	DayOfMonth			INT, -- Field will hold day number of Month
	DayName				NVARCHAR(9), -- Contains name of the day, Sunday, Monday 
	DayOfWeek			INT,-- First Day Sunday=1 and Saturday=7
	DayOfWeekInMonth	INT, -- 1st Monday or 2nd Monday in Month
	DayOfWeekInYear		INT,
	DayOfQuarter		INT,
	DayOfYear			INT,
	WeekOfMonth			INT,-- Week Number of Month 
	WeekOfQuarter		INT, -- Week Number of the Quarter
	WeekOfYear			INT,-- Week Number of the Year
	Month				INT, -- Number of the Month 1 to 12{}
	MonthName			NVARCHAR(9),-- January, February etc
	MonthOfQuarter		INT,-- Month Number belongs to Quarter
	Quarter				NCHAR(2),
	QuarterName			NVARCHAR(9),-- First,Second..
	Year				INT,-- Year value of Date stored in Row
	YearName			CHAR(7), -- CY 2017,CY 2018
	MonthYear			CHAR(10), -- Jan-2018,Feb-2018
	MMYYYY				INT,
	FirstDayOfMonth		DATE,
	LastDayOfMonth		DATE,
	FirstDayOfQuarter	DATE,
	LastDayOfQuarter	DATE,
	FirstDayOfYear		DATE,
	LastDayOfYear		DATE,
	IsHoliday			BIT,-- Flag 1=National Holiday, 0-No National Holiday
	IsWeekday			BIT,-- 0=Week End ,1=Week Day
	Holiday				NVARCHAR(50),--Name of Holiday in US
	Season				NVARCHAR(10)--Name of Season
	);

CREATE TABLE DimCustomer
	(
	Customer_SK			INT IDENTITY CONSTRAINT pk_customer_key PRIMARY KEY,
	Customer_BK			INT NOT NULL,
	FirstName			NVARCHAR(100) NOT NULL,
	LastName			NVARCHAR(100) NOT NULL,
	LFName				NVARCHAR(200) NOT NULL,
	City				NVARCHAR(100) NOT NULL,
	[State]				NVARCHAR(100) NOT NULL,
	PostalCode			NVARCHAR(10) NOT NULL,
	Region				NVARCHAR(100) NOT NULL,
	Gender				NVARCHAR(100) NOT NULL,
	Birthdate			DATE NOT NULL,
	Age					INT NOT NULL,
	AgeGroup			NVARCHAR(100) NOT NULL,
	IsVeteran			NVARCHAR(100) NOT NULL,
	IsFirstResponder	NVARCHAR(100) NOT NULL,
	IsTeacher			NVARCHAR(100) NOT NULL
	);

CREATE TABLE DimCarpenter
	(
	Carpenter_SK		INT IDENTITY CONSTRAINT pk_carpenter_key PRIMARY KEY,
	Carpenter_BK		INT NOT NULL,
	FirstName			NVARCHAR(100) NOT NULL,
	LastName			NVARCHAR(100) NOT NULL,
	LFName				NVARCHAR(200) NOT NULL,
	City				NVARCHAR(100) NOT NULL,
	[State]				NVARCHAR(100) NOT NULL,
	PostalCode			NVARCHAR(10) NOT NULL,
	Region				NVARCHAR(100) NOT NULL,
	Gender				NVARCHAR(100) NOT NULL,
	Birthdate			DATE NOT NULL,
	Age					INT NOT NULL,
	AgeGroup			NVARCHAR(100) NOT NULL,
	CarpenterLevel		NVARCHAR(100) NOT NULL
	);

CREATE TABLE DimProduct
	(
	Product_SK			INT IDENTITY CONSTRAINT pk_product_key PRIMARY KEY,
	Product_BK			INT NOT NULL,
	Product				NVARCHAR(100) NOT NULL
	);

CREATE TABLE FactOrder
	(
	OrderID				INT NOT NULL,
	OrderProductID		INT NOT NULL,
	OrderDate			INT CONSTRAINT fk_order_date_key FOREIGN KEY REFERENCES DimDate(Date_SK) NOT NULL,
	Customer_SK			INT CONSTRAINT fk_customer_key FOREIGN KEY REFERENCES DimCustomer(Customer_SK) NOT NULL,
	Carpenter_SK		INT CONSTRAINT fk_carpenter_key FOREIGN KEY REFERENCES DimCarpenter(Carpenter_SK) NOT NULL,
	Product_SK			INT CONSTRAINT fk_product_key FOREIGN KEY REFERENCES DimProduct(Product_SK) NOT NULL, 
	Price				MONEY NOT NULL,
	Quantity			INT NOT NULL, 
	Revenue				MONEY NOT NULL,
	CONSTRAINT pk_fact_order PRIMARY KEY(OrderID, OrderProductID, OrderDate, Customer_SK, Carpenter_SK, Product_SK)
	);