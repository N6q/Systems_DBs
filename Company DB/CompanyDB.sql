CREATE DATABASE CompanyDB

USE CompanyDB;

CREATE TABLE Employee
(
Fname nvarchar(20) NOT NULL,
Minit nvarchar(20),
Lname nvarchar(20) NOT NULL,
Ssn int primary key identity (1,1) NOT NULL,
Bdate Date NOT NULL,
Address nvarchar(20) NOT NULL,
Sex nvarchar Check (Sex = 'Male' OR Sex = 'Female') NOT NULL,
Salary Int, 
Super_ssn int
);

 ALTER TABLE Employee 
 ADD FOREIGN KEY (Super_ssn) REFERENCES Employee(Ssn);

 ---------------------------------------------------------------------------
 CREATE TABLE Department
 (
 Dname nvarchar(20) NOT NULL,
Dnumber int primary key identity (1,1) NOT NULL,
Mgr_ssn int FOREIGN KEY (Mgr_ssn) REFERENCES Employee(Ssn) NOT NULL,
Mgr_start_date date NOT NULL
);


 ----------------------------------------------------------------------------
  CREATE TABLE DEPT_LOCATION
 (
 Dlocation nvarchar(20) NOT NULL,
Dnumber int FOREIGN KEY (Dnumber) REFERENCES Department(Dnumber) NOT NULL,

PRIMARY KEY (Dlocation, Dnumber)
);

----------------------------------------------------------------------------
CREATE TABLE Project
(
Pname nvarchar(20) NOT NULL,
Pnumber int primary key identity (1,1) NOT NULL,
Plocation nvarchar(20) NOT NULL,
Dnum int FOREIGN KEY (Dnum) REFERENCES Department(Dnumber) NOT NULL,

);

----------------------------------------------------------------------------
CREATE TABLE Works_on
(
Essn int FOREIGN KEY (Essn) REFERENCES Employee(Ssn) NOT NULL,
Pno int FOREIGN KEY (Pno) REFERENCES Project(Pnumber) NOT NULL,
Hours Time NOT NULL,

PRIMARY KEY (Essn, Pno)

);

--ALTER TABLE Works_on 
  --ALTER COLUMN Hours Time ;

  --DROP TABLE Works_on;
----------------------------------------------------------------------------

CREATE TABLE Dependent
(
Essn int FOREIGN KEY (Essn) REFERENCES Employee(Ssn) NOT NULL,
Dependent_name nvarchar(20) NOT NULL,
Bdate Date NOT NULL,
Relationship nvarchar(20) NOT NULL,
Sex nvarchar Check (Sex = 'Male' OR Sex = 'Female') NOT NULL,

PRIMARY KEY (Essn, Dependent_name)
);


