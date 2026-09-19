# Day 01 — What is a Database?

**Exam syllabus points covered today (1Z0-006 → "What is a Database?")**
- Database Concepts: describe the components of a database system; explain the purpose of a database
- Types of Database Models: describe the types (relational, object oriented, flat, network, hierarchical); compare the differences between them
- Relational Database Concepts: characteristics of a relational database; why relational databases matter in business; the major transformations in database technology
- Defining Levels of Data Abstraction: the words used for database storage; the levels of data abstraction used in relational databases

**By the end of today, a student can:**
1. Explain the difference between data and information.
2. Say in plain words what a database is, what a DBMS is, and what a database system is.
3. Name the 5 components of a database system with a College example for each.
4. Recognise each of the 5 database models from a short description and compare them in one table.
5. List the characteristics of a relational database and say why business uses it.
6. Put the storage words (bit, byte, field, record, file/table, database) in order.
7. Name the three levels of data abstraction and give a College example for each.

---

## Today's topics

**0. Welcome**
- Exam facts
- Class rules
- The College story (our example for all 15 days)
- The shape of the course: Part A (design, on paper) and Part B (SQL, on laptops)

**1. Data, database, DBMS**
- 1.1 Data vs information
- 1.2 What is a database? What is a DBMS?
- 1.3 The purpose of a database (the problem with separate files)
- 1.4 The 5 components of a database system

**2. Types of database models**
- 2.1 Flat file
- 2.2 Hierarchical
- 2.3 Network
- 2.4 Relational
- 2.5 Object-oriented
- 2.6 Compare them (one table)

**3. Relational databases**
- 3.1 Characteristics of a relational database
- 3.2 Why business uses relational databases
- 3.3 Major transformations in database technology (5-line timeline)

**4. Storage words and levels of data abstraction**
- 4.1 Storage words, from smallest to biggest
- 4.2 The three levels: external (view), conceptual (logical), internal (physical)

**5. Practice (paper)**
- 5.1 Classify 6 real examples by database model
- 5.2 Draw the same College data as a tree and as tables; mark repeated data
- 5.3 Label 8 statements as view / logical / physical level

**6. 10 exam-style MCQs**

---
## Time plan

| Time | Block | What we do |
|---|---|---|
| 0:00 – 0:15 | 0 | Welcome: exam facts, class rules, the College story, the two-part course |
| 0:15 – 0:55 | 1 | Data, database, DBMS; purpose of a database; 5 components |
| 0:55 – 1:30 | 2 | Types of database models and how they compare |
| 1:30 – 1:40 | — | Break |
| 1:40 – 2:00 | 3 | Relational databases: characteristics, business use, timeline |
| 2:00 – 2:25 | 4 | Storage words; the three levels of data abstraction |
| 2:25 – 2:45 | 5 | Practice on paper |
| 2:45 – 2:55 | 6 | 10 exam-style MCQs |
| 2:55 – 3:00 | 6 | Key points, homework |

---

## Block 0 — Welcome (15 min)

### Exam facts (write on the board)

| Questions | Time | Pass mark | Type |
|---|---|---|---|
| 60 | 120 minutes | 60% = 36 correct | Multiple choice, on a computer |

> **In simple words:** "This exam has no typing and no coding. Every question is multiple choice. About two-thirds of the questions are about **designing** a database — drawing boxes and lines correctly — and about one-third are about **SQL**, the language we use to talk to a database. Nobody who attends all 15 classes and does the homework fails this exam."

### Class rules
1. **Days 1–8 (Part A): notebook and pencil.** We draw, we list, we fill charts. No laptop needed.
2. **Days 9–15 (Part B): laptop or lab PC.** We type SQL in a free website called Oracle Live SQL. You will create the account as homework on Day 8.
3. Every class starts with a 10-minute recap of the last class. Every class ends with 10 exam-style questions.
4. Homework is on paper and is checked at the start of the next class.

### The College story (our example for all 15 days)

> **In simple words:** "Imagine our college office comes to us and says: *We want one system for the whole college.* It must keep track of **students** and their **branch** (CSE, ECE, MECH, CIVIL). It must know which **subjects** each student takes each semester and the **marks** they get. It must know the **teachers**, who is the head of each branch, and who teaches which subject. It must record every **fee payment**. And it must run the **library** — books, copies of books, and who borrowed what. Today we only look at this story. By Day 8 you will have designed the whole thing on paper, and by Day 14 you will be asking it questions in SQL."

