# Day 12 — Sorting Data: ORDER BY, and Query Practice

**Exam syllabus points covered today (1Z0-006 → "Introduction to SQL")**
- Displaying Sorted Data: use ORDER BY
- Basic SELECT: build a SELECT to retrieve data from a table; use WHERE to filter (revision through practice)

**By the end of today, a student can:**
1. Sort a result by one column, going up (ASC) or down (DESC).
2. Sort by two or more columns (the second column breaks ties in the first).
3. Sort by a nickname (alias) and by a column that is not shown.
4. Say where NULL values go in a sort, and move them with NULLS FIRST / NULLS LAST.
5. Write the clauses in the correct order: SELECT → FROM → WHERE → ORDER BY.
6. Turn a report question into a full query using the four questions (which table? which columns? which rows? which order?).
7. Answer 30 report-style questions on the College DB and say the first row of each result.

---

## Today's topics

**0. Recap**
- 5 quick questions from Day 11; data check

**1. ORDER BY: sorting the result**
- 1.1 Rows come back in no fixed order
- 1.2 Sorting by one column: ASC (default) and DESC
- 1.3 Sorting by two or more columns (ties are broken by the next column)
- 1.4 Sorting by a nickname (alias)
- 1.5 Sorting by a column that is not shown
- 1.6 Where do NULLs go? NULLS FIRST / NULLS LAST
- 1.7 ORDER BY with WHERE — ORDER BY is always the last clause

**2. Writing a full query step by step**
- 2.1 The four questions: which table? which columns? which rows? which order?
- 2.2 Checking your answer: row count, first row, last row

**3. Practice**
- 3.1 30 report-style exercises (sorting only → WHERE + ORDER BY → everything together)
- 3.2 SQL assignment 1 (10 questions to submit)

---
## Time plan

| Time | Block | What we do |
|---|---|---|
| 0:00 – 0:10 | 0 | Recap: 5 quick questions from last class; data check |
| 0:10 – 0:55 | 1 | ORDER BY: one column, ASC/DESC, several columns, alias, hidden column, NULLs, clause order |
| 0:55 – 1:15 | 2 | Writing a full query step by step (the four questions) |
| 1:15 – 1:25 | — | Break |
| 1:25 – 2:25 | 3 | Practice: 30 report-style exercises |
| 2:25 – 2:40 | 3 | SQL assignment 1 handed out; start in class, finish at home |
| 2:40 – 2:55 | 4 | 10 exam-style MCQs |
| 2:55 – 3:00 | last | Key points, homework |

---

## Block 0 — Recap (10 min)

Ask quickly (one-line answers):
1. The three parts of a query, in order? *(SELECT, FROM, WHERE)*
2. `%` in LIKE means…? *(any number of characters)*
3. How do you find students with no phone? *(`WHERE phone IS NULL`)*
4. Which is read first, AND or OR? *(AND)*
5. `marks + 5` when marks is NULL gives…? *(NULL)*

> **In simple words:** "Yesterday you learned to *choose* rows. But the database gives them back in any order it likes. Today you learn to *arrange* them — highest marks first, names A to Z, oldest payment first."

---

## Block 1 — ORDER BY: sorting the result (45 min)

### 1.1 Rows come back in no fixed order

```sql
-- Run this twice. Oracle promises nothing about the order (8 rows)
SELECT name FROM students;
```

> **In simple words:** "Remember Day 1: in a relational database, the order of rows does not matter. If you *want* an order, you must *ask* for it. That is ORDER BY."

**ORDER BY** = the line at the end of a query that says which column to sort the result by.

### 1.2 Sorting by one column: ASC (default) and DESC

```sql
-- Names from A to Z (8 rows; first row: Anjali Gupta)
SELECT name FROM students ORDER BY name;

-- Exactly the same, written in full. ASC = ascending = small to big
SELECT name FROM students ORDER BY name ASC;

-- Names from Z to A. DESC = descending = big to small (8 rows; first row: Vikram Nair)
SELECT name FROM students ORDER BY name DESC;

-- Biggest payment first (9 rows; first row: 5003, 90000)
SELECT payment_id, amount FROM fee_payments ORDER BY amount DESC;

-- Longest-serving teacher first (6 rows; first row: Dr. Rao, 2010)
SELECT name, joining_date FROM teachers ORDER BY joining_date;
```

| Word | Meaning |
|---|---|
| `ASC` | Ascending — small to big, A to Z, oldest date to newest. **Default**; you may leave it out |
| `DESC` | Descending — big to small, Z to A, newest date to oldest |

What "small to big" means for each type:

