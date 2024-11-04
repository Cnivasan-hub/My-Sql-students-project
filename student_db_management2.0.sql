/*

Here's a project idea that will help students apply key MySQL concepts while developing a small database application:

### **Project Title:** **Student Management System**

### **Objective:**
Create a database-driven application for managing student records, including student information, courses, grades, and attendance. The project will help students understand database design, querying, and basic CRUD operations (Create, Read, Update, Delete).

### **Project Overview:**
Students will design and implement a relational database to manage data for a fictional school or college. The database should include the following components:

1. **Students Table**:
   - `student_id` (Primary Key, Auto Increment)
   - `first_name`
   - `last_name`
   - `date_of_birth`
   - `gender`
   - `email`
   - `phone_number`
   - `address`

2. **Courses Table**:
   - `course_id` (Primary Key, Auto Increment)
   - `course_name`
   - `course_code`
   - `instructor_name`
   - `semester`

3. **Enrollments Table**:
   - `enrollment_id` (Primary Key, Auto Increment)
   - `student_id` (Foreign Key from Students)
   - `course_id` (Foreign Key from Courses)
   - `enrollment_date`

4. **Grades Table**:
   - `grade_id` (Primary Key, Auto Increment)
   - `enrollment_id` (Foreign Key from Enrollments)
   - `grade`

5. **Attendance Table**:
   - `attendance_id` (Primary Key, Auto Increment)
   - `enrollment_id` (Foreign Key from Enrollments)
   - `date`
   - `status` (Present/Absent)

### **Tasks:**

1. **Database Design**: 
   - Create an Entity-Relationship Diagram (ERD) to visualize the database schema.
   - Design tables with appropriate data types and constraints.

2. **Database Implementation**:
   - Create the database and tables in MySQL.
   - Insert sample data into each table.

3. **CRUD Operations**:
   - Write SQL queries to perform the following operations:
     - **Create**: Add new students, courses, and enrollments.
     - **Read**: Retrieve student details, course lists, and attendance records.
     - **Update**: Modify student information and grades.
     - **Delete**: Remove students, courses, or enrollment records.

4. **Advanced Queries**:
   - Retrieve a list of students enrolled in a specific course.
   - Calculate the average grade for a course.
   - Generate a report of students with perfect attendance.
   - List all courses a student is enrolled in for a particular semester.

5. **Reporting**:
   - Create a few reports using SQL that summarize important data, such as:
     - Total number of students enrolled in each course.
     - Percentage of students who passed/failed a course.
     - Attendance percentage for each student.

### **Extension (Optional):**
- Implement a basic user interface (UI) using a programming language like Python (using Tkinter) or PHP to interact with the database.
- Add user authentication to the system to allow access control.

### **Learning Outcomes:**
- Understanding of relational database design and normalization.
- Proficiency in writing SQL queries, including joins, subqueries, and aggregations.
- Practical experience in managing a database, including data entry, updating, and reporting.

This project will provide students with a hands-on experience in building and managing a MySQL database, which is essential for real-world applications.

*/

-- Create Database and Tables

-- Create Database
CREATE DATABASE StudentManagementSystem;

-- Use the Database
USE StudentManagementSystem;

-- Create Students Table
CREATE TABLE Students (
    student_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    date_of_birth DATE,
    gender ENUM('Male', 'Female', 'Other'),
    email VARCHAR(100),
    phone_number VARCHAR(15),
    address TEXT
);

-- Create Courses Table
CREATE TABLE Courses (
    course_id INT AUTO_INCREMENT PRIMARY KEY,
    course_name VARCHAR(100),
    course_code VARCHAR(10),
    instructor_name VARCHAR(100),
    semester VARCHAR(10)
);

-- Create Enrollments Table
CREATE TABLE Enrollments (
    enrollment_id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT,
    course_id INT,
    enrollment_date DATE,
    FOREIGN KEY (student_id) REFERENCES Students(student_id),
    FOREIGN KEY (course_id) REFERENCES Courses(course_id)
);

-- Create Grades Table
CREATE TABLE Grades (
    grade_id INT AUTO_INCREMENT PRIMARY KEY,
    enrollment_id INT,
    grade CHAR(2),
    FOREIGN KEY (enrollment_id) REFERENCES Enrollments(enrollment_id)
);

