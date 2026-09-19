-- =====================================================================
--  COLLEGE MANAGEMENT SYSTEM  —  shared practice database
--  Loaded on Day 10 and used for every query from Day 11 onward.
--  Students paste and run the whole file in Oracle Live SQL, then
--  click Save and name it "College_DB". Run it again any time you want
--  fresh data.
--  Days 02–08 design these ten tables step by step on paper, and Day 09
--  types the first four of them by hand.
-- =====================================================================

-- ---------- 1. Clean start (errors here are fine on first run) --------
DROP TABLE loans;
DROP TABLE copies;
DROP TABLE books;
DROP TABLE fee_payments;
DROP TABLE enrollments;
DROP TABLE teaches;
DROP TABLE subjects;
DROP TABLE teachers;
DROP TABLE students;
DROP TABLE branches;

-- ---------- 2. Tables (parents first, children later) ------------------

-- BRANCH: CSE, ECE, MECH ...
CREATE TABLE branches (
    branch_code   VARCHAR2(10)  PRIMARY KEY,
    branch_name   VARCHAR2(60)  NOT NULL,
    head_name     VARCHAR2(50)
);

-- STUDENT: every student must belong to one branch
CREATE TABLE students (
    roll_no         NUMBER(6)     PRIMARY KEY,
    name            VARCHAR2(50)  NOT NULL,
    email           VARCHAR2(80)  NOT NULL UNIQUE,
    phone           VARCHAR2(15),
    dob             DATE,
    admission_date  DATE          NOT NULL,
    branch_code     VARCHAR2(10)  NOT NULL,
    CONSTRAINT fk_students_branch
        FOREIGN KEY (branch_code) REFERENCES branches (branch_code)
);

-- TEACHER: belongs to one branch; may report to a head (another teacher)
CREATE TABLE teachers (
    teacher_id    NUMBER(4)     PRIMARY KEY,
    name          VARCHAR2(50)  NOT NULL,
    email         VARCHAR2(80),
    joining_date  DATE,
    branch_code   VARCHAR2(10),
    hod_id        NUMBER(4),                 -- recursive: a teacher's head is also a teacher
    CONSTRAINT fk_teachers_branch
        FOREIGN KEY (branch_code) REFERENCES branches (branch_code),
    CONSTRAINT fk_teachers_hod
        FOREIGN KEY (hod_id) REFERENCES teachers (teacher_id)
);

-- SUBJECT: offered by one branch
CREATE TABLE subjects (
    subject_code  VARCHAR2(10)  PRIMARY KEY,
    title         VARCHAR2(60)  NOT NULL,
    credits       NUMBER(1)     NOT NULL,
    branch_code   VARCHAR2(10),
    CONSTRAINT ck_subjects_credits CHECK (credits BETWEEN 1 AND 5),
    CONSTRAINT fk_subjects_branch
        FOREIGN KEY (branch_code) REFERENCES branches (branch_code)
);

-- TEACHES: which teacher teaches which subject (many-to-many resolved)
CREATE TABLE teaches (
    teacher_id    NUMBER(4),
    subject_code  VARCHAR2(10),
    CONSTRAINT pk_teaches PRIMARY KEY (teacher_id, subject_code),
    CONSTRAINT fk_teaches_teacher FOREIGN KEY (teacher_id)   REFERENCES teachers (teacher_id),
    CONSTRAINT fk_teaches_subject FOREIGN KEY (subject_code) REFERENCES subjects (subject_code)
);

-- ENROLLMENT: which student takes which subject (many-to-many resolved)
CREATE TABLE enrollments (
    roll_no       NUMBER(6),
    subject_code  VARCHAR2(10),
    semester      NUMBER(1)     NOT NULL,
    marks         NUMBER(3),
    grade         CHAR(1),
    CONSTRAINT pk_enrollments PRIMARY KEY (roll_no, subject_code),
    CONSTRAINT fk_enroll_student FOREIGN KEY (roll_no)      REFERENCES students (roll_no),
    CONSTRAINT fk_enroll_subject FOREIGN KEY (subject_code) REFERENCES subjects (subject_code),
    CONSTRAINT ck_enroll_marks   CHECK (marks BETWEEN 0 AND 100)
);

