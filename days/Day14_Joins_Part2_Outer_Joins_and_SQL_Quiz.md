# Day 14 — Joins Part 2: Outer Joins, Choosing the Right Join, SQL Revision

**Exam syllabus points covered today (1Z0-006 → "Table Joins")**
- Describe the different types of joins and their features (today: left, right and full outer joins; all six types compared)
- Use joins to retrieve data from multiple tables (keeping rows with no match; finding rows with no match)
- Revision of the whole "Introduction to SQL" section (DDL, DML and TCL, SELECT and WHERE, ORDER BY, joins) for the SQL Quiz

**By the end of today, a student can:**
1. Explain in plain words the difference between an inner join and an outer join.
2. Write a LEFT OUTER JOIN and say which rows come back with NULLs.
3. Explain RIGHT and FULL OUTER JOIN and rewrite a RIGHT join as a LEFT join.
4. Find "the ones with no match" with LEFT JOIN + `IS NULL`.
5. Recognise the Oracle `(+)` style in an exam question.
6. Choose the right join type from the question and the diagram.
7. Write the shape of every SQL statement from Days 9–13 from memory and avoid the 10 common mistakes.

---

## Today's topics

**0. Recap**
- 5 questions on inner joins

**1. The problem: an inner join drops rows with no match**
- 1.1 Who is missing? CIVIL, Anjali, CS204, a book with no copies

**2. Outer joins**
- 2.1 LEFT OUTER JOIN — keep every row of the left table
- 2.2 RIGHT OUTER JOIN — keep every row of the right table
- 2.3 FULL OUTER JOIN — keep every row of both
- 2.4 Finding the ones with no match: LEFT JOIN + IS NULL
- 2.5 The Oracle `(+)` style — one line, for awareness
- 2.6 The loan arc: LEFT JOIN to two parents

**3. Choosing the right join**
- 3.1 The decision table
- 3.2 The six join types in one table

**4. SQL revision (Days 9–13)**
- 4.1 The shape of every statement
- 4.2 The 10 most common mistakes

**5. Practice**
- 5.1 15 outer-join exercises

**6. SQL Quiz — 25 exam-style MCQs (35 min)**

---
## Time plan

| Time | Block | What we do |
|---|---|---|
| 0:00 – 0:10 | 0 | Recap: 5 quick questions from last class; homework check |
| 0:10 – 0:20 | 1 | The problem: rows that vanish in an inner join |
| 0:20 – 1:00 | 2 | LEFT, RIGHT, FULL; the no-match pattern; `(+)`; the loan arc |
| 1:00 – 1:10 | — | Break |
| 1:10 – 1:20 | 3 | Choosing the right join: decision table, six join types |
| 1:20 – 1:40 | 4 | SQL revision: statement shapes and the 10 common mistakes |
| 1:40 – 2:10 | 5 | Practice: 15 outer-join exercises |
| 2:10 – 2:45 | 6 | SQL Quiz: 25 MCQs |
| 2:45 – 2:55 | 6 | Go through the answer key |
| 2:55 – 3:00 | last | Key points, homework |

---

## Block 0 — Recap (10 min)

1. Which join keeps only the matching rows? (Inner join.)
2. Two tables of 4 and 7 rows, no join condition — how many rows? (28, Cartesian product.)
3. Why do we write `s.branch_code` and not just `branch_code`? (It exists in both tables — ambiguous.)
4. What is a self join? Give the College example. (Same table twice with two aliases; teacher and head.)
5. From yesterday: who was missing from the teacher–head join, and why? (Dr. Rao, Dr. Iyer, Prof. Fatima — their `hod_id` is NULL, so no partner.)

Homework check: the fee payment + student + branch query gives 9 rows.

---

## Block 1 — The problem: an inner join drops rows with no match (10 min)

Run these four inner joins and look for who is **missing**:

```sql
-- 1. Branches and their students: 8 rows, CIVIL is missing (no students)
SELECT b.branch_name, s.name
FROM   branches b JOIN students s ON b.branch_code = s.branch_code;

-- 2. Students and their enrollments: 14 rows, Anjali (108) is missing (no enrollments)
SELECT s.name, e.subject_code
FROM   students s JOIN enrollments e ON s.roll_no = e.roll_no;

-- 3. Subjects and their enrollments: 14 rows, CS204 Computer Networks is missing (nobody enrolled)
SELECT sub.title, e.roll_no
FROM   subjects sub JOIN enrollments e ON sub.subject_code = e.subject_code;

-- 4. Books and their copies: 7 rows, Engineering Thermodynamics is missing (no copies)
SELECT b.title, c.copy_no
FROM   books b JOIN copies c ON b.isbn = c.isbn;
```

The office asks: "Where is CIVIL? I want **every** branch on the list, even the empty one." An inner join cannot do that. We need an **outer join**.

> **In simple words:** "An inner join is a handshake. If nobody shakes your hand, you are not in the photo. An outer join keeps you in the photo, with an empty hand."

---

## Block 2 — Outer joins (40 min)

**Plain meaning:** an **outer join** keeps rows even when they have no partner in the other table. The missing partner's columns are shown as **NULL**. There are three kinds: LEFT, RIGHT and FULL. "Left" and "right" mean the table written **before** and **after** the JOIN keyword.

### 2.1 LEFT OUTER JOIN — keep every row of the left table

```sql
-- LEFT: every branch, even one with no students
SELECT b.branch_code, b.branch_name, s.roll_no, s.name
FROM   branches b
LEFT   OUTER JOIN students s ON b.branch_code = s.branch_code
ORDER  BY b.branch_code, s.roll_no;
```

```
 BRANCH_CODE | BRANCH_NAME                       | ROLL_NO | NAME
 ------------+-----------------------------------+---------+--------------
 CIVIL       | Civil Engineering                 | (null)  | (null)         ← kept, with NULLs
 CSE         | Computer Science and Engineering  | 101     | Ravi Kumar
 CSE         | Computer Science and Engineering  | 102     | Priya Sharma
 CSE         | Computer Science and Engineering  | 106     | Sneha Patel
 CSE         | Computer Science and Engineering  | 108     | Anjali Gupta
 ECE         | Electronics and Communication     | 103     | Arjun Reddy
 ECE         | Electronics and Communication     | 104     | Meena Devi
 MECH        | Mechanical Engineering            | 105     | Karthik S
 MECH        | Mechanical Engineering            | 107     | Vikram Nair
                                                                    (9 rows)
```
9 rows = the 8 matches + CIVIL with NULLs. `LEFT OUTER JOIN` and `LEFT JOIN` mean the same thing (`OUTER` is optional).

> **In simple words:** "LEFT means the table on the left is the boss. Every one of its rows comes to the party, with or without a partner."

Which side is "left" matters. Turn it around and nothing extra appears, because every student already has a branch:

```sql
-- LEFT from students: 8 rows, same as the inner join (every student has a branch)
SELECT s.name, b.branch_name
FROM   students s
LEFT   JOIN branches b ON s.branch_code = b.branch_code;
```

### 2.2 RIGHT OUTER JOIN — keep every row of the right table

Same idea, other side: the table written **after** JOIN keeps all its rows.

```sql
-- RIGHT: students on the left, branches on the right; every branch kept
SELECT b.branch_code, b.branch_name, s.roll_no, s.name
FROM   students s
RIGHT  OUTER JOIN branches b ON s.branch_code = b.branch_code
ORDER  BY b.branch_code, s.roll_no;
```
Exactly the same 9 rows as 2.1, including the CIVIL row with NULLs. **Any RIGHT join can be written as a LEFT join by swapping the two tables.** Most people write LEFT only; know that RIGHT exists for the exam.

### 2.3 FULL OUTER JOIN — keep every row of both

```sql
-- FULL: every branch and every student
SELECT b.branch_code, b.branch_name, s.roll_no, s.name
FROM   branches b
FULL   OUTER JOIN students s ON b.branch_code = s.branch_code
ORDER  BY b.branch_code, s.roll_no;
```
Again 9 rows — the same as LEFT here, because no student is without a branch. FULL only shows its power when **both** sides have rows with no partner. Branches and subjects is such a pair: CIVIL offers no subject, and HS101 belongs to no branch.

