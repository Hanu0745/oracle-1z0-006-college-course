# Day 10 — Adding and Changing Data (DML) and Transactions (TCL)

**Exam syllabus points covered today (1Z0-006 → "Introduction to SQL")**
- DML and TCL: purpose of DML; use DML to manage data in tables
- DML and TCL: use TCL to manage transactions

**By the end of today, a student can:**
1. Add rows with INSERT (with and without a column list, with NULL, DEFAULT and dates).
2. Read the Oracle error when a row breaks a rule and say which constraint caused it.
3. Change rows with UPDATE ... SET ... WHERE and remove rows with DELETE ... WHERE.
4. Explain what a transaction is and use COMMIT, ROLLBACK, SAVEPOINT and ROLLBACK TO.
5. Compare DELETE, TRUNCATE and DROP.
6. Load the shared College database into Live SQL and save it as `College_DB`.

---

## Today's topics

**0. Recap**
- 5 quick questions from Day 9 (DDL)
**1. INSERT: adding rows**
- 1.1 The simplest INSERT (all columns, table order)
- 1.2 INSERT with a column list (recommended)
- 1.3 NULL, dates and text
- 1.4 DEFAULT
- 1.5 When a rule is broken: the four errors
**2. UPDATE: changing rows**
- 2.1 UPDATE ... SET ... WHERE
- 2.2 The danger of UPDATE without WHERE
- 2.3 More than one column; setting a value to NULL
- 2.4 UPDATE can break rules too
**3. DELETE: removing rows**
- 3.1 DELETE ... WHERE
- 3.2 DELETE without WHERE
- 3.3 Deleting a parent that has children (ORA-02292) and the right order
- 3.4 DELETE vs TRUNCATE vs DROP
**4. Transactions**
- 4.1 What a transaction is
- 4.2 The Live SQL rule: one Run = one transaction
- 4.3 ROLLBACK: undo
- 4.4 COMMIT: save
- 4.5 SAVEPOINT and ROLLBACK TO
- 4.6 DDL commits automatically
- 4.7 Who sees my change?
**5. Practice**
- 5.1 20 exercises on the Day 9 tables
**6. Loading the shared practice database**
- 6.1 Run the College script and save it as `College_DB`
**7. 10 exam-style MCQs**

---
## Time plan

| Time | Block | What we do |
|---|---|---|
| 0:00 – 0:10 | 0 | Recap: 5 quick questions from last class; check everyone has the four empty tables |
| 0:10 – 0:40 | 1 | INSERT, and the errors when a rule is broken |
| 0:40 – 1:00 | 2 | UPDATE |
| 1:00 – 1:20 | 3 | DELETE; DELETE vs TRUNCATE vs DROP |
| 1:20 – 1:30 | — | Break |
| 1:30 – 2:00 | 4 | Transactions: COMMIT, ROLLBACK, SAVEPOINT |
| 2:00 – 2:35 | 5 | Practice: 20 exercises |
| 2:35 – 2:45 | 6 | Load the College script, save as `College_DB` |
| 2:45 – 2:55 | 7 | 10 quick MCQs |
| 2:55 – 3:00 | last | Key points, homework |

---

## Block 0 — Recap (10 min)

1. Which group of commands builds tables? Name its four commands.
2. Which rule gives `ORA-02291 ... parent key not found`?
3. Which is written at table level: NOT NULL or a compound primary key?
4. Which comes first, dropping `students` or dropping `branches`?
5. How do we write 1 August 2024 in SQL?

> **In simple words:** "Yesterday we built empty cupboards. Today we put things in, move them, take them out — and learn the undo button."

**One borrowed command.** To see what is inside a table we need SELECT, which is Day 11. Today we borrow only its simplest form and do not explain it further:
```sql
SELECT * FROM branches;      -- show every row and every column of branches
```

## Block 1 — INSERT: adding rows (30 min)

### 1.1 The simplest INSERT