### The shape of the course

| Part A — Design (Days 1–8, on paper) | Part B — SQL (Days 9–15, on a laptop) |
|---|---|
| Day 1 what a database is → Day 2 requirements and rules → Days 3–6 drawing the design → Day 7 turning the drawing into tables → Day 8 the complete College design + a mock test | Day 9 what SQL is, creating tables → Day 10 adding and changing data → Days 11–12 reading and sorting data → Days 13–14 joining tables + SQL quiz → Day 15 full mock exam + exam tips |

---

## Block 1 — Data, database, DBMS (40 min)

### 1.1 Data vs information

Write on the board: **85   92   78**

Ask: "What is this?" Nobody knows. Now write: **Ravi (CSE) — Databases 85, Operating Systems 92, Networks 78.** Now everyone knows.

| Word | Plain meaning | College example |
|---|---|---|
| **Data** | Raw facts. On their own they mean nothing. | 85, 92, 78, Ravi, CSE |
| **Information** | Data arranged so that it has a meaning and can be used | Ravi of CSE scored 85 in Databases |

> **In simple words:** "A database stores data **together with its meaning** — which number belongs to which student and which subject. Turning data into information is the whole point of a database."

### 1.2 What is a database? What is a DBMS?

**Database** — simple definition, good enough for the exam:
> A database is an **organized collection of related data**, kept in one place, so that it can be stored, searched, changed and shared easily.

Three key words: **organized** (not thrown together), **related** (the marks belong to a student, the student belongs to a branch), **one place** (not four different spreadsheets).

**DBMS (Database Management System)**:
> The **software** that creates the database, stores the data, protects it, and lets people and programs use it. Examples: **Oracle Database**, MySQL, PostgreSQL, Microsoft SQL Server.

**Three words that students mix up (the exam loves this):**

| Word | Means | College example |
|---|---|---|
| **Database** | The data itself, organized | All the College data: students, marks, fees, books |
| **DBMS** | The software that manages the data | Oracle Database |
| **Database system** | Everything together: data + software + hardware + procedures + people | The whole College setup, including the office staff who use it |

**A library picture to remember it by:**

| In a library | In a database system |
|---|---|
| The books on the shelves | The data |
| The catalogue that describes every book | The description of the data (called **metadata** = data about data) |
| The librarian | The DBMS (the software) |
| Rules: "3 books at a time, return in 14 days" | Procedures and rules |
| Members and staff | People (users) |
| The building and the shelves | Hardware |

### 1.3 The purpose of a database (the problem with separate files)

**Tell this story:**
> "Before the database, the admission office keeps a spreadsheet of students. The exam cell keeps a spreadsheet of marks and types every student's name again. The library keeps its own member list. The accounts office keeps a fee sheet. Now Priya changes her phone number. The admission office updates its file. The library still calls the old number. The exam cell spelt her name wrong, so her marks sheet does not match her admission record."

Problems when data is kept in separate files:

| Problem | Plain meaning | College example |
|---|---|---|
| **Repeated data** (the book word is *redundancy*) | The same fact typed in many places | Priya's name and phone in 4 files |
| **Data does not match** (*inconsistency*) | The copies disagree with each other | New phone in 1 file, old phone in 3 |
| **Hard to search across files** | You match the sheets by hand | "Students with fees due AND a library fine" takes a full day |
| **Two people cannot work at once** | The second person overwrites the first | Two clerks entering marks in the same file |
| **No proper security** | Either you can open the whole file or nothing | The library clerk can see everyone's fee details |
| **Data gets lost** | One damaged file, no copy | The marks sheet is deleted by mistake |

**So the purpose of a database is to:**
1. Store each fact **once**, so there is nothing to repeat.
2. Keep the data **correct and matching everywhere**.
3. Let **many people** use it at the same time.
4. Show each user **only what they are allowed to see**.
5. **Find** data fast, across all of it at once.
6. **Keep data safe** with backups, and bring it back after a crash.
7. Give managers **reports** they can trust, to take decisions.

### 1.4 The 5 components of a database system