```sql
-- FULL: every branch AND every subject, even the ones with no partner
SELECT b.branch_code, sub.subject_code, sub.title
FROM   branches b
FULL   OUTER JOIN subjects sub ON b.branch_code = sub.branch_code
ORDER  BY b.branch_code, sub.subject_code;
```

```
 BRANCH_CODE | SUBJECT_CODE | TITLE
 ------------+--------------+----------------------
 CIVIL       | (null)       | (null)                 ← branch with no subject
 CSE         | CS201        | Database Systems
 CSE         | CS202        | Operating Systems
 CSE         | CS203        | Data Structures
 CSE         | CS204        | Computer Networks
 ECE         | EC201        | Digital Electronics
 ECE         | EC202        | Signals and Systems
 MECH        | ME201        | Thermodynamics
 (null)      | HS101        | Communication Skills   ← subject with no branch
                                              (9 rows)
```
Compare the four joins on this same pair: inner 7 rows, LEFT from branches 8 (adds CIVIL), RIGHT from branches (= LEFT from subjects) 8 (adds HS101), FULL 9 (adds both).

### 2.4 Finding the ones with no match: LEFT JOIN + IS NULL

This is the most useful trick of the day. **LEFT JOIN, then keep only the rows where the right side is NULL.**

```sql
-- Branches with no students
SELECT b.branch_code, b.branch_name
FROM   branches b
LEFT   JOIN students s ON b.branch_code = s.branch_code
WHERE  s.roll_no IS NULL;
-- 1 row: CIVIL

-- Students with no enrollments
SELECT s.roll_no, s.name
FROM   students s
LEFT   JOIN enrollments e ON s.roll_no = e.roll_no
WHERE  e.roll_no IS NULL;
-- 1 row: 108 Anjali Gupta

-- Subjects nobody has enrolled in
SELECT sub.subject_code, sub.title
FROM   subjects sub
LEFT   JOIN enrollments e ON sub.subject_code = e.subject_code
WHERE  e.roll_no IS NULL;
-- 1 row: CS204 Computer Networks

-- Books with no copies
SELECT b.title, b.author
FROM   books b
LEFT   JOIN copies c ON b.isbn = c.isbn
WHERE  c.isbn IS NULL;
-- 1 row: Engineering Thermodynamics, P K Nag
```

> **In simple words:** "LEFT JOIN gives everyone a seat. Then `IS NULL` on the right side picks out the ones who sat alone."

The self join from Day 13 works the same way — now all 6 teachers appear, and `IS NULL` finds the ones with no head:

```sql
-- Every teacher with their head; NULL head where there is none
SELECT t.name AS teacher, h.name AS head
FROM   teachers t
LEFT   JOIN teachers h ON t.hod_id = h.teacher_id;
-- 6 rows: Dr. Rao, Dr. Iyer and Prof. Fatima have a NULL head

-- Teachers who have no head
SELECT t.name
FROM   teachers t
LEFT   JOIN teachers h ON t.hod_id = h.teacher_id
WHERE  h.teacher_id IS NULL;
-- 3 rows
```

**Careful — test the key column, not a data column.** A real NULL in the data looks the same as an outer-join NULL:

```sql
-- WRONG test: 2 rows — Anjali (no enrollment) AND Sneha (enrolled, marks not entered yet)
SELECT s.name, e.subject_code, e.marks
FROM   students s
LEFT   JOIN enrollments e ON s.roll_no = e.roll_no
WHERE  e.marks IS NULL;
-- To find only students with NO enrollment, test the key: WHERE e.roll_no IS NULL (1 row)
```

> 📌 **Exam-likely:** "Which join returns all rows from the first table even when there is no match in the second?" → **LEFT OUTER JOIN**. "Which join returns all rows from both tables?" → **FULL OUTER JOIN**. "How do you list departments with no employees?" → **LEFT JOIN from departments to employees, then WHERE employee_id IS NULL**.

