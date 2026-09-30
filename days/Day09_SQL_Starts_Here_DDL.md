# Day 09 — SQL Starts Here: What SQL Is, and Creating Tables (DDL)

**Exam syllabus points covered today (1Z0-006 → "Introduction to SQL" and "Mapping the Physical Model")**
- Using SQL: explain the relationship between a database and SQL
- DDL: purpose of DDL; use DDL to manage tables and their relationships
- Mapping Entities, Columns and Data Types: common data types (NUMBER, VARCHAR2, CHAR, DATE)
- Mapping Primary, Composite Primary and Foreign Keys: turning the Day 7 table list into real tables

**By the end of today, a student can:**
1. Say what SQL is and name its three command groups (DDL, DML, TCL) with two commands each.
2. Open Oracle Live SQL, type a statement, run it, and find the table in the Schema tab.
3. Choose NUMBER, VARCHAR2, CHAR or DATE for a column from the ERD.
4. Write CREATE TABLE with PRIMARY KEY, NOT NULL, UNIQUE, FOREIGN KEY, CHECK and DEFAULT.
5. Explain which Oracle error each rule gives and why parent tables are created first and dropped last.
6. Change a table with ALTER TABLE and remove one with DROP TABLE or empty it with TRUNCATE TABLE.

---

## Today's topics

**0. Recap**
- 5 quick questions from Day 8 (the physical model)
**1. What SQL is**
- 1.1 SQL: the only way to talk to Oracle
- 1.2 The three groups of commands: DDL, DML, TCL
- 1.3 One line for awareness: DCL
**2. Oracle Live SQL**
- 2.1 Sign in and the SQL Worksheet
- 2.2 Run, Save, My Scripts, Schema tab
- 2.3 Writing rules (`;`, quotes, `--` comments, spaces)
**3. Data types**
- 3.1 NUMBER, VARCHAR2, CHAR, DATE with College columns
- 3.2 How to write a date: `DATE '2024-08-01'`
**4. CREATE TABLE, one idea at a time**
- 4.1 `branches` with two columns and no rules
- 4.2 Add PRIMARY KEY
- 4.3 Add NOT NULL (the final `branches`)
- 4.4 `students`: FOREIGN KEY and UNIQUE
- 4.5 `subjects`: CHECK
- 4.6 `enrollments`: a compound PRIMARY KEY at table level
- 4.7 Naming constraints, column level vs table level, DEFAULT
- 4.8 The five rules and the error each one gives
- 4.9 Order of creating and order of dropping
**5. Changing and removing tables**
- 5.1 ALTER TABLE: ADD, MODIFY, DROP COLUMN, RENAME COLUMN
- 5.2 ALTER TABLE: ADD / DROP CONSTRAINT; RENAME table
- 5.3 DROP TABLE and TRUNCATE TABLE
- 5.4 Looking at a table: DESCRIBE and the Schema tab
**6. Practice**
- 6.1 Type the four tables yourself
- 6.2 Break it on purpose: DROP the parent, ALTER a child
**7. 10 exam-style MCQs**

---
## Time plan

| Time | Block | What we do |
|---|---|---|
| 0:00 – 0:10 | 0 | Recap: 5 quick questions from last class; everyone opens Live SQL |
| 0:10 – 0:25 | 1 | What SQL is; DDL, DML, TCL |
| 0:25 – 0:40 | 2 | Live SQL tour and writing rules |
| 0:40 – 0:50 | 3 | Data types |
| 0:50 – 1:35 | 4 | CREATE TABLE one idea at a time (students type along) |
| 1:35 – 1:45 | — | Break |
| 1:45 – 2:00 | 5 | ALTER, DROP, TRUNCATE, DESCRIBE |
| 2:00 – 2:45 | 6 | Practice: build the four tables, then break things on purpose |
| 2:45 – 2:55 | 7 | 10 quick MCQs |
| 2:55 – 3:00 | last | Key points, homework |

