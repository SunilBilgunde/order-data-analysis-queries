-- Q.1 List the total sales amount for each customer, including their first and last names.
SELECT C.FirstName, C.LastName, SUM(o.TotalAmount) as Total_Amount
FROM customers C
LEFT JOIN orders o
	ON c.CustomerID = o.CustomerID
GROUP BY C.FirstName, C.LastName;


-- Q.2 Find the orders where the total amount is higher than the average total amount of all orders.
SELECT OrderDate, OrderID, TotalAmount
FROM orders
WHERE TotalAmount >
(
SELECT AVG(TotalAmount)
FROM orders
);


-- Q.3 Calculate the total quantity and subtotal for each product in the OrderDetails table.
SELECT ProductID, SUM(Quantity) as Total_quantity, SUM(Subtotal) as Sub_Total
FROM orderdetails
GROUP BY ProductID;

-- if we want product name then we can join the orderdetails table with Products table.

 SELECT o.ProductID, p.ProductName, SUM(Quantity) as Total_quantity, SUM(Subtotal) as Sub_Total
FROM orderdetails o
INNER JOIN products p 
	ON o.ProductID = p.ProductID
GROUP BY o.ProductID, p.ProductName;


-- Q.4 Create a report that shows whether an order's total amount is high, medium, or low based on the following ranges: high (>= 1500), medium (>= 1000), low (< 1000).
SELECT OrderID, TotalAmount,
CASE
WHEN TotalAmount >= 1500 THEN "High"
WHEN TotalAmount >=1000 THEN "Medium"
ELSE "Low"
END AS Category
FROM orders;


-- Q.5 Rank the employees based on the total number of orders they have processed.
SELECT EmployeeID, COUNT(OrderID),
RANK () OVER(ORDER BY COUNT(OrderID) DESC) as Employee_Rank
FROM Orders
GROUP BY EmployeeID;


-- Q.6 List the products that have been ordered more than the average quantity ordered across all products.
SELECT o.ProductID, p.ProductName, SUM(o.Quantity)
FROM orderdetails o
INNER JOIN products p 
	ON o.ProductID = p.ProductID
GROUP BY o.ProductID, p.ProductName
HAVING SUM(o.Quantity) > avg(quantity);


-- Q.7 Retrieve the customer details along with the employee's first and last names who handled their order.
SELECT C.CustomerID, C.FirstName AS CustomerFirstName, C.LastName AS CustomerLastName, 
O.OrderID, o.OrderDate,
E.FirstName AS EmployeeFirstName, E.LastName AS EmployeeLastName
FROM Customers C
INNER JOIN Orders o
	ON C.CustomerID = o.CustomerID
INNER JOIN Employees E
	ON o.EmployeeID = E.EmployeeID;
    
    
-- Q.8 List the total quantity sold and the average price per product category.
SELECT p.Category, AVG(p.price) AS Average_Price_per_Category, SUM(o.quantity) AS Total_Quantity_sold
FROM products p
INNER JOIN orderdetails o
	ON p.productID = o.ProductID
GROUP BY p.Category;


-- Q.9 List the customers who have placed orders more than the average number of orders.
SELECT CustomerID, count(OrderID)
FROM Orders
GROUP BY CustomerID
HAVING COUNT(OrderID) >
(
SELECT AVG(Total_orders)
FROM
(
SELECT CustomerID, COUNT(OrderID) AS Total_Orders
FROM Orders
GROUP BY CustomerID
)a
);

