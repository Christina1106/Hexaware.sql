CREATE Database CareerHub
--create table Companies 
CREATE TABLE Companies (
    CompanyID INT IDENTITY(1,1) PRIMARY KEY,
    CompanyName VARCHAR(100) NOT NULL,
    Location VARCHAR(100) NOT NULL
);
drop table Companies
--create table Jobs 
CREATE TABLE Jobs (
    JobID INT PRIMARY KEY IDENTITY(1,1),
    CompanyID INT,
    JobTitle VARCHAR(100) NOT NULL,
    JobDescription TEXT,
    JobLocation VARCHAR(100) NOT NULL,
    Salary DECIMAL(10, 2),
    JobType VARCHAR(50),
    PostedDate DATETIME NOT NULL,
    FOREIGN KEY (CompanyID) REFERENCES Companies(CompanyID)
);
--create table Applicants

CREATE TABLE Applicants (
    ApplicantID INT PRIMARY KEY IDENTITY(1,1),
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Email VARCHAR(100) UNIQUE NOT NULL,
    Phone VARCHAR(20),
    Resume TEXT
);

--create table Application
CREATE TABLE Applications (
    ApplicationID INT PRIMARY KEY IDENTITY(1,1),
    JobID INT,
    ApplicantID INT,
    ApplicationDate DATETIME NOT NULL,
    CoverLetter TEXT,
    FOREIGN KEY (JobID) REFERENCES Jobs(JobID),
    FOREIGN KEY (ApplicantID) REFERENCES Applicants(ApplicantID)
);
drop table Applications

-- Insert into companies
INSERT INTO Companies (CompanyName, Location) VALUES 
('Hexaware Technologies', 'Chennai'),
('TCS', 'Mumbai'),
('Infosys', 'Bangalore'),
('Accenture', 'Chennai');
 SELECT * FROM Companies

 --Insert into jobs
INSERT INTO Jobs (CompanyID, JobTitle, JobDescription, JobLocation, Salary, JobType, PostedDate) VALUES
(1, 'Software Developer', 'Develop and maintain web applications.', 'Chennai', 600000.00, 'Full-time', '2025-06-17 10:00:00'),
(2, 'Business Analyst', 'Analyze business requirements and data.', 'Mumbai', 500000.00, 'Full-time', '2025-06-16 09:30:00'),
(3, 'System Engineer', 'Support system infrastructure and maintenance.', 'Bangalore', 550000.00, 'Contract', '2025-06-15 11:00:00'),
(4, 'Cloud Engineer', 'Responsible for deploying and managing cloud infrastructure.', 'Chennai', 700000.00, 'Full-time', '2025-06-17 15:30:00');
SELECT * FROM Jobs

--Insert into Applicants
INSERT INTO Applicants (FirstName, LastName, Email, Phone, Resume) VALUES 
('Anjali', 'Raj', 'anjali.rajgmail.com', '9876543210', 'Experienced Java developer with Spring Boot knowledge.'),
('Ravi', 'Kumar', 'ravi.kumar@gmail.com', '9123456780', 'B.Tech graduate with strong SQL and Python skills.'),
('Sneha', 'Patel', 'sneha.patel@gmail.com', '9012345678', 'Front-end developer proficient in HTML, CSS, and JavaScript.'),
('Christina','Abiksha','chris.tina@gmail.com', '8610342765','Back-end developer with strong SQL and Java skills.');
SELECT * FROM Applicants

--Insert into Applications 
INSERT INTO Applications (JobID, ApplicantID, ApplicationDate, CoverLetter) VALUES 
(1, 1, '2025-06-17', 'I am very interested in the Software Developer position.'),
(2, 2, '2025-06-17', 'Please consider me for the Business Analyst role.'),
(3, 3, '2025-06-17', 'Eager to join as a System Engineer and contribute.'),
(4, 4, '2025-06-17', 'I am excited to apply for the Cloud Engineer role at Accenture. My backend and cloud skills align well with the job requirements.');
 
 SELECT * FROM Applications


--1. Provide a SQL script that initializes the database for the Job Board scenario “CareerHub”. 
--2. Create tables for Companies, Jobs, Applicants and Applications. 
--3. Define appropriate primary keys, foreign keys, and constraints. 
--4. Ensure the script handles potential errors, such as if the database or tables already exist.