-- FEE PAYMENT: one student pays many times (history over time)
CREATE TABLE fee_payments (
    payment_id    NUMBER(6)     PRIMARY KEY,
    roll_no       NUMBER(6)     NOT NULL,
    amount        NUMBER(8,2)   NOT NULL,
    paid_on       DATE          NOT NULL,
    pay_mode      VARCHAR2(10),
    CONSTRAINT fk_fee_student FOREIGN KEY (roll_no) REFERENCES students (roll_no),
    CONSTRAINT ck_fee_mode CHECK (pay_mode IN ('CASH', 'UPI', 'CARD', 'NETBANK'))
);

-- BOOK: one title (ISBN)
CREATE TABLE books (
    isbn          VARCHAR2(13)  PRIMARY KEY,
    title         VARCHAR2(80)  NOT NULL,
    author        VARCHAR2(60)  NOT NULL,
    publisher     VARCHAR2(60)
);

-- COPY: physical copies of a book (barred relationship → composite key)
CREATE TABLE copies (
    isbn          VARCHAR2(13),
    copy_no       NUMBER(2),
    status        VARCHAR2(10)  DEFAULT 'AVAILABLE' NOT NULL,
    CONSTRAINT pk_copies PRIMARY KEY (isbn, copy_no),
    CONSTRAINT fk_copies_book FOREIGN KEY (isbn) REFERENCES books (isbn),
    CONSTRAINT ck_copies_status CHECK (status IN ('AVAILABLE', 'ISSUED', 'LOST'))
);

-- LOAN: a copy is borrowed by EITHER a student OR a teacher (arc)
CREATE TABLE loans (
    loan_id       NUMBER(6)     PRIMARY KEY,
    isbn          VARCHAR2(13)  NOT NULL,
    copy_no       NUMBER(2)     NOT NULL,
    roll_no       NUMBER(6),
    teacher_id    NUMBER(4),
    issue_date    DATE          NOT NULL,
    due_date      DATE          NOT NULL,
    return_date   DATE,
    CONSTRAINT fk_loans_copy    FOREIGN KEY (isbn, copy_no) REFERENCES copies (isbn, copy_no),
    CONSTRAINT fk_loans_student FOREIGN KEY (roll_no)       REFERENCES students (roll_no),
    CONSTRAINT fk_loans_teacher FOREIGN KEY (teacher_id)    REFERENCES teachers (teacher_id),
    -- the arc rule: exactly one of roll_no / teacher_id must be filled
    CONSTRAINT ck_loans_arc CHECK (
        (roll_no IS NOT NULL AND teacher_id IS NULL) OR
        (roll_no IS NULL AND teacher_id IS NOT NULL)
    )
);

-- ---------- 3. Data ----------------------------------------------------

INSERT INTO branches VALUES ('CSE',  'Computer Science and Engineering', 'Dr. Rao');
INSERT INTO branches VALUES ('ECE',  'Electronics and Communication',    'Dr. Iyer');
INSERT INTO branches VALUES ('MECH', 'Mechanical Engineering',           'Dr. Singh');
INSERT INTO branches VALUES ('CIVIL','Civil Engineering',                NULL);        -- no students yet

