-- =====================================================================
-- File : 05_operators_group_functions.sql  (Section 3)
-- =====================================================================
USE university_db;

-- 3.1 Students belonging to 'CSE' or 'ECE' using IN
SELECT s.student_id, s.student_name, d.dept_name
FROM   STUDENT s
JOIN   DEPARTMENT d ON d.dept_id = s.dept_id
WHERE  d.dept_name IN ('CSE', 'ECE')
ORDER  BY d.dept_name, s.student_id;

-- 3.2 Faculty with salary BETWEEN 50,000 and 90,000
SELECT faculty_id, faculty_name, designation, salary
FROM   FACULTY
WHERE  salary BETWEEN 50000 AND 90000
ORDER  BY salary DESC;

-- 3.3 Number of students enrolled in each course (GROUP BY)
SELECT c.course_id,
       c.course_name,
       COUNT(e.student_id) AS students_enrolled
FROM   COURSE c
LEFT   JOIN ENROLLMENT e ON e.course_id = c.course_id
GROUP  BY c.course_id, c.course_name
ORDER  BY students_enrolled DESC, c.course_id;

-- 3.4 Departments with more than 5 students (HAVING)
SELECT d.dept_name,
       COUNT(s.student_id) AS student_count
FROM   DEPARTMENT d
JOIN   STUDENT s ON s.dept_id = d.dept_id
GROUP  BY d.dept_id, d.dept_name
HAVING COUNT(s.student_id) > 5;

-- 3.5 Total fee collected, grouped by payment status
SELECT status,
       COUNT(*)    AS num_payments,
       SUM(amount) AS total_amount
FROM   FEE_PAYMENT
GROUP  BY status
ORDER  BY total_amount DESC;
