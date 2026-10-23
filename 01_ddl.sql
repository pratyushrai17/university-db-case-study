-- =====================================================================
-- Case Study 1 : University Database Management System
-- File        : 01_ddl.sql  (Section 1 - Constraints)
-- DBMS        : MySQL 8.0
-- Author      : Pratyush Rai (24BDS0170)
-- =====================================================================

DROP DATABASE IF EXISTS university_db;
CREATE DATABASE university_db;
USE university_db;

-- ---------------------------------------------------------------------
-- DEPARTMENT
-- ---------------------------------------------------------------------
CREATE TABLE DEPARTMENT (
    dept_id     INT          PRIMARY KEY,
    dept_name   VARCHAR(50)  NOT NULL UNIQUE,
    hod_name    VARCHAR(60)
);

-- ---------------------------------------------------------------------
-- FACULTY
-- ---------------------------------------------------------------------
CREATE TABLE FACULTY (
    faculty_id    INT           PRIMARY KEY,
    faculty_name  VARCHAR(60)   NOT NULL,
    dept_id       INT           NOT NULL,
    designation   VARCHAR(40),
    salary        DECIMAL(10,2) NOT NULL,
    doj           DATE,
    CONSTRAINT chk_faculty_salary CHECK (salary > 0),
    CONSTRAINT fk_faculty_dept FOREIGN KEY (dept_id)
        REFERENCES DEPARTMENT(dept_id)
);

-- ---------------------------------------------------------------------
-- STUDENT
-- ---------------------------------------------------------------------
CREATE TABLE STUDENT (
    student_id    INT          PRIMARY KEY,
    student_name  VARCHAR(60)  NOT NULL,
    dob           DATE,
    gender        CHAR(1),
    dept_id       INT          NOT NULL,
    email         VARCHAR(80)  UNIQUE,
    phone         VARCHAR(15)  UNIQUE,
    CONSTRAINT chk_student_gender CHECK (gender IN ('M','F','O')),
    CONSTRAINT fk_student_dept FOREIGN KEY (dept_id)
        REFERENCES DEPARTMENT(dept_id)
);

-- ---------------------------------------------------------------------
-- COURSE
-- ---------------------------------------------------------------------
CREATE TABLE COURSE (
    course_id    VARCHAR(10)  PRIMARY KEY,
    course_name  VARCHAR(80)  NOT NULL,
    dept_id      INT          NOT NULL,
    credits      INT          NOT NULL,
    faculty_id   INT,
    CONSTRAINT chk_course_credits CHECK (credits BETWEEN 1 AND 6),
    CONSTRAINT fk_course_dept FOREIGN KEY (dept_id)
        REFERENCES DEPARTMENT(dept_id),
    CONSTRAINT fk_course_faculty FOREIGN KEY (faculty_id)
        REFERENCES FACULTY(faculty_id) ON DELETE SET NULL
);

-- ---------------------------------------------------------------------
-- ENROLLMENT
-- ---------------------------------------------------------------------
CREATE TABLE ENROLLMENT (
    enroll_id    INT          PRIMARY KEY AUTO_INCREMENT,
    student_id   INT          NOT NULL,
    course_id    VARCHAR(10)  NOT NULL,
    enroll_date  DATE         NOT NULL,
    grade        CHAR(2),
    CONSTRAINT chk_enroll_grade CHECK (grade IN ('S','A','B','C','D','E','F')),
    CONSTRAINT fk_enroll_student FOREIGN KEY (student_id)
        REFERENCES STUDENT(student_id) ON DELETE CASCADE,
    CONSTRAINT fk_enroll_course FOREIGN KEY (course_id)
        REFERENCES COURSE(course_id) ON DELETE CASCADE
);

-- ---------------------------------------------------------------------
-- FEE_PAYMENT
-- ---------------------------------------------------------------------
CREATE TABLE FEE_PAYMENT (
    payment_id    INT           PRIMARY KEY AUTO_INCREMENT,
    student_id    INT           NOT NULL,
    amount        DECIMAL(10,2) NOT NULL,
    payment_date  DATE,
    status        VARCHAR(10)   NOT NULL DEFAULT 'PENDING',
    CONSTRAINT chk_fee_amount CHECK (amount > 0),
    CONSTRAINT chk_fee_status CHECK (status IN ('PENDING','PAID','FAILED')),
    CONSTRAINT fk_fee_student FOREIGN KEY (student_id)
        REFERENCES STUDENT(student_id) ON DELETE CASCADE
);

-- ---------------------------------------------------------------------
-- AUDIT_LOG  (used by the fee-payment trigger in Section 5)
-- ---------------------------------------------------------------------
CREATE TABLE AUDIT_LOG (
    log_id      INT           PRIMARY KEY AUTO_INCREMENT,
    table_name  VARCHAR(30)   NOT NULL,
    action      VARCHAR(10)   NOT NULL,
    record_id   INT           NOT NULL,
    details     VARCHAR(200),
    logged_by   VARCHAR(80)   DEFAULT (CURRENT_USER()),
    logged_at   TIMESTAMP     DEFAULT CURRENT_TIMESTAMP
);

SHOW TABLES;