INSERT INTO students VALUES (101, 'Ravi Kumar',   'ravi@college.edu',   '9800000001', DATE '2006-03-15', DATE '2024-08-01', 'CSE');
INSERT INTO students VALUES (102, 'Priya Sharma', 'priya@college.edu',  NULL,         DATE '2006-07-22', DATE '2024-08-01', 'CSE');
INSERT INTO students VALUES (103, 'Arjun Reddy',  'arjun@college.edu',  '9600000003', DATE '2005-11-02', DATE '2024-08-01', 'ECE');
INSERT INTO students VALUES (104, 'Meena Devi',   'meena@college.edu',  '9500000004', DATE '2006-01-30', DATE '2024-08-01', 'ECE');
INSERT INTO students VALUES (105, 'Karthik S',    'karthik@college.edu','9400000005', DATE '2005-09-18', DATE '2024-08-01', 'MECH');
INSERT INTO students VALUES (106, 'Sneha Patel',  'sneha@college.edu',  NULL,         DATE '2006-05-05', DATE '2024-08-01', 'CSE');
INSERT INTO students VALUES (107, 'Vikram Nair',  'vikram@college.edu', '9200000007', DATE '2006-12-12', DATE '2025-08-01', 'MECH');
INSERT INTO students VALUES (108, 'Anjali Gupta', 'anjali@college.edu', '9100000008', DATE '2007-02-14', DATE '2025-08-01', 'CSE'); -- no enrollments, no fees

-- Heads first (hod_id NULL), then teachers who report to them
INSERT INTO teachers VALUES (1, 'Dr. Rao',      'rao@college.edu',    DATE '2010-06-01', 'CSE',  NULL);
INSERT INTO teachers VALUES (2, 'Dr. Iyer',     'iyer@college.edu',   DATE '2012-01-15', 'ECE',  NULL);
INSERT INTO teachers VALUES (3, 'Prof. Lakshmi','lakshmi@college.edu',DATE '2018-07-01', 'CSE',  1);
INSERT INTO teachers VALUES (4, 'Prof. Anand',  'anand@college.edu',  DATE '2020-08-10', 'CSE',  1);
INSERT INTO teachers VALUES (5, 'Prof. Bhaskar','bhaskar@college.edu',DATE '2019-02-01', 'ECE',  2);
INSERT INTO teachers VALUES (6, 'Prof. Fatima', NULL,                 DATE '2021-09-01', 'MECH', NULL); -- MECH has no head yet

INSERT INTO subjects VALUES ('CS201', 'Database Systems',      4, 'CSE');
INSERT INTO subjects VALUES ('CS202', 'Operating Systems',     4, 'CSE');
INSERT INTO subjects VALUES ('CS203', 'Data Structures',       3, 'CSE');
INSERT INTO subjects VALUES ('EC201', 'Digital Electronics',   4, 'ECE');
INSERT INTO subjects VALUES ('EC202', 'Signals and Systems',   3, 'ECE');
INSERT INTO subjects VALUES ('ME201', 'Thermodynamics',        4, 'MECH');
INSERT INTO subjects VALUES ('HS101', 'Communication Skills',  2, NULL);   -- common subject, no branch
INSERT INTO subjects VALUES ('CS204', 'Computer Networks',     3, 'CSE');  -- nobody enrolled yet

INSERT INTO teaches VALUES (3, 'CS201');
INSERT INTO teaches VALUES (3, 'CS203');
INSERT INTO teaches VALUES (4, 'CS202');
INSERT INTO teaches VALUES (4, 'CS204');
INSERT INTO teaches VALUES (5, 'EC201');
INSERT INTO teaches VALUES (5, 'EC202');
INSERT INTO teaches VALUES (6, 'ME201');
INSERT INTO teaches VALUES (1, 'CS201');           -- two teachers for CS201

INSERT INTO enrollments VALUES (101, 'CS201', 3, 88, 'A');
INSERT INTO enrollments VALUES (101, 'CS202', 3, 79, 'B');
INSERT INTO enrollments VALUES (101, 'HS101', 3, 91, 'A');
INSERT INTO enrollments VALUES (102, 'CS201', 3, 92, 'A');
INSERT INTO enrollments VALUES (102, 'CS203', 3, 67, 'C');
INSERT INTO enrollments VALUES (103, 'EC201', 3, 74, 'B');
INSERT INTO enrollments VALUES (103, 'EC202', 3, 58, 'D');
INSERT INTO enrollments VALUES (103, 'HS101', 3, 80, 'B');
INSERT INTO enrollments VALUES (104, 'EC201', 3, 95, 'A');
INSERT INTO enrollments VALUES (105, 'ME201', 3, 49, 'F');
INSERT INTO enrollments VALUES (105, 'HS101', 3, 72, 'B');
INSERT INTO enrollments VALUES (106, 'CS201', 3, NULL, NULL);   -- exam not yet written
INSERT INTO enrollments VALUES (106, 'CS202', 3, 85, 'A');
INSERT INTO enrollments VALUES (107, 'ME201', 1, 63, 'C');