**INSERT** adds one new row. The simplest form gives one value for every column, in the order the columns were created.

```sql
INSERT INTO branches VALUES ('CSE', 'Computer Science and Engineering', 'Dr. Rao');
```
Result: **1 row(s) inserted.** Now look:
```sql
SELECT * FROM branches;
```
| BRANCH_CODE | BRANCH_NAME | HEAD_NAME |
|---|---|---|
| CSE | Computer Science and Engineering | Dr. Rao |

Text goes in single quotes, exactly as it should be stored (`'CSE'`, not `'cse'`). The values are separated by commas, inside brackets, after the word VALUES.

### 1.2 INSERT with a column list (recommended)

Write the column names in brackets after the table name, then the values in the **same order**. This way the statement still works if someone later adds a column, and you can list the columns in any order you like.

```sql
INSERT INTO branches (branch_code, branch_name, head_name)
VALUES ('ECE', 'Electronics and Communication', 'Dr. Iyer');

INSERT INTO branches (branch_name, branch_code, head_name)
VALUES ('Mechanical Engineering', 'MECH', 'Dr. Singh');
```
Result: **1 row(s) inserted.** twice. `SELECT * FROM branches;` → 3 rows.

> **In simple words:** "Without a column list you must know the exact table order and give every column. With a column list, you say which column gets which value. Use the column list — the exam calls it the safer form."

### 1.3 NULL, dates and text

**NULL** means "no value". Two ways to store it: write the word `NULL` in the values, or leave the column out of the column list.

```sql
-- way 1: the word NULL (CIVIL has no head yet)
INSERT INTO branches VALUES ('CIVIL', 'Civil Engineering', NULL);

-- a full student row: text in quotes, dates as DATE 'YYYY-MM-DD', numbers bare
INSERT INTO students
VALUES (101, 'Ravi Kumar', 'ravi@college.edu', '9800000001', DATE '2006-03-15', DATE '2024-08-01', 'CSE');

-- way 2: leave phone out of the column list, so it becomes NULL
INSERT INTO students (roll_no, name, email, dob, admission_date, branch_code)
VALUES (102, 'Priya Sharma', 'priya@college.edu', DATE '2006-07-22', DATE '2024-08-01', 'CSE');
```
Result: **1 row(s) inserted.** three times. `SELECT * FROM students;` → 2 rows; Priya's PHONE column is empty.

| ROLL_NO | NAME | EMAIL | PHONE | DOB | ADMISSION_DATE | BRANCH_CODE |
|---|---|---|---|---|---|---|
| 101 | Ravi Kumar | ravi@college.edu | 9800000001 | 15-MAR-06 | 01-AUG-24 | CSE |
| 102 | Priya Sharma | priya@college.edu | *(null)* | 22-JUL-06 | 01-AUG-24 | CSE |

Oracle **shows** dates as `15-MAR-06`; we always **write** them as `DATE '2006-03-15'`. A number is written bare (`101`); a phone is text, so it is quoted.

Now the subjects and two enrollments we will use in the next blocks:
```sql
INSERT INTO subjects VALUES ('CS201', 'Database Systems',  4, 'CSE');
INSERT INTO subjects VALUES ('CS202', 'Operating Systems', 4, 'CSE');
INSERT INTO enrollments VALUES (101, 'CS201', 3, 88, 'A');
INSERT INTO enrollments VALUES (101, 'CS202', 3, 79, 'B');
```
Result: **1 row(s) inserted.** four times.

### 1.4 DEFAULT

If a column has a DEFAULT and you leave it out of the column list, Oracle fills the default in. Only `copies.status` has one (`DEFAULT 'AVAILABLE'`). If you built `books` and `copies` for homework:
```sql
INSERT INTO books VALUES ('9780073523323', 'Database System Concepts', 'Silberschatz', 'McGraw Hill');
INSERT INTO copies (isbn, copy_no) VALUES ('9780073523323', 1);
SELECT * FROM copies;
```
| ISBN | COPY_NO | STATUS |
|---|---|---|
| 9780073523323 | 1 | AVAILABLE |

