/*
USE master
GO

DROP DATABASE IF EXISTS hlawson5_University
GO

CREATE DATABASE hlawson5_University
GO
*/

USE hlawson5_University
GO

DROP TABLE IF EXISTS Enrollments
GO

DROP TABLE IF EXISTS Students
DROP TABLE IF EXISTS Courses
DROP TABLE IF EXISTS Instructors
GO

CREATE TABLE Students(
	StudentID int IDENTITY NOT NULL PRIMARY KEY,
	FirstName varchar(30) NOT NULL,
	LastName varchar(30) NOT NULL,

	DateOfBirth date NOT NULL CHECK(
		DATEDIFF(YEAR, DateOfBirth, GETDATE()) >= 18
	),

	Major char(16) NOT NULL CHECK(
		Major IN('Computer Science', 'Engineering', 'Business', 'Arts', 'Science')
	)
)

CREATE TABLE Courses(
	CourseID int IDENTITY NOT NULL PRIMARY KEY,
	CourseName varchar(30) NOT NULL,
	Department varchar(30) NOT NULL,
	Credits int NOT NULL CHECK(
		Credits BETWEEN 1 AND 6
	)
)

CREATE TABLE Instructors(
	InstructorID int IDENTITY NOT NULL PRIMARY KEY,
	FirstName varchar(30) NOT NULL,
	LastName varchar(30) NOT NULL
)

GO

CREATE TABLE Enrollments(
	EnrollmentID int IDENTITY NOT NULL PRIMARY KEY,
	StudentID int NOT NULL,
	CourseID int NOT NULL,
	InstructorID int NOT NULL,
	Grade char(2) NOT NULL CHECK(
		Grade LIKE '[A,B,C,D]%' AND (Grade LIKE '%[+,-]' OR RIGHT(Grade, 1) = '')
	)

	FOREIGN KEY (StudentID) REFERENCES Students(StudentID),
	FOREIGN KEY (CourseID) REFERENCES Courses(CourseID),
	FOREIGN KEY (InstructorID) REFERENCES Instructors(InstructorID),
)

GO