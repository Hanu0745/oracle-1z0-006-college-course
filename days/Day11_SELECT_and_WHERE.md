# Day 11 — Reading Data: SELECT and WHERE

**Exam syllabus points covered today (1Z0-006 → "Introduction to SQL")**
- Basic SELECT: the connection between an ERD and a relational database using SELECT
- Basic SELECT: build a SELECT to retrieve data from a table
- Basic SELECT: use WHERE to filter (choose) rows

**By the end of today, a student can:**
1. Look at a table in the ERD or the Schema tab and write `SELECT ... FROM ...` for it.
2. Choose columns, give them a nickname (alias), do simple maths, and glue text with `||`.
3. Explain what NULL does in maths (anything + NULL = NULL).
4. Remove repeated values with DISTINCT.
5. Choose rows with `=`, `<>`, `>`, `>=`, `<`, `<=`, BETWEEN, IN, LIKE, IS NULL.
6. Write text and dates correctly in a WHERE (single quotes, exact capital letters, `DATE 'YYYY-MM-DD'`).
7. Combine conditions with AND, OR, NOT and use brackets when AND and OR are mixed.

---

## Today's topics

**0. Recap**
- 5 quick questions from Day 10; data check

**1. SELECT: from the diagram to the query**
- 1.1 The table instance chart tells you the table name and the columns
- 1.2 `SELECT *` — all columns
- 1.3 A column list — only the columns you name, in the order you name them
- 1.4 Nicknames for columns (alias, `AS`)
- 1.5 Simple maths in a query (`+ - * /`)
- 1.6 NULL in maths: anything + NULL = NULL
- 1.7 Gluing text together: `||`
- 1.8 Removing repeats: DISTINCT

**2. WHERE: choosing rows**
- 2.1 The six comparisons: `= <> > >= < <=`
- 2.2 Text values: single quotes, and capital letters matter
- 2.3 Dates: `DATE 'YYYY-MM-DD'`
- 2.4 BETWEEN: a range, both ends included
- 2.5 IN: any value from a list
- 2.6 LIKE: patterns with `%` and `_`
- 2.7 IS NULL and IS NOT NULL: finding the blanks
- 2.8 AND, OR, NOT — and the order Oracle reads them

**3. Practice**
- 3.1 30 query exercises (easy → medium → harder)

**4. Going through the answers**

---
## Time plan

| Time | Block | What we do |
|---|---|---|
| 0:00 – 0:10 | 0 | Recap: 5 quick questions from last class; data check |
| 0:10 – 0:50 | 1 | SELECT: from the diagram to the query; columns, alias, maths, NULL, `\|\|`, DISTINCT |
| 0:50 – 1:35 | 2 | WHERE: comparisons, text, dates, BETWEEN, IN, LIKE, IS NULL, AND/OR/NOT |
| 1:35 – 1:45 | — | Break |
| 1:45 – 2:35 | 3 | Practice: 30 query exercises on the College DB |
| 2:35 – 2:45 | 4 | Going through the answers |
| 2:45 – 2:55 | 5 | 10 exam-style MCQs |
| 2:55 – 3:00 | last | Key points, homework |

---

## Block 0 — Recap (10 min)

Ask quickly (one-line answers):
1. Which three commands change data? *(INSERT, UPDATE, DELETE)*
2. What does COMMIT do? *(Saves the changes for good; other users can now see them)*
3. UPDATE without WHERE changes how many rows? *(Every row in the table)*
4. Can TRUNCATE be rolled back? *(No — it is DDL, it commits by itself)*
5. What does another user see before you COMMIT? *(Only the old, committed data)*

> **In simple words:** "For ten days we designed and built. Today is the first day we *ask the database questions*. SELECT is the command you will use ninety percent of the time in any job."

---

## Block 1 — SELECT: from the diagram to the query (40 min)

### 1.1 The table instance chart tells you the table name and the columns

On Day 7 we turned the ERD into a table list. That list is all you need to write a query: the **entity** became a **table** (write it after FROM), and the **attributes** became **columns** (write them after SELECT). The business question ("only CSE students") becomes the WHERE line.

| In the ERD (Part A) | In the database | In the query |
|---|---|---|
| Entity BRANCH | table `branches` | `FROM branches` |
| Attributes code, name | columns `branch_code`, `branch_name` | `SELECT branch_code, branch_name` |
| "only the CSE branch" | a row where branch_code is CSE | `WHERE branch_code = 'CSE'` |
| A relationship line | a foreign key | a join (Day 13) |