--5. Write an SQL query to count the number of applications received for each job listing in the "Jobs" table. Display the job title and the corresponding application count. Ensure that it lists all jobs, even if they have no applications.
SELECT  J.JobTitle,
     COUNT(A.ApplicationID) AS ApplicationCount
FROM Jobs J
JOIN 
Applications A ON J.JobID = A.JobID
GROUP BY J.JobTitle;

--6. Develop an SQL query that retrieves job listings from the "Jobs" table within a specified salary range. Allow parameters for the minimum and maximum salary values. Display the job title, company name, location, and salary for each matching job.
DECLARE @MinSalary DECIMAL(10,2) = 500000.00;
DECLARE @MaxSalary DECIMAL(10,2) = 650000.00;

SELECT 
    J.JobTitle,
    C.CompanyName,
    C.Location,
    J.Salary
FROM Jobs J
JOIN 
Companies C ON J.CompanyID = C.CompanyID
WHERE 
J.Salary BETWEEN @MinSalary AND @MaxSalary;

--7. Write an SQL query that retrieves the job application history for a specific applicant. Allow a parameter for the ApplicantID, and return a result set with the job titles, company names, and application dates for all the jobs the applicant has applied to.

DECLARE @ApplicantID INT = 2; 
SELECT 
    J.JobTitle,
    C.CompanyName,
    A.ApplicationDate
FROM 
Applications A
JOIN 
Jobs J ON A.JobID = J.JobID
JOIN 
Companies C ON J.CompanyID = C.CompanyID
WHERE A.ApplicantID = @ApplicantID;


--8. Create an SQL query that calculates and displays the average salary offered by all companies for job listings in the "Jobs" table. Ensure that the query filters out jobs with a salary of zero.
SELECT 
    AVG(Salary) AS AverageSalary
FROM Jobs
WHERE Salary > 0;

--9. Write an SQL query to identify the company that has posted the most job listings. Display the company name along with the count of job listings they have posted. Handle ties if multiple companies have the same maximum count.

WITH JobCounts AS ( SELECT C.CompanyName,
    COUNT(J.JobID) AS JobCount
    FROM Jobs J
    JOIN 
    Companies C ON J.CompanyID = C.CompanyID
    GROUP BY  C.CompanyName
)
SELECT 
    CompanyName,
    JobCount
FROM (SELECT CompanyName,JobCount,
    DENSE_RANK() OVER (ORDER BY JobCount DESC) AS Rnk
    FROM JobCounts) AS Ranked
WHERE Rnk = 1;


--10. Find the applicants who have applied for positions in companies located in 'CityX' and have at least 3 years of experience.

SELECT 
    A.ApplicantID,
    A.FirstName,
    A.LastName,
    A.ExperienceYears,
    C.CompanyName,
    C.Location AS CompanyCity,
    J.JobTitle
FROM 
    Applications Ap
JOIN Applicants A ON Ap.ApplicantID = A.ApplicantID
JOIN Jobs J ON Ap.JobID = J.JobID
JOIN Companies C ON J.CompanyID = C.CompanyID
WHERE 
    C.Location = 'Chennai'         
    AND A.ExperienceYears >= 3;


--11. Retrieve a list of distinct job titles with salaries between $60,000 and $80,000.

SELECT DISTINCT JobTitle
FROM Jobs
WHERE Salary BETWEEN 600000 AND 800000
  AND JobTitle IS NOT NULL
  AND JobTitle <> '';


SELECT DISTINCT JobTitle
FROM Jobs
WHERE Salary BETWEEN 60000 AND 80000;
SELECT JobTitle, Salary FROM Jobs;


--12. Find the jobs that have not received any applications.

SELECT JobID, COUNT(*) AS ApplicationCount
FROM Applications
GROUP BY JobID;
SELECT JobID, JobTitle
FROM Jobs;

INSERT INTO Jobs (CompanyID, JobTitle, JobDescription, JobLocation, Salary, JobType, PostedDate)
VALUES (1, 'QA Engineer', 'Testing web apps.', 'Chennai', 450000.00, 'Full-time', GETDATE());

SELECT J.JobID, J.JobTitle, C.CompanyName
FROM Jobs J
LEFT JOIN Applications A ON J.JobID = A.JobID
JOIN Companies C ON J.CompanyID = C.CompanyID
WHERE A.ApplicationID IS NULL;


