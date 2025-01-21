SELECT
	CarpenterShop.dbo.Carpenter.CarpenterID AS Carpenter_BK,
	CarpenterShop.dbo.Carpenter.FirstName,
	CarpenterShop.dbo.Carpenter.LastName,
	CONCAT(CarpenterShop.dbo.Carpenter.LastName, ', ', CarpenterShop.dbo.Carpenter.FirstName) AS LFName,
	CarpenterShop.dbo.Carpenter.[Address],
	CarpenterShop.dbo.Carpenter.City,
	CarpenterShop.dbo.Carpenter.PostalCode,
	CarpenterShop.dbo.[State].StateName AS [State],
	CarpenterShop.dbo.Region.RegionName AS Region,
	ISNULL(CarpenterShop.dbo.Carpenter.Gender, 'Unknown') AS Gender,
	CarpenterShop.dbo.Carpenter.Birthdate,
	DATEDIFF(YY, CarpenterShop.dbo.Carpenter.Birthdate, GETDATE()) AS Age,
	CASE 
	WHEN YEAR(CarpenterShop.dbo.Carpenter.Birthdate) BETWEEN 1901 AND 1927 THEN N'Greatest Generation'
	WHEN YEAR(CarpenterShop.dbo.Carpenter.Birthdate) BETWEEN 1928 AND 1945 THEN N'Silent Genearation'
	WHEN YEAR(CarpenterShop.dbo.Carpenter.Birthdate) BETWEEN 1946 AND 1964 THEN N'Boomer'
	WHEN YEAR(CarpenterShop.dbo.Carpenter.Birthdate) BETWEEN 1965 AND 1979 THEN N'Gen X'
	WHEN YEAR(CarpenterShop.dbo.Carpenter.Birthdate) BETWEEN 1980 AND 1996 THEN N'Millenial'
	WHEN YEAR(CarpenterShop.dbo.Carpenter.Birthdate) BETWEEN 1997 AND 2012 THEN N'Gen Z'
	WHEN YEAR(CarpenterShop.dbo.Carpenter.Birthdate) BETWEEN 2013 AND 2025 THEN N'Gen Alpha'
	END AS AgeGroup,
	CarpenterShop.dbo.CarpenterLevel.CarpenterLevelName AS CarpenterLevel
FROM	
	CarpenterShop.dbo.Carpenter
INNER JOIN
	CarpenterShop.dbo.[State]
ON
	CarpenterShop.dbo.Carpenter.StateCode = CarpenterShop.dbo.[State].StateCode
INNER JOIN
	CarpenterShop.dbo.Region
ON
	CarpenterShop.dbo.[State].RegionCode = CarpenterShop.dbo.Region.RegionCode
INNER JOIN
	CarpenterShop.dbo.CarpenterLevel
ON
	CarpenterShop.dbo.Carpenter.CarpenterLevelID = CarpenterShop.dbo.CarpenterLevel.CarpenterLevelID