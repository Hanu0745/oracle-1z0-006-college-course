# Day 13 — Joins Part 1: Inner Joins

**Exam syllabus points covered today (1Z0-006 → "Table Joins")**
- Describe the different types of joins and their features (today: cross join, inner join, self join)
- Use joins to retrieve data from multiple tables (`JOIN … ON`, `USING`, the old comma style, three tables)

**By the end of today, a student can:**
1. Explain in plain words why data is kept in separate tables and why we need a join.
2. Read the join columns off the College diagram (foreign key = primary key).
3. Say what happens when two tables are joined with no condition (Cartesian product) and predict the row count.
4. Write an inner join with `JOIN … ON`, using table aliases and `alias.column`.
5. Recognise `USING`, `NATURAL JOIN` and the old comma style in an exam question.
6. Join three tables in one query and add `WHERE` and `ORDER BY` to it.
7. Write a self join (each teacher with the name of their head).

---

## Today's topics

**0. Recap**
- 5 questions on ORDER BY and full queries

**1. Why joins**
- 1.1 The data is split on purpose
- 1.2 The diagram tells you how to join: child.fk = parent.pk

**2. What happens with no join condition**
- 2.1 The Cartesian product (CROSS JOIN): students × branches = 32 rows

**3. Inner join**
- 3.1 The main way: `JOIN … ON`
- 3.2 Table aliases and `alias.column`
- 3.3 Columns with the same name in both tables (ambiguous column)
- 3.4 `JOIN … USING (column)`
- 3.5 `NATURAL JOIN` — one line, for awareness only
- 3.6 The old comma style — for awareness only (the exam may show it)

**4. Bigger joins**
- 4.1 Joining three tables (students → enrollments → subjects)
- 4.2 Adding WHERE and ORDER BY to a join

**5. Self join**
- 5.1 The same table twice: teachers and their head

**6. Practice**
- 6.1 25 join exercises (two tables → three tables → self join)

**7. 10 exam-style MCQs**

---
## Time plan

| Time | Block | What we do |
|---|---|---|
| 0:00 – 0:10 | 0 | Recap: 5 quick questions from last class; collect SQL assignment 1 |
| 0:10 – 0:25 | 1 | Why joins; reading the join columns from the diagram |
| 0:25 – 0:40 | 2 | The Cartesian product — show it once |
| 0:40 – 1:20 | 3 | Inner join: `JOIN … ON`, aliases, ambiguous columns, `USING`, `NATURAL JOIN`, old style |
| 1:20 – 1:30 | — | Break |
| 1:30 – 1:55 | 4 | Three-table joins; WHERE and ORDER BY in a join |
| 1:55 – 2:10 | 5 | Self join: teachers and their head |
| 2:10 – 2:45 | 6 | Practice: 25 exercises on the College DB |
| 2:45 – 2:55 | 7 | 10 MCQs |
| 2:55 – 3:00 | last | Key points, homework |

---

## Block 0 — Recap (10 min)

1. Which clause sorts the result, and where does it go? (`ORDER BY`, always last.)
2. `ORDER BY marks DESC` — highest first or lowest first? (Highest first.)
3. Where do NULLs go in `ORDER BY marks` (ascending) in Oracle? (Last.)
4. Write the four clauses in order. (`SELECT` → `FROM` → `WHERE` → `ORDER BY`.)
5. Which table holds a student's marks? Which table holds the student's name? (`enrollments`; `students`.) — "So how do we print a mark sheet with names? That is today."

---

## Block 1 — Why joins (15 min)

### 1.1 The data is split on purpose

On Day 6 (normalization) we split the messy marks sheet so that nothing is typed twice. The student's **name** is now in `students` and the **marks** are in `enrollments`. To print a mark sheet with names we must bring the two tables back together. That is a **join**.

> **In simple words:** "A join is a SELECT that reads two or more tables and matches their rows using a common column. In our database that common column is always a foreign key on one side and a primary key on the other."

```
 students                          enrollments
 ROLL_NO | NAME          ...       ROLL_NO | SUBJECT_CODE | MARKS
 --------+---------------          --------+--------------+------
 101     | Ravi Kumar              101     | CS201        | 88
 102     | Priya Sharma            101     | CS202        | 79
 ...                               102     | CS201        | 92
    ▲                                 ▲
    └────── same value in both ───────┘   ← the join column
```

### 1.2 The diagram tells you how to join: child.fk = parent.pk