> **In simple words:** "Every question has three parts. *What* do you want to see? — that is SELECT. *Where* is it kept? — that is FROM. *Which rows*? — that is WHERE. Write them in that order, always."

```
SELECT   which columns
FROM     which table
WHERE    which rows          (optional — Block 2)
```

### 1.2 `SELECT *` — all columns

The simplest possible query. `*` (star) means "all columns".

```sql
SELECT * FROM branches;
```
Result (4 rows):
```
BRANCH_CODE  BRANCH_NAME                        HEAD_NAME
CSE          Computer Science and Engineering   Dr. Rao
ECE          Electronics and Communication      Dr. Iyer
MECH         Mechanical Engineering             Dr. Singh
CIVIL        Civil Engineering                  (blank)
```

> 📌 SELECT never changes data. You can run it a thousand times safely. The result is a temporary grid on the screen, not a new table.

### 1.3 A column list — only the columns you name, in the order you name them

```sql
-- Two columns of branches (4 rows)
SELECT branch_code, branch_name FROM branches;

-- Two columns of students (8 rows)
SELECT name, email FROM students;

-- Any order you like; the table itself is not changed (8 rows)
SELECT branch_code, name, roll_no FROM students;
```

**Column** = one field of the table, such as `name`. Separate column names with **commas**. The result shows the columns in the order you wrote them.

### 1.4 Nicknames for columns (alias, `AS`)

**Alias** = a nickname you give a column in the result, just for the heading on screen.

```sql
-- AS gives the column a new heading (8 rows)
SELECT name AS student_name, email AS mail_id FROM students;

-- A nickname with a space or small letters goes in DOUBLE quotes (8 rows)
SELECT name AS "Student Name", phone AS "Mobile No" FROM students;
```

| Quote type | Used for | Example |
|---|---|---|
| Single `' '` | Text **values** | `'CSE'`, `'Ravi Kumar'` |
| Double `" "` | Column **nicknames** with spaces or small letters | `"Student Name"` |

### 1.5 Simple maths in a query (`+ - * /`)

```sql
-- Credits × 25 = maximum marks for the subject (8 rows)
SELECT subject_code, credits, credits * 25 AS max_marks FROM subjects;

-- Fee amount plus 18% tax, shown next to the original (9 rows)
SELECT payment_id, amount, amount * 1.18 AS with_tax FROM fee_payments;

-- * and / are done before + and -. Brackets force the order. (8 rows)
SELECT credits, credits + 2 * 10 AS without_brackets, (credits + 2) * 10 AS with_brackets FROM subjects;
```
For CS201 (4 credits): `without_brackets` = 4 + 20 = **24**; `with_brackets` = 6 × 10 = **60**.

The table data does **not** change. Maths in SELECT only changes what is **shown**.

### 1.6 NULL in maths: anything + NULL = NULL

**NULL** = empty, unknown, not filled in. It is not zero and not a blank space.

```sql
-- Sneha (106) has no marks in CS201, so her bonus is blank, not 5 (14 rows)
SELECT roll_no, subject_code, marks, marks + 5 AS with_bonus FROM enrollments;
```
Row for 106 / CS201: `MARKS` blank, `WITH_BONUS` blank.

> **In simple words:** "NULL means *unknown*. Unknown plus five is still unknown. So the answer is blank, not five."

### 1.7 Gluing text together: `||`

Two vertical bars join pieces of text into one column. Fixed text goes in single quotes.

```sql
-- One sentence per student (8 rows), e.g.  Ravi Kumar belongs to CSE
SELECT name || ' belongs to ' || branch_code AS sentence FROM students;

-- Code and title together (8 rows), e.g.  CS201 - Database Systems
SELECT subject_code || ' - ' || title AS label FROM subjects;
```

### 1.8 Removing repeats: DISTINCT

```sql
-- Every row, so CSE appears 4 times (8 rows)
SELECT branch_code FROM students;

-- Each different value once (3 rows: CSE, ECE, MECH)
SELECT DISTINCT branch_code FROM students;

-- DISTINCT looks at the whole combination of columns (5 rows)
SELECT DISTINCT branch_code, admission_date FROM students;
```
Why 5 in the last one? The pairs are CSE/2024, ECE/2024, MECH/2024, MECH/2025, CSE/2025. CIVIL does not appear because no student is in CIVIL.

> ✏️ **Activity 1 (5 min):** Write a SELECT that shows, for each subject, the text `CS201 - Database Systems (4 credits)` in one column named `label`.' AS label FROM subjects;` → 8 rows.)

