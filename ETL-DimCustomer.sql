SELECT
	CarpenterShop.dbo.Customer.CustomerID AS Customer_BK,
	CarpenterShop.dbo.Customer.FirstName,
	CarpenterShop.dbo.Customer.LastName,
	CONCAT(CarpenterShop.dbo.Customer.LastName, ', ', CarpenterShop.dbo.Customer.FirstName) AS LFName,
	CarpenterShop.dbo.Customer.[Address],
	CarpenterShop.dbo.Customer.City,
	CarpenterShop.dbo.Customer.PostalCode,
	CarpenterShop.dbo.[State].StateName AS [State],
	CarpenterShop.dbo.Region.RegionName AS Region,
	ISNULL(CarpenterShop.dbo.Customer.Gender, 'Unknown') AS Gender,
	CarpenterShop.dbo.Customer.Birthdate,
	DATEDIFF(YY, CarpenterShop.dbo.Customer.Birthdate, GETDATE()) AS Age,
	CASE 
	WHEN YEAR(CarpenterShop.dbo.Customer.Birthdate) BETWEEN 1901 AND 1927 THEN N'Greatest Generation'
	WHEN YEAR(CarpenterShop.dbo.Customer.Birthdate) BETWEEN 1928 AND 1945 THEN N'Silent Genearation'
	WHEN YEAR(CarpenterShop.dbo.Customer.Birthdate) BETWEEN 1946 AND 1964 THEN N'Boomer'
	WHEN YEAR(CarpenterShop.dbo.Customer.Birthdate) BETWEEN 1965 AND 1979 THEN N'Gen X'
	WHEN YEAR(CarpenterShop.dbo.Customer.Birthdate) BETWEEN 1980 AND 1996 THEN N'Millenial'
	WHEN YEAR(CarpenterShop.dbo.Customer.Birthdate) BETWEEN 1997 AND 2012 THEN N'Gen Z'
	WHEN YEAR(CarpenterShop.dbo.Customer.Birthdate) BETWEEN 2013 AND 2025 THEN N'Gen Alpha'
	END AS AgeGroup,
	CASE WHEN Veteran = 1 THEN N'Veteran' ELSE N'Not a Veteran' END AS IsVeteran,
	CASE WHEN FirstResponder = 1 THEN N'First Responder' ELSE N'Not a First Responder' END AS IsFirstResponder,
	CASE WHEN Teacher = 1 THEN N'Teacher' ELSE N'Not a Teacher' END AS IsTeacher
FROM	
	CarpenterShop.dbo.Customer
INNER JOIN
	CarpenterShop.dbo.[State]
ON
	CarpenterShop.dbo.Customer.StateCode = CarpenterShop.dbo.[State].StateCode
INNER JOIN
	CarpenterShop.dbo.Region
ON
	CarpenterShop.dbo.[State].RegionCode = CarpenterShop.dbo.Region.RegionCode