Every relationship line in the College ERD became a foreign key on Day 7. **Every foreign key is a join you can write.** You never guess the join columns; you read them off the diagram.

| Line in the diagram | Join condition (child.fk = parent.pk) |
|---|---|
| STUDENT belongs to BRANCH | `students.branch_code = branches.branch_code` |
| ENROLLMENT is for STUDENT | `enrollments.roll_no = students.roll_no` |
| ENROLLMENT is for SUBJECT | `enrollments.subject_code = subjects.subject_code` |
| TEACHES links TEACHER and SUBJECT | `teaches.teacher_id = teachers.teacher_id` and `teaches.subject_code = subjects.subject_code` |
| TEACHER reports to TEACHER | `teachers.hod_id = teachers.teacher_id` (same table!) |
| FEE PAYMENT is made by STUDENT | `fee_payments.roll_no = students.roll_no` |
| COPY is a copy of BOOK | `copies.isbn = books.isbn` |
| LOAN is for COPY | `loans.isbn = copies.isbn AND loans.copy_no = copies.copy_no` (two columns) |

**Plain meanings:** *child table* = the table that holds the foreign key (the "many" side). *Parent table* = the table whose primary key is pointed at (the "one" side).

---

## Block 2 — What happens with no join condition (15 min)

### 2.1 The Cartesian product (CROSS JOIN)

If you name two tables and give **no** matching rule, Oracle pairs every row of the first with every row of the second.

```sql
-- Every student paired with every branch (wrong, but let us see it once)
SELECT s.name, b.branch_name
FROM   students s CROSS JOIN branches b;
```
Result: 8 students × 4 branches = **32 rows**. Ravi appears with CSE, ECE, MECH and CIVIL. Nonsense — but no error.

**Plain meaning:** a **Cartesian product** (also called a **cross join**) is every row of table A paired with every row of table B. Rows in the result = rows in A × rows in B. It is almost always a mistake caused by a **missing join condition**.

> **In simple words:** "Show this once so you recognise it. If your join gives far too many rows and names are paired with the wrong partners, you forgot the join condition."

> 📌 **Exam-likely:** "Two tables of 10 and 20 rows are joined with no join condition. How many rows come back?" → **200**. "What is this called?" → **Cartesian product**.

Activity (2 min): without running it, how many rows does `SELECT * FROM subjects CROSS JOIN teachers;` give? (8 × 6 = **48**.) Now run it.

---

## Block 3 — Inner join (40 min)

### 3.1 The main way: `JOIN … ON`

Start with the simplest join in the College DB: each student with the name of their branch.

```sql
-- Each student with the name of their branch
SELECT students.name, students.branch_code, branches.branch_name
FROM   students
JOIN   branches ON students.branch_code = branches.branch_code;
```

```
 NAME          | BRANCH_CODE | BRANCH_NAME
 --------------+-------------+----------------------------------
 Ravi Kumar    | CSE         | Computer Science and Engineering
 Priya Sharma  | CSE         | Computer Science and Engineering
 Arjun Reddy   | ECE         | Electronics and Communication
 Meena Devi    | ECE         | Electronics and Communication
 Karthik S     | MECH        | Mechanical Engineering
 Sneha Patel   | CSE         | Computer Science and Engineering
 Vikram Nair   | MECH        | Mechanical Engineering
 Anjali Gupta  | CSE         | Computer Science and Engineering
                                                          (8 rows)
```
(The order may differ on your screen — add `ORDER BY students.roll_no` to fix it.)

Read it aloud: "From students, join branches, **on** the branch codes being equal."

**Plain meaning:** an **inner join** returns only the rows where the join condition is true — a row from the first table **and** a matching row from the second. Rows with no partner are left out. `INNER JOIN` and `JOIN` mean exactly the same thing.

Notice: **CIVIL is not in the result.** It has no students, so it has no partner row. Keep this in mind for Day 14.

### 3.2 Table aliases and `alias.column`

Typing `students.` and `branches.` every time is tiring. Give each table a short name (an **alias**) right after its name in `FROM`, then use it in front of every column.

```sql
-- Same query with aliases: s = students, b = branches
SELECT s.name, s.branch_code, b.branch_name
FROM   students s
JOIN   branches b ON s.branch_code = b.branch_code;
```
Same 8 rows.

Rules:
- Once a table has an alias, use **only** the alias. Writing `students.name` after `students s` gives an error.
- Put the alias in front of **every** column in a join. It is not always required, but the reader then knows where each column came from.