| Type | ASC order |
|---|---|
| Numbers | 49, 58, 63 … 95 |
| Text | A, B, C … Z, then a, b, c … (capital letters come **before** small letters) |
| Dates | Oldest first (2010 before 2021) |

> 📌 ORDER BY changes only what is **shown**. The rows inside the table are not rearranged.

### 1.3 Sorting by two or more columns (ties are broken by the next column)

```sql
-- First by branch (A to Z); students in the SAME branch are then sorted by name (8 rows)
SELECT branch_code, name FROM students ORDER BY branch_code, name;
```
Result:
```
BRANCH_CODE  NAME
CSE          Anjali Gupta
CSE          Priya Sharma
CSE          Ravi Kumar
CSE          Sneha Patel
ECE          Arjun Reddy
ECE          Meena Devi
MECH         Karthik S
MECH         Vikram Nair
```

> **In simple words:** "The second column only matters when the first column has a tie. Like a cricket points table: first by points, and if points are equal, by run rate."

```sql
-- Each column can have its own direction: credits high to low, then title A to Z
-- (8 rows; first row: CS201 Database Systems 4)
SELECT subject_code, title, credits FROM subjects ORDER BY credits DESC, title ASC;
```

> 📌 **Exam-likely:** "In `ORDER BY credits DESC, title`, how is title sorted?" → ascending (the default). DESC applies **only** to the column it is written after.

### 1.4 Sorting by a nickname (alias)

```sql
-- The alias from the SELECT list can be used in ORDER BY (9 rows; first row: 5003, 106200)
SELECT payment_id, amount * 1.18 AS with_tax
FROM   fee_payments
ORDER  BY with_tax DESC;
```

### 1.5 Sorting by a column that is not shown

```sql
-- Sort by date of birth, but show only the name (8 rows; first row: Karthik S, the oldest)
SELECT name FROM students ORDER BY dob;
```
This is allowed: the sort column does not have to be in the SELECT list. One exception: with DISTINCT you can sort only by columns you show (`SELECT DISTINCT branch_code FROM students ORDER BY name;` gives error ORA-01791 — Oracle squashed 4 CSE rows into 1 and cannot know which name to sort by).

### 1.6 Where do NULLs go? NULLS FIRST / NULLS LAST

Oracle treats NULL as the **biggest** value when sorting:

| Order | NULLs appear |
|---|---|
| `ASC` (default) | **Last** |
| `DESC` | **First** |

```sql
-- Lowest marks first; Sneha's blank marks come LAST (14 rows; first row: 105 ME201 49)
SELECT roll_no, subject_code, marks FROM enrollments ORDER BY marks;

-- Highest marks first — but the blank row comes FIRST! (14 rows; first row: 106 CS201, blank)
SELECT roll_no, subject_code, marks FROM enrollments ORDER BY marks DESC;

-- Fix: push the blanks to the end (14 rows; first row: 104 EC201 95)
SELECT roll_no, subject_code, marks FROM enrollments ORDER BY marks DESC NULLS LAST;

-- Or pull them to the front on purpose (6 rows; first row: Dr. Iyer)
SELECT name, hod_id FROM teachers ORDER BY hod_id NULLS FIRST, name;
```

> 📌 **Exam-likely:** "By default, where do NULL values appear in an ascending sort in Oracle?" → **at the end**. "Which words change this?" → `NULLS FIRST` / `NULLS LAST`, written right after the column (and after ASC/DESC if you use it).

### 1.7 ORDER BY with WHERE — ORDER BY is always the last clause

```sql
-- Choose the rows first (WHERE), then arrange them (ORDER BY)
-- (4 rows; first row: Ravi Kumar, born 2006-03-15)
SELECT name, dob
FROM   students
WHERE  branch_code = 'CSE'
ORDER  BY dob;

-- DISTINCT and ORDER BY together (3 rows; first row: CSE)
SELECT DISTINCT branch_code FROM students ORDER BY branch_code;
```

Clause order — memorise it:

```
SELECT    what
FROM      where it is
WHERE     which rows          (optional)
ORDER BY  in which order      (optional, ALWAYS LAST)
```

Writing `ORDER BY` before `WHERE` gives error ORA-00933 (SQL command not properly ended).

> ✏️ **Activity 1 (5 min):** Show the name and joining date of teachers who joined after 1 January 2015, newest first.

---

## Block 2 — Writing a full query step by step (20 min)

### 2.1 The four questions: which table? which columns? which rows? which order?

> **In simple words:** "Do not try to write the whole query in one go. Ask four questions, write one line for each, and run it after each step."