You can also write the word `DEFAULT` in the value position: `INSERT INTO copies VALUES ('9780073523323', 2, DEFAULT);` → status AVAILABLE again.

### 1.5 When a rule is broken: the four errors

Type each one. Nothing is inserted; Oracle prints the error and the constraint name. (The part before the dot, `SQL_XYZ`, is your Live SQL schema name and will look different.)

| Broken rule | Statement | What Oracle prints |
|---|---|---|
| PRIMARY KEY (duplicate) | `INSERT INTO branches VALUES ('CSE', 'Computer Sci', NULL);` | `ORA-00001: unique constraint (SQL_XYZ.SYS_C0012345) violated` |
| NOT NULL (missing value) | `INSERT INTO students (roll_no, email, admission_date, branch_code) VALUES (103, 'arjun@college.edu', DATE '2024-08-01', 'ECE');` | `ORA-01400: cannot insert NULL into ("SQL_XYZ"."STUDENTS"."NAME")` |
| FOREIGN KEY (no such parent) | `INSERT INTO students (roll_no, name, email, admission_date, branch_code) VALUES (103, 'Arjun Reddy', 'arjun@college.edu', DATE '2024-08-01', 'IT');` | `ORA-02291: integrity constraint (SQL_XYZ.FK_STUDENTS_BRANCH) violated - parent key not found` |
| CHECK (value fails the test) | `INSERT INTO subjects VALUES ('CS999', 'Too Big', 6, 'CSE');` | `ORA-02290: check constraint (SQL_XYZ.CK_SUBJECTS_CREDITS) violated` |
| Wrong table name | `INSERT INTO student VALUES (103, 'Arjun Reddy', 'arjun@college.edu', NULL, NULL, DATE '2024-08-01', 'ECE');` | `ORA-00942: table or view does not exist` |

Also: UNIQUE gives the same `ORA-00001` as a primary key (try inserting roll 103 with email `ravi@college.edu`). Too many or too few values gives `ORA-00913: too many values` or `ORA-00947: not enough values`.

> **In simple words:** "The error tells you the rule and its name. `FK_STUDENTS_BRANCH` — so the branch does not exist. `CK_SUBJECTS_CREDITS` — so credits are out of range. Read the name, then fix the value."

## Block 2 — UPDATE: changing rows (20 min)

### 2.1 UPDATE ... SET ... WHERE

**UPDATE** changes values in rows that already exist. `SET` says which column gets which new value; `WHERE` says which rows.

```sql
UPDATE enrollments
SET    marks = 90
WHERE  roll_no = 101 AND subject_code = 'CS201';
```
Result: **1 row(s) updated.** `SELECT * FROM enrollments;` → Ravi's CS201 marks are now 90. A WHERE that matches nothing is not an error:
```sql
UPDATE enrollments SET marks = 90 WHERE roll_no = 999;
```
Result: **0 row(s) updated.**

### 2.2 The danger of UPDATE without WHERE

Without WHERE, **every row** in the table is changed.
```sql
UPDATE enrollments SET grade = 'B';
```
Result: **2 row(s) updated.** — both of Ravi's grades are now B, including the CS201 'A'. Nobody meant that. Put it right:
```sql
UPDATE enrollments SET grade = 'A' WHERE roll_no = 101 AND subject_code = 'CS201';
```
Result: **1 row(s) updated.** (In Block 4 you learn the real safety net: ROLLBACK.)

> **In simple words:** "Before you press Run on an UPDATE or DELETE, read the WHERE line twice. No WHERE means the whole table."

### 2.3 More than one column; setting a value to NULL

