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