-- Create Attendance Table
CREATE TABLE Attendance (
    attendance_id INT AUTO_INCREMENT PRIMARY KEY,
    enrollment_id INT,
    date DATE,
    status ENUM('Present', 'Absent'),
    FOREIGN KEY (enrollment_id) REFERENCES Enrollments(enrollment_id)
);


-- Insert Sample Data

-- Insert into Students
INSERT INTO Students (first_name, last_name, date_of_birth, gender, email, phone_number, address)
VALUES
('John', 'Doe', '2000-01-15', 'Male', 'john.doe@example.com', '123-456-7890', '123 Elm St'),
('Jane', 'Smith', '2001-05-22', 'Female', 'jane.smith@example.com', '987-654-3210', '456 Oak St');

-- Insert into Courses
INSERT INTO Courses (course_name, course_code, instructor_name, semester)
VALUES
('Introduction to Programming', 'CS101', 'Dr. Brown', 'Fall 2024'),
('Data Structures', 'CS102', 'Prof. Green', 'Fall 2024');

-- Insert into Enrollments
INSERT INTO Enrollments (student_id, course_id, enrollment_date)
VALUES
(1, 1, '2024-08-15'),
(1, 2, '2024-08-15'),
(2, 1, '2024-08-16');

-- Insert into Grades
INSERT INTO Grades (enrollment_id, grade)
VALUES
(1, 'A'),
(2, 'B'),
(3, 'A');

-- Insert into Attendance
INSERT INTO Attendance (enrollment_id, date, status)
VALUES
(1, '2024-08-21', 'Present'),
(1, '2024-08-22', 'Absent'),
(2, '2024-08-21', 'Present'),
(3, '2024-08-21', 'Present');


#CRUD Operations Create: Already covered in the insert queries above. Read:

-- Retrieve all students
SELECT * FROM Students;

-- Retrieve all courses
SELECT * FROM Courses;

-- Retrieve students enrolled in a specific course
SELECT s.first_name, s.last_name, c.course_name
FROM Students s
JOIN Enrollments e ON s.student_id = e.student_id
JOIN Courses c ON e.course_id = c.course_id
WHERE c.course_name = 'Introduction to Programming';

-- Retrieve grades for a student
SELECT s.first_name, s.last_name, c.course_name, g.grade
FROM Students s
JOIN Enrollments e ON s.student_id = e.student_id
JOIN Courses c ON e.course_id = c.course_id
JOIN Grades g ON e.enrollment_id = g.enrollment_id
WHERE s.student_id = 1;

-- Update:

-- Update student information
UPDATE Students
SET email = 'new.email@example.com'
WHERE student_id = 1;

-- Update grade
UPDATE Grades
SET grade = 'A+'
WHERE grade_id = 1;

-- Delete:

-- Delete a student
DELETE FROM Students
WHERE student_id = 2;

-- Delete a course
DELETE FROM Courses
WHERE course_id = 2;


-- Advanced Queries

-- Retrieve a list of students enrolled in a specific course
SELECT s.first_name, s.last_name
FROM Students s
JOIN Enrollments e ON s.student_id = e.student_id
JOIN Courses c ON e.course_id = c.course_id
WHERE c.course_name = 'Introduction to Programming';

-- Calculate the average grade for a course
SELECT c.course_name, AVG(CASE 
    WHEN g.grade = 'A' THEN 4
    WHEN g.grade = 'B' THEN 3
    WHEN g.grade = 'C' THEN 2
    WHEN g.grade = 'D' THEN 1
    ELSE 0 END) AS average_grade
FROM Courses c
JOIN Enrollments e ON c.course_id = e.course_id
JOIN Grades g ON e.enrollment_id = g.enrollment_id
GROUP BY c.course_name;

-- Generate a report of students with perfect attendance
SELECT s.first_name, s.last_name
FROM Students s
JOIN Enrollments e ON s.student_id = e.student_id
JOIN Attendance a ON e.enrollment_id = a.enrollment_id
GROUP BY s.student_id
HAVING COUNT(CASE WHEN a.status = 'Absent' THEN 1 ELSE NULL END) = 0;

-- List all courses a student is enrolled in for a particular semester
SELECT c.course_name
FROM Courses c
JOIN Enrollments e ON c.course_id = e.course_id
JOIN Students s ON e.student_id = s.student_id
WHERE s.student_id = 1 AND c.semester = 'Fall 2024';
