CREATE DATABASE AirlineDB;
USE AirlineDB;

---------------------------Table: AIRPLANE_TYPE
CREATE TABLE AIRPLANE_TYPE (
    typeName NVARCHAR(50) PRIMARY KEY,
    max_seats INT NOT NULL,
    company NVARCHAR(50) NOT NULL
);

---------------------------Table: AIRPLANE
CREATE TABLE AIRPLANE (
    airplane_id NVARCHAR(20) PRIMARY KEY,
    typeName NVARCHAR(50) NOT NULL,
    total_number_of_seats INT NOT NULL,
    FOREIGN KEY (typeName) REFERENCES AIRPLANE_TYPE(typeName)
);

---------------------------Table: AIRPORT
CREATE TABLE AIRPORT (
    airport_code NVARCHAR(10) PRIMARY KEY,
    name NVARCHAR(50) NOT NULL,
    city NVARCHAR(50) NOT NULL,
    state NVARCHAR(50) NOT NULL
);

---------------------------Table: FLIGHT
CREATE TABLE FLIGHT (
    flight_no NVARCHAR(20) PRIMARY KEY,
    airline NVARCHAR(50) NOT NULL,
    weekdays NVARCHAR(20) NOT NULL,
    restrictions NVARCHAR(100)
);

---------------------------Table: FLIGHT_LEG
CREATE TABLE FLIGHT_LEG (
    leg_no NVARCHAR(20) PRIMARY KEY,
    flight_no NVARCHAR(20) NOT NULL,
    scheduled_dep_time TIME NOT NULL,
    scheduled_arr_time TIME NOT NULL,
    departure_airport NVARCHAR(10) NOT NULL,
    arrival_airport NVARCHAR(10) NOT NULL,
    FOREIGN KEY (flight_no) REFERENCES FLIGHT(flight_no),
    FOREIGN KEY (departure_airport) REFERENCES AIRPORT(airport_code),
    FOREIGN KEY (arrival_airport) REFERENCES AIRPORT(airport_code)
);

---------------------------Table: LEG_INSTANCE
CREATE TABLE LEG_INSTANCE (
    leg_no NVARCHAR(20) NOT NULL,
    date DATE NOT NULL,
    actual_dep_time TIME,
    actual_arr_time TIME,
    num_available_seats INT NOT NULL,
    PRIMARY KEY (leg_no, date),
    FOREIGN KEY (leg_no) REFERENCES FLIGHT_LEG(leg_no)
);

---------------------------Table: FARE
CREATE TABLE FARE (
    code NVARCHAR(20) PRIMARY KEY,
    flight_no NVARCHAR(20) NOT NULL,
    amount DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (flight_no) REFERENCES FLIGHT(flight_no)
);

---------------------------Table: SEAT
CREATE TABLE SEAT (
    airplane_id NVARCHAR(20) NOT NULL,
    seat_number NVARCHAR(5) NOT NULL,
    PRIMARY KEY (airplane_id, seat_number),
    FOREIGN KEY (airplane_id) REFERENCES AIRPLANE(airplane_id)
);

---------------------------Table: CUSTOMER
CREATE TABLE CUSTOMER (
    customer_id NVARCHAR(20) PRIMARY KEY,
    name NVARCHAR(50) NOT NULL,
    phone NVARCHAR(15)
);


---------------------------Relationship: Reservation (Customer - Seat - Leg Instance)
CREATE TABLE RESERVATION (
    reservation_id NVARCHAR(20) PRIMARY KEY,
    customer_id NVARCHAR(20) NOT NULL,
    leg_no NVARCHAR(20) NOT NULL,
    date DATE NOT NULL,
    airplane_id NVARCHAR(20) NOT NULL,
    seat_number NVARCHAR(5) NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES CUSTOMER(customer_id),
    FOREIGN KEY (leg_no, date) REFERENCES LEG_INSTANCE(leg_no, date),
    FOREIGN KEY (airplane_id, seat_number) REFERENCES SEAT(airplane_id, seat_number)
);