A **database system** is not only the data. The exam expects exactly these 5 components:

```
   HARDWARE   →   SOFTWARE   →   DATA   →   PROCEDURES   →   PEOPLE
   (server,        (DBMS,         (the facts    (written rules   (users,
    disks,          operating      + their       on how to use     developers,
    network)        system, apps)  description)  the system)       administrator)
```

| Component | What it is | College example |
|---|---|---|
| **Hardware** | The computers, disks and network the database runs on | The college server room and the network to every office |
| **Software** | The DBMS, the operating system, and the applications that use the data | Oracle Database, plus the student portal website |
| **Data** | The facts, **and** the description of those facts (metadata) | The student rows, and the description "a student has a roll number, a name, a branch…" |
| **Procedures** | Written rules for using the system | "Back up every night", "Only the exam cell can change marks" |
| **People** | Everyone who uses or looks after the system | Students, teachers, office staff, the portal developers, the database administrator (DBA) |

> **In simple words:** "A DBA — database administrator — is the person who looks after the database itself: installs it, takes backups, gives people access. In a college, one person often does this job part-time."

> ✏️ **Activity (5 min, in pairs):** Name 5 apps you used today (a chat app, a food app, a payment app, the college portal). For each, write two things it must store. Then ask: which app needs "one copy of each fact, always correct" the most?

---

## Block 2 — Types of database models (35 min)

A **database model** is the shape in which a database keeps its data. The exam asks you to **describe** each of the 5 models and **compare** them. Keep it visual.

### 2.1 Flat file
- **One table only.** No links to any other table. Like one spreadsheet or one text file.
- Everything about everyone is repeated on every line.

```
ROLL  NAME   BRANCH  BRANCH HEAD   PHONE
101   Ravi   CSE     Dr. Rao       98xxx
102   Priya  CSE     Dr. Rao       97xxx     ← "Dr. Rao" typed again
103   Arjun  ECE     Dr. Iyer      96xxx
```
Good: very simple to make. Bad: repeated data, spelling mistakes, no links, hard to search, one user at a time.

### 2.2 Hierarchical
- Data arranged like a **tree** (a family tree, or the folders on your laptop).
- Every child record has **exactly one parent**. You go from parent to child by following a link.
- The oldest real database model (1960s, big mainframe computers).

```
              COLLEGE
             /       \
          CSE         ECE
         /   \          \
      Ravi  Priya      Arjun
       |      |          |
    CS201  CS201      CS201      ← the subject "CS201" is stored three times
```
Good: very fast to go from parent to child. Bad: a child with two parents (one subject taught in two branches) must be **stored twice**.

### 2.3 Network
- Like hierarchical, but a child can have **many parents**. Records are joined by **pointers** (a pointer = a stored link that says "the next record is over there").

```
   CSE ────┐        ┌──── ECE
           ▼        ▼
         "CS201 Databases"       ← one record, two parents
```
Good: can show "many belong to many". Bad: complicated — the programmer must know the exact path of the pointers to find anything.

### 2.4 Relational  ← the one we study
- Data kept in **tables** (rows and columns). Tables are linked by **matching values**, not by pointers.
- Proposed by E. F. Codd in 1970. Used by Oracle, MySQL, PostgreSQL, SQL Server.
- We talk to it with a language called **SQL**.

```
BRANCHES                          STUDENTS
CODE | NAME        | HEAD         ROLL | NAME  | BRANCH CODE
-----+-------------+--------      -----+-------+------------
CSE  | Comp Sci    | Rao          101  | Ravi  | CSE
ECE  | Electronics | Iyer         102  | Priya | CSE
                                  103  | Arjun | ECE
  ▲                                                 │
  └────── linked only by the matching value "CSE" ──┘
```
Good: easy to understand, each fact stored once, flexible searching, the software enforces the rules. Bad: nothing important at the level of this exam.

### 2.5 Object-oriented
- Data stored as **objects**, like the objects in Java or C++ — with classes and inheritance.
- Used in special areas (engineering drawings, multimedia). Not common for ordinary business data.
- Good: matches program objects directly. Bad: no common language like SQL, fewer tools and people.

### 2.6 Compare them (memorise this table)

