SELECT *
FROM Patients

--Retrieving and Filtering Data
--Questions and Answers:

--1. Retrieve all Patients from Lagos.
SELECT *
FROM Patients
WHERE City = 'Lagos';

--2. Find all Patients with a length of stay greater than 5 days.
SELECT *
FROM Patients
WHERE Length_of_Stay > 5;

--3. Find patients whose age is between 30 and 50 years.
SELECT *
FROM Patients
WHERE Age BETWEEN 30 AND 50;

--4. Retrieve all female patients from Lagos who were admitted through Emergency Admission.
SELECT *
FROM Patients
WHERE Gender = 'Female'
	AND City = 'Lagos'
	AND Admission_Type = 'Emergency';

--5. Retrieve all patients who have Diabetes OR Hypertension.
SELECT *
FROM Patients
WHERE Condition = 'Diabetes' OR Condition = 'Hypertension';


--Sorting, Distinct and Basic Aggregation
-- Questions and Answers:

--1. Find the 3 Patients with the longest hospital stays,
--displaying them from longest to sortest stay
SELECT TOP 3 *
FROM Patients
ORDER BY Length_of_Stay DESC;

--2. List all unique cities represented in the dataset.
SELECT DISTINCT City
FROM Patients;

--3. Count the total number of patients.
SELECT COUNT(*) AS Total_Number_of_Patient
FROM Patients

--4. Calculate the average patient age.
SELECT AVG(Age) AS Avg_Patient_Age
FROM Patients

--5. Count the number of patients for each medical condition.
SELECT Condition,
	COUNT(*) AS Total_Patients
FROM Patients
GROUP BY Condition;


--Working with Strings & Dates
--Questions & Answers:

--1. Display each patient's full name in uppercase.
SELECT Patient_Name,
	UPPER(Patient_Name) AS Name_in_Uppercase
FROM Patients;

--2. Display each patient's full name in lowercase.
SELECT Patient_Name,
	LOWER(Patient_Name) AS Name_in_Lowercase
FROM Patients;

--3. Create a new column that combines the Patient ID
--and Patient Name into one value.
SELECT Patient_ID,
		Patient_Name,
		CONCAT(Patient_ID, ' - ', Patient_Name) AS New_Column
FROM Patients;

--4. Find all patients who were admitted after January 15, 2026.
SELECT *
FROM Patients
WHERE Admission_Date > '2026-01-15';

--5. Display the year and month in which each patient was admitted.
SELECT *,
		YEAR(Admission_Date) AS Year,
		MONTH(Admission_Date) AS Month
FROM Patients;


--Advance Aggregation and conditional Analysis
--Questions & Answers:

--1. Calculate the average length for each admission type.
SELECT Admission_Type, 
	AVG(Length_of_Stay) AS Avg_length
FROM Patients
GROUP BY Admission_Type;

--2. Find the admission type with an average length of stay greater than 4 days.
SELECT Admission_Type,
	AVG(Length_of_Stay) AS Avg_length
FROM Patients
GROUP BY Admission_Type
HAVING AVG(Length_of_Stay) > 4;

--3. Classify Patients as Young (Under 40), Middle-aged (40-59) or Senior (60 and above).
SELECT *,
CASE
		WHEN Age < 40 THEN 'Young'
		WHEN Age BETWEEN 40 AND 59 THEN 'Middle-aged'
		ELSE 'Senior'
END AS Age_Group
FROM Patients;

--4. Count the number of patients in each age group.
SELECT COUNT(*) AS Total_Number_of_Patients,
CASE
		WHEN Age < 40 THEN 'Young'
		WHEN Age BETWEEN 40 AND 59 THEN 'Middle-aged'
		ELSE 'Senior'
END AS Age_Group
FROM Patients
GROUP BY
CASE
		WHEN Age < 40 THEN 'Young'
		WHEN Age BETWEEN 40 AND 59 THEN 'Middle-aged'
		ELSE 'Senior'
END;

--5. Classify patients as Short Stay (3 days or less) or long Stay (more than 3 days).
SELECT *,
CASE
		WHEN Length_of_Stay <= 3 THEN 'Short Stay'
		ELSE 'Long Stay'
END AS Length_of_stay_group
FROM Patients;

--6. Find the medical conditions with more than 1 patient.
SELECT Condition,
	COUNT(*) AS Total_Patients
FROM Patients
GROUP BY Condition
HAVING COUNT(*) > 1;


--Primary & Foreign Keys and SQL JOINs.
--Question and answers:

--1. Import the Doctors table into SQL Server and Verify that it was loaded correctly.
SELECT *
FROM Doctors;

--2. Join the Patients and Doctors tables to display each patient's name
--and their doctor's specialization.
SELECT 
	p.Patient_Name,
	d.Doctor_Name,
	d.Specialization
FROM Patients p
JOIN Doctors d
	ON p.Doctor_ID = d.Doctor_ID;

--3. Find all patients treated by doctors specializing in Internal Medicine.
SELECT
	p.Patient_Name,
	d.Specialization
FROM Patients p
JOIN Doctors d
	ON p.Doctor_ID = d.Doctor_ID
WHERE d.Specialization = 'Internal Medicine';

--4. Calculate the average length of stay for patients treated by each doctor.
SELECT
	d.Doctor_Name,
	AVG(p.Length_of_Stay) AS Avglength
FROM Patients p
JOIN Doctors d
	ON p.Doctor_ID = d.Doctor_ID
GROUP BY d.Doctor_ID, d.Doctor_Name;

--5. Identify the doctor who has treated the highest number of patients.
SELECT TOP 1 
	d.Doctor_Name,
	COUNT(*) AS Total_Patients
FROM Patients p
JOIN Doctors d
	ON p.Doctor_ID = d.Doctor_ID
GROUP BY d.Doctor_ID, d.Doctor_Name
ORDER BY COUNT(*) DESC;