-- Insert data into AIRPLANE_TYPE
INSERT INTO AIRPLANE_TYPE (typeName, max_seats, company) VALUES
('Boeing 737', 180, 'Boeing'),
('Airbus A320', 160, 'Airbus'),
('Boeing 777', 350, 'Boeing'),
('Embraer E190', 100, 'Embraer');

-- Insert data into AIRPLANE
INSERT INTO AIRPLANE (airplane_id, typeName, total_number_of_seats) VALUES
('AP1001', 'Boeing 737', 180),
('AP1002', 'Airbus A320', 160),
('AP1003', 'Boeing 777', 350),
('AP1004', 'Embraer E190', 100);

-- Insert data into AIRPORT
INSERT INTO AIRPORT (airport_code, name, city, state) VALUES
('JFK', 'John F. Kennedy International', 'New York', 'NY'),
('LAX', 'Los Angeles International', 'Los Angeles', 'CA'),
('ORD', 'OHare International', 'Chicago', 'IL'),
('MIA', 'Miami International', 'Miami', 'FL');

-- Insert data into FLIGHT
INSERT INTO FLIGHT (flight_no, airline, weekdays, restrictions) VALUES
('FL100', 'Delta Airlines', 'Mon, Wed, Fri', 'No pets allowed'),
('FL101', 'American Airlines', 'Tue, Thu, Sat', 'No carry-on over 10kg'),
('FL102', 'United Airlines', 'Mon, Fri, Sun', 'Economy seats only'),
('FL103', 'JetBlue', 'Wed, Sat', 'Business class only');

-- Insert data into FLIGHT_LEG
INSERT INTO FLIGHT_LEG (leg_no, flight_no, scheduled_dep_time, scheduled_arr_time, departure_airport, arrival_airport) VALUES
('LEG1001', 'FL100', '08:00:00', '10:30:00', 'JFK', 'LAX'),
('LEG1002', 'FL100', '12:00:00', '14:30:00', 'LAX', 'ORD'),
('LEG1003', 'FL101', '09:00:00', '11:15:00', 'ORD', 'MIA'),
('LEG1004', 'FL102', '13:30:00', '16:00:00', 'MIA', 'JFK');

-- Insert data into LEG_INSTANCE
INSERT INTO LEG_INSTANCE (leg_no, date, actual_dep_time, actual_arr_time, num_available_seats) VALUES
('LEG1001', '2025-05-20', '08:05:00', '10:25:00', 100),
('LEG1002', '2025-05-20', NULL, NULL, 150),
('LEG1003', '2025-05-21', '09:10:00', '11:20:00', 80),
('LEG1004', '2025-05-21', '13:35:00', '15:55:00', 50);

-- Insert data into FARE
INSERT INTO FARE (code, flight_no, amount) VALUES
('F1001', 'FL100', 250.00),
('F1002', 'FL101', 180.00),
('F1003', 'FL102', 220.00),
('F1004', 'FL103', 300.00);

-- Insert data into SEAT
INSERT INTO SEAT (airplane_id, seat_number) VALUES
('AP1001', '1A'),
('AP1001', '1B'),
('AP1002', '2A'),
('AP1002', '2B'),
('AP1003', '3A'),
('AP1003', '3B');

-- Insert data into CUSTOMER
INSERT INTO CUSTOMER (customer_id, name, phone) VALUES
('C1001', 'John Doe', '555-1234'),
('C1002', 'Jane Smith', '555-5678'),
('C1003', 'Michael Johnson', '555-8765');

-- Insert data into RESERVATION
INSERT INTO RESERVATION (reservation_id, customer_id, leg_no, date, airplane_id, seat_number) VALUES
('R1001', 'C1001', 'LEG1001', '2025-05-20', 'AP1001', '1A'),
('R1002', 'C1002', 'LEG1002', '2025-05-20', 'AP1001', '1B'),
('R1003', 'C1003', 'LEG1003', '2025-05-21', 'AP1002', '2A');