---

## Block 0 — Recap (10 min)

1. In the physical model, an entity becomes a ...?
2. A UID becomes a ...?
3. What is the primary key of ENROLLMENT and why is it two columns?
4. Which four data types did we pick columns from on Day 7?
5. Mandatory attribute (`*`) in the ERD becomes what rule on the column?

> **In simple words:** "For eight days we designed on paper. Today the paper design becomes real tables inside Oracle. From now on, laptops open every class."

## Block 1 — What SQL is (15 min)

### 1.1 SQL: the only way to talk to Oracle

**SQL** (Structured Query Language, say "sequel" or "S-Q-L") is the language you use to give orders to a relational database. Every relational database — Oracle, MySQL, SQL Server, PostgreSQL — understands SQL. The exam uses Oracle SQL.

> **In simple words:** "The database is a locked room full of tables. SQL is the only door. Whether it is a bank app, a college portal or you in Live SQL, everyone goes through the same door: an SQL statement."

A **statement** is one complete order to the database, ending with `;`. A **keyword** is a word SQL already knows (CREATE, TABLE, INSERT, SELECT). Your **schema** is your own area in the database: the tables that belong to you. SQL is not a programming language with loops and screens: you tell Oracle **what** you want, and one statement can create a table, put a row in, change it, or read it.

### 1.2 The three groups of commands

| Group | Full name | Plain meaning | Commands |
|---|---|---|---|
| **DDL** | Data Definition Language | Build and change the **structure** (the tables themselves) | CREATE, ALTER, DROP, TRUNCATE |
| **DML** | Data Manipulation Language | Put in, change and remove the **data** inside tables | INSERT, UPDATE, DELETE (SELECT is often listed here too) |
| **TCL** | Transaction Control Language | Save or undo a group of DML changes | COMMIT, ROLLBACK, SAVEPOINT |

> **In simple words:** "DDL is the carpenter who builds the cupboard. DML is you putting clothes in, moving them, taking them out. TCL is the 'save' or 'undo' button for what you did with the clothes."

Today is DDL only. Day 10 is DML and TCL. Days 11 to 14 are SELECT.

### 1.3 For awareness only: DCL

There is a fourth group, **DCL** (Data Control Language: GRANT and REVOKE), which gives or takes away other users' permission to use your tables. It exists, the exam may name it, and we do not use it in this course.

## Block 2 — Oracle Live SQL (15 min)

### 2.1 Sign in and the SQL Worksheet

1. Go to https://livesql.oracle.com and click **Sign In** (the free Oracle account from Day 8 homework).
2. The page that opens is the **SQL Worksheet**: a big white box where you type statements.
3. Type a statement, click **Run** (or press Ctrl+Enter). The result or the error appears under the box.

### 2.2 Run, Save, My Scripts, Schema tab

| Button / tab | What it does |
|---|---|
| **Run** | Runs everything in the worksheet, top to bottom |
| **Save** | Saves the text in the worksheet as a script with a name |
| **My Scripts** | Opens your saved scripts (on Day 10 we save `College_DB` here) |
| **Schema** (left menu) | Shows your tables; click a table to see its columns and rules |
| **Clear** | Empties the worksheet (your tables stay) |

### 2.3 Writing rules

```sql
-- This is a comment. Oracle ignores everything after two dashes.
CREATE TABLE test1 (id NUMBER(3));   -- keywords can be UPPER or lower case
create table test1 (id number(3));   -- same statement; fails only because test1 now exists
DROP TABLE test1;
```

| Rule | Example |
|---|---|
| Every statement ends with a semicolon `;` | `DROP TABLE test1;` |
| Keywords are not case-sensitive | `CREATE` = `create` |
| Text values go in **single** quotes and **are** case-sensitive | `'CSE'` is not the same as `'cse'` |
| Numbers and dates are not quoted like text | `4`, `DATE '2024-08-01'` |
| Spaces and new lines do not matter | You may write a statement on one line or ten |
| `--` starts a comment to the end of the line | `-- parent table` |

