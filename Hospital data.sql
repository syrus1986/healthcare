--Create Database table--
CREATE TABLE Hospital_Data(
Hospital_Name VARCHAR(60),
Location VARCHAR(60),	
Department VARCHAR(50)
Doctors_Count INT,
Patients_Count INT,	
Admission_Date DATE,	
Discharge_Date DATE,	
Medical_Expenses NUMERIC(10,2));

--Import CSV File in PGSQL--

\\ COPY 
Hospital_Data(Hospital_Name, Location, Department, Doctors_Count, Patients_Count, Admission_Date, Discharge_Date, Medical_Expenses)
FROM'C:\Users\USER\Downloads\Hospital_Data.csv'
DELIMITER','
CSV HEADER;

--Retrieve the all database table--

SELECT*from Hospital_data;

--1.Total Number of Patients--
SELECT SUM(Patients_Count) AS Total_Patients
FROM Hospital_Data;

--2.Average Number of Doctors per Hospital--
SELECT Hospital_Name, AVG(Doctors_Count) AS Avg_Doctors
FROM Hospital_Data
GROUP BY Hospital_Name;

--3. Top 3 Departments with the Highest Number of Patients--
SELECT Department, SUM(Patients_Count) AS Total_Patients
FROM Hospital_Data
GROUP BY Department
ORDER BY Total_Patients DESC
LIMIT 3;

--4. Hospital with the Maximum Medical Expenses
SELECT Hospital_Name,Medical_Expenses
FROM Hospital_Data
ORDER BY Hospital_Name DESC
LIMIT 1;

--5. Daily Average Medical Expenses--
SELECT Hospital_Name,
       AVG(Medical_Expenses / NULLIF((Discharge_Date - Admission_Date), 0)) AS Avg_Daily_Expense
FROM Hospital_Data
GROUP BY Hospital_Name
ORDER BY Avg_Daily_Expense DESC;

--6.Longest Hospital Stay--
SELECT Hospital_Name, Department, Patients_Count,
       (Discharge_Date - Admission_Date) AS Stay_Duration
FROM Hospital_Data
ORDER BY Stay_Duration DESC
LIMIT 1;

--7. Total Patients Treated Per City--
SELECT Location AS City, SUM(Patients_Count) AS Total_Patients
FROM Hospital_Data
GROUP BY Location 
ORDER BY total_Patients DESC ;

--8.Average Length of Stay Per Department--
SELECT Department,
       AVG(Discharge_Date-Admission_Date) AS Avg_Stay_Days
FROM Hospital_Data
GROUP BY Department
ORDER BY Avg_stay_Days DESC;

--9. Department with the Lowest Number of Patients--
SELECT Department, SUM(Patients_Count) AS Total_Patients
FROM Hospital_Data
GROUP BY Department
ORDER BY Total_Patients ASC
LIMIT 1;

--10. Monthly Medical Expenses Report--
SELECT
    EXTRACT(MONTH FROM Admission_Date) AS Month,
    SUM(Medical_Expenses) AS Total_Expenses
FROM Hospital_Data
GROUP BY EXTRACT(MONTH FROM Admission_Date)
ORDER BY Month;
--end--









