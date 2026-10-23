-- =====================================================================
-- Case Study 1 : University Database Management System
-- File        : 02_dml.sql  (Sample data)
-- =====================================================================
USE university_db;

-- DEPARTMENT (10 rows)
INSERT INTO DEPARTMENT (dept_id, dept_name, hod_name) VALUES
(1,  'CSE',     'Dr. Ramesh Kumar'),
(2,  'ECE',     'Dr. Lakshmi Narayanan'),
(3,  'EEE',     'Dr. Suresh Babu'),
(4,  'MECH',    'Dr. Arvind Menon'),
(5,  'CIVIL',   'Dr. Kavitha Rao'),
(6,  'IT',      'Dr. Prakash Iyer'),
(7,  'BIOTECH', 'Dr. Meena Sundaram'),
(8,  'CHEM',    'Dr. Ravi Shankar'),
(9,  'MATH',    'Dr. Anitha George'),
(10, 'PHYSICS', 'Dr. Vijay Raghavan');

-- FACULTY (15 rows)
INSERT INTO FACULTY (faculty_id, faculty_name, dept_id, designation, salary, doj) VALUES
(101, 'Dr. Anil Sharma',      1, 'Professor',           125400.00, '2010-07-15'),
(102, 'Dr. Priya Venkatesh',  1, 'Associate Professor',  88750.00, '2015-06-01'),
(103, 'Dr. Karthik Raja',     1, 'Assistant Professor',  62300.00, '2022-01-10'),
(104, 'Dr. Deepa Krishnan',   2, 'Professor',           118900.00, '2012-08-20'),
(105, 'Dr. Mohan Das',        2, 'Assistant Professor',  58600.00, '2023-07-03'),
(106, 'Dr. Sneha Pillai',     3, 'Associate Professor',  84250.00, '2017-12-11'),
(107, 'Dr. Rajesh Nair',      4, 'Professor',           109500.00, '2011-03-25'),
(108, 'Dr. Farhan Ali',       4, 'Assistant Professor',  55450.00, '2024-02-19'),
(109, 'Dr. Lavanya Mohan',    5, 'Associate Professor',  79800.00, '2018-09-05'),
(110, 'Dr. Ganesh Murthy',    6, 'Assistant Professor',  67150.00, '2021-11-22'),
(111, 'Dr. Swathi Reddy',     6, 'Professor',            97600.00, '2014-04-14'),
(112, 'Dr. Naveen Joseph',    7, 'Assistant Professor',  52900.00, '2025-01-06'),
(113, 'Dr. Harini Srinivas',  8, 'Associate Professor',  76450.00, '2019-08-01'),
(114, 'Dr. Balaji Subramani', 9, 'Professor',            91200.00, '2013-10-30'),
(115, 'Dr. Ritu Agarwal',    10, 'Assistant Professor',  48750.00, '2024-06-17');

-- STUDENT (20 rows)
INSERT INTO STUDENT (student_id, student_name, dob, gender, dept_id, email, phone) VALUES
(1001, 'Aarav Mehta',      '2005-03-14', 'M', 1, 'aarav.mehta@vitstudent.ac.in',     '9876500001'),
(1002, 'Diya Sharma',      '2005-07-22', 'F', 1, 'diya.sharma@vitstudent.ac.in',     '9876500002'),
(1003, 'Rohan Gupta',      '2004-11-05', 'M', 1, 'rohan.gupta@gmail.com',            '9876500003'),
(1004, 'Ananya Iyer',      '2005-01-30', 'F', 1, 'ananya.iyer@vitstudent.ac.in',     '9876500004'),
(1005, 'Vikram Singh',     '2004-09-18', 'M', 1, 'vikram.singh@yahoo.com',           '9876500005'),
(1006, 'Sneha Reddy',      '2005-12-02', 'F', 1, 'sneha.reddy@vitstudent.ac.in',     '9876500006'),
(1007, 'Arjun Nair',       '2004-06-25', 'M', 1, 'arjun.nair@outlook.com',           '9876500007'),
(1008, 'Kavya Menon',      '2005-04-11', 'F', 2, 'kavya.menon@vitstudent.ac.in',     '9876500008'),
(1009, 'Rahul Verma',      '2004-08-09', 'M', 2, 'rahul.verma@gmail.com',            '9876500009'),
(1010, 'Pooja Patel',      '2005-02-17', 'F', 2, 'pooja.patel@vitstudent.ac.in',     '9876500010'),
(1011, 'Siddharth Rao',    '2004-12-28', 'M', 2, 'siddharth.rao@gmail.com',          '9876500011'),
(1012, 'Meera Krishnan',   '2005-10-07', 'F', 3, 'meera.krishnan@vitstudent.ac.in',  '9876500012'),
(1013, 'Aditya Kumar',     '2004-05-19', 'M', 3, 'aditya.kumar@yahoo.com',           '9876500013'),
(1014, 'Ishita Bose',      '2005-08-03', 'F', 4, 'ishita.bose@vitstudent.ac.in',     '9876500014'),
(1015, 'Karan Malhotra',   '2004-03-21', 'M', 4, 'karan.malhotra@gmail.com',         '9876500015'),
(1016, 'Nisha Thomas',     '2005-06-13', 'F', 5, 'nisha.thomas@vitstudent.ac.in',    '9876500016'),
(1017, 'Yash Joshi',       '2004-10-29', 'M', 6, 'yash.joshi@outlook.com',           '9876500017'),
(1018, 'Tanvi Desai',      '2005-09-08', 'F', 6, 'tanvi.desai@vitstudent.ac.in',     '9876500018'),
(1019, 'Harsh Agarwal',    '2006-01-15', 'M', 7, 'harsh.agarwal@gmail.com',          '9876500019'),
(1020, 'Riya Chatterjee',  '2005-11-26', 'F', 9, 'riya.chatterjee@vitstudent.ac.in', '9876500020');

