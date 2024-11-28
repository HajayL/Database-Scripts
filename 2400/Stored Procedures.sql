-- Stored procedures
USE hlawson5_Northwind
GO

DROP PROCEDURE IF EXISTS NorthwindEmployees
GO

CREATE PROCEDURE NorthwindEmployees
	@lastName as varchar(50) = '%', -- With defaults
	@firstName as varchar(50) = '%'
as
	SELECT * FROM Employees e
	WHERE 
		e.LastName LIKE @lastName + '%' AND
		e.FirstName LIKE @firstName + '%'
GO

EXEC NorthwindEmployees 'd', 'n'

DROP PROCEDURE IF EXISTS NorthwindEmployees
GO

CREATE PROCEDURE NorthwindEmployees
	@lastName as varchar(50) = '%', -- With defaults
	@firstName as varchar(50) = '%'
as
	SELECT * FROM Employees e
	WHERE 
		e.LastName LIKE @lastName + '%' AND
		e.FirstName LIKE @firstName + '%'
GO

EXEC NorthwindEmployees @firstName = 'n' -- Direct assign


DROP PROCEDURE IF EXISTS MostConnectedEmployee
GO

CREATE PROCEDURE MostConnectedEmployee

AS

DECLARE @empID int

SELECT TOP 1
	@empID = e.EmployeeID

FROM
	Employees e INNER JOIN
	Orders o ON o.EmployeeID = e.EmployeeID INNER JOIN
	Customers c ON c.CustomerID = o.CustomerID

GROUP BY
	e.EmployeeID,
	e.FirstName,
	e.LastName

ORDER BY
	COUNT(DISTINCT c.CustomerID) DESC

	RETURN @empID -- Return value

GO

DECLARE @empID int
EXEC @empID = MostConnectedEmployee
SELECT @empID


DROP PROCEDURE IF EXISTS MostConnectedEmployee
GO

CREATE PROCEDURE MostConnectedEmployee

@empID int out,
@customerCount int out -- Out values

AS

SELECT TOP 1
	@empID = e.EmployeeID,
	@customerCount = COUNT(DISTINCT c.CustomerID)

FROM
	Employees e INNER JOIN
	Orders o ON o.EmployeeID = e.EmployeeID INNER JOIN
	Customers c ON c.CustomerID = o.CustomerID

GROUP BY
	e.EmployeeID,
	e.FirstName,
	e.LastName

ORDER BY
	COUNT(DISTINCT c.CustomerID) DESC

GO

DECLARE @empID int
DECLARE @cusCount int

EXEC MostConnectedEmployee @empID out, @cusCount out
SELECT @empID, @cusCount