### 3.3 Columns with the same name in both tables

`branch_code` exists in both `students` and `branches`. If you write it with no alias, Oracle does not know which one you mean:

```sql
-- ERROR: which branch_code? ORA-00918: column ambiguously defined
SELECT name, branch_code, branch_name
FROM   students s
JOIN   branches b ON s.branch_code = b.branch_code;
```
Fix: `s.branch_code` (or `b.branch_code`). `name` and `branch_name` are fine alone because each exists in only one table — but use the alias anyway.

> **In simple words:** "Ambiguous means 'could be either'. The alias removes the doubt."

### 3.4 `JOIN … USING (column)`

When the join column is spelled the **same** in both tables, you can write `USING` instead of `ON`:

```sql
-- USING works when the join column has the same name in both tables
SELECT s.name, branch_code, b.branch_name
FROM   students s
JOIN   branches b USING (branch_code);
```
Same 8 rows. With `USING`, the join column is written **without** an alias (`branch_code`, not `s.branch_code`); Oracle treats it as one shared column.

### 3.5 `NATURAL JOIN` — for awareness only

```sql
-- NATURAL JOIN: Oracle joins on ALL columns that have the same name in both tables (avoid)
SELECT name, branch_code, branch_name
FROM   students NATURAL JOIN branches;
```
Gives 8 rows here because `branch_code` is the only shared column name. If both tables also had a column called `name`, Oracle would silently join on that too and give wrong answers. Know that it exists; in real work use `JOIN … ON`.

### 3.6 The old comma style — for awareness only (the exam may show it)

Before the `JOIN` keyword existed, the tables were listed with commas and the matching rule went in `WHERE`:

```sql
-- Old style: tables separated by a comma, the join rule in WHERE
SELECT s.name, b.branch_name
FROM   students s, branches b
WHERE  s.branch_code = b.branch_code;
```
Same 8 rows. Forget the `WHERE` and you silently get the 32-row Cartesian product. That is why `JOIN … ON` is safer: the matching rule sits next to the table it belongs to.

| Way of writing | Where the join rule goes | Use it? |
|---|---|---|
| `JOIN … ON a.x = b.y` | in `ON` | Yes — the main way |
| `JOIN … USING (x)` | in `USING` (same column name both sides) | Sometimes |
| `NATURAL JOIN` | nowhere — Oracle guesses from column names | No (awareness only) |
| `FROM a, b WHERE a.x = b.y` | in `WHERE` | No — but recognise it in the exam |

> 📌 **Exam-likely:** "Which join returns only the matching rows?" → **inner join**. "Which keyword joins on a column of the same name without writing the condition?" → **USING** (or NATURAL JOIN). "What happens if the WHERE is missing in the comma style?" → **Cartesian product**.

Activity (5 min): write a join that shows every enrollment with the **student's name** instead of the roll number. (`FROM enrollments e JOIN students s ON e.roll_no = s.roll_no` — 14 rows.)

---

## Break (10 min)

---

## Block 4 — Bigger joins (25 min)

### 4.1 Joining three tables

> **In simple words:** "A join is a chain. Follow the diagram from box to box. `enrollments` is in the middle: it points to `students` on one side and to `subjects` on the other. Each extra table is one more `JOIN … ON` line."

```
 students ──(roll_no)── enrollments ──(subject_code)── subjects
```

```sql
-- Mark sheet: student name, subject title, marks
SELECT s.name, sub.title, e.marks
FROM   enrollments e
JOIN   students s   ON e.roll_no      = s.roll_no
JOIN   subjects sub ON e.subject_code = sub.subject_code
ORDER  BY s.name, sub.title;
```

```
 NAME          | TITLE                | MARKS
 --------------+----------------------+------
 Arjun Reddy   | Communication Skills | 80
 Arjun Reddy   | Digital Electronics  | 74
 Arjun Reddy   | Signals and Systems  | 58
 Karthik S     | Communication Skills | 72
 Karthik S     | Thermodynamics       | 49
 Meena Devi    | Digital Electronics  | 95
 Priya Sharma  | Data Structures      | 67
 Priya Sharma  | Database Systems     | 92
 Ravi Kumar    | Communication Skills | 91
 Ravi Kumar    | Database Systems     | 88
 Ravi Kumar    | Operating Systems    | 79
 Sneha Patel   | Database Systems     | (null)
 Sneha Patel   | Operating Systems    | 85
 Vikram Nair   | Thermodynamics       | 63
                                        (14 rows)
```
14 rows = one per enrollment. Anjali (108) is not here: she has no enrollment, so nothing to match.