Separate the columns in SET with commas. To empty a column, set it to NULL.
```sql
UPDATE enrollments
SET    marks = 88, grade = 'A'
WHERE  roll_no = 101 AND subject_code = 'CS201';    -- back to the original 88 / A

UPDATE students SET phone = NULL WHERE roll_no = 101;             -- Ravi's phone removed
UPDATE students SET phone = '9800000001' WHERE roll_no = 101;     -- and put back
```
Result: **1 row(s) updated.** three times.

### 2.4 UPDATE can break rules too

The same constraints watch UPDATE:
```sql
UPDATE enrollments SET marks = 101 WHERE roll_no = 101 AND subject_code = 'CS201';
-- ORA-02290: check constraint (SQL_XYZ.CK_ENROLL_MARKS) violated
UPDATE students SET branch_code = 'IT' WHERE roll_no = 101;
-- ORA-02291: integrity constraint (SQL_XYZ.FK_STUDENTS_BRANCH) violated - parent key not found
UPDATE students SET name = NULL WHERE roll_no = 101;
-- ORA-01407: cannot update ("SQL_XYZ"."STUDENTS"."NAME") to NULL
```
Nothing changes when an error appears.

## Block 3 — DELETE: removing rows (20 min)

### 3.1 DELETE ... WHERE

**DELETE** removes whole rows (never single columns — that is UPDATE ... SET ... NULL).
```sql
DELETE FROM enrollments WHERE roll_no = 101 AND subject_code = 'CS202';
```
Result: **1 row(s) deleted.** `SELECT * FROM enrollments;` → 1 row. The table still exists; only the row is gone. Put it back:
```sql
INSERT INTO enrollments VALUES (101, 'CS202', 3, 79, 'B');
DELETE FROM enrollments WHERE roll_no = 999;
```
Result: **1 row(s) inserted.** then **0 row(s) deleted.** (no match, no error).

### 3.2 DELETE without WHERE

`DELETE FROM enrollments;` removes **every** row and keeps the empty table. We will run it in Block 4, where ROLLBACK can bring the rows back.

### 3.3 Deleting a parent that has children

Ravi (101) has two enrollments. Try to delete him:
```sql
DELETE FROM students WHERE roll_no = 101;
```
```
ORA-02292: integrity constraint (SQL_XYZ.FK_ENROLL_STUDENT) violated - child record found
```
The same happens for `DELETE FROM branches WHERE branch_code = 'CSE';` — students point at CSE (`FK_STUDENTS_BRANCH`). The rule: **delete the children first, then the parent** — the same order as dropping tables. To really remove Ravi you would delete his 2 enrollment rows, then his student row. Priya (102) has no enrollments, so `DELETE FROM students WHERE roll_no = 102;` would work (do not run it; we need her).

### 3.4 DELETE vs TRUNCATE vs DROP

| | DELETE FROM t WHERE ... | TRUNCATE TABLE t | DROP TABLE t |
|---|---|---|---|
| Group | DML | DDL | DDL |
| Removes | some or all rows | all rows | rows, table, rules |
| WHERE allowed? | yes | no | no |
| Table remains? | yes | yes (empty) | no |
| Can be undone with ROLLBACK? | **yes** | no | no |
| Checks foreign keys? | yes (ORA-02292) | refuses if a child table points at it | refuses if a child table points at it |

## Break (10 min)

## Block 4 — Transactions (30 min)

### 4.1 What a transaction is

A **transaction** is a group of DML changes that succeed or fail **together**. It starts with your first INSERT, UPDATE or DELETE and ends with COMMIT (save everything) or ROLLBACK (undo everything).

> **In simple words:** "Ravi pays his fee: one row goes into `fee_payments` and his status changes in another table. Both or neither. If the power goes off in between, the college must not end up with money received and no record — or a record and no money. That is what a transaction protects."

| Command | Plain meaning |
|---|---|
| **COMMIT** | Save. Every change since the last COMMIT becomes permanent and visible to everyone |
| **ROLLBACK** | Undo. Every change since the last COMMIT is thrown away |
| **SAVEPOINT name** | A bookmark inside the transaction |
| **ROLLBACK TO name** | Undo back to the bookmark only; the transaction continues |

