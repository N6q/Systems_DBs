CREATE DATABASE HotelDB
USE HotelDB;


---------------------------Table: BRANCH
CREATE TABLE BRANCH (
    Branch_ID NVARCHAR(20) PRIMARY KEY,
    Name NVARCHAR(100) NOT NULL,
    Location NVARCHAR(100) NOT NULL
);

---------------------------Table: ROOM
CREATE TABLE ROOM (
    Room_Number INT NOT NULL,
    Branch_ID NVARCHAR(20) NOT NULL,
    Type NVARCHAR(50) NOT NULL,
    Nightly_Rate DECIMAL(10, 2) NOT NULL,
    PRIMARY KEY (Room_Number, Branch_ID),
    FOREIGN KEY (Branch_ID) REFERENCES BRANCH(Branch_ID)
);

---------------------------Table: CUSTOMER
CREATE TABLE CUSTOMER (
    Customer_ID NVARCHAR(20) PRIMARY KEY,
    Name NVARCHAR(100) NOT NULL,
    Phone NVARCHAR(15),
    Email NVARCHAR(100)
);

---------------------------Table: BOOKING
CREATE TABLE BOOKING (
    Booking_ID NVARCHAR(20) PRIMARY KEY,
    Customer_ID NVARCHAR(20) NOT NULL,
    Check_In_Date DATE NOT NULL,
    Check_Out_Date DATE NOT NULL,
    FOREIGN KEY (Customer_ID) REFERENCES CUSTOMER(Customer_ID)
);

---------------------------Table: BOOKING_ROOM
CREATE TABLE BOOKING_ROOM (
    Booking_ID NVARCHAR(20) NOT NULL,
    Room_Number INT NOT NULL,
    Branch_ID NVARCHAR(20) NOT NULL,
    PRIMARY KEY (Booking_ID, Room_Number, Branch_ID),
    FOREIGN KEY (Booking_ID) REFERENCES BOOKING(Booking_ID),
    FOREIGN KEY (Room_Number, Branch_ID) REFERENCES ROOM(Room_Number, Branch_ID)
);

---------------------------Table: STAFF
CREATE TABLE STAFF (
    Staff_ID NVARCHAR(20) PRIMARY KEY,
    Branch_ID NVARCHAR(20) NOT NULL,
    Name NVARCHAR(100) NOT NULL,
    Job_Title NVARCHAR(50) NOT NULL,
    Salary DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (Branch_ID) REFERENCES BRANCH(Branch_ID)
);

---------------------------Table: CHECK_IN_OUT
CREATE TABLE CHECK_IN_OUT (
    Staff_ID NVARCHAR(20) NOT NULL,
    Booking_ID NVARCHAR(20) NOT NULL,
    Action NVARCHAR(10) NOT NULL CHECK (Action IN ('check-in', 'check-out')),
    PRIMARY KEY (Staff_ID, Booking_ID),
    FOREIGN KEY (Staff_ID) REFERENCES STAFF(Staff_ID),
    FOREIGN KEY (Booking_ID) REFERENCES BOOKING(Booking_ID)
);


-- Insert data into BRANCH
INSERT INTO BRANCH (Branch_ID, Name, Location) VALUES
('B001', 'Grand Hotel', 'New York'),
('B002', 'Ocean View Resort', 'Miami');

-- Insert data into ROOM
INSERT INTO ROOM (Room_Number, Branch_ID, Type, Nightly_Rate) VALUES
(101, 'B001', 'Single', 150.00),
(102, 'B001', 'Double', 200.00),
(201, 'B002', 'Suite', 350.00);

-- Insert data into CUSTOMER
INSERT INTO CUSTOMER (Customer_ID, Name, Phone, Email) VALUES
('C001', 'John Doe', '123-456-7890', 'john.doe@example.com'),
('C002', 'Jane Smith', '987-654-3210', 'jane.smith@example.com');

-- Insert data into BOOKING
INSERT INTO BOOKING (Booking_ID, Customer_ID, Check_In_Date, Check_Out_Date) VALUES
('BKG001', 'C001', '2025-06-01', '2025-06-05'),
('BKG002', 'C002', '2025-07-10', '2025-07-15');

-- Insert data into BOOKING_ROOM
INSERT INTO BOOKING_ROOM (Booking_ID, Room_Number, Branch_ID) VALUES
('BKG001', 101, 'B001'),
('BKG001', 102, 'B001'),
('BKG002', 201, 'B002');

-- Insert data into STAFF
INSERT INTO STAFF (Staff_ID, Branch_ID, Name, Job_Title, Salary) VALUES
('S001', 'B001', 'Alice Johnson', 'Manager', 55000.00),
('S002', 'B002', 'Bob Williams', 'Receptionist', 35000.00);

-- Insert data into CHECK_IN_OUT
INSERT INTO CHECK_IN_OUT (Staff_ID, Booking_ID, Action) VALUES
('S001', 'BKG001', 'check-in'),
('S002', 'BKG002', 'check-out');