> **In simple words:** "Oracle does not care about capital letters in commands. It cares very much about capital letters inside quotes. `'CSE'` and `'cse'` are two different values."

Run the three lines above: **Table created.**, then `ORA-00955: name is already used by an existing object` (the name is taken), then **Table dropped.**

## Block 3 — Data types (10 min)

### 3.1 The four types we use

A **data type** tells Oracle what kind of value a column holds and how big it can be.

| Type | Holds | Size means | College examples |
|---|---|---|---|
| `NUMBER(p,s)` | Numbers | p = total digits, s = digits after the point | `roll_no NUMBER(6)` → up to 999999; `amount NUMBER(8,2)` → up to 999999.99; `credits NUMBER(1)` → 0 to 9 |
| `VARCHAR2(n)` | Text of changing length | n = maximum characters; short text takes less space | `name VARCHAR2(50)`, `branch_code VARCHAR2(10)`, `email VARCHAR2(80)` |
| `CHAR(n)` | Text of fixed length | always exactly n characters (padded with spaces) | `grade CHAR(1)` |
| `DATE` | A date (and time) | no size | `dob`, `admission_date`, `paid_on` |

Rule of thumb from the ERD: numbers you count or calculate with → NUMBER; names and codes → VARCHAR2 (CHAR only when the length never changes, like a one-letter grade); any day/month/year → DATE. A phone number is text (`VARCHAR2(15)`) because it may start with 0 or +.

### 3.2 How to write a date

In this course a date is always written as `DATE 'YYYY-MM-DD'`:

```sql
DATE '2024-08-01'      -- 1 August 2024
DATE '2006-03-15'      -- 15 March 2006
```

The word `DATE`, then the value in single quotes, year first, two-digit month, two-digit day.

## Block 4 — CREATE TABLE, one idea at a time (45 min)

### 4.1 `branches` with two columns and no rules

The simplest CREATE TABLE: the table name, then in brackets each column as `column_name  data_type`, separated by commas.

```sql
CREATE TABLE branches (
    branch_code   VARCHAR2(10),
    branch_name   VARCHAR2(60)
);
```
Result: **Table created.** Open **Schema** → `BRANCHES` → two columns, no rules at all. Right now Oracle would happily accept two branches with the same code, or a branch with no code. Drop it and we improve it:

```sql
DROP TABLE branches;
```
Result: **Table dropped.**

### 4.2 Add PRIMARY KEY

The **primary key** is the column that identifies each row (the UID from the ERD). Write `PRIMARY KEY` right after the data type.

```sql
CREATE TABLE branches (
    branch_code   VARCHAR2(10)  PRIMARY KEY,
    branch_name   VARCHAR2(60)
);
DROP TABLE branches;
```
A PRIMARY KEY means two things at once: no two rows can have the same `branch_code` **and** `branch_code` can never be empty. One table has exactly one primary key (it may cover more than one column — see 4.6).

### 4.3 Add NOT NULL (the final `branches`)

`NULL` means "no value, empty". A `*` (mandatory) attribute in the ERD becomes `NOT NULL`. An `o` (optional) attribute gets no rule. This is the final version — exactly the table in the College script:

```sql
CREATE TABLE branches (
    branch_code   VARCHAR2(10)  PRIMARY KEY,
    branch_name   VARCHAR2(60)  NOT NULL,
    head_name     VARCHAR2(50)
);
```
Result: **Table created.** Keep this one — do not drop it.

> **In simple words:** "Read it aloud: table branches; branch_code, text up to 10, primary key; branch_name, text up to 60, must be filled; head_name, text up to 50, may be empty."

### 4.4 `students`: FOREIGN KEY and UNIQUE