### 4.2 The Live SQL rule: one Run = one transaction

In Live SQL, everything you put in the worksheet and run with **one click of Run** is one session, and Live SQL **commits automatically at the end of each Run**. So a ROLLBACK typed in the *next* Run undoes nothing — the previous Run is already saved. **Put the whole story — changes, SELECTs, ROLLBACK or COMMIT — in the worksheet together and click Run once.** Every example below is one Run.

### 4.3 ROLLBACK: undo

```sql
DELETE FROM enrollments;             -- 2 row(s) deleted.
SELECT * FROM enrollments;           -- no data found
ROLLBACK;                            -- Statement processed.
SELECT * FROM enrollments;           -- 2 rows: both enrollments are back
```
The DELETE really happened — the second line shows an empty table — and ROLLBACK undid it.

### 4.4 COMMIT: save

```sql
INSERT INTO subjects VALUES ('CS203', 'Data Structures', 3, 'CSE');   -- 1 row(s) inserted.
COMMIT;                                                              -- Statement processed.
ROLLBACK;                                                            -- nothing left to undo
SELECT * FROM subjects;                                              -- 3 rows: CS203 stays
```
After COMMIT there is no way back: ROLLBACK undoes only what is not yet committed.

### 4.5 SAVEPOINT and ROLLBACK TO

```sql
INSERT INTO students VALUES (103, 'Arjun Reddy', 'arjun@college.edu', '9600000003', DATE '2005-11-02', DATE '2024-08-01', 'ECE');
SAVEPOINT after_arjun;
INSERT INTO students VALUES (104, 'Meena Devi', 'meena@college.edu', '9500000004', DATE '2006-01-30', DATE '2024-08-01', 'ECE');
SAVEPOINT after_meena;
UPDATE students SET phone = NULL WHERE roll_no = 104;
ROLLBACK TO after_meena;          -- only the UPDATE is undone: Meena has her phone again
ROLLBACK TO after_arjun;          -- Meena's INSERT is undone too; Arjun stays
SELECT * FROM students;           -- 3 rows: 101, 102, 103
COMMIT;                           -- Arjun is now permanent
```
Board picture:
```
start ─► INSERT 103 ─► [after_arjun] ─► INSERT 104 ─► [after_meena] ─► UPDATE 104
  ▲                         ▲                              ▲
ROLLBACK             ROLLBACK TO after_arjun        ROLLBACK TO after_meena
(undo all)           (keep Arjun only)              (keep Arjun and Meena)
```

> **In simple words:** "SAVEPOINT is 'quick save' in a game. ROLLBACK TO goes back to that save. Plain ROLLBACK goes back to the start of the level. COMMIT ends the level — no going back."

### 4.6 DDL commits automatically

Any DDL statement (CREATE, ALTER, DROP, TRUNCATE) first commits whatever you changed, then runs.
```sql
INSERT INTO branches VALUES ('IT', 'Information Technology', NULL);   -- 1 row(s) inserted.
CREATE TABLE temp1 (id NUMBER(3));                                    -- DDL: the INSERT is committed now
ROLLBACK;                                                             -- too late
SELECT * FROM branches;                                               -- 5 rows: IT is still there
DROP TABLE temp1;
DELETE FROM branches WHERE branch_code = 'IT';                        -- clean up by hand
COMMIT;
```
Exam favourite: "A user runs an UPDATE and then CREATE TABLE. What happens to the UPDATE?" → it is committed.

### 4.7 Who sees my change?

- **You** see your change as soon as you run it (your own SELECT shows it).
- **Other users** keep seeing the **old** data until you COMMIT. After COMMIT everyone sees the new data.
- If your session ends without COMMIT (crash, power off), Oracle rolls the changes back.