| Step | Ask yourself | Write | Example: "CSE students, oldest first" |
|---|---|---|---|
| 1 | Which table holds this? | `FROM` | `FROM students` |
| 2 | Which rows do I want? | `WHERE` | `WHERE branch_code = 'CSE'` |
| 3 | Which columns should I see? | `SELECT` | `SELECT name, dob` |
| 4 | In what order? | `ORDER BY` | `ORDER BY dob` |

Then put the lines in the correct **written** order:

```sql
-- SELECT is written first, even though you thought of it third (4 rows; first row: Ravi Kumar)
SELECT name, dob
FROM   students
WHERE  branch_code = 'CSE'
ORDER  BY dob;
```

A second example, worked the same way — "UPI payments, newest first":
1. Table? `fee_payments`. 2. Rows? `pay_mode = 'UPI'`. 3. Columns? `payment_id, roll_no, paid_on`. 4. Order? `paid_on DESC`.

```sql
-- (5 rows; first row: 5008, roll 107, 2025-08-04)
SELECT payment_id, roll_no, paid_on
FROM   fee_payments
WHERE  pay_mode = 'UPI'
ORDER  BY paid_on DESC;
```

### 2.2 Checking your answer: row count, first row, last row

1. **Count the rows.** Does the number make sense? (CSE has 4 students, so 4 rows.)
2. **Look at the first row.** Is it really the oldest? (Ravi, born March 2006 — yes.)
3. **Look at the last row.** Is it the youngest? (Anjali, born 2007 — yes.)

> 📌 A common exam question shows a query and asks "which row appears first?" Use the same three checks: which rows survive the WHERE, then which one is smallest (ASC) or biggest (DESC) in the ORDER BY column — remembering that NULLs are last in ASC and first in DESC.

> ✏️ **Activity 2 (5 min):** What is the **first row** of each? (a) `SELECT name FROM students ORDER BY name DESC;` → Vikram Nair. (b) `SELECT title FROM subjects ORDER BY credits, title;` → Communication Skills (2 credits). (c) `SELECT name FROM teachers ORDER BY email;` → Prof. Anand (anand@… is first alphabetically; Prof. Fatima with no email is last). Run and check.

---

## Break (10 min)

---

## Block 3 — Practice: 30 report-style exercises (60 min)

For each exercise: write the query, run it, and check **both** the row count and the **first row**. Save the worksheet as `Day12`.

### Part A — sorting only

| # | Question | Answer | Rows | First row |
|---|---|---|---|---|
| 1 | All students, names A to Z. | `SELECT name FROM students ORDER BY name;` | 8 | Anjali Gupta |
| 2 | All students, highest roll number first. | `SELECT roll_no, name FROM students ORDER BY roll_no DESC;` | 8 | 108 Anjali Gupta |
| 3 | Subjects, most credits first; equal credits sorted by title. | `SELECT subject_code, title, credits FROM subjects ORDER BY credits DESC, title;` | 8 | CS201 Database Systems 4 |
| 4 | Teachers, longest-serving first. | `SELECT name, joining_date FROM teachers ORDER BY joining_date;` | 6 | Dr. Rao |
| 5 | Teachers, newest first. | `SELECT name, joining_date FROM teachers ORDER BY joining_date DESC;` | 6 | Prof. Fatima |
| 6 | Fee payments, biggest amount first; equal amounts by date, oldest first. | `SELECT payment_id, amount, paid_on FROM fee_payments ORDER BY amount DESC, paid_on;` | 9 | 5003 90000 |
| 7 | Enrollments, highest marks first — blank marks at the end. | `SELECT roll_no, subject_code, marks FROM enrollments ORDER BY marks DESC NULLS LAST;` | 14 | 104 EC201 95 |
| 8 | Enrollments, lowest marks first. | `SELECT roll_no, subject_code, marks FROM enrollments ORDER BY marks;` | 14 | 105 ME201 49 |
| 9 | Students grouped by branch (A to Z), names A to Z inside each branch. | `SELECT branch_code, name FROM students ORDER BY branch_code, name;` | 8 | CSE Anjali Gupta |
| 10 | Copies sorted by status, then ISBN, then copy number. | `SELECT * FROM copies ORDER BY status, isbn, copy_no;` | 7 | 9780073523323 copy 2 AVAILABLE |

### Part B — WHERE + ORDER BY

