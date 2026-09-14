# Day 01 — What is a Database and Why Do We Need One?

**Exam syllabus points covered today (1Z0-006 → "What is a Database?")**
- Parts of a database system, and the purpose of a database
- Types of databases: flat file, hierarchical, network, relational, object-oriented
- What makes a relational database special, and why businesses use it
- How database technology changed over time
- Storage words (bit, byte, field, record, file) and the three "levels of looking at data"

**By the end of today, a student can:**
1. Explain the difference between data and information.
2. Say what a database is and what a DBMS is, in plain words.
3. Name the 5 parts of a database system.
4. Recognize each type of database from a short description.
5. List what makes a relational database special.
6. Explain the 3 levels of looking at data with the College example.
7. Log in to Oracle Live SQL, run a SELECT, and create a small table.

---

## Today's topics

**0. Welcome**
- Exam facts
- Class rules
- The College story (our example for all 15 days)

**1. Data, database, DBMS**
- 1.1 Data vs information
- 1.2 What is a database?
- 1.3 Why do we need a database? (The problem it solves)
- 1.4 The 5 parts of a database system

**2. Types of databases**
- 2.1 Flat file
- 2.2 Hierarchical
- 2.3 Network
- 2.4 Relational
- 2.5 Object-oriented
- 2.6 Compare them

**3. Relational databases: what is special, why business uses them, history**
- 3.1 Words we use from today
- 3.2 What makes a relational database special
- 3.3 Why businesses use relational databases
- 3.4 How database technology changed over time (simple timeline)

**4. Storage words and levels of looking at data**
- 4.1 Storage words (from smallest to biggest)
- 4.2 The three levels of looking at data

**5. Practice: Oracle Live SQL**
- 5.1 Log in
- 5.2 Look at a ready-made table
- 5.3 Make your first table (the College story starts)
- 5.4 Make a view (the "view level" in real life)

---
## Time plan

| Time | Block | What we do |
|---|---|---|
| 0:00 – 0:15 | 0 | Welcome, what the exam is, the College story |
| 0:15 – 1:00 | 1 | Data, database, DBMS, why we need a database, 5 parts |
| 1:00 – 1:40 | 2 | Types of databases |
| 1:40 – 1:50 | — | Break |
| 1:50 – 2:20 | 3 | Relational databases: what is special, why business uses them, history |
| 2:20 – 2:40 | 4 | Storage words and levels of looking at data |
| 2:40 – 2:55 | 5 | Practice: Oracle Live SQL |
| 2:55 – 3:00 | 6 | 10 quick MCQs, homework |

---

## Block 0 — Welcome (15 min)

### In simple words
> "This course has two halves. First half: how to **design** a database — that means drawing boxes and lines (called ER diagrams) properly. Second half: how to **talk** to a database using a simple language called SQL. The exam is 60 multiple-choice questions, 2 hours, and you need 36 right. Nobody fails this exam if they attend all 15 classes and do the homework."

### Exam facts (write on board)

| Questions | Time | Pass |
|---|---|---|
| 60 MCQ | 120 min | 60% (36 correct) |

### Class rules
1. Laptop or lab PC every day — every class has a Live SQL practice part.
2. **Notebook and pencil** — diagrams are drawn by hand first.
3. Always click **Save** in Live SQL and give the script a name (`Day01`, `Day02`, …).

### The College story (our example for all 15 days)
> "Our college wants one system to keep track of **students**, their **branch** (CSE, ECE, MECH…), the **subjects** taught each semester, the **teachers**, **marks**, **fees**, and the **library**. Today we just look at it. By Day 8 you will build it yourself."

---

## Block 1 — Data, database, DBMS (45 min)

### 1.1 Data vs information

Write on the board: **85   92   78**

Ask: "What is this?" Nobody knows. Now write: **Ravi — DBMS 85, OS 92, Networks 78.** Now everyone knows.

| Word | Meaning | Example |
|---|---|---|
| **Data** | Raw facts, no meaning by themselves | 85, 92, 78, Ravi, CSE |
| **Information** | Data arranged so it has meaning | Ravi (CSE) scored 85, 92, 78 |

> **In simple words:** "A database stores data **together with its meaning** — which number belongs to which student and which subject. That is the whole point."

### 1.2 What is a database?

**Simple definition (good enough for the exam):**
> A database is an **organized collection of related data** kept in one place so that it can be stored, searched, updated and shared easily.

Three key words: **organized**, **related**, **one place**.

**What is a DBMS?**
> A DBMS (Database Management System) is the **software** that creates, stores, protects and gives access to a database. Examples: **Oracle Database**, MySQL, PostgreSQL, Microsoft SQL Server.

