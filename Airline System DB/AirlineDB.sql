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