INSERT INTO fee_payments VALUES (5001, 101, 45000, DATE '2024-08-05', 'UPI');
INSERT INTO fee_payments VALUES (5002, 101, 45000, DATE '2025-01-10', 'UPI');
INSERT INTO fee_payments VALUES (5003, 102, 90000, DATE '2024-08-03', 'NETBANK');
INSERT INTO fee_payments VALUES (5004, 103, 45000, DATE '2024-08-20', 'CASH');
INSERT INTO fee_payments VALUES (5005, 104, 45000, DATE '2024-09-01', 'CARD');
INSERT INTO fee_payments VALUES (5006, 105, 30000, DATE '2024-08-15', 'CASH');
INSERT INTO fee_payments VALUES (5007, 106, 45000, DATE '2024-08-02', 'UPI');
INSERT INTO fee_payments VALUES (5008, 107, 45000, DATE '2025-08-04', 'UPI');
INSERT INTO fee_payments VALUES (5009, 103, 45000, DATE '2025-01-15', 'UPI');

INSERT INTO books VALUES ('9780073523323', 'Database System Concepts',      'Silberschatz', 'McGraw Hill');
INSERT INTO books VALUES ('9780133591620', 'Operating System Concepts',     'Galvin',       'Wiley');
INSERT INTO books VALUES ('9780262033848', 'Introduction to Algorithms',    'Cormen',       'MIT Press');
INSERT INTO books VALUES ('9780132126953', 'Digital Design',                'Morris Mano',  'Pearson');
INSERT INTO books VALUES ('9788120340077', 'Engineering Thermodynamics',    'P K Nag',      'McGraw Hill');  -- no copies yet

INSERT INTO copies VALUES ('9780073523323', 1, 'ISSUED');
INSERT INTO copies VALUES ('9780073523323', 2, 'AVAILABLE');
INSERT INTO copies VALUES ('9780073523323', 3, 'LOST');
INSERT INTO copies VALUES ('9780133591620', 1, 'AVAILABLE');
INSERT INTO copies VALUES ('9780133591620', 2, 'ISSUED');
INSERT INTO copies VALUES ('9780262033848', 1, 'AVAILABLE');
INSERT INTO copies VALUES ('9780132126953', 1, 'ISSUED');

-- loans: 3 by students, 1 by a teacher, some returned, some not
INSERT INTO loans VALUES (9001, '9780073523323', 1, 101, NULL, DATE '2025-09-01', DATE '2025-09-15', NULL);
INSERT INTO loans VALUES (9002, '9780133591620', 2, 102, NULL, DATE '2025-08-20', DATE '2025-09-03', NULL);
INSERT INTO loans VALUES (9003, '9780132126953', 1, NULL, 5,   DATE '2025-08-25', DATE '2025-09-24', NULL);
INSERT INTO loans VALUES (9004, '9780073523323', 2, 103, NULL, DATE '2025-07-01', DATE '2025-07-15', DATE '2025-07-14');
INSERT INTO loans VALUES (9005, '9780262033848', 1, 104, NULL, DATE '2025-07-10', DATE '2025-07-24', DATE '2025-07-30'); -- returned late

COMMIT;

-- ---------- 4. Quick check ---------------------------------------------
-- Click the Schema tab on the left: you should see 10 tables.
-- Then run these two lines; you should get 8 students and 14 enrollments.
SELECT * FROM students;
SELECT * FROM enrollments;