**Library example (we will reuse this every day):**

| In a library | In a database |
|---|---|
| Books | Data |
| Catalogue / index cards | Information about the data (called *metadata*) |
| Librarian | DBMS (the software) |
| Rules: "max 3 books, return in 14 days" | Rules / constraints |
| Members and staff | Users |
| Building and shelves | Hardware |

### 1.3 Why do we need a database? (The problem it solves)

**Tell this story:**
> "Before the database, the admission office keeps `students.xlsx`. The exam cell keeps `marks.xlsx` and types student names again. The library keeps `members.xlsx`. The hostel keeps `hostel.xlsx`. Priya changes her phone number. The office updates its file. The library still calls the old number."

Problems when data is kept in separate files/spreadsheets:

| Problem | Simple meaning | College example |
|---|---|---|
| **Duplicate data** (redundancy) | Same thing typed in many places | Priya's name and phone in 4 files |
| **Data does not match** (inconsistency) | Copies disagree with each other | Phone changed in 1 file, old in 3 |
| **Two people cannot work at once** | Second person overwrites the first | Two clerks entering marks in the same file |
| **No proper security** | Either you can open the whole file or nothing | Library clerk can see fee details |
| **Half-done changes** | Something fails in the middle | Fee money taken but receipt not saved |
| **Hard to search across files** | Manual matching between sheets | "Students with fee due AND library fine" takes a full day |

**So the purpose of a database is to:**
1. Store each piece of data **once**
2. Keep data **correct and matching everywhere**
3. Let **many people** use it at the same time
4. Give each user **only what they should see**
5. **Find** data fast (using SQL)
6. **Recover** data if the computer crashes
7. Help managers take **decisions** from reports

### 1.4 The 5 parts of a database system

A **database system** is the database + the software + everything around it. The exam expects these 5 parts:

```
   PEOPLE  ──►  PROCEDURES  ──►  SOFTWARE  ──►  HARDWARE  ──►  DATA
   (users,       (rules on how    (DBMS +          (server,       (the actual
    developers,   to use it)       apps + OS)       disk,          data + its
    DBA)                                            network)       description)
```

| Part | What it is | College example |
|---|---|---|
| **Hardware** | Computers, disks, network | College server or a cloud server |
| **Software** | The DBMS, the operating system, the apps | Oracle Database + the student portal website |
| **Data** | The real data **and** the description of that data (metadata) | Student rows; and the definition "the STUDENTS table has ROLL_NO, NAME…" |
| **Procedures** | Written rules on how to use the system | "Take a backup every night", "Only the registrar can change marks" |
| **People** | Everyone who uses or manages it | Students, teachers, the portal developers, the database administrator (DBA) |

**Three words that confuse students (and exam questions love this):**

| Word | Means | Example |
|---|---|---|
| **Database** | The data itself | The College data |
| **DBMS** | The software that manages it | Oracle |
| **Database system** | Everything together — data, software, hardware, people, procedures | The whole College setup |

**Jobs of a DBMS (what the software does for us):**
1. Lets us **create** tables and define their columns
2. Lets us **add, change, delete and search** data
3. Controls **who can see what** (security)
4. Enforces **rules** (roll number must be unique, marks between 0 and 100)
5. Handles **many users at the same time**
6. Takes **backups** and **recovers** after a crash

> ✏️ **Activity 1 (5 min, in pairs):** Name 5 apps you used today (WhatsApp, Swiggy, UPI, college portal, YouTube). For each, say two things it must store. Then ask: which app needs the "no half-done changes" rule the most?

---

## Block 2 — Types of databases (40 min)

The exam asks you to **describe** each type and **compare** them. Keep it visual.

### 2.1 Flat file
- **One table only.** No links between tables. Like one Excel sheet.
- Everything is repeated on every row.

```
ROLL  NAME   BRANCH  BRANCH_HEAD  PHONE
101   Ravi   CSE     Dr. Rao      98xxx
102   Priya  CSE     Dr. Rao      97xxx    ← "Dr. Rao" typed again
103   Arjun  ECE     Dr. Iyer     96xxx
```
Good: very simple. Bad: duplicates, mistakes, no links, one user at a time.

### 2.2 Hierarchical
- Data arranged like a **tree** (like a family tree or an org chart).
- Every child has **exactly one parent**.
- Old style (1960s, IBM mainframes). You still see this shape in folders on your laptop.

```
          COLLEGE
         /       \
      CSE         ECE
     /   \        /
  Ravi  Priya  Arjun
```
Good: fast to go from parent to child. Bad: if a subject is taught in two branches, you must **store it twice**.

