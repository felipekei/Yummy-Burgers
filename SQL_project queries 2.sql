SELECT r.Name, COUNT(o.OrderID) AS TotalOrders
FROM Restaurant r
INNER JOIN [Order] o ON r.RestaurantID = o.CustomerID
GROUP BY r.Name
ORDER BY TotalOrders DESC;

SELECT c.Name, ISNULL(SUM(op.Total), 0) AS TotalSpent
FROM Customer c
LEFT JOIN (
    SELECT o.CustomerID, SUM(p.Total) AS Total
    FROM [Order] o
    INNER JOIN Payment p ON o.OrderID = p.OrderID
    GROUP BY o.CustomerID
) AS op ON c.CustomerID = op.CustomerID
GROUP BY c.Name
ORDER BY TotalSpent DESC;

SELECT e.Name, e.Position
FROM Employee e
WHERE EXISTS (
    SELECT 1
    FROM [Order] o
    WHERE o.CustomerID = e.EmployeeID
    AND o.OrderDate = '2024-04-01'
);

IF OBJECT_ID('OrderDetails', 'V') IS NOT NULL
    DROP VIEW OrderDetails;
GO

CREATE VIEW OrderDetails AS
SELECT o.OrderID, o.OrderDate, c.Name AS CustomerName, r.Name AS RestaurantName, m.ItemName, mo.Quantity, m.Price
FROM [Order] o
INNER JOIN Customer c ON o.CustomerID = c.CustomerID
INNER JOIN MenuItemOrder mo ON o.OrderID = mo.OrderID
INNER JOIN MenuItem m ON mo.ItemID = m.ItemID
INNER JOIN Restaurant r ON m.RestaurantID = r.RestaurantID;

SELECT * FROM OrderDetails;

SELECT *
FROM Customer
WHERE CustomerID IN (
    SELECT CustomerID
    FROM Feedback
    WHERE Rating < 4
);

SELECT r.Name, AVG(m.Price) AS AvgPrice
FROM Restaurant r
INNER JOIN MenuItem m ON r.RestaurantID = m.RestaurantId
GROUP BY r.Name;

SELECT c.Name,
    (SELECT COUNT(*)
     FROM [Order]
     WHERE CustomerID = c.CustomerID) AS TotalOrders
FROM Customer c;

SELECT COUNT(*) AS TotalOrders
FROM [Order];

SELECT MAX(TotalCalories) AS MaxCalories
FROM MenuItem;

SELECT Price, ROUND(Price, 2) AS RoundedPrice
FROM MenuItem;