| Model | Shape | How records are linked | Many-to-many possible? | Example |
|---|---|---|---|---|
| **Flat file** | One table | Not linked | No | A spreadsheet, a text file |
| **Hierarchical** | Tree | One parent per child | No (must repeat data) | IBM IMS |
| **Network** | Web of pointers | Pointers, many parents | Yes | IDMS |
| **Relational** | Many tables | Matching values | Yes | Oracle, MySQL |
| **Object-oriented** | Objects | Object references | Yes | ObjectDB |

> **In simple words:**
> - Hierarchical = **family tree**. You have one father.
> - Network = **social media followers**. Anyone can be linked to anyone, by pointers.
> - Relational = **several spreadsheets** where a column in one sheet matches a column in another. No arrows, only matching values.
> - Object-oriented = **the Java objects** you made in first year, saved as they are.

---

## Break (10 min)

---

## Block 3 — Relational databases (20 min)

### 3.1 Characteristics of a relational database (exam list)

Words we use from today (the exam uses both sets, so hear them once):

| Everyday word | Book word | Plain meaning | College example |
|---|---|---|---|
| **Table** | relation | A grid of rows and columns about one kind of thing | STUDENTS |
| **Row** | record, tuple | One item | 101, Ravi, CSE |
| **Column** | field, attribute | One property of the item | NAME |
| **Primary key** | — | The column that makes each row different from every other row | ROLL NO |
| **Foreign key** | — | A column whose values match the primary key of another table (the link) | BRANCH CODE in STUDENTS matches CODE in BRANCHES |

What makes a relational database relational:

1. Data is stored in **tables** made of rows and columns.
2. Every table has a **name**; every column in a table has a **different name**.
3. Each **cell holds one value** only — never a list like "98xxx, 97xxx".
4. All values in one column are of the **same kind** (all numbers, or all text, or all dates).
5. **No two rows are the same** — the primary key guarantees it.
6. **Order does not matter** — rows and columns can be in any order; we find things by value, not by position.
7. Tables are linked by **matching values** (foreign keys), never by pointers.
8. We use **SQL** to define the tables and to ask questions — we say *what* we want, not *how* to find it.
9. The software **enforces rules**: the primary key is never empty and never repeated; a foreign key must match a real row; a value must be of the right kind.

### 3.2 Why business uses relational databases

| Business need | What a relational database gives |
|---|---|
| Reports must be trusted | One copy of each fact; rules enforced by the software |
| Thousands of users at once | Built-in handling of many users |
| Money must never be half-moved | A group of changes either all happen or none happen |
| Banks and government must keep records | Security, backups, a record of who changed what |
| Requirements keep changing | Add a table or a column without rebuilding everything |
| Easy to hire people | SQL is nearly the same everywhere — Oracle, MySQL, PostgreSQL, SQL Server |

> **In simple words:** "Almost every business in the world — banks, airlines, hospitals, online shops, your college — runs on a relational database. That is why this exam exists."

### 3.3 Major transformations in database technology (5-line timeline)

| When | What changed | One line to remember |
|---|---|---|
| 1960s | Separate files → the first databases: **hierarchical** and **network** | Programmers followed pointers |
| 1970 | E. F. Codd proposes the **relational model** | Data in tables, linked by values |
| Late 1970s – 1980s | **SQL** is created; Oracle (1979) is the first commercial relational database | One standard language for all |
| 1990s | **Object-oriented** databases appear; relational databases add object features (**object-relational**) | Relational stays the main type |
| 2000s – today | Relational databases everywhere; free ones like MySQL and PostgreSQL; new types for very large websites | Relational is still the base of business |

> **Exam-likely facts:** Codd → relational → 1970. Hierarchical came **before** relational. Hierarchical and network use **pointers**; relational uses **values**.

---

## Block 4 — Storage words and levels of data abstraction (25 min)

### 4.1 Storage words, from smallest to biggest

**Bit → byte → field → record → file (table) → database**

| Word | Plain meaning | College example |
|---|---|---|
| **Bit** | The smallest unit a computer stores: 0 or 1 | — |
| **Byte** | 8 bits = one character (letter, digit or symbol) | the letter "R" |
| **Field** | One value = one cell of a table (one column of one row) | "Ravi" |
| **Record** | All the fields of one item = one row | 101, Ravi, CSE, 98xxx |
| **File** (in a database: **table**) | All the records of one kind | All students |
| **Database** | All the tables together | students + branches + subjects + fees + library |

