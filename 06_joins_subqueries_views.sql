-- =====================================================================
-- File : 06_joins_subqueries_views.sql  (Section 4)
-- =====================================================================
USE university_db;

-- 4.1 Student names with department names (INNER JOIN)
SELECT s.student_id, s.student_name, d.dept_name
FROM   STUDENT s
INNER  JOIN DEPARTMENT d ON s.dept_id = d.dept_id
ORDER  BY s.student_id;

-- 4.2 Faculty with the courses they teach, including unassigned faculty (LEFT JOIN)
SELECT f.faculty_id,
       f.faculty_name,
       COALESCE(c.course_id,   '-')            AS course_id,
       COALESCE(c.course_name, 'Not assigned') AS course_name
FROM   FACULTY f
LEFT   JOIN COURSE c ON c.faculty_id = f.faculty_id
ORDER  BY f.faculty_id, c.course_id;

-- 4.3 Students who have not enrolled in any course
SELECT s.student_id, s.student_name
FROM   STUDENT s
WHERE  NOT EXISTS (SELECT 1
                   FROM   ENROLLMENT e
                   WHERE  e.student_id = s.student_id);

-- 4.4 Faculty earning more than their department's average (correlated subquery)
SELECT f.faculty_name,
       f.dept_id,
       f.salary,
       (SELECT ROUND(AVG(f2.salary), 2)
        FROM   FACULTY f2
        WHERE  f2.dept_id = f.dept_id) AS dept_avg_salary
FROM   FACULTY f
WHERE  f.salary > (SELECT AVG(f2.salary)
                   FROM   FACULTY f2
                   WHERE  f2.dept_id = f.dept_id)
ORDER  BY f.dept_id;

-- 4.5 View STUDENT_FEE_STATUS: pending payments with student & department names
CREATE OR REPLACE VIEW STUDENT_FEE_STATUS AS
SELECT p.payment_id,
       s.student_id,
       s.student_name,
       d.dept_name,
       p.amount,
       p.payment_date,
       p.status
FROM   FEE_PAYMENT p
JOIN   STUDENT     s ON s.student_id = p.student_id
JOIN   DEPARTMENT  d ON d.dept_id    = s.dept_id
WHERE  p.status = 'PENDING';

SELECT * FROM STUDENT_FEE_STATUS ORDER BY payment_id;
