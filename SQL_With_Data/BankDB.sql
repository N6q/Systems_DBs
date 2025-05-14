
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

-- Branch Data
INSERT INTO BRANCH VALUES ('B003', '789 Birch St', '555-1122');
INSERT INTO BRANCH VALUES ('B004', '101 Cedar St', '555-3344');

-- Customer Data
INSERT INTO CUSTOMER VALUES ('C003', 'Michael Scott', '1725 Slough Ave', '555-5671', '1975-03-15');
INSERT INTO CUSTOMER VALUES ('C004', 'Pam Beesly', '1725 Slough Ave', '555-7890', '1980-06-25');
INSERT INTO CUSTOMER VALUES ('C005', 'Jim Halpert', '1725 Slough Ave', '555-3456', '1978-10-01');

-- Account Data
INSERT INTO ACCOUNT VALUES ('A003', 'C003', 7500.00, 'savings', '2025-05-12');
INSERT INTO ACCOUNT VALUES ('A004', 'C004', 2000.00, 'checking', '2025-05-12');
INSERT INTO ACCOUNT VALUES ('A005', 'C005', 1500.00, 'savings', '2025-05-12');



-- Employee Data
INSERT INTO EMPLOYEE VALUES ('E003', 'Dwight Schrute', 'Assistant Manager', 'B003');
INSERT INTO EMPLOYEE VALUES ('E004', 'Stanley Hudson', 'Salesman', 'B004');
INSERT INTO EMPLOYEE VALUES ('E005', 'Kevin Malone', 'Accountant', 'B004');

-- Transaction Data
INSERT INTO TRANSACTIONS VALUES ('T003', 'A003', '2025-05-13', 500.00, 'deposit');
INSERT INTO TRANSACTIONS VALUES ('T004', 'A004', '2025-05-13', 100.00, 'withdrawal');
INSERT INTO TRANSACTIONS VALUES ('T005', 'A005', '2025-05-13', 300.00, 'transfer');

-- Loan Data
INSERT INTO LOAN VALUES ('L003', 'C003', 'E003', 'Business', 30000.00, '2025-05-13');
INSERT INTO LOAN VALUES ('L004', 'C004', 'E004', 'Personal', 5000.00, '2025-05-13');
INSERT INTO LOAN VALUES ('L005', 'C005', 'E005', 'Education', 12000.00, '2025-05-13');

-- Employee-Customer Interaction Data
INSERT INTO EMPLOYEE_CUSTOMER_INTERACTION VALUES ('E003', 'C003', 'open_account');
INSERT INTO EMPLOYEE_CUSTOMER_INTERACTION VALUES ('E004', 'C004', 'process_loan');
INSERT INTO EMPLOYEE_CUSTOMER_INTERACTION VALUES ('E005', 'C005', 'open_account');

SELECT * FROM ACCOUNT;
SELECT * FROM BRANCH;
SELECT * FROM CUSTOMER;
SELECT * FROM EMPLOYEE;
SELECT * FROM EMPLOYEE_CUSTOMER_INTERACTION;
SELECT * FROM LOAN;
SELECT * FROM TRANSACTIONS;
