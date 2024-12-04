/*
	Fire all employees that sold beverages illegally
*/


DROP PROCEDURE IF EXISTS BeverageEmployees
GO

CREATE PROCEDURE BeverageEmployees
AS
	-- Find all employees that sold the product category

	-- Pick a remaining employee to inherit the departing employees' items

	-- Reassign orders, supervisory duties, territories to remaining chosen employee
	
	-- Delete the firable employees

	SELECT DISTINCT
		e.EmployeeID INTO #DepartingEmployees

	FROM
		Employees e INNER JOIN
		Orders o ON o.EmployeeID = e.EmployeeID INNER JOIN
		[Order Details] od ON od.OrderID = o.OrderID INNER JOIN
		Products p ON p.ProductID = od.ProductID INNER JOIN
		Categories c ON c.CategoryID = p.CategoryID

	WHERE
		c.CategoryName = 'Beverages'

	SELECT
		e.EmployeeID INTO #RemainingEmployees

	FROM
		Employees e

	EXCEPT
		
	SELECT
		EmployeeID

	FROM #DepartingEmployees

	DECLARE @luckyEmployee int

	SELECT TOP 1 @luckyEmployee = EmployeeId
	FROM #RemainingEmployees

	-- Did we get an employee?

	IF @@ROWCOUNT != 1
	BEGIN
		PRINT 'Did not find any remaining employees'
		RETURN -1
	END

	-- Reassign orders, supervisory duties, territories to remaining chosen employee
	BEGIN TRANSACTION

		BEGIN TRY
			UPDATE Orders
			SET EmployeeID = @luckyEmployee
			WHERE EmployeeID IN (SELECT EmployeeID FROM #DepartingEmployees)
		END TRY
		BEGIN CATCH
			PRINT 'Error updating orders'
			ROLLBACK
			RETURN -2
		END CATCH

		BEGIN TRY
			UPDATE Employees
			SET ReportsTo = @luckyEmployee
			WHERE ReportsTo IN (SELECT EmployeeID FROM #DepartingEmployees)
		END TRY
		BEGIN CATCH
			PRINT 'Error updating reports to'
			ROLLBACK
			RETURN -2
		END CATCH

		BEGIN TRY
			UPDATE EmployeeTerritories
			SET EmployeeID = @luckyEmployee
			WHERE EmployeeID IN (SELECT EmployeeID FROM #DepartingEmployees)
		END TRY
		BEGIN CATCH
			PRINT 'Error updating territories'
			ROLLBACK
			RETURN -2
		END CATCH

		-- Delete the firable employees
		BEGIN TRY
			DELETE Employees
			WHERE EmployeeID IN (SELECT EmployeeID FROM #DepartingEmployees)
		END TRY
		BEGIN CATCH
			PRINT 'Error deleting employees'
			ROLLBACK
			RETURN -2
		END CATCH

		-- Reached the point of no errors

		PRINT 'No errors'

		SELECT * FROM Employees

		ROLLBACK -- You want to commit here, just don't want to mess up the DB
		RETURN 0

GO

EXEC BeverageEmployees