Two new rules:
- **UNIQUE** — no two rows may have the same value, but (unlike a primary key) it is not the row's identifier. Email is the secondary UID of STUDENT, so `email` is `NOT NULL UNIQUE`.
- **FOREIGN KEY ... REFERENCES** — a column whose value must already exist as a primary key in another table (the **parent**). It is the relationship line from the ERD. `students.branch_code` must be one of the codes in `branches`.

```sql
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
```
Result: **Table created.**

Read the last three lines slowly: "a rule named `fk_students_branch`: the column `branch_code` of this table must match the column `branch_code` of `branches`." The foreign key column has the **same type and size** as the primary key it points to: `VARCHAR2(10)` in both tables. `branch_code` is also `NOT NULL` because each STUDENT **must be** in a branch (solid line in the ERD).

### 4.5 `subjects`: CHECK

**CHECK** is a rule about the value itself: credits must be from 1 to 5.

```sql
CREATE TABLE subjects (
    subject_code  VARCHAR2(10)  PRIMARY KEY,
    title         VARCHAR2(60)  NOT NULL,
    credits       NUMBER(1)     NOT NULL,
    branch_code   VARCHAR2(10),
    CONSTRAINT ck_subjects_credits CHECK (credits BETWEEN 1 AND 5),
    CONSTRAINT fk_subjects_branch
        FOREIGN KEY (branch_code) REFERENCES branches (branch_code)
);
```
Result: **Table created.**

Here `branch_code` is **not** NOT NULL: a subject **may be** offered by a branch (HS101 Communication Skills has none). A foreign key column that allows NULL is how an optional relationship is stored.

### 4.6 `enrollments`: a compound PRIMARY KEY at table level

ENROLLMENT's UID is roll number **plus** subject code (barred to both parents). A primary key made of two or more columns cannot be written next to one column; it is written **after all the columns**, at **table level**, with the column names in brackets.

```sql
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
```
Result: **Table created.** The same student can appear many times, the same subject can appear many times, but the **pair** (101, 'CS201') can appear only once. Both key columns are also foreign keys — the pattern of every intersection entity.

### 4.7 Naming constraints, column level vs table level, DEFAULT

**Constraint** is the SQL word for a rule on a table. Every constraint has a name. If you do not give one, Oracle makes one up like `SYS_C0012345` — useless when an error message shows it. So name the ones you will read in error messages:

| Prefix | Rule | Example |
|---|---|---|
| `pk_` | PRIMARY KEY | `pk_enrollments` |
| `fk_` | FOREIGN KEY | `fk_students_branch` (child_parent) |
| `ck_` | CHECK | `ck_subjects_credits` |
| `uq_` | UNIQUE | `uq_students_email` (we left this one unnamed) |

Two places to write a rule:

| | Column level | Table level |
|---|---|---|
| Where | Right after the data type of one column | After the last column, as its own line |
| Shape | `credits NUMBER(1) NOT NULL` | `CONSTRAINT ck_subjects_credits CHECK (credits BETWEEN 1 AND 5)` |
| Can name it? | Yes: `credits NUMBER(1) CONSTRAINT ck_x CHECK (...)` | Yes (the normal way) |
| Must use table level when | — | the rule covers **more than one column** (compound PK, two-column FK) |
| NOT NULL | Column level only | Not allowed here |

**DEFAULT** is not a rule but a helper: the value Oracle fills in when a row is added without that column. In the `copies` table (homework) a new copy is AVAILABLE unless told otherwise:

```sql
status  VARCHAR2(10)  DEFAULT 'AVAILABLE' NOT NULL
```

### 4.8 The five rules and the error each one gives

You cannot see these errors today (adding rows is Day 10), but write them in your notebook now: the exam asks "which constraint gives this error?".