The same idea for teachers and the subjects they teach (`teaches` is in the middle):

```sql
-- Which teacher teaches which subject
SELECT t.name, sub.title
FROM   teaches te
JOIN   teachers t   ON te.teacher_id   = t.teacher_id
JOIN   subjects sub ON te.subject_code = sub.subject_code
ORDER  BY t.name, sub.title;
```
8 rows (one per `teaches` row). Dr. Iyer teaches nothing, so he is missing; nobody teaches HS101, so it is missing.

### 4.2 Adding WHERE and ORDER BY to a join

The join lives in `FROM`. Filtering still goes in `WHERE`, sorting in `ORDER BY`, always last. Everything from Days 11 and 12 works unchanged — just put the alias in front of the column.

```sql
-- Only ECE students, with branch name, sorted by student name
SELECT s.roll_no, s.name, b.branch_name
FROM   students s
JOIN   branches b ON s.branch_code = b.branch_code
WHERE  b.branch_code = 'ECE'
ORDER  BY s.name;
```
2 rows: Arjun Reddy, Meena Devi.

```sql
-- Marks of 80 or more, with student name and subject title, highest first
SELECT s.name, sub.title, e.marks
FROM   enrollments e
JOIN   students s   ON e.roll_no      = s.roll_no
JOIN   subjects sub ON e.subject_code = sub.subject_code
WHERE  e.marks >= 80
ORDER  BY e.marks DESC;
```
6 rows (95, 92, 91, 88, 85, 80).

Text joining with `||` and an alias work too:

```sql
-- One text column: "Ravi Kumar - Computer Science and Engineering"
SELECT s.name || ' - ' || b.branch_name AS student_and_branch
FROM   students s
JOIN   branches b ON s.branch_code = b.branch_code
ORDER  BY s.name;
```
8 rows.

---

## Block 5 — Self join (15 min)

### 5.1 The same table twice: teachers and their head

In `teachers`, `hod_id` points to `teacher_id` **in the same table** (the recursive relationship from Day 5). To show each teacher with the head's name we open the table twice, with two different aliases, as if it were two tables.

```sql
-- Each teacher with the name of their head
SELECT t.name AS teacher, h.name AS head
FROM   teachers t
JOIN   teachers h ON t.hod_id = h.teacher_id;
```

```
 TEACHER        | HEAD
 ---------------+----------
 Prof. Lakshmi  | Dr. Rao
 Prof. Anand    | Dr. Rao
 Prof. Bhaskar  | Dr. Iyer
                     (3 rows)
```

> **In simple words:** "`t` is the table read as 'teachers'. `h` is the same table read as 'heads'. The join says: my hod_id must equal some row's teacher_id. Same table, two names, two jobs."

**Plain meaning:** a **self join** is a table joined to itself. It needs two aliases, because otherwise Oracle cannot tell the two copies apart.

Dr. Rao, Dr. Iyer and Prof. Fatima have `hod_id` NULL, so they have no partner and are **missing** from the result. Only 3 of 6 teachers appear. Tomorrow we learn how to keep them.

> 📌 **Exam-likely:** "A query that joins EMPLOYEES to EMPLOYEES to show each employee's manager is called a…" → **self join**. "How many times does the table appear in FROM?" → **twice, with two aliases**.

---

## Block 6 — Practice: 25 join exercises (35 min)

Students work on the College DB in Live SQL. Write the expected number of rows **before** running, then check. Answers under the table; reveal after 20 minutes.