> **In simple words:** "Field is the old word for a column value; record is the old word for a row; file is the old word for a table. The exam may use either set, so learn both."

### 4.2 The three levels of data abstraction

**Abstraction** means hiding the details you do not need. A student checking marks on the portal does not care which disk the marks are on. The developer does not want to rewrite the portal if the DBA moves the data to a new disk. So a database is looked at on three levels, and each level hides the details of the level below it.

```
   ┌──────────────────────────────────────────────────────┐
   │ EXTERNAL level  (also called the VIEW level)          │  ← what EACH USER sees
   │   A student sees: my marks, my fees                   │
   │   A teacher sees: the list of students in my class    │
   │   The library sees: names and roll numbers, no fees   │
   ├──────────────────────────────────────────────────────┤
   │ CONCEPTUAL level  (also called the LOGICAL level)     │  ← what the WHOLE DATABASE holds
   │   All the tables: STUDENTS, BRANCHES, SUBJECTS,       │
   │   ENROLLMENTS, FEE PAYMENTS, BOOKS…                   │
   │   Their columns, keys and rules — nothing about disks │
   ├──────────────────────────────────────────────────────┤
   │ INTERNAL level  (also called the PHYSICAL level)      │  ← HOW it is stored
   │   Files on disk, how the bytes are arranged,          │
   │   which disk, how much space                          │
   └──────────────────────────────────────────────────────┘
```

| Level | Other name | Who cares | What it describes |
|---|---|---|---|
| **External** | View | Users and application developers | The small part of the data that one group of users needs |
| **Conceptual** | Logical | Database designers (that is you, Days 2–8) | All the tables, columns, keys and rules of the whole database |
| **Internal** | Physical | The DBA and the DBMS software | Where and how the data sits on the disk |

**One line to remember:** each level can be changed **without changing the level above it** — the book word for this is *data independence*. Move the data to a faster disk (internal) and no table changes; add a column to STUDENTS (conceptual) and the teacher's class list (external) still works.

> **Exam-likely questions:** "The part of the database one group of users sees is defined at which level?" → **external (view)**. "Which level describes how data is stored on disk?" → **internal (physical)**. "Which level describes all the tables and their relationships?" → **conceptual (logical)**.

---

## Block 5 — Practice (paper) (20 min)

### 5.1 Classify 6 real examples by database model (5 min)

Write the model next to each description: flat file, hierarchical, network, relational, object-oriented.

| # | Description | Model |
|---|---|---|
| 1 | The attendance register: one sheet, one line per student per day, the student's name and branch written again on every line | |
| 2 | The college organisation chart: Principal → Heads of branch → Teachers, each person under exactly one boss | |
| 3 | A system where a subject record has pointers to the CSE record and to the ECE record, and the programmer follows the pointers | |
| 4 | The college portal: a STUDENTS table, a SUBJECTS table and an ENROLLMENTS table that links them by roll number and subject code | |
| 5 | A CAD tool for the mechanical lab that saves each drawing as an object with a class and inherits properties from a parent class | |
| 6 | The list of contacts on a phone, no groups, no links | |

### 5.2 The same College data as a tree and as tables (10 min)

The data: branch CSE (head Dr. Rao) has students Ravi (101) and Priya (102). Branch ECE (head Dr. Iyer) has student Arjun (103). Ravi and Arjun both take subject CS201 Databases. Priya takes CS202 Operating Systems.

**Do this:** (a) draw the data as a **tree** (hierarchical: COLLEGE → branch → student → subject); (b) draw the same data as **three tables** (BRANCHES, STUDENTS, SUBJECTS) linked by matching values; (c) circle every fact that is written **more than once** in (a) and check whether it is written more than once in (b).

### 5.3 Label 8 statements as external / conceptual / internal level (5 min)

