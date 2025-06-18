create database SISD
--create a table students
CREATE TABLE Students (
    Student_Id INT IDENTITY(1,1) PRIMARY KEY,
    First_Name VARCHAR(50),
    Last_Name VARCHAR(50),
    Date_Of_Birth DATE,
    Email VARCHAR(100),
    Phone_Number VARCHAR(15)
);

--create table Teacher
CREATE TABLE Teacher(
Teacher_Id INT IDENTITY(1,1) PRIMARY KEY,
     First_Name VARCHAR(50) NOT NULL,
     Last_Name varchar(50) NOT NULL,
     Email VARCHAR(100) UNIQUE NOT NULL,
);

--crete table Courses
CREATE TABLE Courses(
Course_Id INT IDENTITY(1,1) PRIMARY KEY,
Course_name VARCHAR(100) NOT NULL,
Credits VARCHAR(50) NOT NULL,
Teacher_Id INT
FOREIGN KEY(teacher_id) References Teacher(Teacher_Id)
);

--create table Enrollments
CREATE TABLE Enrollments(
Enrollment_Id INT IDENTITY(1,1) PRIMARY KEY,
Student_Id INT NOT NULL,
Course_Id INT NOT NULL,
Enrollment_Date DATE NOT NULL,
FOREIGN KEY (Student_Id) References Students(Student_Id),
FOREIGN KEY (Course_Id) References Courses(Course_Id)
);

--create table payment
CREATE TABLE Payments(
Payment_Id INT IDENTITY(1,1) PRIMARY KEY,
   Student_Id INT NOT NULL,
   amount DECIMAL(10,2) CHECK (amount > 0),
   Payment_Date DATE NOT NULL,
   FOREIGN KEY (Student_Id) References Students(Student_Id)
);


drop table Students
drop table Enrollments
drop table Payments
drop table Courses 
drop table teacher



SELECT name FROM sys.tables;

INSERT INTO Students (First_Name, Last_Name, Date_Of_Birth, Email, Phone_Number) VALUES
('John', 'Doe', '2000-01-01', 'john@example.com', '9876543210'),
('Jane', 'Doe', '2000-02-02', 'jane@example.com', '8765432109'),
('Tom', 'Hanks', '2000-03-03', 'tom@example.com', '7654321098'),
('Sara', 'Ali', '2000-04-04', 'sara@example.com', '6543210987'),
('Mike', 'Tyson', '2000-05-05', 'mike@example.com', '5432109876'),
('Nina', 'Dobrev', '2000-06-06', 'nina@example.com', '4321098765'),
('Leo', 'Messi', '2000-07-07', 'leo@example.com', '3210987654'),
('Emma', 'Watson', '2000-08-08', 'emma@example.com', '2109876543'),
('Chris', 'Evans', '2000-09-09', 'chris@example.com', '1098765432'),
('Scarlett', 'Johansson', '2000-10-10', 'scarlett@example.com', '0987654321');

SELECT * FROM Students;

INSERT INTO Teacher (First_Name, Last_Name, Email) VALUES
('Tony', 'Stark', 'tony.stark@avengers.com'),
('Steve', 'Rogers', 'steve.rogers@avengers.com'),
('Bruce', 'Banner', 'bruce.banner@avengers.com'),
('Natasha', 'Romanoff', 'natasha.romanoff@avengers.com'),
('Clint', 'Barton', 'clint.barton@avengers.com'),
('Thor', 'Odinson', 'thor.odinson@avengers.com'),
('Peter', 'Parker', 'peter.parker@avengers.com'),
('Stephen', 'Strange', 'stephen.strange@avengers.com'),
('Wanda', 'Maximoff', 'wanda.maximoff@avengers.com'),
('Scott', 'Lang', 'scott.lang@avengers.com');

SELECT * FROM Teacher;

INSERT INTO Courses (Course_Name, Credits, Teacher_Id) VALUES
('Math 101', 3, 1),
('English 101', 4, 2),
('Physics 101', 3, 3),
('CS Basics', 4, 4),
('Algorithms', 3, 5),
('Data Structures', 4, 6),
('Databases', 3, 7),
('Digital Logic', 3, 8),
('Operating Systems', 4, 9),
('Networks', 3, 10);

SELECT * FROM Courses;


INSERT INTO Enrollments (Student_Id, Course_Id, Enrollment_Date) VALUES
(1, 1, '2024-01-10'),
(2, 2, '2024-01-11'),
(3, 3, '2024-01-12'),
(4, 4, '2024-01-13'),
(5, 5, '2024-01-14'),
(6, 6, '2024-01-15'),
(7, 7, '2024-01-16'),
(8, 8, '2024-01-17'),
(9, 9, '2024-01-18'),
(10, 10, '2024-01-19');

SELECT * FROM Enrollments;

