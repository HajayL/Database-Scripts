/*
USE master
GO

DROP DATABASE IF EXISTS hlawson5_Metro
GO

CREATE DATABASE hlawson5_Metro
GO
*/

USE hlawson5_Metro
GO

DROP TABLE IF EXISTS TripLeg
GO

DROP TABLE IF EXISTS Stations
DROP TABLE IF EXISTS TripPlans
DROP TABLE IF EXISTS TransitLines
GO

CREATE TABLE Stations(
	Station varchar(50) PRIMARY KEY,
	StreetAddress varchar(30) NOT NULL,
	City varchar(30) NOT NULL DEFAULT 'Edmonton',
	Province char(2) NOT NULL DEFAULT 'AB',
	PostalCode char(7) CHECK(LEFT(PostalCode, 4) LIKE '%[ ]')
)

CREATE TABLE TripPlans(
	TripPlanId int IDENTITY PRIMARY KEY,
	PlanGenerated DateTime NOT NULL DEFAULT GETDATE()
)

CREATE TABLE TransitLines(
	TransitLine varchar(50) PRIMARY KEY,
	IntervalMins int NOT NULL CHECK(IntervalMins > 0)
)
GO

CREATE TABLE TripLeg(
	TripPlanId int NOT NULL,
	TransitLine varchar(50) NOT NULL,

	StartStation varchar(50) NOT NULL,
	CONSTRAINT FK_StartStation FOREIGN KEY (StartStation) REFERENCES Stations(Station),

	FinishStation varchar(50) NOT NULL,
	CONSTRAINT FK_FinishStation FOREIGN KEY (FinishStation) REFERENCES Stations(Station),

	StartDeparture datetime NOT NULL,
	FinishArrival datetime NOT NULL,
	Duration AS DATEDIFF(MI, StartDeparture, FinishArrival)

	CONSTRAINT PK_TripPlan_TransitLine PRIMARY KEY (TripPlanId, TransitLine)
)
GO