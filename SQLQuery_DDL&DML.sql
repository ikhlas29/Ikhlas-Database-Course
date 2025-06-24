Create database CompanyDB

Use CompanyDB

--Employee--
Create table Employee (
     SSN int identity (1000,1) primary key, 
     First_name varchar(20) not null,
	 Last_name varchar(20),
	 Gender bit default 0,
	 Birthdate date,
	 Supervisor_ID int null,
	 Department_number int,
	 Foreign key (Supervisor_ID) References Employee(SSN)
	 )


-- Department --
Create table Department(
     Dpt_number int identity (1,1) primary key,
	 Dpt_name varchar (50),
	 Mgr_SSN int,
	 Mgr_hire_date date,
	 Foreign key (Mgr_SSN) References Employee(SSN)
	 )

-- Department Locations --
Create table Dpt_Locations(
     Dpt_number int,
	 Locations varchar (50),
	 Primary key (Dpt_number, Locations),
	 Foreign key (Dpt_number) References Department(Dpt_number)
	 )

-- Project --
Create table Project(
     Proj_number int identity (1,1) Primary key,
	 Proj_name varchar(50),
	 Proj_Location varchar(50),
	 City varchar(30),
	 Dpt_number int,
	 Foreign key (Dpt_number) References Department(Dpt_number)
	 )

-- Project-Work --
Create table Project_Work(
     Proj_number int,
	 SSN int,
	 Work_hours decimal (5,2),
	 PRIMARY KEY (SSN, Proj_number),
     Foreign key (SSN) References Employee(SSN),
     Foreign key (Proj_number) References Project(Proj_number)
	 )


-- Dependent --
Create table Dependent_tb(
     Dpn_name varchar (50),
	 Gender bit default 0,
	 Birthdate date,
	 SSN int,
	 Primary key (SSN, Dpn_name),
     Foreign key (SSN) REFERENCES Employee(SSN)
	 )


-- table alteration --
Alter table Employee
Add FOREIGN KEY (Department_number) REFERENCES Department(Dpt_number)

-- Project table alteration --
Alter table Project
ALTER Column Proj_name VARCHAR(50) not null;


----- Data ------

-- employees (managers)
Insert into Employee (First_name, Last_name, Gender, Birthdate, Supervisor_ID, Department_number)
Values
('Ikhlas', 'Al Khusaibi', 1, '1996-11-29', NULL, NULL),
('Said', 'Al Jabri', 0, '1985-07-22', NULL, NULL);

-- Department with managers--
Insert into Department (Dpt_name, Mgr_SSN, Mgr_hire_date)
Values
('Networking', 1000, '2020-01-01'),
('HR', 1001, '2021-06-15');

-- assign Ikhlas and Said to departments
Update Employee Set Department_number = 1 WHERE SSN = 1000;
Update Employee Set Department_number = 2 WHERE SSN = 1001;


-- Employees --
Insert into Employee (First_name, Last_name, Gender, Birthdate, Supervisor_ID, Department_number)
Values
('Maryam', 'AlBalushi', 0, '1992-03-10', 1000, 1),
('Fatma', 'AlHasani', 1, '1995-11-25', 1001, 2),
('Mohammed', 'ALShibli', 0, '1990-09-18', 1000, 1);

-- Department location --
Insert into Dpt_Locations (Dpt_number, Locations)
Values
(1, 'Main Office'),
(1, 'Data Center'),
(2, 'Admin Block');


-- Project --
Insert into Project (Proj_name, Proj_Location, City, Dpt_number)
Values
('Migration', 'HQ Floor 2', 'Muscat', 1),
('Recruitment System', 'Office A', 'Sohar', 2);


-- Employee and project --
Insert into Project_Work (Proj_number, SSN, Work_hours)
Values
(1, 1002, 20.50),  -- Maryam
(1, 1004, 15.00),  -- Fatma
(2, 1003, 25.75);  -- Mohammed


-- Dependent --
Insert into Dependent_tb (Dpn_name, Gender, Birthdate, SSN)
Values
('Danah', 0, '2014-06-10', 1002),   -- Maryam dependent
('Sara', 1, '2017-03-22', 1003);   -- Mohammed dependent


------ Display ------
-- Display all employees --
SELECT * FROM Employee

-- Update --
Update Employee
Set Last_name = 'Mohammed'
Where First_name = 'Said';


-- Display project --
SELECT * FROM Project

SELECT * FROM Project_Work

DELETE FROM Project_Work
WHERE SSN = 1004;