INSERT INTO Payments (Student_Id, Amount, Payment_Date) VALUES
(1, 500.00, '2024-02-01'),
(2, 600.00, '2024-02-02'),
(3, 450.00, '2024-02-03'),
(4, 700.00, '2024-02-04'),
(5, 550.00, '2024-02-05'),
(6, 500.00, '2024-02-06'),
(7, 520.00, '2024-02-07'),
(8, 530.00, '2024-02-08'),
(9, 510.00, '2024-02-09'),
(10, 600.00, '2024-02-10');

SELECT * FROM Payments;


--TASK - 2

--1. Write an SQL query to insert a new student into the "Students" table with the following details:a. First Name: Johnb. Last Name: Doe c. Date of Birth: 1995-08-15 d. Email: john.doe@example.com e. Phone Number: 123456789

INSERT INTO Students (First_Name, Last_Name, Date_of_Birth, Email, Phone_Number)
VALUES ('John','Doe','1995-08-15','john.doe@example.com','1234567890');

SELECT * FROM Students;

SELECT * FROM Students
WHERE Email = 'john.doe@example.com';

--2. Write an SQL query to enroll a student in a course. Choose an existing student and course and insert a record into the "Enrollments" table with the enrollment date

INSERT INTO Enrollments(Student_Id, Course_Id, Enrollment_Date)
VALUES (2, 5, '2024-06-11');
--Jane enrolled in Algorithms on June 11, 2024 
SELECT * FROM Enrollments;

--3. Update the email address of a specific teacher in the "Teacher" table. Choose any teacher and modify their email address.

UPDATE Teacher
SET Email = 'iron.man@avengers.com'
WHERE First_Name = 'Tony' AND Last_Name = 'Stark';

SELECT * FROM Teacher;

--4.Write an SQL query to delete a specific enrollment record from the "Enrollments" table. Select an enrollment record based on the student and course

DELETE FROM Enrollments
WHERE Student_Id = 1 AND Course_Id = 1;

SELECT * FROM Enrollments

--5.Update the "Courses" table to assign a specific teacher to a course. Choose any course and teacher from the respective tables.

UPDATE Courses
SET Teacher_Id = 7
WHERE Course_Id = 6;

SELECT * FROM Courses;

--6. Delete a specific student from the "Students" table and remove all their enrollment records from the "Enrollments" table. Be sure to maintain referential integrity

DELETE FROM Enrollments WHERE Student_Id = 2;
DELETE FROM Payments WHERE Student_Id = 2;
DELETE FROM Students WHERE Student_Id = 2;

SELECT * FROM Students

--7. Update the payment amount for a specific payment record in the "Payments" table. Choose any payment record and modify the payment amount

UPDATE Payments
SET amount = 650.00
WHERE Payment_Id = 3;

SELECT *FROM Payments
WHERE Payment_Id = 3;

-- Task - 3
--Aggregate functions, Having, Order By, GroupBy and Joins

--1.Write an SQL query to calculate the total payments made by a specific student. You will need to join the "Payments" table with the "Students" table based on the student's ID

SELECT s.First_Name, s.Last_Name,
SUM(p.Amount) AS Total_Payments
FROM Students s
JOIN 
Payments p ON s.Student_Id  = p.Student_Id
WHERE 
s.First_Name = 'John' AND s.Last_Name = 'Doe'
GROUP BY
s.First_Name,s.Last_Name;

--2.Write an SQL query to retrieve a list of courses along with the count of students enrolled in each course. Use a JOIN operation between the "Courses" table and the "Enrollments" table.

SELECT c.Course_Name,
COUNT(e.Student_Id) AS Total_Students
FROM Courses c
JOIN 
Enrollments e ON c.Course_Id = e.Course_Id
GROUP BY c.Course_Name;

SELECT * FROM Enrollments
SELECT * FROM Courses


--3.Write an SQL query to find the names of students who have not enrolled in any course. Use a LEFT JOIN between the "Students" table and the "Enrollments" table to identify students without enrollments.

SELECT s.First_Name,s.Last_Name
FROM Students s
LEFT JOIN 
Enrollments e ON s.Student_Id = e.Student_Id
WHERE 
e.Enrollment_Id IS NULL;


Select *from students

--4.Write an SQL query to retrieve the first name, last name of students, and the names of the courses they are enrolled in. Use JOIN operations between the "Students" table and the "Enrollments" and "Courses" tables.

SELECT 
    s.First_Name,
    s.Last_Name,
    c.Course_Name
FROM Students s
JOIN 
Enrollments e ON s.Student_Id = e.Student_Id
JOIN 
Courses c ON e.Course_Id = c.Course_Id;

Select *from students
Select *from Courses
Select *from Enrollments


--5.Create a query to list the names of teachers and the courses they are assigned to. Join the "Teacher" table with the "Courses" table.