### 2.5 The Oracle `(+)` style — for awareness only

Before `LEFT JOIN` existed, Oracle put a `(+)` in the `WHERE` clause on the side that **may have no rows**: `FROM branches b, students s WHERE b.branch_code = s.branch_code (+);` gives the same 9 rows as the LEFT JOIN in 2.1. Do not use it in new work; just recognise it — in `a.x = b.x (+)`, table **b** is the one that may be missing.

### 2.6 The loan arc: LEFT JOIN to two parents

A loan is borrowed by **either** a student **or** a teacher (the arc from Day 5): one of `roll_no` / `teacher_id` is filled, the other is NULL. To show the borrower's name we LEFT JOIN to **both** tables; whichever matches is filled, the other is NULL.

```sql
-- Every loan with the book title and the borrower (student or teacher)
SELECT l.loan_id, b.title, s.name AS student, t.name AS teacher
FROM   loans l
JOIN   copies c ON l.isbn = c.isbn AND l.copy_no = c.copy_no
JOIN   books  b ON c.isbn = b.isbn
LEFT   JOIN students s ON l.roll_no    = s.roll_no
LEFT   JOIN teachers t ON l.teacher_id = t.teacher_id
ORDER  BY l.loan_id;
```

```
 LOAN_ID | TITLE                      | STUDENT      | TEACHER
 --------+----------------------------+--------------+---------------
 9001    | Database System Concepts   | Ravi Kumar   | (null)
 9002    | Operating System Concepts  | Priya Sharma | (null)
 9003    | Digital Design             | (null)       | Prof. Bhaskar
 9004    | Database System Concepts   | Arjun Reddy  | (null)
 9005    | Introduction to Algorithms | Meena Devi   | (null)
                                                          (5 rows)
```
With a plain `JOIN` to students, loan 9003 would vanish; with a plain `JOIN` to teachers, the four student loans would vanish. Copies and books can stay inner joins: every loan **must** have a copy and every copy **must** have a book.

---

## Break (10 min)

---

## Block 3 — Choosing the right join (10 min)

### 3.1 The decision table

Ask one question: **"Must every row of table A appear, even with no partner?"**

| The question says… | Example | Use |
|---|---|---|
| Only the ones that match | "students and their branch", "marks with names" | Inner join (`JOIN … ON`) |
| All of the first table, partner or not | "every branch, even with no students" | `A LEFT JOIN B` |
| All of the second table, partner or not | same question, tables written the other way round | `A RIGHT JOIN B` (or swap and use LEFT) |
| All of both tables | "every branch and every subject, matched where possible" | `A FULL JOIN B` |
| The ones with **no** partner | "branches with no students", "books with no copies" | `A LEFT JOIN B … WHERE B.key IS NULL` |
| Every combination, on purpose | "every branch paired with every subject" (a blank grid) | `A CROSS JOIN B` |
| Rows of a table matched to other rows of the same table | "each teacher and their head" | Self join (two aliases) |

**Read it off the diagram too:** look at the end of the line on the side you start from. If it is **must** (solid), an inner join loses nothing (every student must have a branch). If it is **may** (dashed), use LEFT JOIN or you will lose rows (a branch may have students; a teacher may have a head; a book may have copies).

### 3.2 The six join types in one table

| Join | Rows returned | College example (rows) |
|---|---|---|
| Inner (`JOIN … ON`) | Only matches | branches JOIN students: 8 |
| Left outer | All of the left table + matches | branches LEFT JOIN students: 9 (CIVIL with NULLs) |
| Right outer | All of the right table + matches | students RIGHT JOIN branches: 9 (same result) |
| Full outer | All of both tables | branches FULL JOIN subjects: 9 (CIVIL and HS101 with NULLs) |
| Cross (Cartesian) | Every pair, no condition | students CROSS JOIN branches: 32 |
| Self | A table joined to itself, two aliases | teachers t JOIN teachers h ON t.hod_id = h.teacher_id: 3 (LEFT: 6) |

---

## Block 4 — SQL revision (Days 9–13) (20 min)

### 4.1 The shape of every statement

