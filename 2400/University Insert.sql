USE hlawson5_University
GO

declare @StudentsID int
declare @CoursesID int
declare @instructorID int

INSERT Students(FirstName, LastName, DateOfBirth, Major)
VALUES('Hajay', 'Lawson', '2005-03-14', 'Computer Science')

set @StudentsID = @@IDENTITY

INSERT Courses(CourseName, Department, Credits)
VALUES('Databases', 'CNT', 3)

set @CoursesID = @@IDENTITY

INSERT Instructors(FirstName, LastName)
VALUES('Steven', 'Dytiuk')

set @instructorID = @@IDENTITY

INSERT Enrollments(StudentID, CourseID, InstructorID, Grade)
VALUES(@StudentsID, @CoursesID, @instructorID, 'B+')

SELECT *

FROM Students

SELECT *

FROM Courses

SELECT *

FROM Instructors

SELECT *

FROM Enrollments