SELECT 
    t.First_Name,
    t.Last_Name,
    c.Course_Name
FROM  Teacher t
JOIN 
Courses c ON t.Teacher_Id = c.Teacher_Id;

Select * from Teacher
Select * from Courses

--6.Retrieve a list of students and their enrollment dates for a specific course. You'll need to join the "Students" table with the "Enrollments" and "Courses" tables

SELECT 
    s.First_Name,
    s.Last_Name,
    c.Course_Name,
    e.Enrollment_Date
FROM Students s
JOIN 
Enrollments e ON s.Student_Id = e.Student_Id
JOIN 
Courses c ON e.Course_Id = c.Course_Id
WHERE 
c.Course_Name = 'English 101';

 --7.Find the names of students who have not made any payments. Use a LEFT JOIN between the "Students" table and the "Payments" table and filter for students with NULL payment records

 SELECT 
    s.First_Name,
    s.Last_Name
FROM Students s
LEFT JOIN 
Payments p ON s.Student_Id = p.Student_Id
WHERE p.Payment_Id IS NULL;

--8.Write a query to identify courses that have no enrollments. You'll need to use a LEFT JOIN between the "Courses" table and the "Enrollments" table and filter for courses with NULL enrollment records.

SELECT c.Course_Name
FROM Courses c
LEFT JOIN 
Enrollments e ON c.Course_Id = e.Course_Id
WHERE 
e.Enrollment_Id IS NULL;

--9.Identify students who are enrolled in more than one course. Use a self-join on the "Enrollments" table to find students with multiple enrollment records

INSERT INTO Enrollments (Student_Id, Course_Id, Enrollment_Date)
VALUES (1, 3, '2024-07-11');

SELECT Student_Id, COUNT(Course_Id) AS Total_Courses
FROM Enrollments
GROUP BY Student_Id
HAVING COUNT(Course_Id) > 1;

SELECT * FROM Enrollments WHERE Student_Id = 1;

--10.Find teachers who are not assigned to any courses. Use a LEFT JOIN between the "Teacher" table and the "Courses" table and filter for teachers with NULL course assignments

SELECT 
    t.First_Name,
    t.Last_Name
FROM Teacher t
LEFT JOIN 
Courses c ON t.Teacher_Id = c.Teacher_Id
WHERE 
c.Course_Id IS NULL;

--Task 4. Subquery and its type:
--1. Write an SQL query to calculate the average number of students enrolled in each course. Use aggregate functions and subqueries to achieve this.

--Count students per course
SELECT Course_Id, COUNT(Student_Id) AS Enrolled_Count
FROM Enrollments
GROUP BY Course_Id;

--
SELECT 
    AVG(Enrolled_Count) AS Average_Enrollment
FROM (
    SELECT 
        Course_Id, COUNT(Student_Id) AS Enrolled_Count
    FROM 
        Enrollments
    GROUP BY 
        Course_Id
) AS CourseEnrollments;

--2.Identify the student(s) who made the highest payment. Use a subquery to find the maximum payment amount and then retrieve the student(s) associated with that amount

SELECT * FROM Students
SELECT * FROM Payments

SELECT 
    s.Student_Id,
    s.First_Name,
    s.Last_Name,
    p.Amount
FROM Payments p
JOIN
Students s ON s.Student_Id = p.Student_Id

WHERE p.Amount = (SELECT MAX(Amount) FROM Payments );

--3.Retrieve a list of courses with the highest number of enrollments. Use subqueries to find the course(s) with the maximum enrollment count

SELECT * FROM Courses
SELECT * FROM Enrollments

--counts enrollments per course 
SELECT Course_Id,
COUNT(Student_Id) AS Enrollment_Count 
FROM Enrollments
GROUP BY Course_Id
--find the maximum enrollment count
SELECT 
     MAX(Enrollment_Count)
FROM ( SELECT Course_Id, COUNT(Student_Id) AS Enrollment_Count
     FROM Enrollments
     GROUP BY Course_Id ) AS Course_Enrollments


SELECT c.Course_Id, c.Course_Name, Count(e.Student_Id) as Enrollment_Count
FROM Courses c
JOIN Enrollments e ON c.Course_Id = e.Course_Id
GROUP BY c.Course_Id, c.Course_Name
HAVING 
     COUNT(e.Student_Id) = (SELECT MAX(Enrollment_Count) 
     FROM (SELECT Course_Id, Count(Student_Id) AS Enrollment_Count
     FROM Enrollments
     GROUP BY Course_Id )AS Course_Enrollments); 
    
--4.Calculate the total payments made to courses taught by each teacher. Use subqueries to sum payments for each teacher's courses.

SELECT * FROM Enrollments
SELECT * FROM Courses
SELECT * FROM Teacher