### 2.3 Network
- Like hierarchical, but a child can have **many parents**. Records are connected with **pointers** (links).

```
   CSE ───┐      ┌─── ECE
          ▼      ▼
      "Data Structures"   ← two parents
```
Good: can handle many-to-many. Bad: complicated; the programmer must know the exact path of the links.

### 2.4 Relational  ← the one we study
- Data kept in **tables** (rows and columns). Tables are linked by **matching values**, not by pointers.
- Invented by **E. F. Codd at IBM in 1970**. Used by Oracle, MySQL, PostgreSQL, SQL Server.
- We talk to it with **SQL**.

```
BRANCHES                     STUDENTS
CODE | NAME       | HEAD     ROLL | NAME  | BRANCH_CODE
-----+------------+------    -----+-------+------------
CSE  | Comp Sci   | Rao      101  | Ravi  | CSE
ECE  | Electronics| Iyer     102  | Priya | CSE
                              103  | Arjun | ECE
  ▲                                            │
  └──────── linked by the matching value ──────┘
```
Good: easy to understand, flexible searching, rules enforced by the software, no duplicate data. Bad: nothing important at this level.

### 2.5 Object-oriented
- Data stored as **objects** (like objects in Java or C++) — with classes and inheritance.
- Used in special areas (engineering drawings, multimedia). Not common for business data.
- Good: matches programming objects directly. Bad: no strong standard language like SQL, small community.

*(For awareness only: Oracle is actually "object-relational" — a relational database with some object features added. The exam does not go deeper than this.)*

### 2.6 Compare them (memorize this table)

| Type | Shape | How tables/records are linked | Can handle many-to-many? | Example |
|---|---|---|---|---|
| Flat file | One table | Not linked | No | Excel, CSV |
| Hierarchical | Tree | One parent per child | No (must duplicate) | IBM IMS |
| Network | Web / graph | Pointers, many parents | Yes | IDMS |
| Relational | Many tables | Matching values | Yes | Oracle, MySQL |
| Object-oriented | Objects | Object references | Yes | ObjectDB |

> **In simple words:**
> - Hierarchical = **family tree**. You have one father.
> - Network = **Instagram followers**. Anyone can be linked to anyone.
> - Relational = **several Excel sheets** where a column in one sheet matches a column in another. No arrows, only matching values.
> - Object-oriented = **the Java objects** you made in first year, saved directly.

> ✏️ **Activity 2 (5 min):** Which type fits best?
> 1. A phone contact list with no groups → flat file
> 2. Folders on your laptop → hierarchical
> 3. College: students take many subjects, subjects have many students, and we need many kinds of reports → relational
> 4. A 3D design tool that stores parts with inheritance → object-oriented

---

## Break (10 min)

---

## Block 3 — Relational databases: what is special, why business uses them, history (30 min)

### 3.1 Words we use from today

| Word | Plain meaning | College example |
|---|---|---|
| **Table** | A grid of rows and columns about one kind of thing | STUDENTS |
| **Row** (record) | One item | (101, Ravi, CSE) |
| **Column** (field) | One property | NAME |
| **Primary key** | The column that makes each row unique | ROLL_NO |
| **Foreign key** | A column that points to the primary key of another table | BRANCH_CODE in STUDENTS points to BRANCHES |

*(You may hear "relation", "tuple", "attribute" in books. They mean table, row, column. The exam uses both sets of words, so mention them once and move on.)*

### 3.2 What makes a relational database special (exam list)

1. Data is stored in **tables** made of rows and columns.
2. Every table has a **name**; every column in a table has a **different name**.
3. **No two rows are the same** — the primary key guarantees it.
4. Each cell holds **only one value** (never a list like "98xxx, 97xxx").
5. All values in a column are of the **same type** (all numbers, or all text, or all dates).
6. **Order does not matter** — rows and columns can be in any order; we search by value.
7. Tables are linked by **matching values** (foreign keys), not by pointers.
8. We use **SQL** — we say *what* we want, not *how* to find it.
9. The software **enforces rules**: primary key never empty and never duplicate; a foreign key must point to a real row; values must be the right type.

### 3.3 Why businesses use relational databases

| Business need | What relational databases give |
|---|---|
| Money must never be half-transferred | Transactions: all steps happen, or none (Day 9) |
| Thousands of users at once | Built-in handling of many users |
| Reports must be trusted | One copy of each fact, rules enforced by the software |
| Rules and audits (banks, government) | Security, backups, change tracking |
| Requirements keep changing | Add a table or a column without rebuilding everything |
| Easy to hire people | SQL is the same everywhere — Oracle, MySQL, PostgreSQL, SQL Server |