| # | Statement | Level |
|---|---|---|
| 1 | "The STUDENTS table has the columns roll number, name, email, phone, branch code." | |
| 2 | "The fee data is kept on the second disk of the server." | |
| 3 | "The library clerk's screen shows roll number and name only, never fees." | |
| 4 | "Every enrollment row is linked to one student and one subject." | |
| 5 | "The student portal shows a student only their own marks." | |
| 6 | "Each row of STUDENTS takes about 200 bytes on disk." | |
| 7 | "The DBA moved the database to a faster disk last night; nobody noticed." | |
| 8 | "The exam cell's report shows roll number, subject and marks for one semester." | |

---

## Block 6 — 10 exam-style MCQs

1. A database is best described as:
   A. A program that manages files  B. An organized collection of related data  C. A spreadsheet with many sheets  D. A storage device

2. Which component of a database system includes the DBMS and the operating system?
   A. Hardware  B. Software  C. Procedures  D. Data

3. "Data about data" — the description of the columns and their types — is called:
   A. Big data  B. Metadata  C. Backup data  D. User data

4. Which database model arranges data as a tree in which each child has exactly one parent?
   A. Relational  B. Network  C. Hierarchical  D. Object-oriented

5. Which database model links tables using matching values instead of pointers?
   A. Hierarchical  B. Network  C. Relational  D. Flat file

6. Which statement about a relational database is NOT true?
   A. Each cell holds only one value  B. The order of the rows matters when searching  C. No two rows are the same  D. Tables are linked by common values

7. Which model came first?
   A. Relational  B. Object-oriented  C. Hierarchical  D. Object-relational

8. The part of the database that one group of users sees is defined at which level?
   A. Physical  B. Conceptual  C. External  D. Internal

9. In storage terms, one row of a table is also called a:
   A. Bit  B. Byte  C. Field  D. Record

10. Moving the data to a new disk without changing any application is possible because of:
    A. Repeated data  B. The separation between the internal level and the levels above it  C. The flat file model  D. Pointers between records

---

## Homework (bring to Day 2)

1. In 5 lines, in your own words: the difference between a *database*, a *DBMS* and a *database system*. Name one DBMS product.
2. Write the 6 problems of keeping data in separate files, and one line each on how a database solves it.
3. Redraw exercise 5.2 with one change: subject CS201 is now taught in both CSE and ECE. Show how the tree and the tables each handle it, and write two lines on which one repeats data.
4. Look at any one paper form the college uses (admission form, fee receipt, library card). Write down every box on it. Bring the list — on Day 2 we turn boxes into columns.

---

## One-slide summary

- **Data** = raw facts; **information** = data with meaning.
- **Database** = organized related data; **DBMS** = the software (Oracle); **database system** = hardware + software + data + procedures + people.
- Purpose of a database: no repeated data, data always matches, many users at once, security, fast search, safe from loss, trusted reports.
- Five models: **flat file** (one table) → **hierarchical** (tree, one parent) → **network** (pointers, many parents) → **relational** (tables linked by matching values, Codd 1970, SQL) → **object-oriented** (objects and classes).
- A relational database: tables; unique rows via the primary key; one value per cell; one kind of value per column; order does not matter; linked by values; SQL; rules enforced by the software.
- Storage words: bit → byte → field → record → file/table → database.
- Three levels: **external / view** (what one user sees) → **conceptual / logical** (all the tables) → **internal / physical** (disk). Change one level without breaking the level above = data independence.

## Simple glossary

| Word | Meaning in one line |
|---|---|
| Data | Raw facts with no meaning on their own |
| Information | Data arranged so that it means something |
| Database | An organized collection of related data kept in one place |
| DBMS | The software that manages a database (Oracle Database, MySQL…) |
| Database system | Data + DBMS + hardware + procedures + people |
| Metadata | Data about data: the description of the tables and columns |
| Database model | The shape in which a database keeps its data (flat, hierarchical, network, relational, object-oriented) |
| Pointer | A stored link that says where the next record is (used by hierarchical and network models) |
| Table | A grid of rows and columns about one kind of thing |
| Row / record | One item in a table |
| Column / field | One property; one cell of a row |
| Primary key | The column that makes every row different |
| Foreign key | A column whose values match the primary key of another table |
| SQL | The language used to define and ask questions of a relational database |
| External (view) level | The part of the data one group of users sees |
| Conceptual (logical) level | All the tables, columns, keys and rules |
| Internal (physical) level | How and where the data is stored on disk |
| Data independence | Change one level without breaking the level above |