| # | Question | Answer | Rows | First row |
|---|---|---|---|---|
| 11 | CSE students, oldest (earliest date of birth) first. | `SELECT name, dob FROM students WHERE branch_code = 'CSE' ORDER BY dob;` | 4 | Ravi Kumar |
| 12 | Students who gave a phone, phone numbers from largest to smallest. | `SELECT name, phone FROM students WHERE phone IS NOT NULL ORDER BY phone DESC;` | 6 | Ravi Kumar 9800000001 |
| 13 | The different payment modes, alphabetical. | `SELECT DISTINCT pay_mode FROM fee_payments ORDER BY pay_mode;` | 4 | CARD |
| 14 | Loans not yet returned, earliest due date first. | `SELECT loan_id, due_date FROM loans WHERE return_date IS NULL ORDER BY due_date;` | 3 | 9002 |
| 15 | Books sorted by publisher, then by title. | `SELECT publisher, title FROM books ORDER BY publisher, title;` | 5 | MIT Press – Introduction to Algorithms |
| 16 | Teachers with no head first, then the rest; names A to Z inside each group. | `SELECT name, hod_id FROM teachers ORDER BY hod_id NULLS FIRST, name;` | 6 | Dr. Iyer |
| 17 | Grade A enrollments, highest marks first. | `SELECT roll_no, subject_code, marks FROM enrollments WHERE grade = 'A' ORDER BY marks DESC;` | 5 | 104 EC201 95 |
| 18 | Enrollments in HS101, lowest marks first. | `SELECT roll_no, marks FROM enrollments WHERE subject_code = 'HS101' ORDER BY marks;` | 3 | 105 (72) |
| 19 | Students admitted in 2024, names A to Z. | `SELECT name, admission_date FROM students WHERE admission_date BETWEEN DATE '2024-01-01' AND DATE '2024-12-31' ORDER BY name;` | 6 | Arjun Reddy |
| 20 | Fee payments made in 2025, earliest first. | `SELECT payment_id, paid_on FROM fee_payments WHERE paid_on >= DATE '2025-01-01' ORDER BY paid_on;` | 3 | 5002 |

### Part C — everything together

| # | Question | Answer | Rows | First row |
|---|---|---|---|---|
| 21 | CS subjects, fewest credits first; equal credits by code. | `SELECT subject_code, credits FROM subjects WHERE subject_code LIKE 'CS%' ORDER BY credits, subject_code;` | 4 | CS203 (3) |
| 22 | Teachers who have an email, sorted by email. | `SELECT name, email FROM teachers WHERE email IS NOT NULL ORDER BY email;` | 5 | Prof. Anand |
| 23 | A label `name - branch` for every student, sorted Z to A by the label. | `SELECT name \|\| ' - ' \|\| branch_code AS label FROM students ORDER BY label DESC;` | 8 | Vikram Nair - MECH |
| 24 | Enrollments with marks 70 to 90, sorted by subject code, then highest marks first. | `SELECT subject_code, roll_no, marks FROM enrollments WHERE marks BETWEEN 70 AND 90 ORDER BY subject_code, marks DESC;` | 6 | CS201 101 88 |
| 25 | Students not in CSE, branch Z to A, then name A to Z. | `SELECT branch_code, name FROM students WHERE branch_code <> 'CSE' ORDER BY branch_code DESC, name;` | 4 | MECH Karthik S |
| 26 | Fee amount with 18% tax as `with_tax`, biggest first. | `SELECT payment_id, amount * 1.18 AS with_tax FROM fee_payments ORDER BY with_tax DESC;` | 9 | 5003 (106200) |
| 27 | Loans taken by students, most recent issue date first. | `SELECT loan_id, roll_no, issue_date FROM loans WHERE roll_no IS NOT NULL ORDER BY issue_date DESC;` | 4 | 9001 |
| 28 | Enrollments sorted by grade (A first, blanks last), then highest marks first. | `SELECT roll_no, subject_code, grade, marks FROM enrollments ORDER BY grade NULLS LAST, marks DESC;` | 14 | 104 EC201 A 95 |
| 29 | Subjects that belong to a branch, sorted by branch, then title. | `SELECT branch_code, title FROM subjects WHERE branch_code IS NOT NULL ORDER BY branch_code, title;` | 7 | CSE Computer Networks |
| 30 | Students whose name contains a small "a", grouped by branch (A to Z), youngest first inside each branch. | `SELECT branch_code, name, dob FROM students WHERE name LIKE '%a%' ORDER BY branch_code, dob DESC;` | 7 | CSE Anjali Gupta |

### 3.2 SQL assignment 1 (10 questions to submit)

Write each query in one Live SQL worksheet named `Assignment1_<your roll number>`, with the question as a `--` comment above it. Submit before Day 13. Each query must use WHERE and ORDER BY. Marks: 1 per correct query.

