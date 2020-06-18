-- ***** Introductory Problems *****
-- 1. Which shippers do we have?
-- We have a table called Shippers. Return all the fields from all the shippers
SELECT * 
FROM shippers;

-- 2. Certain fields from Categories
-- In the Categories table, selecting all the fields using this SQL:
-- Select * from Categories
-- ...will return 4 columns. We only want to see two columns, CategoryName and Description.
SELECT CategoryName, Description
FROM categories;

-- 3. Sales Representatives
-- We’d like to see just the FirstName, LastName, and HireDate of all the employees with 
-- the Title of Sales Representative. Write a SQL statement that returns only those employees.
SELECT FirstName, LastName, HireDate
FROM employees
WHERE Title = 'Sales Representative';

-- 4. Sales Representatives in the United States
-- Now we’d like to see the same columns as above, but only for those employees that both
-- have the title of Sales Representative, and also are in the United States.
SELECT FirstName, LastName, HireDate
FROM employees
WHERE Title = 'Sales Representative'
AND Country = 'USA';

-- 5. Orders placed by specific EmployeeID
-- Show all the orders placed by a specific employee. The EmployeeID for this Employee 
-- (Steven Buchanan) is 5.

SELECT OrderId, OrderDate
FROM orders
WHERE EmployeeID = 5;

-- 6. Suppliers and ContactTitles
-- In the Suppliers table, show the SupplierID, ContactName, and ContactTitle for those
-- Suppliers whose ContactTitle is not Marketing Manager.
SELECT SupplierID, ContactName, ContactTitle
FROM suppliers
WHERE ContactTitle <> 'Marketing Manager';

-- 7. Products with “queso” in ProductName
-- In the products table, we’d like to see the ProductID and ProductName for those 
-- products where the ProductName includes the string “queso”.
SELECT ProductID, ProductName 
FROM products
WHERE ProductName like '%queso%';

-- 8. Orders shipping to France or Belgium
-- Looking at the Orders table, there’s a field called ShipCountry. 
-- Write a query that shows the OrderID, CustomerID, and ShipCountry 
-- for the orders where the ShipCountry is either France or Belgium.
SELECT OrderID, CustomerID, ShipCountry 
FROM orders 
WHERE ShipCountry = 'France'
OR ShipCountry = 'Belgium';

-- 9. Orders shipping to any country in Latin America
-- Now, instead of just wanting to return all the orders from France of Belgium, 
-- we want to show all the orders from any Latin American country. But we don’t
-- have a list of Latin American countries in a table in the Northwind database. 
-- So, we’re going to just use this list of Latin American countries that happen 
-- to be in the Orders table:
-- Brazil, Mexico, Argentina, Venezuela
--  It doesn’t make sense to use multiple Or statements anymore, it would get 
-- too convoluted. Use the In statement.
SELECT OrderID, CustomerID, ShipCountry 
FROM orders 
WHERE ShipCountry IN ('Brazil', 'Mexico', 'Argentina', 'Venezuela');

-- 10. Employees, in order of age
-- For all the employees in the Employees table, show the FirstName, LastName, 
-- Title, and BirthDate. Order the results by BirthDate, so we have the oldest employees first.
SELECT  FirstName, LastName, Title, BirthDate
FROM employees
ORDER BY BirthDate;

-- 11. Showing only the Date with a DateTime field
-- In the output of the query above, showing the Employees in order of BirthDate,
-- we see the time of the BirthDate field, which we don’t want. 
-- Show only the date portion of the BirthDate field.
SELECT  FirstName, LastName, Title, DATE(BirthDate) as DateOnlyBoirthDate
FROM employees
ORDER BY BirthDate;

-- 12. Employees full name
-- Show the FirstName and LastName columns from the Employees table, 
-- and then create a new column called FullName, 
-- showing FirstName and LastName joined together in one column,
-- with a space in- between.
SELECT  FirstName, LastName, CONCAT(FirstName, ' ', LastName) as FullName
FROM employees;

-- 13. OrderDetails amount per line item
-- In the OrderDetails table, we have the fields UnitPrice and Quantity. 
-- Create a new field, TotalPrice, that multiplies these two together. 
-- We’ll ignore the Discount field for now.
-- In addition, show the OrderID, ProductID, UnitPrice, and Quantity.
-- Order by OrderID and ProductID.
SELECT OrderID, ProductID, UnitPrice, Quantity, UnitPrice * Quantity AS TotalPrice
FROM `order details`
ORDER BY OrderID and ProductID;