--13. Retrieve a list of job applicants along with the companies they have applied to and the positions they have applied for.

SELECT 
    A.ApplicantID,
    A.FirstName + ' ' + A.LastName AS ApplicantName,
    C.CompanyName,
    J.JobTitle
FROM Applicants A
JOIN 
Applications Ap ON A.ApplicantID = Ap.ApplicantID
JOIN 
Jobs J ON Ap.JobID = J.JobID
JOIN 
Companies C ON J.CompanyID = C.CompanyID;


--14. Retrieve a list of companies along with the count of jobs they have posted, even if they have not received any applications.
SELECT 
    C.CompanyName,
    COUNT(J.JobID) AS JobCount
FROM Companies C
LEFT JOIN 
Jobs J ON C.CompanyID = J.CompanyID
GROUP BY 
C.CompanyName;



--15. List all applicants along with the companies and positions they have applied for, including those who have not applied.
SELECT 
    A.ApplicantID,
    A.FirstName + ' ' + A.LastName AS ApplicantName,
    C.CompanyName,
    J.JobTitle
FROM Applicants A
LEFT JOIN 
Applications Ap ON A.ApplicantID = Ap.ApplicantID
LEFT JOIN 
Jobs J ON Ap.JobID = J.JobID
LEFT JOIN 
Companies C ON J.CompanyID = C.CompanyID;



--16. Find companies that have posted jobs with a salary higher than the average salary of all jobs.

SELECT DISTINCT 
    C.CompanyName
FROM Jobs J
JOIN Companies C ON J.CompanyID = C.CompanyID
WHERE 
J.Salary > ( SELECT AVG(Salary)
    FROM Jobs
    WHERE Salary > 0);


--17. Display a list of applicants with their names and a concatenated string of their city and state.

ALTER TABLE Applicants
ADD City VARCHAR(100), 
    State VARCHAR(100);

-- UPDATED the application since it did not have cuty and state

UPDATE Applicants
SET City = 'Chennai', State = 'Tamil Nadu'
WHERE ApplicantID = 1;
UPDATE Applicants
SET City = 'Mumbai', State = 'Maharashtra'
WHERE ApplicantID = 2;
UPDATE Applicants
SET City = 'Bangalore', State = 'Karnataka'
WHERE ApplicantID = 3;
UPDATE Applicants
SET City = 'Coimbatore', State = 'Tamil Nadu'
WHERE ApplicantID = 4;

SELECT 
    FirstName + ' ' + LastName AS FullName,
    City + ', ' + State AS Location
FROM Applicants;

--18. Retrieve a list of jobs with titles containing either 'Developer' or 'Engineer'.

SELECT 
    JobTitle,
    JobLocation,
    Salary,
    JobType
FROM Jobs
WHERE 
JobTitle LIKE '%Developer%' 
OR JobTitle LIKE '%Engineer%';


--19. Retrieve a list of applicants and the jobs they have applied for, including those who have not applied and jobs without applicants.
SELECT 
    A.ApplicantID,
    A.FirstName,
    A.LastName,
    J.JobID,
    J.JobTitle
FROM Applicants A
FULL OUTER JOIN Applications AP ON A.ApplicantID = AP.ApplicantID
FULL OUTER JOIN Jobs J ON AP.JobID = J.JobID;

--20. List all combinations of applicants and companies where the company is in a specific city and the applicant has more than 2 years of experience. For example: city=Chenna

ALTER TABLE Applicants ADD ExperienceYears INT;

UPDATE Applicants SET ExperienceYears = 4 WHERE ApplicantID = 1;
UPDATE Applicants SET ExperienceYears = 1 WHERE ApplicantID = 2;
UPDATE Applicants SET ExperienceYears = 3 WHERE ApplicantID = 3;
UPDATE Applicants SET ExperienceYears = 2 WHERE ApplicantID = 4;

SELECT * FROM Applicants
SELECT * FROM Companies

SELECT 
    A.FirstName,
    A.LastName,
    C.CompanyName,
    C.Location,
    A.ExperienceYears
FROM 
    Applicants A
CROSS JOIN Companies C
WHERE 
    C.Location = 'Chennai'
    AND A.ExperienceYears > 2;



