### 3.4 How database technology changed over time (simple timeline)

| When | What changed | One line to remember |
|---|---|---|
| 1960s | Files → first databases (hierarchical, network) | Programmers followed pointers |
| **1970** | **E. F. Codd proposes the relational model** | Data in tables, linked by values |
| Late 1970s | SQL is created; **Oracle (1979)** becomes the first commercial relational database | SQL becomes the standard language |
| 1980s–90s | Relational databases everywhere; object features added; reporting/data warehouses | Business runs on relational |
| 2000s | Free/open-source databases (MySQL, PostgreSQL); very large websites create "NoSQL" | New tools for huge scale |
| 2010s–today | Databases in the **cloud**, self-managing, and now with AI features | You rent a database instead of buying a server |

> **Exam-likely facts:** Codd → relational → 1970. Hierarchical came **before** relational. Hierarchical and network use **pointers**; relational uses **values**.

---

## Block 4 — Storage words and levels of looking at data (20 min)

### 4.1 Storage words (from smallest to biggest)

```
 BIT  →  BYTE  →  FIELD  →  RECORD  →  FILE / TABLE  →  DATABASE
 0/1     one       one       one row     all rows of      all tables
         letter    value                 one kind         together
```

| Word | Meaning | College example |
|---|---|---|
| **Bit** | Smallest unit: 0 or 1 | — |
| **Byte** | 8 bits = one character | the letter "R" |
| **Field** (column value) | One piece of data | "Ravi" |
| **Record** (row) | All fields of one item | 101, Ravi, CSE, 98xxx |
| **File / Table** | All records of one kind | all students |
| **Database** | All tables together | students + branches + subjects + … |

*(For awareness only: inside Oracle, tables are kept in storage areas called **tablespaces**, which are made of **data files** on the disk. You do not manage these in this course.)*

### 4.2 The three levels of looking at data

**In simple words:**
> "A student checking marks on the portal does not care which disk the marks are on. The developer does not want to rewrite the app if the DBA moves the disk. So a database is viewed at three levels, and each level hides the details of the level below."

```
   ┌───────────────────────────────────────────┐
   │ VIEW level  (also called External)         │  ← what EACH USER sees
   │   Student sees: my marks, my fees           │
   │   Teacher sees: my class list               │
   ├───────────────────────────────────────────┤
   │ LOGICAL level  (also called Conceptual)    │  ← what the WHOLE DATABASE contains
   │   Tables: STUDENTS, SUBJECTS, MARKS…        │
   │   Columns, keys, rules                      │
   ├───────────────────────────────────────────┤
   │ PHYSICAL level  (also called Internal)     │  ← HOW it is stored on disk
   │   Files, disk blocks, indexes               │
   └───────────────────────────────────────────┘
```

| Level | Who cares | What it describes |
|---|---|---|
| **View / External** | Users and app developers | The small part of the data one group of users needs |
| **Logical / Conceptual** | Database designers | All the tables, columns, keys and rules — but nothing about disks |
| **Physical / Internal** | The DBA and the software | Files and disk storage |

**Why this is useful ("data independence")**
- Add a new column to STUDENTS → the teacher's class-list view still works. (Changing the logical level does not break the view level.)
- Move the data from a slow disk to a fast disk → no table or app changes. (Changing the physical level does not break the logical level.)

> **Exam-likely question:** "Views for particular groups of users are defined at which level?" → **External (view) level**. "Moving storage to a new disk without changing the application is an example of…" → **physical data independence**.

---

## Block 5 — Practice: Oracle Live SQL (15 min)

### 5.1 Log in
1. Open https://livesql.oracle.com and **Sign In** with the Oracle account.
2. Left side: **SQL Worksheet** (type here), **My Scripts** (saved work), **Schema** (see your tables).
3. Type SQL → click **Run**. The result appears below.
4. Click **Save**, name it `Day01`.

### 5.2 Look at a ready-made table
Live SQL comes with a sample company database called `HR` (employees, departments, …).

```sql
-- Show the whole table
SELECT * FROM hr.employees;

-- Show only some columns (this is the "view level": a user sees just what they need)
SELECT first_name, last_name, salary FROM hr.employees;

-- Count the rows
SELECT COUNT(*) FROM hr.employees;
```
Click the **Schema** tab on the left and open `EMPLOYEES` to see its columns and types — that is the **logical level**.

> ⚠️ If `hr.employees` says "table or view does not exist": open **Code Library → Schemas → HR**, click **Run**, then try again.

