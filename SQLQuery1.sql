USE Northwind
GO

 --QUESTION 4

--Find all orders that took more than 2 days to ship after the order date, showing the number of days, Order ID, Order date, Customer ID and Country, where total sale value is greater than 10000


SELECT O.OrderID, o.CustomerID, o.OrderDate, o.ShippedDate, o.ShipCountry,
DATEDIFF(DAY, OrderDate, ShippedDate) AS Duration_to_Ship,
SUM(od.Quantity * od.UnitPrice) AS [Total Sale Amount]
FROM
Orders o
INNER JOIN
[Order Details] od
ON o.OrderID = od.OrderID
WHERE
DATEDIFF(DAY, OrderDate, ShippedDate) >  2
GROUP BY o.OrderID, CustomerID, OrderDate, ShippedDate, ShipCountry
HAVING SUM(od.Quantity * od.UnitPrice) > 10000
ORDER BY DATEDIFF(DAY, OrderDate, ShippedDate) DESC


 SELECT productid, ProductName,
 CASE
 WHEN (UnitsInStock < UnitsOnOrder and Discontinued = 0)
 THEN 'Negative Inventory - Order Now!'
 WHEN ((UnitsInStock - UnitsOnOrder) < ReorderLevel and Discontinued =0) 
 THEN 'Reorder Level Reached - Place Order'
 WHEN (Discontinued = 1)
 THEN '****Discontinued****'
 ELSE 'In Stock' 
 END AS [Stock Status]
 FROM products


 --QUESTION 6
 Find the number of Orders by product in 2017

 SELECT p.ProductName,COUNT(o.orderid) AS [Number of Orders]
 FROM Products p
 LEFT JOIN [Order Details] AS od
 ON p.ProductID = od.ProductID
 LEFT JOIN Orders o
 ON o.OrderID = od.OrderID
 WHERE YEAR(o.OrderDate) = '2017'
 group by p.ProductName
 ORDER BY COUNT(o.orderid) DESC
 From Orders


 DATA ANALYSIS(EMPLOYEES AND STAFF)
 --TASK 1 : FIND THE EMPLOYEES THAT ACHIEVED HIGHEST SALES VOLUMES AND THEIR BONUS
 --TASK 2: FIND THE NUMBER OF EMPLOYEES PER TITLE FOR EACH CITY
 --TASK 3: LIST THE COMPANYS EMPLOYEES AND THEIR WORK DURATION IN EACH CITY YEARS
-- TASK 4: FIND THE EMPLOYEES OLDER THAN 70 YEARS OLD


--TASK 1
--FIND THE EMPLOYEES THAT ACHIEVED THE TOP 3 HIGHEST SALES VOLUME, 
--THEIR SALE VOLUMES, CITIES AND BONUS(0.02 of their total sale) 
--for January(2018). Concatenate first and last names of employees.

SELECT TOP 3 e.FirstName + ' ' + e.LastName AS [Full Name], e.City,
SUM(od.Quantity * od.UnitPrice) as [Total Sale],
ROUND(SUM(od.Quantity * od.UnitPrice)* .02, 0) AS [Bonus]
FROM
Employees e
INNER JOIN
Orders o
ON e.EmployeeID = o.EmployeeID
INNER JOIN
[Order Details] od
ON O.OrderID = od.OrderID
WHERE YEAR(o.OrderDate) = '2018' AND MONTH(o.OrderDate) = '1'
GROUP BY e.FirstName + ' ' + e.LastName, e.City
ORDER BY [Total Sale] DESC



FIND THE NUMBER OF EMPLOYEES IN EACH POSITION FOR EACH CITY

SELECT Title, City, COUNT(Title) AS [Number of Employees] FROM Employees
GROUP BY Title, City

TASK 3
SELECT LastName, FirstName, Title, DATEDIFF(YEAR, HireDate, GETDATE()) as [Work Duration]
FROM Employees
--WHERE City = 'London'

TASK 4:
Find the employees and their ages for those older than 70 years old in every city

SELECT FirstName, LastName, Title,DATEDIFF(YEAR, BirthDate, GETDATE()) AS [Age]
FROM Employees
WHERE DATEDIFF(YEAR, BirthDate, GETDATE()) >=70