CREATE DATABASE DB;
GO

USE DB;
GO
CREATE SCHEMA ABC;
GO 
CREATE TABLE ABC.Companies 
(
	CRNNO int primary key ,
	CompanyName varchar(50) not null,


);
GO 

CREATE TABLE ABC.Managers 
(
	Id int primary key ,
	Email varchar(100) not null,


);

GO

CREATE TABLE ABC.Projects 
(
	PRJNO int primary key ,
	Title varchar(50) not null,
	ManagerId int foreign key references ABC.Managers(Id) not null,
	StartDate datetime2 not null,
	InitialCost decimal(18,2) not null ,
	Parked bit not null,
	CRNNO int not null ,
	foreign key (CRNNO) references ABC.Companies(CRNNO) ,


);

GO 

CREATE TABLE ABC.Technology(
	Id int NOT NULL,
	Name varchar (100) NOT NULL,
    PRIMARY KEY (Id))

GO


CREATE TABLE ABC.ProjectTechnology
(
	PRJNO int foreign key references ABC.Projects(PRJNO) ,
	TechnologyId  int foreign key references ABC.Technology(Id) not null,
	primary key (PRJNO , TechnologyId ),


);
GO