---

## Block 2 — WHERE: choosing rows (45 min)

**WHERE** = the line that keeps only the rows that pass a test (a *condition*). Rows that fail the test are simply not shown; nothing is deleted.

### 2.1 The six comparisons: `= <> > >= < <=`

| Sign | Meaning | Example |
|---|---|---|
| `=` | equal to | `branch_code = 'CSE'` |
| `<>` | not equal to (`!=` also works) | `pay_mode <> 'UPI'` |
| `>` `<` | greater than / less than | `marks > 80` |
| `>=` `<=` | greater or equal / less or equal | `credits >= 3` |

```sql
-- Start with one condition on the simplest table (4 rows)
SELECT * FROM students WHERE branch_code = 'CSE';

-- Marks above 80 (5 rows: 88, 91, 92, 95, 85)
SELECT roll_no, subject_code, marks FROM enrollments WHERE marks > 80;

-- Marks 80 or above — now the 80 is included too (6 rows)
SELECT roll_no, subject_code, marks FROM enrollments WHERE marks >= 80;

-- Payments NOT made by UPI (4 rows)
SELECT payment_id, pay_mode FROM fee_payments WHERE pay_mode <> 'UPI';

-- Subjects with fewer than 4 credits (4 rows)
SELECT title, credits FROM subjects WHERE credits < 4;
```

### 2.2 Text values: single quotes, and capital letters matter

```sql
SELECT * FROM students WHERE branch_code = 'CSE';    -- 4 rows
SELECT * FROM students WHERE branch_code = 'cse';    -- 0 rows!  'cse' is not 'CSE'
SELECT * FROM students WHERE branch_code = CSE;      -- ERROR ORA-00904: Oracle thinks CSE is a column name
```

> 📌 **Exam-likely, and the number one beginner mistake:** text must be in **single quotes** and must match the stored value **exactly**, including capital and small letters. Numbers are written without quotes: `marks > 80`.

### 2.3 Dates: `DATE 'YYYY-MM-DD'`

A date is written as the word DATE, then the date in single quotes, year first.

```sql
-- Students admitted on 1 August 2025 (2 rows: Vikram, Anjali)
SELECT name, admission_date FROM students WHERE admission_date = DATE '2025-08-01';

-- Teachers who joined after 1 January 2018 (4 rows)
SELECT name, joining_date FROM teachers WHERE joining_date > DATE '2018-01-01';

-- Students born before 2006 (2 rows: Arjun, Karthik)
SELECT name, dob FROM students WHERE dob < DATE '2006-01-01';
```
"Greater than" for dates means **later**; "less than" means **earlier**.

### 2.4 BETWEEN: a range, both ends included

```sql
-- Marks from 60 to 79, including 60 and 79 (5 rows: 79, 67, 74, 72, 63)
SELECT roll_no, subject_code, marks FROM enrollments WHERE marks BETWEEN 60 AND 79;

-- Same as:  marks >= 60 AND marks <= 79

-- Payments made in August 2024 (5 rows)
SELECT payment_id, paid_on FROM fee_payments
WHERE  paid_on BETWEEN DATE '2024-08-01' AND DATE '2024-08-31';

-- Smaller value must come first. This gives 0 rows, and no error!
SELECT roll_no, marks FROM enrollments WHERE marks BETWEEN 79 AND 60;
```

### 2.5 IN: any value from a list

```sql
-- Students in MECH or CIVIL (2 rows — both are MECH; CIVIL has no students)
SELECT name, branch_code FROM students WHERE branch_code IN ('MECH', 'CIVIL');

-- Same as:  branch_code = 'MECH' OR branch_code = 'CIVIL'

-- Enrollments with grade A or B (9 rows)
SELECT roll_no, subject_code, grade FROM enrollments WHERE grade IN ('A', 'B');
```

### 2.6 LIKE: patterns with `%` and `_`

| Symbol | Means |
|---|---|
| `%` | any number of characters (including none) |
| `_` | exactly one character |

```sql
-- Names starting with A (2 rows: Arjun Reddy, Anjali Gupta)
SELECT name FROM students WHERE name LIKE 'A%';

-- Titles ending with the word Systems (3 rows)
SELECT title FROM subjects WHERE title LIKE '%Systems';

-- Titles with "System" anywhere inside (3 rows, the same three)
SELECT title FROM subjects WHERE title LIKE '%System%';

-- Subject codes: CS, then exactly three characters (4 rows)
SELECT subject_code FROM subjects WHERE subject_code LIKE 'CS___';

-- Capital letters matter here too:
SELECT name FROM students WHERE name LIKE '%a%';    -- names with a small a → 7 rows (Arjun Reddy has none)
SELECT name FROM students WHERE name LIKE '%A%';    -- names with a capital A → 2 rows
```