> **In simple words:** "This is the whole SQL part of the exam on one page. Read each shape, then say what it does."

```sql
-- DDL (Day 9): the structure. Each DDL statement commits automatically.
CREATE TABLE branches (
    branch_code  VARCHAR2(10)  PRIMARY KEY,
    branch_name  VARCHAR2(60)  NOT NULL,
    head_name    VARCHAR2(50)
);
CREATE TABLE enrollments (
    roll_no       NUMBER(6),
    subject_code  VARCHAR2(10),
    semester      NUMBER(1) NOT NULL,
    marks         NUMBER(3),
    CONSTRAINT pk_enrollments PRIMARY KEY (roll_no, subject_code),
    CONSTRAINT fk_enroll_student FOREIGN KEY (roll_no) REFERENCES students (roll_no),
    CONSTRAINT ck_enroll_marks   CHECK (marks BETWEEN 0 AND 100)
);
ALTER TABLE students ADD hostel VARCHAR2(20);
ALTER TABLE students MODIFY hostel VARCHAR2(30);
ALTER TABLE students DROP COLUMN hostel;
ALTER TABLE students ADD CONSTRAINT uq_students_phone UNIQUE (phone);
ALTER TABLE students DROP CONSTRAINT uq_students_phone;
ALTER TABLE students RENAME COLUMN phone TO mobile;
TRUNCATE TABLE fee_payments;      -- empties the table, cannot be rolled back
DROP TABLE fee_payments;          -- removes the table; drop children before parents

-- DML and TCL (Day 10): the data
INSERT INTO branches (branch_code, branch_name, head_name) VALUES ('IT', 'Information Technology', NULL);
UPDATE enrollments SET marks = 90, grade = 'A' WHERE roll_no = 106 AND subject_code = 'CS201';
DELETE FROM enrollments WHERE roll_no = 107 AND subject_code = 'ME201';
SAVEPOINT before_delete;
ROLLBACK TO before_delete;
ROLLBACK;                         -- undo everything since the last COMMIT
COMMIT;                           -- make it permanent; other users can now see it

-- SELECT (Days 11-12): reading. Clause order: SELECT, FROM, WHERE, ORDER BY
SELECT DISTINCT branch_code FROM students;
SELECT roll_no, marks * 2 AS doubled, subject_code || '-' || grade AS label FROM enrollments;
SELECT roll_no, name FROM students
WHERE  branch_code IN ('CSE', 'ECE') AND (phone IS NULL OR dob >= DATE '2006-06-01')
ORDER  BY name DESC;

-- Joins (Days 13-14): several tables
SELECT s.name, sub.title, e.marks
FROM   enrollments e
JOIN   students s   ON e.roll_no      = s.roll_no
JOIN   subjects sub ON e.subject_code = sub.subject_code;
SELECT b.branch_name, s.name FROM branches b LEFT JOIN students s ON b.branch_code = s.branch_code;
SELECT b.branch_name FROM branches b LEFT JOIN students s ON b.branch_code = s.branch_code WHERE s.roll_no IS NULL;
```
(The DDL and DML lines above are shapes to read, not to run on the College DB in class — they would change it.)

The five constraints and their errors, from Day 9: PRIMARY KEY duplicate → ORA-00001; NOT NULL missing → ORA-01400; FOREIGN KEY parent missing → ORA-02291; deleting a parent that has children → ORA-02292; CHECK fails → ORA-02290.

### 4.2 The 10 most common mistakes

