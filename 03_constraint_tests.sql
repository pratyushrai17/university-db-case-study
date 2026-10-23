-- =====================================================================
-- File : 03_constraint_tests.sql  (Section 1 - proving each constraint)
-- Each statement below is EXPECTED TO FAIL. Run with: mysql --force
-- =====================================================================
USE university_db;

-- NOT NULL on student_name
INSERT INTO STUDENT (student_id, student_name, dept_id) VALUES (2001, NULL, 1);

-- NOT NULL on faculty_name
INSERT INTO FACULTY (faculty_id, faculty_name, dept_id, salary) VALUES (201, NULL, 1, 50000);

-- NOT NULL on dept_name
INSERT INTO DEPARTMENT (dept_id, dept_name) VALUES (11, NULL);

-- UNIQUE on student email (duplicate of student 1001)
INSERT INTO STUDENT (student_id, student_name, dept_id, email, phone)
VALUES (2002, 'Test Student', 1, 'aarav.mehta@vitstudent.ac.in', '9000000001');

-- UNIQUE on student phone (duplicate of student 1001)
INSERT INTO STUDENT (student_id, student_name, dept_id, email, phone)
VALUES (2003, 'Test Student', 1, 'new.mail@vitstudent.ac.in', '9876500001');

-- CHECK credits BETWEEN 1 AND 6
INSERT INTO COURSE (course_id, course_name, dept_id, credits) VALUES ('BTEST01', 'Test', 1, 8);

-- CHECK salary > 0
INSERT INTO FACULTY (faculty_id, faculty_name, dept_id, salary) VALUES (202, 'Test Faculty', 1, -5000);

-- FOREIGN KEY: department 99 does not exist
INSERT INTO STUDENT (student_id, student_name, dept_id) VALUES (2004, 'Test Student', 99);
