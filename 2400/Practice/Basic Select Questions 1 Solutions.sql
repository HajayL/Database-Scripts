-- Use Northwind Traders for these questions

USE Northwind
GO

-- Q1	- Return all customers who have a Fax

SELECT
	*

FROM Customers c
WHERE c.Fax IS NOT NULL

-- Q2	- Return all orders that have a shipping region and a ship postal code

SELECT
	*

FROM Orders o
WHERE ShipRegion IS NOT NULL AND ShipPostalCode IS NOT NULL

-- Q3	- Return all customer's who's contact names start with 'M'

SELECT
	*

FROM Customers c
WHERE ContactName LIKE 'M%'

-- Q4	- Return all the ages of Employees over 30

SELECT
	*,
	DATEDIFF(YEAR, BirthDate, GETDATE())

FROM Employees e
WHERE DATEDIFF(YEAR, BirthDate, GETDATE()) > 30

-- Q5	- Return the 5 youngest employees

SELECT TOP(5)
	*,
	DATEDIFF(YEAR, BirthDate, GETDATE())

FROM Employees e
ORDER BY DATEDIFF(YEAR, BirthDate, GETDATE())

-- Q5	- Return all customers in cities that start with 'p' or 'is'

SELECT
	*

FROM Customers c
WHERE c.City LIKE 'p%' OR c.City LIKE 'is%'

-- Q7	- Return all products that start with 'c' and end with 'e'

SELECT
	*

FROM Products p
WHERE p.ProductName LIKE 'c%e'

-- Q8	- Return all employees which's first name contains an 'a' or Last name is 'Pike'

SELECT
	*

FROM Employees e
WHERE e.FirstName LIKE '%a%' OR e.LastName = 'Pike'

-- Q9	- Return all employees in the format 'TitleofCourtesy LastName' example -> 'Ms. Johnson'

SELECT
	e.TitleOfCourtesy + ' ' + e.LastName
	
FROM Employees e

-- Q10	- Return all orders where the shipped date is at least 10 days after the required day, order by hours taken

SELECT
	*,
	DATEDIFF(DAY, RequiredDate, ShippedDate)

FROM Orders o
WHERE DATEDIFF(DAY, RequiredDate, ShippedDate) >= 10
ORDER BY DATEDIFF(HOUR, RequiredDate, ShippedDate)

-- Q11	- Return all customers with a postal code that respects that Canadian postal code system (has a space in the middle) example -> 'TTT 555'

SELECT
	*

FROM Customers c
WHERE RIGHT(c.PostalCode, 4) LIKE ' %'

-- Q12	- Return all orders that were made on this day, but with any year or month

SELECT
	*

FROM Orders o
WHERE DAY(o.OrderDate) = DAY(GETDATE())

-- Q13	- Create a variable that stores the city 'Seattle' use that variable to return all employees in that city

DECLARE @city char(7) = 'Seattle';

SELECT
	*

FROM Employees e
WHERE e.City = @city