| # | Mistake | What you see | Fix |
|---|---|---|---|
| 1 | Text without quotes, or wrong case: `WHERE branch_code = cse` or `= 'cse'` | Error, or 0 rows | `'CSE'` — single quotes, exact case |
| 2 | `WHERE phone = NULL` | 0 rows, no error | `IS NULL` / `IS NOT NULL` |
| 3 | `UPDATE` or `DELETE` without `WHERE` | Every row changed or gone | Always write the WHERE; ROLLBACK if not yet committed |
| 4 | Expecting a ROLLBACK to undo DDL, or another user to see uncommitted rows | Table still dropped; rows invisible to others | DDL commits itself; use COMMIT to publish DML |
| 5 | Child before parent: inserting a student for a branch that does not exist, or dropping `branches` while `students` exists | ORA-02291 / cannot drop | Parent first when creating and inserting; child first when deleting and dropping |
| 6 | `ORDER BY` before `WHERE`, or `WHERE` after `ORDER BY` | Syntax error | SELECT → FROM → WHERE → ORDER BY |
| 7 | AND / OR mixed without brackets | Wrong rows | Oracle reads NOT, then AND, then OR — add brackets |
| 8 | Join with no join condition | Far too many rows (Cartesian product) | `JOIN … ON child.fk = parent.pk` |
| 9 | Shared column with no alias | ORA-00918 column ambiguously defined | `s.branch_code` |
| 10 | Inner join when the question said "every", or a `WHERE` on the optional table after a LEFT JOIN | Rows silently missing | LEFT JOIN; put the extra condition in `ON`, or test the key column with `IS NULL` |

Mistake 10 in action:

```sql
-- Meant: every student, and their semester-1 enrollment if any.
-- WHERE runs after the join, so the NULL rows are thrown away: 1 row (Vikram)
SELECT s.name, e.subject_code
FROM   students s
LEFT   JOIN enrollments e ON s.roll_no = e.roll_no
WHERE  e.semester = 1;

-- Correct: the condition on the optional table goes in ON: 8 rows (only Vikram has a subject shown)
SELECT s.name, e.subject_code
FROM   students s
LEFT   JOIN enrollments e ON s.roll_no = e.roll_no AND e.semester = 1;
```

---

## Block 5 — Practice: 15 outer-join exercises (30 min)

Write the expected row count **before** running. Answers under the table; reveal after 20 minutes.

| # | Question | Answer | Rows |
|---|---|---|---|
| 1 | Every student and their enrollments, including students with none | `SELECT s.name, e.subject_code, e.marks FROM students s LEFT JOIN enrollments e ON s.roll_no = e.roll_no;` | 15 |
| 2 | Every subject and who is enrolled, including empty subjects | `SELECT sub.title, e.roll_no FROM subjects sub LEFT JOIN enrollments e ON sub.subject_code = e.subject_code;` | 15 |
| 3 | Every branch and its students, including empty branches | `SELECT b.branch_name, s.name FROM branches b LEFT JOIN students s ON b.branch_code = s.branch_code;` | 9 |
| 4 | Every book with its copies, including books with none, sorted by title then copy | `SELECT b.title, c.copy_no, c.status FROM books b LEFT JOIN copies c ON b.isbn = c.isbn ORDER BY b.title, c.copy_no;` | 8 |
| 5 | Every teacher with their head, including teachers with no head | `SELECT t.name AS teacher, h.name AS head FROM teachers t LEFT JOIN teachers h ON t.hod_id = h.teacher_id;` | 6 |
| 6 | Every subject with its branch name, keeping the common subject HS101 | `SELECT sub.title, b.branch_name FROM subjects sub LEFT JOIN branches b ON sub.branch_code = b.branch_code;` | 8 |
| 7 | Branches with no students | `SELECT b.branch_code, b.branch_name FROM branches b LEFT JOIN students s ON b.branch_code = s.branch_code WHERE s.roll_no IS NULL;` | 1 |
| 8 | Students with no enrollments | `SELECT s.roll_no, s.name FROM students s LEFT JOIN enrollments e ON s.roll_no = e.roll_no WHERE e.roll_no IS NULL;` | 1 |
| 9 | Subjects with no enrollments | `SELECT sub.subject_code, sub.title FROM subjects sub LEFT JOIN enrollments e ON sub.subject_code = e.subject_code WHERE e.roll_no IS NULL;` | 1 |
| 10 | Books with no copies | `SELECT b.title FROM books b LEFT JOIN copies c ON b.isbn = c.isbn WHERE c.isbn IS NULL;` | 1 |
| 11 | Students who have never paid a fee | `SELECT s.roll_no, s.name FROM students s LEFT JOIN fee_payments f ON s.roll_no = f.roll_no WHERE f.payment_id IS NULL;` | 1 |
| 12 | Teachers who teach no subject | `SELECT t.name FROM teachers t LEFT JOIN teaches te ON t.teacher_id = te.teacher_id WHERE te.subject_code IS NULL;` | 1 |
| 13 | Copies that have never been loaned (join on two columns) | `SELECT c.isbn, c.copy_no, c.status FROM copies c LEFT JOIN loans l ON c.isbn = l.isbn AND c.copy_no = l.copy_no WHERE l.loan_id IS NULL;` | 2 |
| 14 | Exercise 1 written as a RIGHT join | `SELECT s.name, e.subject_code, e.marks FROM enrollments e RIGHT JOIN students s ON e.roll_no = s.roll_no;` | 15 |
| 15 | Every branch and every subject, FULL join, sorted by branch code | `SELECT b.branch_code, sub.title FROM branches b FULL JOIN subjects sub ON b.branch_code = sub.branch_code ORDER BY b.branch_code;` | 9 |