### 2.7 IS NULL and IS NOT NULL: finding the blanks

```sql
-- Students who have not given a phone number (2 rows: Priya, Sneha)
SELECT name FROM students WHERE phone IS NULL;

-- Students who have (6 rows)
SELECT name FROM students WHERE phone IS NOT NULL;

-- WRONG: this gives 0 rows, never an error
SELECT name FROM students WHERE phone = NULL;
```

Why does `= NULL` never work? NULL means *unknown*. "Is this unknown value equal to unknown?" — Oracle cannot say yes, so no row passes. The only test that works for blanks is `IS NULL`.

> 📌 **Exam-likely:** "Which condition finds rows where a column is empty?" → `IS NULL`. `= NULL` is always false.

### 2.8 AND, OR, NOT — and the order Oracle reads them

| Word | Row is chosen when… |
|---|---|
| `AND` | **both** conditions are true |
| `OR` | **at least one** condition is true |
| `NOT` | the condition is **false** |

```sql
-- CSE students who gave a phone number (2 rows: Ravi, Anjali)
SELECT name FROM students WHERE branch_code = 'CSE' AND phone IS NOT NULL;

-- Students in CSE or in ECE (6 rows)
SELECT name FROM students WHERE branch_code = 'CSE' OR branch_code = 'ECE';

-- Students not in CSE (4 rows)
SELECT name FROM students WHERE NOT branch_code = 'CSE';

-- NOT works with IN, LIKE and BETWEEN too
SELECT name FROM students WHERE branch_code NOT IN ('CSE', 'ECE');              -- 2 rows
SELECT name FROM students WHERE name NOT LIKE 'A%';                            -- 6 rows
SELECT roll_no, marks FROM enrollments WHERE marks NOT BETWEEN 60 AND 79;      -- 8 rows (the NULL row is left out)
```

**Order of reading: NOT first, then AND, then OR.** When AND and OR are mixed, **always use brackets**.

```sql
-- Without brackets Oracle reads it as  CSE  OR  (ECE AND no phone)  → 4 + 0 = 4 rows
SELECT name, branch_code, phone FROM students
WHERE  branch_code = 'CSE' OR branch_code = 'ECE' AND phone IS NULL;

-- With brackets: (CSE OR ECE) AND no phone → 2 rows (Priya, Sneha)
SELECT name, branch_code, phone FROM students
WHERE  (branch_code = 'CSE' OR branch_code = 'ECE') AND phone IS NULL;
```

> **In simple words:** "AND is like multiplication, OR is like addition. Just as 2 + 3 × 4 is 14 and not 20, Oracle does the AND part first. If you are not sure, put brackets. Brackets never hurt."

> ✏️ **Activity 2 (5 min):** Without running, how many rows? (a) `SELECT title FROM subjects WHERE credits = 4 AND branch_code = 'CSE';` → 2 (CS201, CS202). (b) `SELECT title FROM subjects WHERE credits = 4 OR branch_code = 'CSE';` → 6 (four with 4 credits, plus CS203 and CS204). (c) `SELECT title FROM subjects WHERE branch_code IS NULL;` → 1 (HS101). Now run and check.

---

## Break (10 min)

---

## Block 3 — Practice: 30 query exercises (50 min)

Work in the order given. Write the query, run it, and compare your **row count** with the expected count. If it differs, read your WHERE line again. Save the worksheet as `Day11`.

### Easy (one table, one condition)

| # | Question | Answer | Rows |
|---|---|---|---|
| 1 | Show everything in the branches table. | `SELECT * FROM branches;` | 4 |
| 2 | Show the name and email of every student. | `SELECT name, email FROM students;` | 8 |
| 3 | Show the code and title of every subject. | `SELECT subject_code, title FROM subjects;` | 8 |
| 4 | Students in the CSE branch. | `SELECT * FROM students WHERE branch_code = 'CSE';` | 4 |
| 5 | Titles of subjects worth 4 credits. | `SELECT title FROM subjects WHERE credits = 4;` | 4 |
| 6 | Fee payments made by UPI. | `SELECT * FROM fee_payments WHERE pay_mode = 'UPI';` | 5 |
| 7 | Book copies that are available. | `SELECT * FROM copies WHERE status = 'AVAILABLE';` | 3 |
| 8 | Teachers of the CSE branch. | `SELECT name FROM teachers WHERE branch_code = 'CSE';` | 3 |
| 9 | Enrollments with marks 80 or above. | `SELECT * FROM enrollments WHERE marks >= 80;` | 6 |
| 10 | Books published by McGraw Hill. | `SELECT title FROM books WHERE publisher = 'McGraw Hill';` | 2 |