| # | Question | Answer | Rows |
|---|---|---|---|
| 1 | Every student (roll no, name) with their branch name | `SELECT s.roll_no, s.name, b.branch_name FROM students s JOIN branches b ON s.branch_code = b.branch_code;` | 8 |
| 2 | Only CSE students with the branch name | `SELECT s.name, b.branch_name FROM students s JOIN branches b ON s.branch_code = b.branch_code WHERE b.branch_code = 'CSE';` | 4 |
| 3 | Every student with the head name of their branch | `SELECT s.name, b.head_name FROM students s JOIN branches b ON s.branch_code = b.branch_code;` | 8 |
| 4 | Every enrollment with the student's name and marks | `SELECT s.name, e.subject_code, e.marks FROM enrollments e JOIN students s ON e.roll_no = s.roll_no;` | 14 |
| 5 | Every subject with its branch name | `SELECT sub.subject_code, sub.title, b.branch_name FROM subjects sub JOIN branches b ON sub.branch_code = b.branch_code;` | 7 |
| 6 | Every teacher with their branch name | `SELECT t.name, b.branch_name FROM teachers t JOIN branches b ON t.branch_code = b.branch_code;` | 6 |
| 7 | Every fee payment with the student's name | `SELECT f.payment_id, s.name, f.amount, f.paid_on FROM fee_payments f JOIN students s ON f.roll_no = s.roll_no;` | 9 |
| 8 | Fee payments made by UPI, with names | `SELECT s.name, f.amount, f.paid_on FROM fee_payments f JOIN students s ON f.roll_no = s.roll_no WHERE f.pay_mode = 'UPI';` | 5 |
| 9 | Fee payments made in 2025, with names | `SELECT s.name, f.amount, f.paid_on FROM fee_payments f JOIN students s ON f.roll_no = s.roll_no WHERE f.paid_on >= DATE '2025-01-01';` | 3 |
| 10 | Every copy with its book title, sorted by title then copy number | `SELECT b.title, c.copy_no, c.status FROM copies c JOIN books b ON c.isbn = b.isbn ORDER BY b.title, c.copy_no;` | 7 |
| 11 | Loans taken by students, with the student's name | `SELECT l.loan_id, s.name, l.issue_date, l.return_date FROM loans l JOIN students s ON l.roll_no = s.roll_no;` | 4 |
| 12 | Loans taken by teachers, with the teacher's name | `SELECT l.loan_id, t.name, l.issue_date FROM loans l JOIN teachers t ON l.teacher_id = t.teacher_id;` | 1 |
| 13 | Roll no and name of students enrolled in CS201 | `SELECT s.roll_no, s.name FROM students s JOIN enrollments e ON s.roll_no = e.roll_no WHERE e.subject_code = 'CS201';` | 3 |
| 14 | Students who have at least one enrollment, each name once | `SELECT DISTINCT s.roll_no, s.name FROM students s JOIN enrollments e ON s.roll_no = e.roll_no ORDER BY s.roll_no;` | 7 |
| 15 | Exercise 1 written with USING | `SELECT s.roll_no, s.name, b.branch_name FROM students s JOIN branches b USING (branch_code);` | 8 |
| 16 | Exercise 1 written in the old comma style | `SELECT s.roll_no, s.name, b.branch_name FROM students s, branches b WHERE s.branch_code = b.branch_code;` | 8 |
| 17 | Mark sheet: student name, subject title, marks, grade (three tables) | `SELECT s.name, sub.title, e.marks, e.grade FROM enrollments e JOIN students s ON e.roll_no = s.roll_no JOIN subjects sub ON e.subject_code = sub.subject_code;` | 14 |
| 18 | Which teacher teaches which subject (names and titles) | `SELECT t.name, sub.title FROM teaches te JOIN teachers t ON te.teacher_id = t.teacher_id JOIN subjects sub ON te.subject_code = sub.subject_code ORDER BY t.name;` | 8 |
| 19 | ECE students and the titles of the subjects they take | `SELECT s.name, sub.title FROM students s JOIN enrollments e ON s.roll_no = e.roll_no JOIN subjects sub ON e.subject_code = sub.subject_code WHERE s.branch_code = 'ECE';` | 4 |
| 20 | All grade A results with student name and subject title | `SELECT s.name, sub.title, e.marks FROM enrollments e JOIN students s ON e.roll_no = s.roll_no JOIN subjects sub ON e.subject_code = sub.subject_code WHERE e.grade = 'A';` | 5 |
| 21 | Teachers and the CSE subjects they teach | `SELECT t.name, sub.subject_code, sub.title FROM teaches te JOIN teachers t ON te.teacher_id = t.teacher_id JOIN subjects sub ON te.subject_code = sub.subject_code WHERE sub.branch_code = 'CSE';` | 5 |
| 22 | Every loan with the book title (join on two columns, then books) | `SELECT l.loan_id, b.title, l.copy_no, l.issue_date FROM loans l JOIN copies c ON l.isbn = c.isbn AND l.copy_no = c.copy_no JOIN books b ON c.isbn = b.isbn;` | 5 |
| 23 | Student name, book title and issue date for every loan by a student | `SELECT s.name, b.title, l.issue_date FROM loans l JOIN students s ON l.roll_no = s.roll_no JOIN copies c ON l.isbn = c.isbn AND l.copy_no = c.copy_no JOIN books b ON c.isbn = b.isbn;` | 4 |
| 24 | Each teacher with the name of their head (self join) | `SELECT t.name AS teacher, h.name AS head FROM teachers t JOIN teachers h ON t.hod_id = h.teacher_id;` | 3 |
| 25 | Each teacher, their head, and the teacher's branch name (self join + branches) | `SELECT t.name AS teacher, h.name AS head, b.branch_name FROM teachers t JOIN teachers h ON t.hod_id = h.teacher_id JOIN branches b ON t.branch_code = b.branch_code ORDER BY b.branch_name, t.name;` | 3 |