1. Students in the ECE branch, names A to Z.
2. Subjects worth 4 credits, titles Z to A.
3. Fee payments of exactly 45000, newest first.
4. Teachers whose head is teacher 1, earliest joining date first.
5. Book copies that are not available (status is not AVAILABLE), sorted by ISBN and then copy number.
6. Enrollments with grade C or D, lowest marks first.
7. Students without a phone number, highest roll number first.
8. A label `subject_code: title` named `subject_label` for subjects **not** in the CSE branch, sorted by the label. (Think: what happens to HS101, which has no branch?)
9. Loans that have been returned, latest return date first.
10. Students born in 2006, youngest first.

---

## Block 4 — 10 exam-style MCQs

1. Which clause sorts the result of a query?
   A. SORT BY  B. ORDER BY  C. LIST BY  D. ARRANGE BY

2. What is the default sort direction?
   A. Descending  B. Ascending  C. Random  D. By primary key

3. Which keyword sorts from highest to lowest?
   A. DESC  B. DOWN  C. HIGH  D. REVERSE

4. In `ORDER BY credits DESC, title`, the title column is sorted:
   A. Descending  B. Ascending  C. Not sorted  D. Randomly

5. Where must ORDER BY appear in a SELECT statement?
   A. Before FROM  B. Before WHERE  C. After WHERE, at the end  D. Anywhere

6. In Oracle, in an ascending sort, NULL values appear:
   A. First  B. Last  C. In the middle  D. They are removed

7. Which query shows the highest marks first **and** keeps blank marks at the bottom?
   A. `ORDER BY marks DESC`
   B. `ORDER BY marks DESC NULLS LAST`
   C. `ORDER BY marks ASC`
   D. `ORDER BY marks NULLS FIRST`

8. Which query gives an error?
   A. `SELECT name FROM students ORDER BY dob;`
   B. `SELECT DISTINCT branch_code FROM students ORDER BY name;`
   C. `SELECT name AS n FROM students ORDER BY n;`
   D. `SELECT name FROM students ORDER BY name DESC;`

9. `SELECT name FROM students WHERE branch_code = 'CSE' ORDER BY dob DESC;` — which student is shown first?
   A. Ravi Kumar  B. Anjali Gupta  C. Priya Sharma  D. Sneha Patel

10. Does ORDER BY change the order of rows stored in the table?
    A. Yes, permanently  B. Yes, until COMMIT  C. No, only the displayed result  D. Only for the primary key

---

## Homework (bring to Day 13)

1. **Submit SQL assignment 1** (the 10 questions in 3.2) as the worksheet `Assignment1_<roll number>`.
2. **Predict:** Without running, write the first row of each, then check: (a) `SELECT name FROM teachers ORDER BY branch_code, name;` (b) `SELECT isbn, copy_no FROM copies WHERE status <> 'LOST' ORDER BY copy_no DESC, isbn;` (c) `SELECT title FROM books ORDER BY author;`.
3. **Fix it:** Rewrite these correctly: (a) `SELECT name FROM students ORDER name;` (b) `SELECT name FROM students WHERE dob > 2006-01-01;` (c) `SELECT name FROM students ORDER BY name WHERE branch_code = 'CSE';`
4. **Read ahead:** Tomorrow we join tables. Look at the `students` and `branches` tables and write in words how you would find each student's branch **name** (not code).

---

## One-slide summary

- `ORDER BY column` sorts the **display**, never the table. Default is **ASC** (A→Z, small→big, old→new). `DESC` reverses.
- Several columns: `ORDER BY branch_code, name` — the second column breaks ties. `DESC` applies only to the column it follows.
- Clause order: **SELECT → FROM → WHERE → ORDER BY**. ORDER BY is always last.
- You may sort by an alias (`ORDER BY with_tax`) or by a column that is not shown (`SELECT name … ORDER BY dob`).
- **NULLs are last in ASC and first in DESC.** Change with `NULLS FIRST` / `NULLS LAST`.
- With DISTINCT, sort only by columns in the SELECT list.
- Four questions for any report: which table? which rows? which columns? which order?
- Always check three things: row count, first row, last row.

## Simple glossary

| Word | Meaning in one line |
|---|---|
| ORDER BY | The clause that arranges the result |
| ASC | Ascending — small to big; the default |
| DESC | Descending — big to small |
| Sort within a sort | The second column decides the order when the first column has equal values |
| Tie | Two rows with the same value in the sort column |
| Alias | A nickname for a column; can be used in ORDER BY |
| NULLS FIRST / NULLS LAST | Where to put empty values in the sort |
| Clause | One part of a query: SELECT, FROM, WHERE or ORDER BY |
| ORA-00933 | The error when a clause is in the wrong place (e.g. ORDER BY before WHERE) |
| ORA-01791 | The error when you sort a DISTINCT result by a column that is not shown |
