SELECT
	CarpenterShop.dbo.OrderProduct.OrderProductID,
	CarpenterShop.dbo.OrderProduct.OrderID,
	CarpenterShopDM.dbo.DimDate.Date_SK AS OrderDate,
	CarpenterShopDM.dbo.DimCustomer.Customer_SK,
	CarpenterShopDM.dbo.DimCarpenter.Carpenter_SK,
	CarpenterShopDM.dbo.DimProduct.Product_SK,
	CarpenterShop.dbo.Product.Price,
	CarpenterShop.dbo.OrderProduct.Quantity,
	CarpenterShop.dbo.Product.Price * CarpenterShop.dbo.OrderProduct.Quantity AS Revenue
FROM
	CarpenterShop.dbo.OrderProduct
INNER JOIN
	CarpenterShop.dbo.[Order]
ON
	CarpenterShop.dbo.OrderProduct.OrderID = CarpenterShop.dbo.[Order].OrderID
INNER JOIN
	CarpenterShop.dbo.Product
ON
	CarpenterShop.dbo.OrderProduct.ProductID = CarpenterShop.dbo.Product.ProductID
INNER JOIN
	CarpenterShopDM.dbo.DimDate
ON
	CarpenterShopDM.dbo.DimDate.Date = CarpenterShop.dbo.[Order].OrderDate
INNER JOIN
	CarpenterShopDM.dbo.DimCustomer
ON
	CarpenterShopDM.dbo.DimCustomer.Customer_BK = CarpenterShop.dbo.[Order].CustomerID
INNER JOIN
	CarpenterShopDM.dbo.DimCarpenter
ON
	CarpenterShopDM.dbo.DimCarpenter.Carpenter_BK = CarpenterShop.dbo.[Order].CarpenterID
INNER JOIN
	CarpenterShopDM.dbo.DimProduct
ON
	CarpenterShopDM.dbo.DimProduct.Product_BK = CarpenterShop.dbo.OrderProduct.ProductID