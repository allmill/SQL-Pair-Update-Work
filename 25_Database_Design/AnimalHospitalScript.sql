USE master;

Go

DROP DATABASE IF EXISTS AnimalHospital;

CREATE DATABASE AnimalHospital;
Go

USE AnimalHospital;
Go

BEGIN Transaction;

CREATE TABLE Customer
(
	customerID int identity(1,1),
	first_name nvarchar(20)		not null,
	last_name nvarchar(50)		null,
	address int					null,
	phone varchar(15)			null,

	constraint pk_customers primary key(customerID)
)

CREATE TABLE PetType
(
	typeID int identity(1, 1),
	name nvarchar(20)

	constraint pk_type primary key(typeID)
)

CREATE TABLE Pet
(
	petID int identity(1, 1),
	name nvarchar(20),
	age int,
	typeID int,
	ownerID int

	constraint pk_pet primary key(petID),
	constraint fk_pet_type foreign key(typeID) references PetType (typeID),
	constraint fk_pet_customer foreign key(ownerID) references Customer (CustomerID)
)

CREATE TABLE customer_pets
(
	customerID int,
	petID int

	constraint fk_customer_pets_customer foreign key(customerID) references Customer (customerID),
	constraint fk_customer_pets_pet foreign key(petID) references Pet (petID)
)

CREATE TABLE Address 
(
	customerID int,
	addressID int identity(1, 1),
	streetaddress nvarchar(30),
	suiteaddress nvarchar(30),
	city nvarchar(20),
	state char(2),
	zipcode nvarchar(15)

	constraint fk_address_customer foreign key(customerID) references Customer (customerID)
	constraint pk_address primary key(AddressID)
)

CREATE TABLE AnimalProcedures
(
	procedureID int identity(1, 1),
	name nvarchar(30),
	cost int

	constraint pk_procedure primary key(procedureID)
)

CREATE TABLE Visits 
(
	visitID int identity(1, 1),
	customerID int,
	petID int,
	procedureID int,
	visitdate datetime

	constraint pk_visits primary key(visitID)
	constraint fk_visits_customer foreign key (customerID) references Customer (customerID),
	constraint fk_visits_pet foreign key (petID) references Pet (petID),
	constraint fk_visits_procedure foreign key(procedureID) references AnimalProcedures (procedureID)
)

CREATE TABLE Procedure_visits
(
	visitID int,
	procedureID int

	constraint fk_procedure_visits_procedure foreign key (procedureID) references AnimalProcedures (procedureID),
	constraint fk_procedure_visits_visits foreign key (visitID) references Visits (visitID)
)

CREATE TABLE Pet_Visits
(
	petID int,
	visitID int,
	date datetime

	constraint pet_visits_petID foreign key (petID) references Pet (petID),
	constraint pet_visits_visitID foreign key (visitID) references Visits (visitID)
)