---

## Block 6 — SQL Quiz: 25 exam-style MCQs (35 min)

Covers Days 9–14. One answer per question unless the question says "two". Paper only, no Live SQL.

1. Which group of SQL commands does `CREATE TABLE` belong to?
   A. DML  B. DDL  C. TCL  D. DCL
2. Which statement removes all rows from a table and cannot be undone with ROLLBACK?
   A. `DELETE FROM t;`  B. `TRUNCATE TABLE t;`  C. `ROLLBACK;`  D. `UPDATE t SET …;`
3. Which data type is right for a student's admission date?
   A. VARCHAR2(10)  B. NUMBER(8)  C. DATE  D. CHAR(8)
4. A student is inserted with a `branch_code` that does not exist in `branches`. Which constraint stops it?
   A. PRIMARY KEY  B. NOT NULL  C. FOREIGN KEY  D. CHECK
5. Two tables: `branches` (parent) and `students` (child). In which order must they be created?
   A. students then branches  B. branches then students  C. Any order  D. Both in one statement
6. Which statement adds a column `hostel` to `students`?
   A. `ALTER TABLE students ADD hostel VARCHAR2(20);`  B. `UPDATE students ADD hostel;`  C. `INSERT INTO students hostel;`  D. `ALTER students ADD COLUMN hostel;`
7. Which error appears when a second row is inserted with an existing primary key value?
   A. ORA-01400  B. ORA-02291  C. ORA-00001  D. ORA-02290
8. `UPDATE enrollments SET marks = 90;` — what happens?
   A. Error: WHERE is missing  B. Only one row is changed  C. Every row gets marks 90  D. Nothing until COMMIT
9. Which statement makes your changes permanent and visible to other users?
   A. SAVEPOINT  B. ROLLBACK  C. COMMIT  D. TRUNCATE
10. After `DELETE FROM fee_payments WHERE roll_no = 101;` you run `ROLLBACK;`. What is the result?
    A. The rows are deleted for ever  B. The deleted rows are back  C. Error  D. The table is dropped
11. Which is true about a DDL statement such as `DROP TABLE`?
    A. It can be undone with ROLLBACK  B. It commits automatically  C. It needs a WHERE clause  D. It is part of TCL
12. Which INSERT is correct for a table with columns (branch_code, branch_name, head_name)?
    A. `INSERT INTO branches VALUES ('IT', 'Information Technology', NULL);`  B. `INSERT branches ('IT', 'Information Technology');`  C. `INSERT INTO branches SET branch_code = 'IT';`  D. `ADD INTO branches VALUES ('IT');`
13. Which WHERE clause finds students with no phone number?
    A. `WHERE phone = NULL`  B. `WHERE phone = ''`  C. `WHERE phone IS NULL`  D. `WHERE phone = 'NULL'`
14. `WHERE marks BETWEEN 70 AND 80` returns rows with marks…
    A. 71 to 79  B. 70 to 80, both included  C. 70 to 79  D. 71 to 80
15. Which pattern matches every name that starts with the letter P?
    A. `LIKE 'P_'`  B. `LIKE '%P'`  C. `LIKE 'P%'`  D. `= 'P%'`