-- COURSE (12 rows; faculty 103, 108, 112, 115 deliberately teach nothing)
INSERT INTO COURSE (course_id, course_name, dept_id, credits, faculty_id) VALUES
('BCSE302L', 'Database Systems',             1, 3, 101),
('BCSE303L', 'Operating Systems',            1, 3, 102),
('BCSE306L', 'Artificial Intelligence',      1, 3, 101),
('BCSE308L', 'Computer Networks',            1, 4, 102),
('BECE204L', 'Microprocessors',              2, 4, 104),
('BECE301L', 'Digital Signal Processing',    2, 3, 105),
('BEEE205L', 'Power Systems',                3, 3, 106),
('BMEE207L', 'Thermodynamics',               4, 4, 107),
('BCLE210L', 'Structural Analysis',          5, 3, 109),
('BITE304L', 'Web Technologies',             6, 2, 110),
('BMAT205L', 'Discrete Mathematics',         9, 4, 114),
('BCHY102L', 'Engineering Chemistry',        8, 2, 113);

-- ENROLLMENT (25 rows; students 1007, 1016, 1019 are not enrolled anywhere)
INSERT INTO ENROLLMENT (student_id, course_id, enroll_date, grade) VALUES
(1001, 'BCSE302L', '2026-07-20', 'A'),
(1001, 'BCSE306L', '2026-07-20', 'S'),
(1001, 'BMAT205L', '2026-07-21', 'B'),
(1002, 'BCSE302L', '2026-07-20', 'S'),
(1002, 'BCSE303L', '2026-07-20', 'A'),
(1003, 'BCSE302L', '2026-07-21', 'B'),
(1003, 'BCSE308L', '2026-07-21', 'C'),
(1004, 'BCSE302L', '2026-07-22', 'A'),
(1004, 'BCSE306L', '2026-07-22', 'A'),
(1005, 'BCSE303L', '2026-07-22', 'B'),
(1005, 'BCSE308L', '2026-07-22', 'D'),
(1006, 'BCSE306L', '2026-07-23', 'S'),
(1006, 'BITE304L', '2026-07-23', 'A'),
(1008, 'BECE204L', '2026-07-20', 'A'),
(1008, 'BECE301L', '2026-07-20', 'B'),
(1009, 'BECE204L', '2026-07-21', 'C'),
(1010, 'BECE301L', '2026-07-21', 'A'),
(1011, 'BECE204L', '2026-07-22', NULL),
(1012, 'BEEE205L', '2026-07-20', 'B'),
(1013, 'BEEE205L', '2026-07-21', 'E'),
(1014, 'BMEE207L', '2026-07-20', 'A'),
(1015, 'BMEE207L', '2026-07-22', 'C'),
(1017, 'BITE304L', '2026-07-21', 'B'),
(1018, 'BITE304L', '2026-07-21', 'S'),
(1020, 'BMAT205L', '2026-07-23', NULL);

-- FEE_PAYMENT (15 rows; last three rows omit status to show the DEFAULT)
INSERT INTO FEE_PAYMENT (student_id, amount, payment_date, status) VALUES
(1001, 198000.00, '2026-07-05', 'PAID'),
(1002, 198000.00, '2026-07-06', 'PAID'),
(1003, 198000.00, '2026-07-10', 'PENDING'),
(1004, 198000.00, '2026-07-04', 'PAID'),
(1005,  99000.00, '2026-07-12', 'FAILED'),
(1005,  99000.00, '2026-07-15', 'PENDING'),
(1006, 198000.00, '2026-07-03', 'PAID'),
(1008, 176000.00, '2026-07-08', 'PAID'),
(1009, 176000.00, '2026-07-18', 'PENDING'),
(1010, 176000.00, '2026-07-07', 'PAID'),
(1012, 165000.00, '2026-07-09', 'PAID'),
(1014, 165000.00, '2026-07-11', 'FAILED');
INSERT INTO FEE_PAYMENT (student_id, amount, payment_date) VALUES
(1015, 165000.00, '2026-07-19'),
(1017, 182000.00, '2026-07-20'),
(1020, 150000.00, '2026-07-21');

-- Row counts
SELECT 'DEPARTMENT' AS table_name, COUNT(*) AS row_count FROM DEPARTMENT
UNION ALL SELECT 'FACULTY',     COUNT(*) FROM FACULTY
UNION ALL SELECT 'STUDENT',     COUNT(*) FROM STUDENT
UNION ALL SELECT 'COURSE',      COUNT(*) FROM COURSE
UNION ALL SELECT 'ENROLLMENT',  COUNT(*) FROM ENROLLMENT
UNION ALL SELECT 'FEE_PAYMENT', COUNT(*) FROM FEE_PAYMENT;

-- DEFAULT check: rows inserted without a status
SELECT payment_id, student_id, status FROM FEE_PAYMENT WHERE payment_id >= 13;
