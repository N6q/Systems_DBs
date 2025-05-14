CREATE DATABASE BankDB
USE BankDB;

---------------------------Table: BRANCH
CREATE TABLE BRANCH (
    Branch_ID NVARCHAR(20) PRIMARY KEY,
    Address NVARCHAR(100) NOT NULL,
    Phone NVARCHAR(15)
);

---------------------------Table: CUSTOMER
CREATE TABLE CUSTOMER (
    Customer_ID NVARCHAR(20) PRIMARY KEY,
    Name NVARCHAR(100) NOT NULL,
    Address NVARCHAR(100),
    Phone NVARCHAR(15),
    Date_Of_Birth DATE NOT NULL
);

---------------------------Table: ACCOUNT
CREATE TABLE ACCOUNT (
    Account_Number NVARCHAR(20) PRIMARY KEY,
    Customer_ID NVARCHAR(20) NOT NULL,
    Balance DECIMAL(15, 2) NOT NULL,
    Type NVARCHAR(10) CHECK (Type IN ('savings', 'checking')),
    Date_Of_Creation DATE NOT NULL,
    FOREIGN KEY (Customer_ID) REFERENCES CUSTOMER(Customer_ID)
);

---------------------------Table: TRANSACTION
CREATE TABLE TRANSACTIONS (
    Transaction_ID NVARCHAR(20) PRIMARY KEY,
    Account_Number NVARCHAR(20) NOT NULL,
    Date DATE NOT NULL,
    Amount DECIMAL(15, 2) NOT NULL,
    Type NVARCHAR(10) CHECK (Type IN ('withdrawal', 'deposit', 'transfer')),
    FOREIGN KEY (Account_Number) REFERENCES ACCOUNT(Account_Number)
);

---------------------------Table: EMPLOYEE
CREATE TABLE EMPLOYEE (
    Employee_ID NVARCHAR(20) PRIMARY KEY,
    Name NVARCHAR(100) NOT NULL,
    Position NVARCHAR(50),
    Branch_ID NVARCHAR(20) NOT NULL,
    FOREIGN KEY (Branch_ID) REFERENCES BRANCH(Branch_ID)
);

---------------------------Table: LOAN
CREATE TABLE LOAN (
    Loan_ID NVARCHAR(20) PRIMARY KEY,
    Customer_ID NVARCHAR(20) NOT NULL,
    Employee_ID NVARCHAR(20) NOT NULL,
    Type NVARCHAR(20) NOT NULL,
    Amount DECIMAL(15, 2) NOT NULL,
    Issue_Date DATE NOT NULL,
    FOREIGN KEY (Customer_ID) REFERENCES CUSTOMER(Customer_ID),
    FOREIGN KEY (Employee_ID) REFERENCES EMPLOYEE(Employee_ID)
);


---------------------------Table: EMPLOYEE_CUSTOMER_INTERACTION
CREATE TABLE EMPLOYEE_CUSTOMER_INTERACTION (
    Employee_ID NVARCHAR(20) NOT NULL,
    Customer_ID NVARCHAR(20) NOT NULL,
    Action_Type NVARCHAR(20) CHECK (Action_Type IN ('open_account', 'process_loan')),
    PRIMARY KEY (Employee_ID, Customer_ID, Action_Type),
    FOREIGN KEY (Employee_ID) REFERENCES EMPLOYEE(Employee_ID),
    FOREIGN KEY (Customer_ID) REFERENCES CUSTOMER(Customer_ID)
);
