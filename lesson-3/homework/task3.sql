
WITH RankedProducts AS (
    SELECT 
        Category,
        ProductName,
        Price,
        Stock,
        IIF(Stock = 0, 'Out of Stock', 
            IIF(Stock BETWEEN 1 AND 10, 'Low Stock', 'In Stock')) AS InventoryStatus,
        ROW_NUMBER() OVER (PARTITION BY Category ORDER BY Price DESC) AS Rank
    FROM Products
)
SELECT Category, ProductName, Price, InventoryStatus
FROM RankedProducts
WHERE Rank = 1
ORDER BY Price DESC
OFFSET 5 ROWS;