| Constraint | Plain meaning | ERD source | Error when broken (Day 10) |
|---|---|---|---|
| PRIMARY KEY | identifies the row: unique and never NULL | `#` UID | `ORA-00001: unique constraint (...) violated` |
| NOT NULL | the column must have a value | `*` mandatory | `ORA-01400: cannot insert NULL into (...)` |
| UNIQUE | no two rows share this value (NULL allowed) | secondary UID | `ORA-00001: unique constraint (...) violated` |
| FOREIGN KEY | the value must exist in the parent table | relationship line | `ORA-02291: integrity constraint (...) violated - parent key not found` when the child points at a missing parent; `ORA-02292: integrity constraint (...) violated - child record found` when you delete a parent that still has children |
| CHECK | the value must pass a test | business rule | `ORA-02290: check constraint (...) violated` |

The `(...)` shows the constraint name — which is why we name constraints. Two more errors you **will** see today:

| Error | When |
|---|---|
| `ORA-00942: table or view does not exist` | You typed a table name that does not exist (typo, or the table was dropped, or you never created it) |
| `ORA-00955: name is already used by an existing object` | You ran CREATE TABLE for a name that already exists (run DROP TABLE first) |

### 4.9 Order of creating and order of dropping

A foreign key points at a parent table, so the parent must exist first.

- **Create:** parents first, children later. `branches` → `students`, `subjects` → `enrollments`.
- **Drop:** children first, parents last. `enrollments` → `students`, `subjects` → `branches`.

If you drop a parent while a child still points at it, Oracle refuses:
```
ORA-02449: unique/primary keys in table referenced by foreign keys
```

> **In simple words:** "Build the wall before you hang the picture. Take the picture down before you demolish the wall."

## Break (10 min)

## Block 5 — Changing and removing tables (15 min)

### 5.1 ALTER TABLE for columns

**ALTER TABLE** changes the structure of a table that already exists (the data inside stays).

```sql
ALTER TABLE students ADD (hostel_room VARCHAR2(10));      -- new column, empty in every row
ALTER TABLE students MODIFY (hostel_room VARCHAR2(20));   -- make it bigger
ALTER TABLE students RENAME COLUMN hostel_room TO room_no; -- new name
ALTER TABLE students DROP COLUMN room_no;                  -- remove it, with its data
```
Each one says **Table altered.** You can make a VARCHAR2 column bigger any time; making it smaller or adding NOT NULL only works if the existing data allows it.

### 5.2 ALTER TABLE for constraints; renaming a table

```sql
ALTER TABLE subjects DROP CONSTRAINT ck_subjects_credits;                                   -- rule gone
ALTER TABLE subjects ADD CONSTRAINT ck_subjects_credits CHECK (credits BETWEEN 1 AND 5);   -- rule back
ALTER TABLE students MODIFY (phone NOT NULL);     -- adds NOT NULL (works now: the table is empty)
ALTER TABLE students MODIFY (phone NULL);         -- removes it again
RENAME students TO learners;                       -- rename the whole table ...
RENAME learners TO students;                       -- ... and back
```
To add or drop a constraint you use its name — one more reason to name them.

### 5.3 DROP TABLE and TRUNCATE TABLE

| Command | What goes | What stays | Can it be undone? | Group |
|---|---|---|---|---|
| `DROP TABLE enrollments;` | the table, its rows, its rules | nothing | No | DDL |
| `TRUNCATE TABLE enrollments;` | all the rows | the empty table with its rules | No | DDL |
| `DELETE FROM enrollments;` (Day 10) | all the rows | the empty table | Yes, with ROLLBACK | DML |

Both DROP and TRUNCATE are DDL: they happen at once and cannot be rolled back. Do not type either one on a table you care about.

### 5.4 Looking at a table

```sql
DESCRIBE students;
```
Live SQL prints each column with its type and whether it allows NULL. The **Schema** tab shows the same plus the constraints (click the table, then **Constraints**). `DESCRIBE` on a name that does not exist gives `ORA-00942`.

## Block 6 — Practice (45 min)

### 6.1 Type the four tables yourself (25 min)

Clear the worksheet. Drop what you built in Block 4 (children first!) and rebuild all four tables from the Day 7 table list **without looking at Block 4**. Run each statement, then check it in the Schema tab.