16. What does `SELECT DISTINCT branch_code FROM students;` return?
    A. All 8 rows  B. Each branch code once  C. The first row only  D. An error
17. Which is the correct order of clauses?
    A. SELECT, WHERE, FROM, ORDER BY  B. SELECT, FROM, ORDER BY, WHERE  C. SELECT, FROM, WHERE, ORDER BY  D. FROM, SELECT, WHERE, ORDER BY
18. `ORDER BY marks DESC` puts the…
    A. Lowest marks first  B. Highest marks first  C. NULLs first, always  D. Rows in insert order
19. Two tables with 10 and 20 rows are joined without a join condition. How many rows come back?
    A. 10  B. 20  C. 30  D. 200
20. Which join returns only the rows that have a match in both tables?
    A. Inner join  B. Left outer join  C. Full outer join  D. Cross join
21. Which join returns all rows from the first table, even when there is no match in the second?
    A. Inner join  B. Left outer join  C. Cross join  D. Self join
22. In a LEFT OUTER JOIN, what appears in the right-hand columns for a left row that has no match?
    A. Zero  B. An empty string  C. NULL  D. The row is not shown
23. Which join returns all rows from both tables, matched where possible?
    A. Inner  B. Left outer  C. Right outer  D. Full outer
24. `SELECT * FROM a, b WHERE a.id = b.id (+);` — which table may have missing rows?
    A. a  B. b  C. Both  D. Neither
25. A LEFT JOIN from BRANCHES to STUDENTS followed by `WHERE students.roll_no IS NULL` lists…
    A. All students  B. Branches with no students  C. Students with no branch  D. All branches

## Homework (bring to Day 15)

1. Write three "find rows with no match" queries of your own on the College DB (for example: subjects nobody teaches — 1 row, HS101; students who never borrowed a book — 4 rows; teachers with no loan — 5 rows). Write the expected count first, then run.
2. On paper: for each pair, inner or LEFT? (a) every copy with its book title; (b) every book with its copies; (c) every teacher with the subjects they teach. inner — every copy must have a book; (b) LEFT — one book has no copies; (c) LEFT — Dr. Iyer teaches nothing.)
3. Revise all the one-slide summaries from Days 1–14. Tomorrow is Mock Test 2: 60 questions, 120 minutes, the whole course.
4. Bring the quiz paper with your corrections.

---

## One-slide summary

- **Inner join** = only matches. **Outer join** = keep the rows with no partner, with NULLs in the missing columns.
- **LEFT JOIN** keeps every row of the table written first; **RIGHT JOIN** every row of the table written second; **FULL JOIN** both. `OUTER` is optional.
- `A RIGHT JOIN B` = `B LEFT JOIN A`.
- "The ones with no match": LEFT JOIN, then `WHERE right.key IS NULL`. Test the key column, not a data column.
- Old Oracle style: `(+)` on the side that may be missing — recognise it, do not use it.
- The loan arc (student **or** teacher): LEFT JOIN to both parents.
- Choose by the question: "only matching" → inner; "every … even with none" → LEFT; "both sides" → FULL; "with none" → LEFT + IS NULL.
- A WHERE on the optional table turns a LEFT JOIN back into an inner join — put that condition in ON.
- Clause order never changes: SELECT → FROM (with JOINs) → WHERE → ORDER BY.

## Simple glossary

| Word | Meaning in one line |
|---|---|
| Outer join | A join that keeps rows even when they have no partner |
| LEFT OUTER JOIN | Keep every row of the first (left) table |
| RIGHT OUTER JOIN | Keep every row of the second (right) table |
| FULL OUTER JOIN | Keep every row of both tables |
| `(+)` | Old Oracle mark for the side that may be missing (awareness only) |
| No-match pattern | LEFT JOIN then `IS NULL` on the right table's key to find rows with nothing |
| Arc | A row linked to one of two possible parents (a loan by a student or a teacher) |
| Cross join | Every row of one table paired with every row of the other |
| Self join | The same table joined to itself with two aliases |
