CREATE DATABASE CompanyDB;

USE CompanyDB;

CREATE TABLE Employee
(
    Fname NVARCHAR(20) NOT NULL,
    Minit NVARCHAR(1),
    Lname NVARCHAR(20) NOT NULL,
    Ssn INT PRIMARY KEY IDENTITY (1,1) NOT NULL,
    Bdate DATE NOT NULL,
    Address NVARCHAR(50) NOT NULL,
    Sex NVARCHAR(6) CHECK (Sex = 'Male' OR Sex = 'Female') NOT NULL,
    Salary INT, 
    Super_ssn INT,
    FOREIGN KEY (Super_ssn) REFERENCES Employee(Ssn)
);

---------------------------------------------------------------------------
CREATE TABLE Department
(
    Dname NVARCHAR(20) NOT NULL,
    Dnumber INT PRIMARY KEY IDENTITY (1,1) NOT NULL,
    Mgr_ssn INT NOT NULL,
    Mgr_start_date DATE NOT NULL,
    FOREIGN KEY (Mgr_ssn) REFERENCES Employee(Ssn)
);

----------------------------------------------------------------------------
CREATE TABLE DEPT_LOCATION
(
    Dlocation NVARCHAR(20) NOT NULL,
    Dnumber INT NOT NULL,
    PRIMARY KEY (Dlocation, Dnumber),
    FOREIGN KEY (Dnumber) REFERENCES Department(Dnumber)
);

----------------------------------------------------------------------------
CREATE TABLE Project
(
    Pname NVARCHAR(20) NOT NULL,
    Pnumber INT PRIMARY KEY IDENTITY (1,1) NOT NULL,
    Plocation NVARCHAR(20) NOT NULL,
    Dnum INT NOT NULL,
    FOREIGN KEY (Dnum) REFERENCES Department(Dnumber)
);

----------------------------------------------------------------------------
CREATE TABLE Works_on
(
    Essn INT NOT NULL,
    Pno INT NOT NULL,
    Hours DECIMAL(5, 2) NOT NULL,
    PRIMARY KEY (Essn, Pno),
    FOREIGN KEY (Essn) REFERENCES Employee(Ssn),
    FOREIGN KEY (Pno) REFERENCES Project(Pnumber)
);

----------------------------------------------------------------------------
CREATE TABLE Dependent
(
    Essn INT NOT NULL,
    Dependent_name NVARCHAR(20) NOT NULL,
    Bdate DATE NOT NULL,
    Relationship NVARCHAR(20) NOT NULL,
    Sex NVARCHAR(6) CHECK (Sex = 'Male' OR Sex = 'Female') NOT NULL,
    PRIMARY KEY (Essn, Dependent_name),
    FOREIGN KEY (Essn) REFERENCES Employee(Ssn)
);

-- Insert data into Employee
INSERT INTO Employee (Fname, Minit, Lname, Bdate, Address, Sex, Salary, Super_ssn) VALUES
('John', 'A', 'Doe', '1980-06-15', '123 Main St', 'Male', 75000, NULL),
('Jane', 'B', 'Smith', '1985-08-20', '456 Oak Ave', 'Female', 85000, NULL),
('Michael', 'C', 'Johnson', '1990-03-10', '789 Pine Rd', 'Male', 55000, 1),
('Emily', 'D', 'Brown', '1995-11-05', '321 Maple Dr', 'Female', 65000, 1);

-- Insert data into Department
INSERT INTO Department (Dname, Mgr_ssn, Mgr_start_date) VALUES
('HR', 1, '2022-01-01'),
('IT', 2, '2023-03-15');

-- Insert data into DEPT_LOCATION
INSERT INTO DEPT_LOCATION (Dlocation, Dnumber) VALUES
('Head Office', 1),
('Branch Office', 2);

-- Insert data into Project
INSERT INTO Project (Pname, Plocation, Dnum) VALUES
('Project Alpha', 'New York', 1),
('Project Beta', 'Chicago', 2);

-- Insert data into Works_on
INSERT INTO Works_on (Essn, Pno, Hours) VALUES
(1, 1, 8.00),
(2, 1, 6.50),
(3, 2, 5.00);

-- Insert data into Dependent
INSERT INTO Dependent (Essn, Dependent_name, Bdate, Relationship, Sex) VALUES
(1, 'Anna', '2012-07-10', 'Daughter', 'Female'),
(2, 'James', '2010-09-15', 'Son', 'Male');