### Medium (blanks, ranges, lists, patterns, dates)

| # | Question | Answer | Rows |
|---|---|---|---|
| 11 | Students who have not given a phone number. | `SELECT name FROM students WHERE phone IS NULL;` | 2 |
| 12 | Loans not yet returned. | `SELECT * FROM loans WHERE return_date IS NULL;` | 3 |
| 13 | Students in CSE or ECE (use IN). | `SELECT name, branch_code FROM students WHERE branch_code IN ('CSE', 'ECE');` | 6 |
| 14 | Enrollments with marks from 60 to 79. | `SELECT * FROM enrollments WHERE marks BETWEEN 60 AND 79;` | 5 |
| 15 | Fee payments made in August 2024. | `SELECT * FROM fee_payments WHERE paid_on BETWEEN DATE '2024-08-01' AND DATE '2024-08-31';` | 5 |
| 16 | Students whose name starts with A. | `SELECT name FROM students WHERE name LIKE 'A%';` | 2 |
| 17 | Subjects whose title ends with the word Systems. | `SELECT title FROM subjects WHERE title LIKE '%Systems';` | 3 |
| 18 | Teachers who have no head (hod_id is empty). | `SELECT name FROM teachers WHERE hod_id IS NULL;` | 3 |
| 19 | Teachers who joined after 1 January 2018. | `SELECT name, joining_date FROM teachers WHERE joining_date > DATE '2018-01-01';` | 4 |
| 20 | Enrollments with grade A or B. | `SELECT * FROM enrollments WHERE grade IN ('A', 'B');` | 9 |

### Harder (two or more conditions, maths, text, DISTINCT)

| # | Question | Answer | Rows |
|---|---|---|---|
| 21 | Students admitted in the year 2025. | `SELECT name FROM students WHERE admission_date BETWEEN DATE '2025-01-01' AND DATE '2025-12-31';` | 2 |
| 22 | Subjects with a code starting CS and worth 3 credits. | `SELECT subject_code FROM subjects WHERE subject_code LIKE 'CS%' AND credits = 3;` | 2 |
| 23 | CSE students who have a phone number. | `SELECT name FROM students WHERE branch_code = 'CSE' AND phone IS NOT NULL;` | 2 |
| 24 | Enrollments in CS201 or CS202 with marks 85 or more. | `SELECT * FROM enrollments WHERE subject_code IN ('CS201', 'CS202') AND marks >= 85;` | 3 |
| 25 | Payments of exactly 45000 made in 2025. | `SELECT * FROM fee_payments WHERE amount = 45000 AND paid_on >= DATE '2025-01-01';` | 3 |
| 26 | Loans returned after the due date (compare two columns). | `SELECT * FROM loans WHERE return_date > due_date;` | 1 |
| 27 | The different subjects that have at least one enrollment (each once). | `SELECT DISTINCT subject_code FROM enrollments;` | 7 |
| 28 | Subject code, title and credits × 25 as `max_marks`, for subjects with 3 or more credits. | `SELECT subject_code, title, credits * 25 AS max_marks FROM subjects WHERE credits >= 3;` | 7 |
| 29 | A label like `Karthik S (105)` for every MECH student, column named `label`. | `SELECT name \|\| ' (' \|\| roll_no \|\| ')' AS label FROM students WHERE branch_code = 'MECH';` | 2 |
| 30 | Students in CSE or ECE who have **no** phone — write it once **without** brackets and once **with**, and explain the difference. | Without: `SELECT name FROM students WHERE branch_code = 'CSE' OR branch_code = 'ECE' AND phone IS NULL;` → 4. With: `SELECT name FROM students WHERE (branch_code = 'CSE' OR branch_code = 'ECE') AND phone IS NULL;` → 2 | 4 / 2 |

---

## Block 4 — Going through the answers (10 min)