> **In simple words:** "The exam clerk types Ravi's new marks but has not pressed COMMIT. Ravi refreshes the portal and still sees 88. The clerk commits — now Ravi sees 90."

## Block 5 — Practice (35 min)

Each line is one exercise. Exercises 1, 19 and 20 must be a single Run. Expected results are what a student whose tables match Blocks 1–4 will see (counts in exercise 1 may differ if someone experimented).

| # | Task | Answer SQL | Expected |
|---|---|---|---|
| 1 | Empty all four tables, children first, and save | `DELETE FROM enrollments; DELETE FROM students; DELETE FROM subjects; DELETE FROM branches; COMMIT;` | 2, 3, 3, 4 row(s) deleted |
| 2 | Add branch CSE (no column list) | `INSERT INTO branches VALUES ('CSE', 'Computer Science and Engineering', 'Dr. Rao');` | 1 row(s) inserted |
| 3 | Add ECE and MECH with a column list | `INSERT INTO branches (branch_code, branch_name, head_name) VALUES ('ECE', 'Electronics and Communication', 'Dr. Iyer');` and the same shape for `('MECH', 'Mechanical Engineering', 'Dr. Singh')` | 1 row(s) inserted, twice |
| 4 | Show the branches | `SELECT * FROM branches;` | 3 rows |
| 5 | Add student 101 with all columns | `INSERT INTO students VALUES (101, 'Ravi Kumar', 'ravi@college.edu', '9800000001', DATE '2006-03-15', DATE '2024-08-01', 'CSE');` | 1 row(s) inserted |
| 6 | Add student 102 without a phone, using a column list | `INSERT INTO students (roll_no, name, email, dob, admission_date, branch_code) VALUES (102, 'Priya Sharma', 'priya@college.edu', DATE '2006-07-22', DATE '2024-08-01', 'CSE');` | 1 row(s) inserted |
| 7 | Add students 103 and 104 (ECE) | `INSERT INTO students VALUES (103, 'Arjun Reddy', 'arjun@college.edu', '9600000003', DATE '2005-11-02', DATE '2024-08-01', 'ECE');` `INSERT INTO students VALUES (104, 'Meena Devi', 'meena@college.edu', '9500000004', DATE '2006-01-30', DATE '2024-08-01', 'ECE');` | 1 row(s) inserted, twice |
| 8 | Try to add 104 again with a new email | `INSERT INTO students VALUES (104, 'Meena D', 'meena2@college.edu', NULL, NULL, DATE '2024-08-01', 'ECE');` | ORA-00001 — nothing to fix, the row exists |
| 9 | Add subjects CS201 and CS202 | `INSERT INTO subjects VALUES ('CS201', 'Database Systems', 4, 'CSE');` `INSERT INTO subjects VALUES ('CS202', 'Operating Systems', 4, 'CSE');` | 1 row(s) inserted, twice |
| 10 | Intentional error 1: add CS203 with branch `'CS'` | `INSERT INTO subjects VALUES ('CS203', 'Data Structures', 3, 'CS');` | ORA-02291 (FK_SUBJECTS_BRANCH): parent key not found |
| 11 | Fix it | `INSERT INTO subjects VALUES ('CS203', 'Data Structures', 3, 'CSE');` | 1 row(s) inserted |
| 12 | Add three enrollments | `INSERT INTO enrollments VALUES (101, 'CS201', 3, 88, 'A');` `INSERT INTO enrollments VALUES (101, 'CS202', 3, 79, 'B');` `INSERT INTO enrollments VALUES (102, 'CS201', 3, 92, 'A');` | 1 row(s) inserted, three times |
| 13 | Intentional error 2: Priya's CS203 marks typed as 670 | `INSERT INTO enrollments VALUES (102, 'CS203', 3, 670, 'C');` | ORA-02290 (CK_ENROLL_MARKS) |
| 14 | Fix it, then show enrollments | `INSERT INTO enrollments VALUES (102, 'CS203', 3, 67, 'C');` `SELECT * FROM enrollments;` | 1 row(s) inserted; 4 rows |
| 15 | Priya's CS203 paper was re-checked: 70 marks, grade B | `UPDATE enrollments SET marks = 70, grade = 'B' WHERE roll_no = 102 AND subject_code = 'CS203';` | 1 row(s) updated |
| 16 | Give 100 marks to student 108 in CS201 (nobody has that roll) | `UPDATE enrollments SET marks = 100 WHERE roll_no = 108 AND subject_code = 'CS201';` | 0 row(s) updated — no error |
| 17 | Priya drops CS203 | `DELETE FROM enrollments WHERE roll_no = 102 AND subject_code = 'CS203';` | 1 row(s) deleted; 3 enrollments left |
| 18 | Try to remove Ravi (101) from students | `DELETE FROM students WHERE roll_no = 101;` | ORA-02292 (FK_ENROLL_STUDENT): child record found |
| 19 | Savepoint story, one Run: add CIVIL, bookmark, add student 105, bookmark, delete all enrollments, undo to the second bookmark, undo to the first, save | `INSERT INTO branches VALUES ('CIVIL', 'Civil Engineering', NULL); SAVEPOINT sp1; INSERT INTO students VALUES (105, 'Karthik S', 'karthik@college.edu', '9400000005', DATE '2005-09-18', DATE '2024-08-01', 'MECH'); SAVEPOINT sp2; DELETE FROM enrollments; ROLLBACK TO sp2; SELECT * FROM enrollments; ROLLBACK TO sp1; SELECT * FROM students; COMMIT; SELECT * FROM branches;` | enrollments 3 rows; students 4 rows (105 gone); branches 4 rows (CIVIL stays) |
| 20 | Load the full College database and save it | See Block 6 | 10 tables in the Schema tab; the two checks at the end show 8 students and 14 enrollments |

