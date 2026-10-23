-- =====================================================================
-- File : 08_section5_demo.sql  (sample runs for Section 5)
-- Run with: mysql --force   (the duplicate-enrollment test is meant to fail)
-- =====================================================================
USE university_db;

-- 5.1 enroll_student: Arjun Nair (1007) had no courses
CALL enroll_student(1007, 'BCSE302L');
SELECT * FROM ENROLLMENT WHERE student_id = 1007;

-- 5.1 enroll_student with a course that does not exist (expected error)
CALL enroll_student(1007, 'BXXX999');

-- 5.2 get_student_age
SELECT student_id, student_name, dob, get_student_age(student_id) AS age
FROM   STUDENT
WHERE  student_id IN (1001, 1005, 1019);

-- 5.3 Cursor-based salary hike
SELECT faculty_id, faculty_name, doj, salary FROM FACULTY ORDER BY faculty_id;
CALL faculty_salary_hike();

-- 5.4 Trigger: enroll 1001 in BCSE302L again (expected error)
INSERT INTO ENROLLMENT (student_id, course_id, enroll_date) VALUES (1001, 'BCSE302L', CURDATE());
-- ... and through the procedure (expected error)
CALL enroll_student(1001, 'BCSE302L');

-- 5.5 Trigger: new fee payments are logged automatically
INSERT INTO FEE_PAYMENT (student_id, amount, payment_date, status)
VALUES (1016, 165000.00, CURDATE(), 'PAID');
INSERT INTO FEE_PAYMENT (student_id, amount, payment_date)
VALUES (1019, 172000.00, CURDATE());
SELECT log_id, table_name, action, record_id, details FROM AUDIT_LOG;