| # | Task | Expected message |
|---|---|---|
| 1 | Drop the four tables in the right order: `enrollments`, `students`, `subjects`, `branches` | **Table dropped.** four times |
| 2 | Create `branches` (PK, NOT NULL on the name, optional head) | **Table created.** |
| 3 | Create `students` (PK, NOT NULL name/email/admission_date/branch_code, UNIQUE email, FK `fk_students_branch`) | **Table created.** |
| 4 | Create `subjects` (PK, NOT NULL title/credits, CHECK `ck_subjects_credits`, FK `fk_subjects_branch`) | **Table created.** |
| 5 | Create `enrollments` (compound PK `pk_enrollments`, two FKs, CHECK `ck_enroll_marks`) | **Table created.** |
| 6 | `DESCRIBE enrollments;` — how many columns allow NULL? | 2 (`marks`, `grade`) |
| 7 | Schema tab → `STUDENTS` → Constraints: find the PK, the UNIQUE and the FK | `fk_students_branch` is the only one with a name you chose; the others are `SYS_C...` |

### 6.2 Break it on purpose (20 min)

| # | Try this | What you see | Why |
|---|---|---|---|
| 8 | `DROP TABLE branches;` | `ORA-02449: unique/primary keys in table referenced by foreign keys` | `students` and `subjects` still point at it |
| 9 | `CREATE TABLE branches (branch_code VARCHAR2(10));` | `ORA-00955: name is already used by an existing object` | the table already exists |
| 10 | `DESCRIBE student;` | `ORA-00942: table or view does not exist` | the table is `students` — spelling matters |
| 11 | `ALTER TABLE students ADD (blood_group CHAR(3));` then `DESCRIBE students;` | **Table altered.**; 8 columns | a new optional column |
| 12 | `ALTER TABLE students MODIFY (blood_group VARCHAR2(5));` | **Table altered.** | CHAR → VARCHAR2 and bigger is allowed on an empty column |
| 13 | `ALTER TABLE students DROP COLUMN blood_group;` then `DESCRIBE students;` | **Table altered.**; back to 7 columns | column removed |
| 14 | `ALTER TABLE enrollments DROP CONSTRAINT ck_enroll_marks;` then add it back with the same name | **Table altered.** twice | a rule can be removed and re-added |
| 15 | `CREATE TABLE enrollments2 (roll_no NUMBER(6), subject_code VARCHAR2(10) PRIMARY KEY (roll_no, subject_code));` | `ORA-00907: missing right parenthesis` | a two-column key cannot sit next to one column; it goes at table level |
| 16 | `TRUNCATE TABLE enrollments;` | **Table truncated.** | it was empty anyway; the table and its rules stay |

## Block 7 — 10 exam-style MCQs

1. Which SQL group does CREATE TABLE belong to?
   A. DML  B. DDL  C. TCL  D. DCL

2. Which rule allows NULL values but does not allow duplicates?
   A. PRIMARY KEY  B. NOT NULL  C. UNIQUE  D. FOREIGN KEY

3. How many PRIMARY KEY constraints can one table have?
   A. One  B. Two  C. One per column  D. Unlimited

4. Which constraint makes sure `marks` is between 0 and 100?
   A. UNIQUE  B. CHECK  C. NOT NULL  D. DEFAULT

5. Which command adds a column to an existing table?
   A. UPDATE TABLE … ADD  B. ALTER TABLE … ADD  C. INSERT COLUMN  D. MODIFY TABLE

6. A foreign key column in the child table must:
   A. Have the same data type as the primary key it references
   B. Always be NOT NULL
   C. Be the primary key of the child
   D. Be a NUMBER

7. Which statement removes all rows, keeps the table, and cannot be rolled back?
   A. DELETE  B. DROP  C. TRUNCATE  D. ALTER