## Block 6 — Loading the shared practice database (10 min)

From Day 11 every class starts with the same data, so everyone's answers match the printed row counts.

1. Open `College_Database_Script.sql` in any text editor, select all, copy.
2. In Live SQL: **Clear** the worksheet, paste, click **Run** once. It takes a few seconds.
3. Read the output from the top: the first block is ten `DROP TABLE` lines — they drop the tables you built on Day 9 and for homework (a table you never created gives `ORA-00942: table or view does not exist`, which is fine here). Then ten **Table created.**, then many **1 row(s) inserted.**, then a COMMIT.
4. The script ends with two `SELECT *` checks: `students` must show **8 rows** and `enrollments` **14 rows**. Then open the **Schema** tab: you should see **10 tables**. (Full row counts, if you want to check every table with `SELECT *`: branches 4, students 8, teachers 6, subjects 8, teaches 8, enrollments 14, fee_payments 9, books 5, copies 7, loans 5.)
5. Click **Save**, name it `College_DB`, save. From now on: **My Scripts → College_DB → Run** rebuilds the whole database in one click whenever you want a clean copy.
6. Open the **Schema** tab and look at the ten tables. Click `students`, then `loans` — recognise the physical model from Day 7.

## Block 7 — 10 exam-style MCQs

1. Which group of commands is used to add, change and remove data in tables?
   A. DDL  B. DML  C. TCL  D. DCL

2. Which command adds a new row to a table?
   A. ADD  B. CREATE  C. INSERT  D. UPDATE

3. An UPDATE statement without a WHERE clause will:
   A. Give an error
   B. Change no rows
   C. Change every row in the table
   D. Change only the first row

4. You INSERT a student whose `branch_code` is 'IT', but no such branch exists. Which error appears?
   A. ORA-00001 unique constraint violated
   B. ORA-02291 parent key not found
   C. ORA-02292 child record found
   D. ORA-02290 check constraint violated

5. Which command makes the changes of a transaction permanent?
   A. SAVE  B. COMMIT  C. END  D. ROLLBACK

