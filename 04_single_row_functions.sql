-- =====================================================================
-- File : 04_single_row_functions.sql  (Section 2)
-- =====================================================================
USE university_db;

-- 2.1 Each student's name in uppercase with its length
SELECT student_id,
       UPPER(student_name)       AS name_upper,
       CHAR_LENGTH(student_name) AS name_length
FROM   STUDENT
ORDER  BY student_id;

-- 2.2 Domain name from each student's email
SELECT student_name,
       email,
       SUBSTRING_INDEX(email, '@', -1) AS email_domain
FROM   STUDENT
ORDER  BY student_id;

-- 2.3 Each student's current age from dob
SELECT student_name,
       dob,
       TIMESTAMPDIFF(YEAR, dob, CURDATE()) AS age_years
FROM   STUDENT
ORDER  BY student_id;

-- 2.4 Faculty doj in DD-Mon-YYYY format
SELECT faculty_name,
       doj,
       DATE_FORMAT(doj, '%d-%b-%Y') AS doj_formatted
FROM   FACULTY
ORDER  BY faculty_id;

-- 2.5 Round vs truncate salary to the nearest thousand
SELECT faculty_name,
       salary,
       ROUND(salary, -3)                     AS rounded_salary,
       TRUNCATE(salary, -3)                  AS truncated_salary,
       ROUND(salary, -3) - TRUNCATE(salary, -3) AS difference
FROM   FACULTY
ORDER  BY faculty_id;