-- 14. How many customers?
-- How many customers do we have in the Customers table?
-- Show one value only, and don’t rely on getting the recordcount at the end of a resultset.
SELECT count(CustomerID) AS TotalCustomers
FROM customers;

-- 15. When was the first order?
-- Show the date of the first order ever made in the Orders table.
SELECT MIN(OrderDate) as FirstOrder
FROM orders;

-- 16. Countries where there are customers
-- Show a list of countries where the Northwind company has customers.
SELECT DISTINCT country
FROM customers
ORDER BY country;

-- 17. Contact titles for customers
-- Show a list of all the different values in the Customers table for ContactTitles.
-- Also include a count for each ContactTitle.
SELECT 
    ContactTitle, COUNT(ContactTitle) AS TotalContactTitle
FROM
    customers
GROUP BY ContactTitle
ORDER BY TotalContactTitle DESC;

-- 18. Products with associated supplier names
-- We’d like to show, for each product, the associated Supplier. 
-- Show the ProductID, ProductName, and the CompanyName of the Supplier. 
-- Sort by ProductID.
SELECT ProductID, ProductName, CompanyName
FROM products p
JOIN suppliers s ON p.SupplierID = s.SupplierID
ORDER BY ProductID ;

-- 19. Orders and the Shipper that was used
-- We’d like to show a list of the Orders that were made,
-- including the Shipper that was used. Show the 
-- OrderID, OrderDate (date only), and CompanyName 
-- of the Shipper, and sort by OrderID.
SELECT OrderID, DATE(OrderDate), CompanyName
FROM orders o 
JOIN shippers s ON o.ShipVia = s.ShipperID
WHERE OrderID < 10300
ORDER BY OrderID;

-- ***** Intermediate Problems *****
-- 20. Categories, and the total products in each category
-- For this problem, we’d like to see the total number of products in each category.
-- Sort the results by the total number of products, in descending order.
SELECT CategoryName, COUNT(ProductID) AS TotalProducts
FROM products p
JOIN categories c ON p.CategoryID = c.CategoryID
group by CategoryName;

-- 21. Total customers per country/city
-- In the Customers table, show the total number of customers per Country and City.
SELECT Country, City,  COUNT(CustomerID) AS TotalCustomerss
FROM customers
group by Country, City
ORDER BY TotalCustomerss DESC;

-- 22. Products that need reordering
-- What products do we have in our inventory that should be reordered? 
-- For now, just use the fields UnitsInStock and ReorderLevel, 
-- where UnitsInStock is less than the ReorderLevel, ignoring the fields UnitsOnOrder and Discontinued.
-- Order the results by ProductID.
SELECT ProductID, ProductName, UnitsInStock, ReorderLevel
FROM products
WHERE UnitsInStock < ReorderLevel
ORDER BY ProductID;

-- 23. Products that need reordering, continued
-- Now we need to incorporate these fields—
-- UnitsInStock, UnitsOnOrder, ReorderLevel, Discontinued
-- — into our calculation. We’ll define “products 
-- that need reordering” with the following:
SELECT ProductID, ProductName, UnitsInStock, UnitsOnOrder, ReorderLevel, Discontinued
FROM products
WHERE UnitsInStock+ UnitsOnOrder <= ReorderLevel
AND Discontinued = 0
ORDER BY ProductID;

-- 24. Customer list by region
-- A salesperson for Northwind is going on a business trip
-- to visit customers, and would like to see 
-- a list of all customers, sorted by region, alphabetically.
-- However, he wants the customers with no region 
-- (null in the Region field) to be at the end, instead of at the top,
-- where you’d normally find the null values. 
-- Within the same region, companies should be sorted by CustomerID.
SELECT CustomerID, CompanyName, Region
FROM customers
ORDER BY IFNULL(Region,'zzz'), CustomerID;

-- 25. High freight charges
-- Some of the countries we ship to have very high freight charges.
-- We'd like to investigate some more shipping options for our customers,
-- to be able to offer them lower freight charges. 
-- Return the three ship countries with the
--  highest average freight overall, in descending order by average freight.
SELECT ShipCountry, ROUND(AVG(Freight),4) AverageFreight
FROM orders
GROUP BY ShipCountry
ORDER BY AverageFreight DESC
LIMIT 3;