### 5.3 Make your first table (the College story starts)
```sql
-- A table: columns with a type each; ROLL_NO is the primary key (unique, never empty)
CREATE TABLE students (
    roll_no   NUMBER(6)     PRIMARY KEY,
    name      VARCHAR2(50)  NOT NULL,     -- must be filled
    branch    VARCHAR2(10),
    phone     VARCHAR2(15)
);

-- Rows
INSERT INTO students VALUES (101, 'Ravi',  'CSE', '9800000001');
INSERT INTO students VALUES (102, 'Priya', 'CSE', '9700000002');
INSERT INTO students VALUES (103, 'Arjun', 'ECE', '9600000003');

SELECT * FROM students;

-- Try to add the same roll number again → Oracle refuses (primary key rule)
INSERT INTO students VALUES (101, 'Copy', 'CSE', NULL);
-- Error: ORA-00001 unique constraint violated  ← this is the software enforcing the rule

-- Order does not matter: we find rows by VALUE
SELECT * FROM students WHERE roll_no = 103;
```

> **In simple words:** "`NUMBER` means numbers, `VARCHAR2(50)` means text up to 50 letters. That is all we need this week."

### 5.4 Make a view (the "view level" in real life)
```sql
-- Library staff should see names but NOT phone numbers
CREATE VIEW student_names AS
SELECT roll_no, name, branch FROM students;

SELECT * FROM student_names;
```
Ask the class: "Which level is `student_names`? Which level is `students`? Where is the disk?" (View, logical, physical.)

---

## Block 6 — 10 exam-style MCQs

1. A database is best described as:
   A. A program that manages files
   B. An organized collection of related data
   C. A spreadsheet with many sheets
   D. A storage device

2. Which part of a database system includes the DBMS and the operating system?
   A. Hardware  B. Software  C. Procedures  D. Data

3. "Data about data" is called:
   A. Big data  B. Metadata  C. Backup data  D. User data

4. Which type of database arranges data as a tree where each child has exactly one parent?
   A. Relational  B. Network  C. Hierarchical  D. Object-oriented

5. Which type of database links tables using matching values instead of pointers?
   A. Hierarchical  B. Network  C. Relational  D. Flat file

6. Who proposed the relational model?
   A. Larry Ellison  B. E. F. Codd  C. Bill Gates  D. Charles Bachman

7. Which is NOT a feature of a relational database?
   A. Each cell holds only one value
   B. The order of rows matters when searching
   C. No two rows are the same
   D. Tables are linked by common values

8. Views for particular user groups belong to which level?
   A. Physical  B. Logical  C. External  D. Internal

9. In storage terms, one row of a table is also called a:
   A. Bit  B. Byte  C. Field  D. Record

10. Changing the disk where data is stored without changing any application is an example of:
    A. Logical data independence
    B. Physical data independence
    C. Data redundancy
    D. Data inconsistency

---

## Homework (bring to Day 2)

1. In 5 lines, in your own words: difference between a *database*, a *DBMS* and a *database system*. Name one DBMS product.
2. Draw the College data (3 students, 2 branches, 2 subjects) as **(a)** a tree (hierarchical) and **(b)** tables (relational). Circle where data is repeated in (a).
3. Write the 6 problems of keeping data in separate files, and one line each on how a database fixes it.
4. In Live SQL, create a table `branches (code, name, head_name)` with 3 rows. Save the script as `Day01_homework`. Tomorrow we link it to `students`.

---

## One-slide summary

- **Data** = raw facts; **information** = data with meaning.
- **Database** = organized related data; **DBMS** = the software (Oracle); **database system** = data + software + hardware + procedures + people.
- Why a database: no duplicates, data always matches, many users, security, fast search, recovery, reports.
- Types: **flat** (one table) → **hierarchical** (tree) → **network** (pointers, many parents) → **relational** (tables linked by values, Codd 1970, SQL) → **object-oriented** (objects).
- Relational is special: tables, unique rows (primary key), one value per cell, same type per column, order does not matter, linked by values, SQL, rules enforced.
- Storage words: bit → byte → field → record → file/table → database.
- Three levels: **view** (what a user sees) → **logical** (all tables) → **physical** (disk). Change one level without breaking the one above = data independence.

## Simple glossary

| Word | Meaning in one line |
|---|---|
| Data | Raw facts |
| Information | Data with meaning |
| Metadata | Description of the data (column names, types) |
| DBMS | Software that manages a database |
| Table | Grid of rows and columns for one kind of thing |
| Row / record | One item in a table |
| Column / field | One property |
| Primary key | Column that makes every row unique |
| Foreign key | Column that points to another table's primary key |
| View | A saved SELECT that shows part of the data |
| SQL | The language used to talk to a relational database |
| Data independence | Change one level without breaking the level above |
