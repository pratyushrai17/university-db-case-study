-- =====================================================================
-- File : 07_procedures_functions_cursors_triggers.sql  (Section 5)
-- =====================================================================
USE university_db;

DROP PROCEDURE IF EXISTS enroll_student;
DROP FUNCTION  IF EXISTS get_student_age;
DROP PROCEDURE IF EXISTS faculty_salary_hike;
DROP TRIGGER   IF EXISTS trg_prevent_duplicate_enrollment;
DROP TRIGGER   IF EXISTS trg_fee_payment_audit;

DELIMITER //

-- ---------------------------------------------------------------------
-- 5.1 Procedure enroll_student(student_id, course_id)
-- ---------------------------------------------------------------------
CREATE PROCEDURE enroll_student(IN p_student_id INT, IN p_course_id VARCHAR(10))
BEGIN
    IF NOT EXISTS (SELECT 1 FROM STUDENT WHERE student_id = p_student_id) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Student does not exist';
    END IF;

    IF NOT EXISTS (SELECT 1 FROM COURSE WHERE course_id = p_course_id) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Course does not exist';
    END IF;

    INSERT INTO ENROLLMENT (student_id, course_id, enroll_date, grade)
    VALUES (p_student_id, p_course_id, CURDATE(), NULL);

    SELECT CONCAT('Student ', p_student_id, ' enrolled in ', p_course_id,
                  ' (enroll_id ', LAST_INSERT_ID(), ')') AS message;
END //

-- ---------------------------------------------------------------------
-- 5.2 Function get_student_age(student_id)
-- ---------------------------------------------------------------------
CREATE FUNCTION get_student_age(p_student_id INT)
RETURNS INT
READS SQL DATA
BEGIN
    DECLARE v_dob DATE;

    SELECT dob INTO v_dob
    FROM   STUDENT
    WHERE  student_id = p_student_id;

    IF v_dob IS NULL THEN
        RETURN NULL;
    END IF;

    RETURN TIMESTAMPDIFF(YEAR, v_dob, CURDATE());
END //

-- ---------------------------------------------------------------------
-- 5.3 Cursor: 10% salary hike for faculty with 5+ years of service
-- ---------------------------------------------------------------------
CREATE PROCEDURE faculty_salary_hike()
BEGIN
    DECLARE v_done      INT DEFAULT 0;
    DECLARE v_id        INT;
    DECLARE v_name      VARCHAR(60);
    DECLARE v_salary    DECIMAL(10,2);
    DECLARE v_years     INT;
    DECLARE v_count     INT DEFAULT 0;

    DECLARE cur_faculty CURSOR FOR
        SELECT faculty_id, faculty_name, salary,
               TIMESTAMPDIFF(YEAR, doj, CURDATE())
        FROM   FACULTY
        WHERE  TIMESTAMPDIFF(YEAR, doj, CURDATE()) >= 5;

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET v_done = 1;

    -- holds a before/after record of each hike for display
    DROP TEMPORARY TABLE IF EXISTS hike_report;
    CREATE TEMPORARY TABLE hike_report (
        faculty_id    INT,
        faculty_name  VARCHAR(60),
        years_service INT,
        old_salary    DECIMAL(10,2),
        new_salary    DECIMAL(10,2)
    );

    OPEN cur_faculty;

    read_loop: LOOP
        FETCH cur_faculty INTO v_id, v_name, v_salary, v_years;
        IF v_done = 1 THEN
            LEAVE read_loop;
        END IF;

        UPDATE FACULTY
        SET    salary = ROUND(salary * 1.10, 2)
        WHERE  faculty_id = v_id;

        INSERT INTO hike_report
        VALUES (v_id, v_name, v_years, v_salary, ROUND(v_salary * 1.10, 2));

        SET v_count = v_count + 1;
    END LOOP;

    CLOSE cur_faculty;

    SELECT * FROM hike_report ORDER BY faculty_id;
    SELECT CONCAT(v_count, ' faculty members received a 10% hike') AS summary;
END //

-- ---------------------------------------------------------------------
-- 5.4 Trigger: prevent duplicate enrollment in the same course
-- ---------------------------------------------------------------------
CREATE TRIGGER trg_prevent_duplicate_enrollment
BEFORE INSERT ON ENROLLMENT
FOR EACH ROW
BEGIN
    IF EXISTS (SELECT 1
               FROM   ENROLLMENT
               WHERE  student_id = NEW.student_id
               AND    course_id  = NEW.course_id) THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Duplicate enrollment: student is already enrolled in this course';
    END IF;
END //

-- ---------------------------------------------------------------------
-- 5.5 Trigger: log every fee payment into AUDIT_LOG after insert
-- ---------------------------------------------------------------------
CREATE TRIGGER trg_fee_payment_audit
AFTER INSERT ON FEE_PAYMENT
FOR EACH ROW
BEGIN
    INSERT INTO AUDIT_LOG (table_name, action, record_id, details)
    VALUES ('FEE_PAYMENT', 'INSERT', NEW.payment_id,
            CONCAT('student_id=', NEW.student_id,
                   ', amount=',    NEW.amount,
                   ', status=',    NEW.status));
END //

DELIMITER ;
