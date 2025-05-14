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



-- Insert data into DEPARTMENT
INSERT INTO DEPARTMENT (Department_id, D_name) VALUES
(1, 'Computer Science'),
(2, 'Electrical Engineering');

-- Insert data into HOSTAL
INSERT INTO HOSTAL (Hostel_id, Hostel_name, No_of_seats, Pin_code, Address, City, State) VALUES
(1, 'Al-Dar A', 100, '110001', '123 ABC Street', 'Muscat', 'OMAN'),
(2, 'Al-Dar B', 150, '110002', '456 XYZ Road', 'Salalah', 'OMAN');

-- Insert data into STUDENT
INSERT INTO STUDENT (S_ID, F_name, L_name, DOB, Age, Phone_no, Hostel_id, Department_id) VALUES
(1, 'Mohammad', 'Al-Atibi', '2000-01-01', 21, '9876543210', 1, 1),
(2, 'Fatima', 'Al-Shamsi', '2001-05-10', 20, '9876543211', 2, 2);

-- Insert data into COURSE
INSERT INTO COURSE (Course_id, Course_name, Duration) VALUES
(1, 'Bachelor in Computer Science', 4),
(2, 'Bachelor in Electrical Engineering', 4);

-- Insert data into SUBJECT
INSERT INTO SUBJECT (Subject_id, Subject_name, Course_id) VALUES
(1, 'Data Structures', 1),
(2, 'Circuit Analysis', 2);

-- Insert data into EXAMS
INSERT INTO EXAMS (Exam_code, Date, Time, Room) VALUES
(101, '2025-05-01', '10:00:00', 'Room 101'),
(102, '2025-06-01', '14:00:00', 'Room 102');


ALTER TABLE FACULTY
ALTER COLUMN Mobile_no NVARCHAR(15);


-- Insert data into FACULTY
INSERT INTO FACULTY (F_ID, Name, Mobile_no, Department_id, Salary) VALUES
(1, 'Dr. Ali Bin Said', 98733201, 1, 80000),
(2, 'Dr. Youssef Bin Salem', 98763542, 2, 90000);

-- Insert data into TAKE (for student-exam relationships)
INSERT INTO TAKE (S_ID, Exam_code) VALUES
(1, 101),
(2, 102);



-- Insert data into TEACHES (for faculty-subject relationships)
INSERT INTO TEACHES (F_ID, Subject_id) VALUES
(1, 1),
(2, 2);

-- Insert data into ENROLL (ensure no duplicates)
INSERT INTO ENROLL (S_ID, Subject_id) 
SELECT 1, 1 WHERE NOT EXISTS (SELECT 1 FROM ENROLL WHERE S_ID = 1 AND Subject_id = 1);
INSERT INTO ENROLL (S_ID, Subject_id) 
SELECT 2, 2 WHERE NOT EXISTS (SELECT 1 FROM ENROLL WHERE S_ID = 2 AND Subject_id = 2);

-- Insert data into DEPARTMENT_HANDLES_COURSE (ensure no duplicates)
INSERT INTO Department_Handles_Course (Department_id, Course_id) 
SELECT 1, 1 WHERE NOT EXISTS (SELECT 1 FROM Department_Handles_Course WHERE Department_id = 1 AND Course_id = 1);
INSERT INTO Department_Handles_Course (Department_id, Course_id) 
SELECT 2, 2 WHERE NOT EXISTS (SELECT 1 FROM Department_Handles_Course WHERE Department_id = 2 AND Course_id = 2);

SELECT * FROM ENROLL;

SELECT * FROM Department_Handles_Course;