8. You try to drop the `branches` table and Oracle refuses. The most likely reason is:
   A. The table is empty
   B. Other tables have foreign keys pointing to it
   C. It has a CHECK constraint
   D. It has more than one column

9. A constraint on two columns together (such as a compound primary key) must be written:
   A. At column level, after the first column
   B. At table level, after all the columns
   C. In a separate CREATE CONSTRAINT command
   D. Inside the data type

10. What does DEFAULT 'AVAILABLE' do on the `status` column?
    A. Prevents any other value
    B. Fills in 'AVAILABLE' when no value is given
    C. Makes the column the primary key
    D. Deletes rows with other values

## Homework (bring to Day 10)

1. In Live SQL, type and run the remaining six tables from the Day 7 table list, in this order: `teachers`, `teaches`, `fee_payments`, `books`, `copies`, `loans`. Use the constraint names from the list (`fk_teachers_branch`, `fk_teachers_hod`, `pk_teaches`, `fk_fee_student`, `ck_fee_mode`, `pk_copies`, `ck_copies_status`, `fk_loans_copy`, `ck_loans_arc` ...). Hint: `teachers` has a foreign key to itself; `copies` has the DEFAULT from 4.7; `loans` has a two-column foreign key `FOREIGN KEY (isbn, copy_no) REFERENCES copies (isbn, copy_no)`.
2. Write in your notebook the correct **drop order** for all ten tables.
3. Fill a table with two columns: "rule" and "Oracle error number" for PRIMARY KEY, NOT NULL, UNIQUE, FOREIGN KEY (both directions), CHECK.

## One-slide summary

- SQL is the one language every relational database understands; it is the only way in.
- DDL builds structure (CREATE, ALTER, DROP, TRUNCATE); DML changes data (INSERT, UPDATE, DELETE); TCL saves or undoes (COMMIT, ROLLBACK, SAVEPOINT).
- Statements end with `;`; keywords are not case-sensitive; text in single quotes is.
- Four data types: NUMBER(p,s), VARCHAR2(n), CHAR(n), DATE; dates are written `DATE '2024-08-01'`.
- `CREATE TABLE name ( column type rule, ..., CONSTRAINT name RULE (...) );`
- PRIMARY KEY = unique + not null; UNIQUE allows NULL; NOT NULL; FOREIGN KEY ... REFERENCES parent(pk); CHECK (test); DEFAULT value.
- Multi-column rules go at table level; name constraints `pk_`, `fk_`, `ck_`.
- Errors: ORA-00001 unique, ORA-01400 NULL, ORA-02291 parent missing, ORA-02292 child exists, ORA-02290 check, ORA-00942 no such table.
- Create parents first, drop children first.
- ALTER TABLE changes structure; DROP and TRUNCATE are DDL and cannot be undone.

## Simple glossary

| Word | Meaning in one line |
|---|---|
| SQL | The language used to give orders to a relational database |
| Statement | One complete SQL order, ending with `;` |
| DDL | Commands that build or change table structure (CREATE, ALTER, DROP, TRUNCATE) |
| DML | Commands that change the data in tables (INSERT, UPDATE, DELETE) |
| TCL | Commands that save or undo DML changes (COMMIT, ROLLBACK, SAVEPOINT) |
| Schema | Your own set of tables in the database; also the Live SQL tab that shows them |
| Data type | The kind and size of value a column can hold |
| NULL | No value at all (not zero, not a blank space) |
| Constraint | A rule on a table that Oracle enforces on every row |
| Primary key | The column(s) that identify a row: unique and never NULL |
| Compound primary key | A primary key made of two or more columns |
| Foreign key | A column whose value must exist as a primary key in the parent table |
| Parent / child table | The table pointed at by a foreign key / the table that holds the foreign key |
| UNIQUE | No two rows may share the value; NULL is allowed |
| CHECK | A test every value must pass |
| DEFAULT | The value used when none is given |
| DESCRIBE | Shows the columns of a table |
