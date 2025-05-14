CREATE DATABASE University;
USE University

-----------------------Table: DEPARTMENT---------------------
CREATE TABLE DEPARTMENT (
    Department_id INT PRIMARY KEY,
    D_name NVARCHAR(50) NOT NULL
);

-----------------------Table: HOSTAL-------------------------
CREATE TABLE HOSTAL (
    Hostel_id INT PRIMARY KEY,
    Hostel_name NVARCHAR(50) NOT NULL,
    No_of_seats INT NOT NULL,
    Pin_code NVARCHAR(10) NOT NULL,
    Address NVARCHAR(100) NOT NULL,
    City NVARCHAR(50) NOT NULL,
    State NVARCHAR(50) NOT NULL
);

-----------------------Table: STUDENT
CREATE TABLE STUDENT (
    S_ID INT PRIMARY KEY,
    F_name NVARCHAR(50) NOT NULL,
    L_name NVARCHAR(50) NOT NULL,
    DOB DATE NOT NULL,
    Age INT NOT NULL,
    Phone_no NVARCHAR(15),
    Hostel_id INT,
    Department_id INT NOT NULL,
    FOREIGN KEY (Hostel_id) REFERENCES HOSTAL(Hostel_id),
    FOREIGN KEY (Department_id) REFERENCES DEPARTMENT(Department_id)
);

-----------------------Table: COURSE
CREATE TABLE COURSE (
    Course_id INT PRIMARY KEY,
    Course_name NVARCHAR(50) NOT NULL,
    Duration INT NOT NULL
);

-----------------------Table: SUBJECT
CREATE TABLE SUBJECT (
    Subject_id INT PRIMARY KEY,
    Subject_name NVARCHAR(50) NOT NULL,
    Course_id INT NOT NULL,
    FOREIGN KEY (Course_id) REFERENCES COURSE(Course_id)
);

-----------------------Table: EXAMS
CREATE TABLE EXAMS (
    Exam_code INT PRIMARY KEY,
    Date DATE NOT NULL,
    Time TIME NOT NULL,
    Room NVARCHAR(20) NOT NULL
);

-----------------------Table: FACULTY
CREATE TABLE FACULTY (
    F_ID INT PRIMARY KEY,
    Name NVARCHAR(50) NOT NULL,
    Mobile_no INT NOT NULL,
    Department_id INT NOT NULL,
    Salary DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (Department_id) REFERENCES DEPARTMENT(Department_id)
);

-----------------------Relationship: Live (Student - Hostel)
CREATE TABLE Live (
    S_ID INT,
    Hostel_id INT,
    PRIMARY KEY (S_ID, Hostel_id),
    FOREIGN KEY (S_ID) REFERENCES STUDENT(S_ID),
    FOREIGN KEY (Hostel_id) REFERENCES HOSTAL(Hostel_id)
);

-----------------------Relationship: Take (Student - Exams)
CREATE TABLE Take (
    S_ID INT,
    Exam_code INT,
    PRIMARY KEY (S_ID, Exam_code),
    FOREIGN KEY (S_ID) REFERENCES STUDENT(S_ID),
    FOREIGN KEY (Exam_code) REFERENCES EXAMS(Exam_code)
);

-----------------------Relationship: Enroll (Student - Subject)
CREATE TABLE Enroll (
    S_ID INT,
    Subject_id INT,
    PRIMARY KEY (S_ID, Subject_id),
    FOREIGN KEY (S_ID) REFERENCES STUDENT(S_ID),
    FOREIGN KEY (Subject_id) REFERENCES SUBJECT(Subject_id)
);

-----------------------Relationship: Teaches (Faculty - Subject)
CREATE TABLE Teaches (
    F_ID INT,
    Subject_id INT,
    PRIMARY KEY (F_ID, Subject_id),
    FOREIGN KEY (F_ID) REFERENCES FACULTY(F_ID),
    FOREIGN KEY (Subject_id) REFERENCES SUBJECT(Subject_id)
);

-----------------------Relationship: Handles (Faculty - Course)
CREATE TABLE Handles (
    F_ID INT,
    Course_id INT,
    PRIMARY KEY (F_ID, Course_id),
    FOREIGN KEY (F_ID) REFERENCES FACULTY(F_ID),
    FOREIGN KEY (Course_id) REFERENCES COURSE(Course_id)
);

-----------------------Relationship: Conducted_By (Exams - Department)
CREATE TABLE Conducted_By (
    Exam_code INT,
    Department_id INT,
    PRIMARY KEY (Exam_code, Department_id),
    FOREIGN KEY (Exam_code) REFERENCES EXAMS(Exam_code),
    FOREIGN KEY (Department_id) REFERENCES DEPARTMENT(Department_id)
);

-----------------------Relationship: Belong (Student - Department)
CREATE TABLE Belong (
    S_ID INT,
    Department_id INT,
    PRIMARY KEY (S_ID, Department_id),
    FOREIGN KEY (S_ID) REFERENCES STUDENT(S_ID),
    FOREIGN KEY (Department_id) REFERENCES DEPARTMENT(Department_id)
);

-----------------------Relationship: Handles (Department - Course)
CREATE TABLE Department_Handles_Course (
    Department_id INT,
    Course_id INT,
    PRIMARY KEY (Department_id, Course_id),
    FOREIGN KEY (Department_id) REFERENCES DEPARTMENT(Department_id),
    FOREIGN KEY (Course_id) REFERENCES COURSE(Course_id)
);