Pick the exercises most groups got wrong. Usually these are: **16** (capital A vs small a — `'a%'` finds nobody), **21** (a year needs a date range, not `= 2025`), **26** (comparing two columns to each other, no quotes), **30** (brackets). Put the wrong and right versions side by side on the projector and let students say the row count before you run each one.

---

## Block 5 — 10 exam-style MCQs

1. Which SQL command is used to read data from a table?
   A. READ  B. GET  C. SELECT  D. SHOW

2. In `SELECT name FROM students WHERE branch_code = 'CSE'`, which part chooses the rows?
   A. SELECT  B. FROM  C. WHERE  D. name

3. What does `SELECT *` mean?
   A. All rows  B. All columns  C. Only the primary key  D. The first row

4. Which condition finds rows where the phone column is empty?
   A. `phone = NULL`  B. `phone = ''`  C. `phone IS NULL`  D. `phone = 'NULL'`

5. What is the result of `marks + 5` when marks is NULL?
   A. 5  B. 0  C. NULL  D. An error

6. Which symbol in LIKE stands for any number of characters?
   A. `_`  B. `%`  C. `*`  D. `?`

7. `WHERE marks BETWEEN 60 AND 79` includes:
   A. Only values above 60 and below 79
   B. 60 and 79 themselves, and everything between
   C. Only 60 and 79
   D. Everything except 60 and 79

8. `WHERE branch_code = 'cse'` returns no rows even though CSE students exist. Why?
   A. The column is a number
   B. Text comparison is case-sensitive; 'cse' is not 'CSE'
   C. WHERE cannot compare text
   D. Single quotes are wrong

9. Which word removes repeated values from the result?
   A. UNIQUE  B. DISTINCT  C. ONLY  D. SINGLE

10. In a WHERE with AND and OR but no brackets, which is evaluated first?
    A. OR  B. AND  C. Left to right  D. Right to left

---

## Homework (bring to Day 12)

1. **SQL:** Write 10 questions of your own about the College DB (like "which subjects are worth 2 credits?") and their SELECT answers. Save as `Day11_homework`. At least two must use LIKE, two must use dates, one must use IS NULL, and one must mix AND and OR with brackets.
2. **Trace by hand:** Without running, write the row count for each, then run and check: (a) `SELECT * FROM teachers WHERE branch_code = 'ECE' OR hod_id IS NULL;` (b) `SELECT * FROM copies WHERE status IN ('ISSUED', 'LOST');` (c) `SELECT * FROM enrollments WHERE grade = 'A' AND marks < 90;`.
3. **Think:** In 3 lines, explain why `WHERE phone = NULL` gives no rows but no error.
4. **Read ahead:** Tomorrow is ORDER BY (sorting). Think: if you sort students by branch and then by name, which student comes first?

---

## One-slide summary

- A question → **SELECT** (which columns) **FROM** (which table) **WHERE** (which rows). Entity = table, attribute = column, business question = WHERE.
- `*` = all columns. A column list shows only those columns, in the order you write them.
- Alias = nickname: `AS max_marks`, or `AS "With Space"`.
- Maths: `+ - * /`; brackets first, then `*` `/`, then `+` `-`. **Anything with NULL gives NULL.**
- `||` glues text. `DISTINCT` shows each different value once.
- WHERE tools: `= <> > >= < <=`, `BETWEEN a AND b` (both ends included), `IN (list)`, `LIKE 'A%'` (`%` = many characters, `_` = one), `IS NULL` / `IS NOT NULL`.
- Text in **single quotes**, exact **capital letters**. Numbers without quotes. Dates as `DATE 'YYYY-MM-DD'`.
- `NOT` first, then `AND`, then `OR`. Use **brackets** when mixing AND and OR.
- `= NULL` is never true. Use `IS NULL`.

## Simple glossary

| Word | Meaning in one line |
|---|---|
| SELECT | The command that reads data |
| FROM | Says which table |
| WHERE | Says which rows (a test each row must pass) |
| `*` | All columns |
| Alias | A nickname for a column in the result |
| NULL | Empty / unknown; any maths with it gives NULL |
| `\|\|` | Joins pieces of text into one column |
| DISTINCT | Shows each different value once |
| BETWEEN | A range, both ends included |
| IN | Matches any value from a list |
| LIKE | Pattern matching with `%` (many characters) and `_` (one character) |
| IS NULL | Finds empty values (`= NULL` never works) |
| AND / OR / NOT | Combine or reverse conditions; NOT, then AND, then OR |
| Condition | A test that is true or false for a row, e.g. `marks > 80` |