SELECT 
    t.First_Name + ' ' + t.Last_Name AS Teacher_Name,
    ( SELECT SUM(p.Amount)
    FROM 
    Payments p
    WHERE 
    p.Student_Id IN (
    SELECT 
        e.Student_Id
    FROM 
        Enrollments e
    JOIN 
        Courses c ON e.Course_Id = c.Course_Id
     WHERE 
         c.Teacher_Id = t.Teacher_Id)
    ) AS Total_Payments
FROM 
    Teacher t;

--5.Identify students who are enrolled in all available courses. Use subqueries to compare a student's enrollments with the total number of courses

INSERT INTO Enrollments (Student_Id, Course_Id, Enrollment_Date)
SELECT 1, Course_Id, '2024-01-20'
FROM Courses;

SELECT 
    s.Student_Id,
    s.First_Name,
    s.Last_Name
FROM Students s
JOIN 
Enrollments e ON s.Student_Id = e.Student_Id
GROUP BY 
s.Student_Id, s.First_Name, s.Last_Name
HAVING 
COUNT(DISTINCT e.Course_Id) = (SELECT COUNT(*) FROM Courses);

--6. Retrieve the names of teachers who have not been assigned to any courses. Use subqueries to find teachers with no course assignments.

SELECT 
    First_Name, 
    Last_Name 
FROM Teacher
WHERE Teacher_Id NOT IN (
    SELECT DISTINCT Teacher_Id FROM Courses WHERE Teacher_Id IS NOT NULL
);

--7.. Calculate the average age of all students. Use subqueries to calculate the age of each student based on their date of birth.

SELECT 
    AVG(Age) AS Average_Age
FROM (
    SELECT 
        -- Calculate age by subtracting birth year from current year
        DATEDIFF(YEAR, Date_Of_Birth, GETDATE()) 
        -- Subtract 1 if birthday hasn't occurred yet this year
        - CASE 
            WHEN MONTH(Date_Of_Birth) > MONTH(GETDATE()) 
              OR (MONTH(Date_Of_Birth) = MONTH(GETDATE()) AND DAY(Date_Of_Birth) > DAY(GETDATE()))
            THEN 1 
            ELSE 0 
          END AS Age
    FROM Students
) AS AgeTable;

--8.Identify courses with no enrollments. Use subqueries to find courses without enrollment records.

SELECT Course_Id, Course_Name
FROM Courses
WHERE Course_Id NOT IN (
    SELECT DISTINCT Course_Id
    FROM Enrollments
);

--9.Calculate the total payments made by each student for each course they are enrolled in. Use subqueries and aggregate functions to sum payments

SELECT 
    S.Student_Id,
    S.First_Name + ' ' + S.Last_Name AS Student_Name,
    C.Course_Id,
    C.Course_Name,
    (
        SELECT SUM(P.Amount)
        FROM Payments P
        WHERE P.Student_Id = S.Student_Id
    ) AS Total_Payment
FROM Students S
JOIN Enrollments E ON S.Student_Id = E.Student_Id
JOIN Courses C ON E.Course_Id = C.Course_Id;


--10.Identify students who have made more than one payment. Use subqueries and aggregate functions to count payments per student and filter for those with counts greater than one.

INSERT INTO Payments (Student_Id, Amount, Payment_Date)
VALUES (3, 400.00, '2024-03-01');

SELECT * FROM Payments

SELECT 
    Student_Id,
    COUNT(*) AS Payment_Count
FROM Payments
GROUP BY Student_Id
HAVING COUNT(*) > 1;

--11.. Write an SQL query to calculate the total payments made by each student. Join the "Students" table with the "Payments" table and use GROUP BY to calculate the sum of payments for each student.

SELECT 
    S.Student_Id,
    S.First_Name,
    S.Last_Name,
    SUM(P.Amount) AS Total_Payment
FROM 
Students S
JOIN 
Payments P ON S.Student_Id = P.Student_Id
GROUP BY S.Student_Id, S.First_Name, S.Last_Name;

--12.Retrieve a list of course names along with the count of students enrolled in each course. Use JOIN operations between the "Courses" table and the "Enrollments" table and GROUP BY to count enrollments.

SELECT 
    C.Course_Name,
    COUNT(E.Student_Id) AS Enrollment_Count
FROM Courses C
LEFT JOIN 
Enrollments E ON C.Course_Id = E.Course_Id
GROUP BY C.Course_Name;

--13.Calculate the average payment amount made by students. Use JOIN operations between the "Students" table and the "Payments" table and GROUP BY to calculate the average.

SELECT 
    S.Student_Id,
    S.First_Name,
    S.Last_Name,
    AVG(P.Amount) AS Average_Payment
FROM Students S
JOIN 
Payments P ON S.Student_Id = P.Student_Id
GROUP BY S.Student_Id, S.First_Name, S.Last_Name;