---

## Block 7 — 10 exam-style MCQs

1. Two tables with 5 and 6 rows are joined with no join condition. How many rows are returned?
   A. 5  B. 6  C. 11  D. 30
2. What is the result of joining two tables without a join condition called?
   A. Inner join  B. Cartesian product  C. Self join  D. Outer join
3. Which join returns only the rows that have a match in both tables?
   A. Inner join  B. Left outer join  C. Full outer join  D. Cross join
4. In `SELECT s.name FROM students s JOIN branches b ON s.branch_code = b.branch_code`, what is `s`?
   A. A column  B. A table alias  C. A schema  D. A keyword
5. Which keyword lets you join on a column that has the same name in both tables without writing `a.x = b.x`?
   A. WHERE  B. USING  C. DISTINCT  D. ORDER BY
6. What causes the error "ORA-00918: column ambiguously defined"?
   A. A column name exists in both joined tables and no alias is given
   B. The table has no primary key
   C. ORDER BY is missing
   D. The alias is too long
7. A join in which a table is joined to itself is called a:
   A. Cross join  B. Natural join  C. Self join  D. Outer join
8. In the College database, which column joins ENROLLMENTS to SUBJECTS?
   A. roll_no  B. subject_code  C. branch_code  D. marks
9. In an inner join between BRANCHES and STUDENTS, a branch that has no students will:
   A. Appear once with NULL student values  B. Appear once for every student  C. Not appear at all  D. Cause an error
10. Which of these is the old way of writing a join?
    A. `FROM a JOIN b ON a.x = b.x`  B. `FROM a, b WHERE a.x = b.x`  C. `FROM a NATURAL JOIN b`  D. `FROM a CROSS JOIN b`

---

## Homework (bring to Day 14)

1. Write five inner-join queries of your own on the College DB. For each, write the expected row count **before** running, then check.
2. Draw the join chain (boxes and arrows) and write the query for: "every fee payment with the student's name and branch name".
3. On paper, without running: which rows are missing from `teachers JOIN teaches`? Which rows are missing from `books JOIN copies`?
4. Read the one-slide summary. Tomorrow: the join that keeps the missing rows.

---

## One-slide summary

- Data is split into tables on purpose. A **join** brings it back together using **child.fk = parent.pk**.
- Read the join columns off the diagram. Every foreign key is a join.
- No join condition → **Cartesian product** (CROSS JOIN): rows of A × rows of B. Almost always a mistake.
- **Inner join** = `JOIN … ON`. Keeps only rows that match in both tables. Rows with no partner disappear (CIVIL, Anjali, CS204, the three heads).
- Give each table an **alias** and write `alias.column`. A shared column name with no alias → "column ambiguously defined".
- `USING (col)` when the column name is the same on both sides. `NATURAL JOIN` guesses — avoid. Old comma style `FROM a, b WHERE a.x = b.x` — recognise it.
- Three tables = two `JOIN … ON` lines. Follow the chain. WHERE and ORDER BY work as before.
- **Self join** = the same table twice with two aliases (teacher and head via `hod_id`).

## Simple glossary

| Word | Meaning in one line |
|---|---|
| Join | A SELECT that matches rows from two or more tables using a common column |
| Join condition | The rule that says which rows match (`ON s.branch_code = b.branch_code`) |
| Child / parent table | The table with the foreign key / the table with the primary key it points at |
| Cartesian product (cross join) | Every row of A paired with every row of B — no join condition |
| Inner join | Only the rows that match in both tables |
| Alias | A short name for a table (`students s`) or for a column (`AS head`) |
| Ambiguous column | A column name found in two joined tables with no alias in front |
| USING | Join on a column spelled the same in both tables |
| NATURAL JOIN | Join automatically on all same-named columns (awareness only) |
| Self join | A table joined to itself using two aliases |