-- 26, 27. High freight charges - 2015 (1995)
-- We're continuing on the question above on high freight charges.
-- Now, instead of using all the orders we have,
-- we only want to see orders from the year 2015(1995).
SELECT ShipCountry, ROUND(AVG(Freight),4) AverageFreight
FROM orders
WHERE 
-- YEAR(OrderDate) = 1995
 OrderDate between '1995-01-01 00:00:00' and '1995-12-31 23:59:00'
GROUP BY ShipCountry
ORDER BY AverageFreight DESC
LIMIT 3;

-- 28. High freight charges - last year
-- We're continuing to work on high freight charges. 
-- We now want to get the three ship countries with the highest average freight charges.
-- But instead of filtering for a particular year,
-- we want to use the last 12 months of order data, 
-- using as the end date the last OrderDate in Orders.
SELECT ShipCountry, ROUND(AVG(Freight),4) AverageFreight
FROM orders
WHERE OrderDate >= DATE_SUB((SELECT MAX(OrderDate) FROM orders), INTERVAL 1 YEAR)
GROUP BY ShipCountry
ORDER BY AverageFreight DESC
LIMIT 3;

-- 29. Inventory list
-- We're doing inventory, and need to show 
-- information like the below, for all orders. Sort by OrderID and Product ID.
SELECT e.EmployeeID, LastName, o. OrderID, ProductName, Quantity
FROM `order details` od
JOIN orders o ON o.orderID = od.orderID
JOIN products p ON p.ProductID = od.ProductID
JOIN employees e on e.EmployeeID = o.EmployeeID
ORDER BY o.OrderID, p.ProductID;

-- 30. Customers with no orders
-- There are some customers who have never actually placed an order.
-- Show these customers.
SELECT c.CustomerID AS Customers_CustomerID, o.customerID AS Orders_CustomerID
FROM orders o 
RIGHT JOIN customers c ON c.customerID = o.CustomerID
WHERE o.CustomerID IS NULL;

-- 31. Customers with no orders for EmployeeID 4
-- One employee (Margaret Peacock, EmployeeID 4) has placed the most orders.
-- However, there are some customers who've never placed an order with her. 
-- Show only those customers who have never placed an order with her.
SELECT DISTINCT c.customerID, temp.customerID
FROM orders o
RIGHT JOIN customers c ON o.customerID = c.customerID
LEFT JOIN (SELECT DISTINCT CustomerID FROM orders WHERE EmployeeID = 4) temp ON temp.CustomerID = c.CustomerID
WHERE temp.customerID IS NULL;


-- Advanced Problems
-- 32. High-value customers
-- We want to send all of our high-value customers a special VIP gift. 
-- We're defining high-value customers as those who've made at least 1 order
-- with a total value (not including the discount) equal to $10,000 or more.
-- We only want to consider orders made in the year 2016(1996).
SELECT c.CustomerID, c.CompanyName, o.OrderID, ROUND(SUM(od.UnitPrice * Quantity), 2) as TotalOrderAmout
FROM customers c
JOIN orders o ON o.CustomerID = c.CustomerID
JOIN `order details` od ON o.OrderId = od.OrderID
WHERE YEAR(o.OrderDate) = 1996
GROUP BY c.CustomerID, c.CompanyName, o.orderID
HAVING TotalOrderAmout > 9999;


-- 33. High-value customers - total orders
-- The manager has changed his mind. 
-- Instead of requiring that customers have at least one individual orders totaling $10,000 or more,
-- he wants to define high-value customers as those who have orders totaling $15,000 or more in 2016(1996).
-- How would you change the answer to the problem above?

SELECT c.CustomerID, c.CompanyName, ROUND(SUM(od.UnitPrice * Quantity), 2) as TotalOrderAmout
FROM customers c
JOIN orders o ON o.CustomerID = c.CustomerID
JOIN `order details` od ON o.OrderId = od.OrderID
WHERE YEAR(o.OrderDate) = 1996
GROUP BY c.CustomerID, c.CompanyName
HAVING TotalOrderAmout > 14999;