6. Which command undoes all changes since the last COMMIT?
   A. UNDO  B. ROLLBACK  C. DELETE  D. RESTORE

7. What is a SAVEPOINT?
   A. A backup copy of the table
   B. A marker inside a transaction that you can roll back to
   C. A command that saves the transaction
   D. A copy of the database on disk

8. Which of these can NOT be undone with ROLLBACK?
   A. INSERT  B. UPDATE  C. DELETE  D. TRUNCATE

9. A user updates a row but has not yet committed. What does another user see when reading that row?
   A. The new value
   B. The old value
   C. An error message
   D. An empty row

10. Which event automatically commits the current transaction?
    A. Running a SELECT
    B. Running a CREATE TABLE
    C. Running a SAVEPOINT
    D. Running an UPDATE

## Homework (bring to Day 11)

1. Run `College_DB` from My Scripts once more at home and check that the Schema tab shows ten tables.
2. In one Run: insert a fifth branch `('IT', 'Information Technology', NULL)`, a student 109 in IT, a SAVEPOINT, an enrollment for 109 in HS101, then `ROLLBACK TO` the savepoint and `ROLLBACK`. Write down what `SELECT * FROM students;` showed after each step.
3. In your notebook, write the shape of INSERT, UPDATE, DELETE, COMMIT, ROLLBACK, SAVEPOINT and ROLLBACK TO — one line each — and the four error numbers with their rule (00001, 01400, 02291/02292, 02290).
4. Read the ten tables in the Schema tab and, for each, write which columns are the primary key and which are foreign keys (you will need this for joins on Day 13).

## One-slide summary

- `INSERT INTO t (cols) VALUES (...)` adds one row; use the column list; text in quotes, dates as `DATE '2024-08-01'`, missing = NULL, DEFAULT fills in the default.
- Broken rule → nothing inserted: ORA-00001 (PK/UNIQUE), ORA-01400 (NOT NULL), ORA-02291 (FK parent missing), ORA-02290 (CHECK).
- `UPDATE t SET col = value, col2 = value2 WHERE ...` — no WHERE means every row.
- `DELETE FROM t WHERE ...` removes rows; a parent with children gives ORA-02292 — delete children first.
- DELETE is DML and can be rolled back; TRUNCATE and DROP are DDL and cannot.
- A transaction is a group of changes that succeed or fail together; COMMIT saves, ROLLBACK undoes.
- SAVEPOINT marks a point; ROLLBACK TO goes back to it without ending the transaction.
- DDL (CREATE, ALTER, DROP, TRUNCATE) commits automatically; others see only committed data.
- In Live SQL, one Run = one transaction; put COMMIT/ROLLBACK in the same Run.
- `College_DB` in My Scripts rebuilds the practice database any time.

## Simple glossary

| Word | Meaning in one line |
|---|---|
| DML | Commands that change data: INSERT, UPDATE, DELETE |
| TCL | Commands that save or undo DML changes: COMMIT, ROLLBACK, SAVEPOINT |
| INSERT | Adds a new row to a table |
| Column list | The bracketed list of column names after the table name in INSERT |
| UPDATE ... SET | Changes values in existing rows |
| DELETE | Removes whole rows from a table |
| WHERE | The part of UPDATE or DELETE that picks which rows are affected |
| NULL | No value; stored by writing NULL or leaving the column out |
| DEFAULT | The value Oracle fills in when a column is left out |
| Transaction | A group of changes that are saved or undone together |
| COMMIT | Makes the transaction's changes permanent and visible to all |
| ROLLBACK | Throws away all changes since the last COMMIT |
| SAVEPOINT | A bookmark inside a transaction |
| ROLLBACK TO | Undoes back to a bookmark, keeping the transaction open |
| Auto-commit | A commit Oracle does by itself — after any DDL, and in Live SQL at the end of each Run |
| Parent / child row | The row a foreign key points at / the row holding the foreign key |
