-- Create the 'patients' schema if it doesn't exist
CREATE SCHEMA IF NOT EXISTS patients;

-- Drop the table if it exists
DROP TABLE IF EXISTS edgar_hospital.patients.patient_records;

-- Create the 'patient_records' table
CREATE TABLE edgar_hospital.patients.patient_records (
	ID VARCHAR(255),
	LOG_DATE DATE,
	MEASURE VARCHAR(255),
	MEASURE_VALUE FLOAT,
	SYSTOLIC FLOAT,
	DIASTOLIC FLOAT
);

-- Copy data from CSV file into the 'patient_records' table
COPY edgar_hospital.patients.patient_records 
FROM 'C:\Users\Ben\Downloads\dataset.csv' DELIMITER ',' CSV HEADER;

-- View all records in the 'patient_records' table
SELECT *
FROM edgar_hospital.patients.patient_records;

-- Count the number of distinct patients in the dataset
SELECT COUNT(DISTINCT ID)
FROM edgar_hospital.patients.patient_records;

-- Find the average number of measurements recorded per user
SELECT AVG(measure_count) AS average_measurements
FROM (
	SELECT ID,
		COUNT(measure) AS measure_count
	FROM edgar_hospital.patients.patient_records
	GROUP BY ID
) AS avg_measurements;

-- Find the median number of measurements per user
SELECT PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY number_of_measures) AS median_value
FROM (
	SELECT ID,
		COUNT(measure) AS number_of_measures
	FROM edgar_hospital.patients.patient_records
	GROUP BY ID
) AS median_measurements;

-- Count the number of users with 3 or more measurements
SELECT COUNT(ID)
FROM (
	SELECT ID,
		COUNT(measure) AS number_of_measures
	FROM edgar_hospital.patients.patient_records
	GROUP BY ID
	HAVING COUNT(measure) >= 3
) AS measurements;

-- Count the number of users with more than 1000 measurements
SELECT COUNT(ID)
FROM (
	SELECT ID,
		COUNT(measure) AS number_of_measures
	FROM edgar_hospital.patients.patient_records
	GROUP BY ID
	HAVING COUNT(measure) > 1000
) AS measurements;

-- Count the number of users who have logged blood glucose measurements
SELECT COUNT(DISTINCT ID)
FROM edgar_hospital.patients.patient_records
WHERE measure LIKE '%blood%glucose%';

-- Count the number of users who have at least two types of measurements
SELECT COUNT(ID)
FROM (
	SELECT ID,
		COUNT(DISTINCT measure) AS measure_types
	FROM edgar_hospital.patients.patient_records
	GROUP BY ID
	HAVING COUNT(DISTINCT measure) >= 2
) AS count_users;

-- Count the number of users who have all three measures (blood glucose, weight, and blood pressure) recorded
SELECT COUNT(ID)
FROM edgar_hospital.patients.patient_records
WHERE measure IN ('blood glucose', 'weight', 'blood pressure');

-- Find the median values for systolic and diastolic blood pressure
SELECT PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY systolic) AS median_systolic,
	PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY diastolic) AS median_diastolic
FROM edgar_hospital.patients.patient_records
WHERE measure LIKE '%blood%pressure%';

