# Day 02 — Collecting Requirements, Tables, and Keys

**Exam syllabus points covered today (1Z0-006)**
- Collecting requirements for a database; what a business rule is
- Parts of a single table
- What a conceptual data model is, and its parts (entity, attribute, relationship)
- Schema vs instance; entity ↔ table, attribute ↔ column
- Unique identifiers and primary keys; composite and compound primary keys
- Relationships and foreign keys; barred relationships and their primary keys

**By the end of today, a student can:**
1. Explain how requirements are collected and give 5 business rules for the College.
2. Describe the parts of a table and the rules a table must follow.
3. Say what a conceptual model is and name its 3 parts.
4. Tell the difference between schema (design) and instance (data).
5. Pick a primary key; explain simple, composite and compound keys.
6. Explain what a foreign key is and what a barred relationship is.
7. Create two linked tables in Live SQL and show what happens when the rules are broken.

---

## Today's topics

**1. Collecting requirements and business rules**
- 1.1 Where does a database design begin?
- 1.2 Where do requirements come from?
- 1.3 What do we write down at the end?
- 1.4 Business rules
- 1.5 Two kinds of business rules

**2. Parts of a table; the conceptual model**
- 2.1 Parts of a table
- 2.2 What is a conceptual data model?
- 2.3 How we draw the diagram (the notation used by Oracle and in the exam)
- 2.4 Conceptual model vs the real tables

**3. Schema vs instance; entity → table**
- 3.1 Schema vs instance
- 3.2 From drawing to table
- 3.3 See it in Live SQL

**4. Primary keys, foreign keys, barred relationships**
- 4.1 Unique identifier (in the drawing) → primary key (in the table)
- 4.2 Simple, composite and compound primary keys
- 4.3 Relationships become foreign keys
- 4.4 Barred relationships

**5. Practice**
- 5.1 Live SQL: parent table, child table, and breaking the rules on purpose
- 5.2 Composite and compound keys
- 5.3 Paper exercise — the College Library

---
## Time plan

| Time | Block | What we do |
|---|---|---|
| 0:00 – 0:10 | 0 | Quick recap of Day 1, homework check |
| 0:10 – 0:45 | 1 | Collecting requirements and business rules |
| 0:45 – 1:25 | 2 | Parts of a table; the conceptual model (entity, attribute, relationship) |
| 1:25 – 1:35 | — | Break |
| 1:35 – 2:00 | 3 | Schema vs instance; entity → table, attribute → column |
| 2:00 – 2:35 | 4 | Primary keys, foreign keys, barred relationships |
| 2:35 – 2:55 | 5 | Practice: Live SQL + paper exercise (College Library) |
| 2:55 – 3:00 | 6 | 10 quick MCQs, homework |

---

## Block 0 — Recap (10 min)

Ask quickly (do not lecture):
1. Database vs DBMS?  2. Who invented the relational model, and when?  3. Which types use pointers?  4. The three levels, top to bottom?  5. Smallest to biggest: bit, record, field, byte, table — put in order.

Homework check: two or three students run their `Day01_homework` (`branches` table). We use it again in Block 5.

---

## Block 1 — Collecting requirements and business rules (35 min)

### 1.1 Where does a database design begin?

**In simple words:**
> "It does **not** begin with tables. It begins with **people and their problems**. Before we draw anything, we must find out what the college actually needs to store."

```
  Talk to people  →  Write requirements  →  Write business rules  →  Draw the diagram (ERD)
                                                                            │
                                   Create tables in SQL  ←  Table design  ◄─┘
```
Today: the first three steps. Days 3–7: the rest.

### 1.2 Where do requirements come from?

| Source | How | College example |
|---|---|---|
| **People who will use it** | Talk to them (interview, meeting) | Registrar, a teacher, a student, the librarian |
| **Existing paper forms and reports** | Read them; every box on a form is a possible column | Admission form, mark sheet, library card, fee receipt |
| **Existing files / software** | Look at what is already used | The 4 Excel sheets from Day 1's story |
| **Watching the work** | Sit and observe | One hour at the library counter |
| **Questionnaires** | For big groups | Ask 200 students what the portal should show |

### 1.3 What do we write down at the end?
1. **Scope** — what the system covers and what it does not. (College system covers academics and library; salary is out.)
2. **Business rules** — the most important output (next section).
3. **Word list** — agreed meaning of each word. Does "course" mean B.Tech CSE or "Data Structures"? Two departments using one word for two things causes half of all design mistakes.
4. **The diagram (ERD)** — drawn from the rules (Block 2 onward).

### 1.4 Business rules

**Simple definition:**
> A business rule is a **plain-English sentence** that says **what the business must store** or **what it must not allow**.

A good business rule is short, specific, and can be checked as true or false.

**College business rules (put these on the board):**

| # | Business rule | What it tells the designer |
|---|---|---|
| R1 | Every student belongs to exactly one branch. | Link between STUDENT and BRANCH; every student **must** have a branch |
| R2 | A branch can have many students. | One branch → many students |
| R3 | Every student has a unique roll number. | Roll number is the unique identifier (becomes the primary key) |
| R4 | A subject belongs to one department. | Link between SUBJECT and DEPARTMENT |
| R5 | A student can take many subjects, and a subject has many students. | Many-to-many (we fix this on Day 5) |
| R6 | A student cannot take more than 6 subjects in a semester. | Needs extra programming, not just a table |
| R7 | A library member can borrow at most 3 books at a time. | Needs extra programming |
| R8 | Every copy of a book has a unique accession number. | Unique identifier → primary key |
| R9 | Phone number is optional; email is compulsory. | Which columns may be empty (NULL) |
| R10 | Marks must be between 0 and 100. | A value rule (CHECK) |

### 1.5 Two kinds of business rules (short intro — full detail on Day 3)

| Kind | Talks about | Where it is enforced | Examples above |
|---|---|---|---|
| **Structural** | *What* data exists and *how it is linked* | In the table design (keys, NOT NULL) | R1, R2, R3, R4, R5, R8, R9 |
| **Procedural** | *Steps*, *limits*, *conditions* | By extra programming (application code, triggers) | R6, R7, "fee must be paid before enrollment" |

> ✏️ **Activity 1 (8 min, groups of 3) — Interview the librarian.**

---

## Block 2 — Parts of a table; the conceptual model (40 min)

### 2.1 Parts of a table

```
 Table name:  STUDENTS
              ┌──────────┬────────────┬─────────────┬──────────────┐
 Columns ───► │ ROLL_NO  │ NAME       │ BRANCH_CODE │ PHONE        │
 Type    ───► │ number   │ text       │ text        │ text         │
              ├──────────┼────────────┼─────────────┼──────────────┤
 Row 1   ───► │ 101      │ Ravi       │ CSE         │ 9800000001   │
 Row 2   ───► │ 102      │ Priya      │ CSE         │ (empty=NULL) │
 Row 3   ───► │ 103      │ Arjun      │ ECE         │ 9600000003   │
              └──────────┴────────────┴─────────────┴──────────────┘
                   ▲                         ▲
              primary key              one cell = one value
```

**Rules a table must follow (exam):**
1. The table has a **name**. Each column has a **different name** and **one type** (number, text, date).
2. **No two rows are the same** — the primary key makes sure of this.
3. One cell = **one value**. If a value is missing, it is **NULL** (empty / unknown).
4. Rows and columns have **no fixed order**.
5. Columns = **properties** (attributes). Rows = **individual items** (instances).

**The only data types we need this week** (full list on Day 7):

| Type | Used for | Example |
|---|---|---|
| `NUMBER(6)` | Numbers up to 6 digits | roll number |
| `NUMBER(8,2)` | Numbers with 2 decimal places | fees 45000.50 |
| `VARCHAR2(50)` | Text up to 50 characters | name |
| `DATE` | A date | date of birth |

### 2.2 What is a conceptual data model?

**Simple definition:**
> A conceptual data model is a **drawing** of the *things* the business needs to keep information about, the *facts* about each thing, and *how the things are connected*. It is drawn **before** choosing any software.

This drawing is called an **Entity Relationship Diagram (ERD)**.

**The 3 parts (the exam asks exactly this):**

| Part | Simple meaning | College examples |
|---|---|---|
| **Entity** | A *thing* we need to store information about. Written as a **singular noun in CAPITALS**. | STUDENT, BRANCH, SUBJECT, TEACHER, BOOK |
| **Attribute** | A *fact* about an entity. One value per item. | STUDENT: roll number, name, email, phone, date of birth |
| **Relationship** | A *named link* between two entities. | STUDENT *belongs to* BRANCH; TEACHER *teaches* SUBJECT |

> **In simple words — the "is it an entity?" test:**
> Ask three questions. (1) Is it a noun? (2) Do we need to store **more than one fact** about it? (3) Can there be **many** of them?
> STUDENT passes all three. "Student's name" fails question 2 — it is an attribute. "College" fails question 3 if there is only one college — so it is not an entity in our system.

### 2.3 How we draw the diagram (the notation used by Oracle and in the exam)

```
      ┌──────────────────┐                          ┌──────────────────┐
      │ STUDENT          │                          │ BRANCH           │
      │ # roll number    │  belongs to         has  │ # branch code    │
      │ * name           ├──────────────────────────┤ * branch name    │
      │ * email          │ ──────────────  - - - -  │ o head of branch │
      │ o phone          │       ▲             ▲    │                  │
      └──────────────────┘       │             │    └──────────────────┘
                            crow's foot     single line
                            = "many"        = "one"
```

| Symbol | Meaning |
|---|---|
| Box with rounded corners, name in CAPITALS, singular | Entity |
| `#` in front of an attribute | This attribute **identifies** the item (unique identifier, UID) |
| `*` in front of an attribute | **Must** have a value (mandatory) |
| `o` in front of an attribute | **May** be empty (optional) |
| Solid half of the line | **must** |
| Dashed half of the line | **may** |
| Crow's foot (three toes) | **many** |
| Plain line end | **one** |
| Words near each end | The relationship name, read in both directions |

**Reading the diagram in English (we practice this a lot on Day 4):**
- "Each **STUDENT** *must* **belong to** *one and only one* **BRANCH**."
- "Each **BRANCH** *may* **have** *one or more* **STUDENTs**."

### 2.4 Conceptual model vs the real tables

| | Conceptual model (the drawing) | Physical model (the real tables) |
|---|---|---|
| Purpose | Agree with the users on **what** to store | Decide **how** to build it in Oracle |
| Who reads it | Users, managers, designers | Developers, DBA |
| Contains | Entities, attributes, relationships | Tables, columns, data types, keys |
| Software | None — independent | Oracle-specific |
| Names | STUDENT, "roll number" | STUDENTS, ROLL_NO NUMBER(6) |

> 📌 Books sometimes say "conceptual model" and sometimes "logical model" for the same drawing. For this exam: **drawing = conceptual/logical, tables = physical.** We convert one to the other on Day 7.

---

## Break (10 min)

---

## Block 3 — Schema vs instance; entity → table (25 min)

### 3.1 Schema vs instance

| | **Schema** | **Instance** |
|---|---|---|
| Simple meaning | The **design**: which tables, which columns, which types, which rules | The **actual data** inside, right now |
| How often it changes | Rarely (only when the design changes) | All the time (every insert, update, delete) |
| Like… | The **blank form** | The **filled-in form** |
| College | STUDENTS has ROLL_NO (number), NAME (text), … | The rows: Ravi, Priya, Arjun |

**One more meaning of "schema" in Oracle:** all the tables and other objects **owned by one user**. The `HR` schema in Live SQL = everything owned by the user called HR. Both meanings can appear in the exam — read the question.

### 3.2 From drawing to table — learn this mapping by heart

| In the drawing (ERD) | In the database | College example |
|---|---|---|
| **Entity** | **Table** | STUDENT → `STUDENTS` |
| **Attribute** | **Column** | "roll number" → `ROLL_NO` |
| **One item** (instance) | **Row** | Ravi → the row (101, Ravi, CSE, …) |
| **Unique identifier** (`#`) | **Primary key** | # roll number → `ROLL_NO PRIMARY KEY` |
| **Relationship** | **Foreign key column** | belongs to → `BRANCH_CODE` in STUDENTS |
| Mandatory attribute (`*`) | `NOT NULL` column | name → `NAME NOT NULL` |
| Optional attribute (`o`) | Column that allows NULL | phone |

**Worked example**

```
 Drawing                               Table
 ┌──────────────────┐                  BRANCHES
 │ BRANCH           │                  CODE  | NAME                    | HEAD_NAME
 │ # branch code    │     ──────►      ------+-------------------------+----------
 │ * branch name    │                  CSE   | Computer Science        | Dr. Rao
 │ o head of branch │                  ECE   | Electronics             | Dr. Iyer
 └──────────────────┘                  MECH  | Mechanical              | (NULL)

 1 entity, 3 attributes                1 table, 3 columns
 3 items (CSE, ECE, MECH)              3 rows
```

Naming habit we follow: entity **singular** (STUDENT) → table **plural** (STUDENTS); attribute in words ("date of birth") → column in CAPITALS with underscores (`DATE_OF_BIRTH`); a foreign key column gets the **same name** as the primary key it points to (`BRANCH_CODE` in both tables).

### 3.3 See it in Live SQL (2 minutes)
```sql
-- INSTANCE: the data right now
SELECT * FROM students;

-- Change the instance (design stays the same)
INSERT INTO students VALUES (104, 'Meena', 'ECE', NULL);
SELECT * FROM students;

-- Change the SCHEMA (design): add a column. Old rows get NULL in it.
ALTER TABLE students ADD email VARCHAR2(80);
SELECT * FROM students;
```
Open the **Schema** tab on the left and click `STUDENTS` — that page **is** the schema. The result grid **is** the instance.

---

## Block 4 — Primary keys, foreign keys, barred relationships (35 min)

### 4.1 Unique identifier (in the drawing) → primary key (in the table)

**Unique identifier (UID):** the attribute (or group of attributes) whose value is **different for every item**, so we can point to exactly one item.

**Primary key (PK):** the column(s) in the table that do this job. Oracle makes sure a primary key is **never duplicated** and **never empty**.

| Entity | Could be the identifier | We choose | Why |
|---|---|---|---|
| STUDENT | roll number, email, Aadhaar | **roll number** | Short, never changes, known on day one |
| BRANCH | branch code, branch name | **branch code** | Names get renamed; codes stay |
| BOOK COPY | accession number | **accession number** | Given by the library, unique per copy |
| SUBJECT | subject code | **subject code** | e.g. CS201 |

**How to pick a good primary key:**
1. **Unique** for every item, forever.
2. **Never empty** — every item has it from the start.
3. **Never changes** — if it changes, every link to it breaks.
4. **Short and simple** — a number or code, not a long name.

### 4.2 Simple, composite and compound primary keys

| Kind | Meaning | Example |
|---|---|---|
| **Simple** | One column | `STUDENTS (ROLL_NO)` |
| **Composite** | **Two or more columns together** identify a row | `TIMETABLE (ROOM, DAY, PERIOD)` — same room and day is fine, but not the same period twice. `FLIGHTS (FLIGHT_NO, FLIGHT_DATE)` — the same flight number flies every day |
| **Compound** | A composite key where **every column is a foreign key** (the row is identified only by the things it links) | `ENROLLMENTS (ROLL_NO, SUBJECT_CODE)` — "this student in this subject" |

> 📌 Some books use "composite" and "compound" as the same thing. Teach it like this: **composite = more than one column; compound = more than one column and all of them come from other tables.** If the exam offers both, choose *composite* for "more than one column" and *compound* when the columns are foreign keys.

Composite key in a picture:
```
 TIMETABLE
 ROOM | DAY | PERIOD | SUBJECT
 -----+-----+--------+--------
 LH1  | MON | 1      | CS201
 LH1  | MON | 2      | CS202     ← same room + day, different period → OK
 LH1  | MON | 1      | CS203     ✗ (LH1, MON, 1) already exists → not allowed
```

### 4.3 Relationships become foreign keys

**Simple definition:**
> A **foreign key (FK)** is a column in one table whose values **must match** the primary key of another table (or be empty). It is how a relationship is built in real tables.

**Rule of thumb:** the foreign key goes on the **"many" side**.

```
 BRANCHES  (parent, the "one" side)      STUDENTS  (child, the "many" side)
 CODE | NAME                             ROLL_NO | NAME  | BRANCH_CODE
 -----+-----------                       --------+-------+------------
 CSE  | Comp Sci  ◄──────────┐           101     | Ravi  | CSE ──┐
 ECE  | Electron. ◄──────┐   └───────────102     | Priya | CSE ──┘
                         └──────────────103     | Arjun | ECE
                                         104     | Meena | XYZ   ✗ no such branch → refused
```

**What Oracle refuses (this is called referential integrity):**

| You try to… | Allowed? | What Oracle says |
|---|---|---|
| Add a student with branch 'XYZ' that does not exist | ✗ | `ORA-02291 … parent key not found` |
| Add a student with no branch (only if the rule says branch is optional) | ✓ | — |
| Delete branch 'CSE' while students still belong to it | ✗ | `ORA-02292 … child record found` |
| Delete branch 'MECH' that has no students | ✓ | — |

**"Must" or "may" decides NULL:**
- "Each STUDENT **must** belong to a BRANCH" → `BRANCH_CODE NOT NULL`
- "Each EMPLOYEE **may** have a MANAGER" → `MANAGER_ID` can be empty (the boss has no manager)

*(Preview of Day 5: in `hr.employees`, the column MANAGER_ID points to EMPLOYEE_ID in the **same** table — a manager is also an employee.)*

### 4.4 Barred relationships

**Simple definition:**
> A **barred relationship** is one where the child **cannot be identified without its parent**, so the **foreign key becomes part of the child's primary key**. On the diagram we draw a short **bar** across the line at the child end.

**In simple words:** "Order line number 2 — of which order? The line number alone means nothing. You need the order number too. So the primary key of ORDER LINE is (order number + line number)."

```
 ┌──────────────────┐                    ┌──────────────────┐
 │ ORDER            │                    │ ORDER LINE       │
 │ # order number   │    made up of      │ # line number    │
 │ * order date     ├─────────────────┼──┤ * quantity       │
 └──────────────────┘              bar ▲  └──────────────────┘
                                        │
             primary key of ORDER LINE = order number (from the parent) + line number
```

| Child | Barred to | Child's primary key | Kind |
|---|---|---|---|
| ORDER LINE | ORDER | (ORDER_NO, LINE_NO) | Composite |
| BOOK COPY (numbered per book) | BOOK | (ISBN, COPY_NO) | Composite |
| BANK ACCOUNT (numbered within a branch) | BRANCH | (BRANCH_CODE, ACCOUNT_NO) | Composite |
| ENROLLMENT | STUDENT **and** SUBJECT | (ROLL_NO, SUBJECT_CODE) | Compound (both are foreign keys) |

**Not barred vs barred — same pair, two choices:**

| Pair | Not barred | Barred |
|---|---|---|
| STUDENT – BRANCH | STUDENTS (ROLL_NO as PK, BRANCH_CODE as FK). A student is identified by roll number alone. | Not suitable — a student does not need the branch to be identified |
| ORDER – ORDER LINE | ORDER_LINES (LINE_ID as PK, ORDER_NO as FK) — possible, using a made-up id | ORDER_LINES (ORDER_NO, LINE_NO) as PK — natural, line numbers restart for each order |

> 📌 **Exam-style:** "In a barred relationship, the primary key of the child…" → **includes the foreign key from the parent.** "Which gives a compound primary key?" → the middle entity between two barred relationships (ENROLLMENT).

---

## Block 5 — Practice (20 min)

### 5.1 Live SQL: parent table, child table, and breaking the rules on purpose

```sql
-- Start clean (ignore errors if the tables do not exist yet)
DROP TABLE students;
DROP TABLE branches;

-- PARENT: BRANCH entity → BRANCHES table
CREATE TABLE branches (
    code       VARCHAR2(10) PRIMARY KEY,      -- unique identifier → simple primary key
    name       VARCHAR2(60) NOT NULL,         -- mandatory attribute
    head_name  VARCHAR2(50)                   -- optional attribute
);

-- CHILD: STUDENT entity → STUDENTS table; the relationship → foreign key
CREATE TABLE students (
    roll_no      NUMBER(6)     PRIMARY KEY,
    name         VARCHAR2(50)  NOT NULL,
    email        VARCHAR2(80)  NOT NULL,
    phone        VARCHAR2(15),
    branch_code  VARCHAR2(10)  NOT NULL,      -- "must belong to" → NOT NULL
    CONSTRAINT fk_students_branch
        FOREIGN KEY (branch_code) REFERENCES branches (code)
);

INSERT INTO branches VALUES ('CSE',  'Computer Science',  'Dr. Rao');
INSERT INTO branches VALUES ('ECE',  'Electronics',       'Dr. Iyer');
INSERT INTO branches VALUES ('MECH', 'Mechanical',        NULL);

INSERT INTO students VALUES (101, 'Ravi',  'ravi@college.edu',  '9800000001', 'CSE');
INSERT INTO students VALUES (102, 'Priya', 'priya@college.edu', NULL,         'CSE');
INSERT INTO students VALUES (103, 'Arjun', 'arjun@college.edu', '9600000003', 'ECE');

SELECT * FROM branches;
SELECT * FROM students;
```

Now **break each rule** and read the error message together:

```sql
-- 1. Same primary key twice
INSERT INTO students VALUES (101, 'Copy', 'copy@college.edu', NULL, 'CSE');
-- ORA-00001: unique constraint violated  → "roll number must be unique"

-- 2. Empty primary key
INSERT INTO students VALUES (NULL, 'NoRoll', 'x@college.edu', NULL, 'CSE');
-- ORA-01400: cannot insert NULL  → "roll number can never be empty"

-- 3. Foreign key points to a branch that does not exist
INSERT INTO students VALUES (104, 'Meena', 'meena@college.edu', NULL, 'XYZ');
-- ORA-02291: parent key not found  → "no branch called XYZ"

-- 4. Delete a parent that still has children
DELETE FROM branches WHERE code = 'CSE';
-- ORA-02292: child record found  → "students still belong to CSE"

-- 5. This one works: the parent has no children
DELETE FROM branches WHERE code = 'MECH';
SELECT * FROM branches;
```

> **In simple words:** "You did not write any checking code. Oracle checked everything because you told it the keys. That is why we spend so much time on keys."

### 5.2 Composite and compound keys (type along)
```sql
-- Composite primary key: room + day + period
CREATE TABLE timetable (
    room      VARCHAR2(10),
    day_name  VARCHAR2(3),
    period_no NUMBER(2),
    subject   VARCHAR2(10) NOT NULL,
    CONSTRAINT pk_timetable PRIMARY KEY (room, day_name, period_no)
);
INSERT INTO timetable VALUES ('LH1', 'MON', 1, 'CS201');
INSERT INTO timetable VALUES ('LH1', 'MON', 2, 'CS202');   -- OK
INSERT INTO timetable VALUES ('LH1', 'MON', 1, 'CS203');   -- ORA-00001: already used

-- Compound primary key: both columns are foreign keys (full topic on Day 5)
CREATE TABLE subjects (
    code   VARCHAR2(10) PRIMARY KEY,
    title  VARCHAR2(60) NOT NULL
);
INSERT INTO subjects VALUES ('CS201', 'Database Systems');
INSERT INTO subjects VALUES ('CS202', 'Operating Systems');

CREATE TABLE enrollments (
    roll_no       NUMBER(6)    REFERENCES students (roll_no),
    subject_code  VARCHAR2(10) REFERENCES subjects (code),
    marks         NUMBER(3),
    CONSTRAINT pk_enrollments PRIMARY KEY (roll_no, subject_code)
);
INSERT INTO enrollments VALUES (101, 'CS201', 88);
INSERT INTO enrollments VALUES (101, 'CS202', 79);
INSERT INTO enrollments VALUES (102, 'CS201', 91);
INSERT INTO enrollments VALUES (101, 'CS201', 70);   -- ORA-00001: Ravi is already in CS201
INSERT INTO enrollments VALUES (999, 'CS201', 70);   -- ORA-02291: no student 999

SELECT * FROM enrollments;
```
Save as `Day02`.

### 5.3 Paper exercise — the College Library (10 min, then solve on the board)

**Story:** The library keeps **books** (ISBN, title, author, publisher). A book can have several physical **copies**, each with an accession number and a status (available / issued / lost). **Members** are students or teachers, with a member id, name and type. When a member borrows a copy, a **loan** is recorded with issue date, due date and return date.

**Do this:**
1. List the entities.
2. For each entity, list the attributes and mark `#` (identifier), `*` (must), `o` (may).
3. Write the relationships as English sentences.
4. Which relationship is barred? What is the child's primary key then?
5. Which primary key is composite? Is any compound?

---

## Block 6 — 10 exam-style MCQs

1. Which is the best place to find attributes when collecting requirements?
   A. The DBMS manual
   B. Existing forms and reports
   C. The server specification
   D. The SQL standard

2. "Every student must belong to exactly one branch" is a:
   A. Procedural business rule
   B. Structural business rule
   C. Data type
   D. Storage rule

3. Which rule would need extra programming rather than a simple table rule?
   A. Roll number must be unique
   B. Branch name is compulsory
   C. A student may not take more than 6 subjects per semester
   D. Marks must be a number

4. In a table, one cell holds:
   A. Exactly one value or NULL
   B. A list of values
   C. Another table
   D. A pointer to a parent record

5. The three parts of a conceptual data model are:
   A. Tables, rows, columns
   B. Entities, attributes, relationships
   C. Files, records, fields
   D. Schema, instance, view

6. In an ER diagram, an entity name should be a:
   A. Plural noun in lower case
   B. Singular noun in capital letters
   C. Verb
   D. Adjective

7. The actual data in the database at one moment is called the:
   A. Schema  B. Instance  C. Model  D. Dictionary

8. An entity in the drawing becomes a ______ in the database.
   A. Column  B. Row  C. Table  D. Constraint

9. A primary key made of two columns that are both foreign keys is called a:
   A. Simple key  B. Compound key  C. Candidate key  D. Surrogate key

10. In a barred relationship, the primary key of the child entity:
    A. Is always a single made-up column
    B. Includes the foreign key from the parent
    C. Cannot contain a foreign key
    D. Must be the same as the parent's primary key

---

## Homework (bring to Day 3)

1. **Requirements:** Interview one person (a friend who runs a club, a shopkeeper, a hostel warden). Write the scope in 2 lines and **8 business rules**. Mark each S (structural) or P (procedural).
2. **Drawing:** Draw the College Library diagram (Block 5.3) with `#`, `*`, `o`, crow's feet and the bar. Take a photo and bring it.
3. **SQL:** In Live SQL, extend `Day02`: add a `teachers` table (teacher_id as primary key, name NOT NULL, dept) and a `teaches` table with a **compound** primary key (teacher_id, subject_code). Add 3 rows, then try a duplicate to prove the key works.
4. **Think:** Write 4 lines: why is *email* a bad primary key for STUDENT even though it is unique?

---

## One-slide summary

- Design starts by **talking to people** and reading **forms**. The result is a list of **business rules**: *structural* (what data, how linked → tables and keys) and *procedural* (steps and limits → extra programming).
- A **table** has a name, columns with one type each, unique rows (primary key), one value per cell, and no fixed order.
- **Conceptual model** = the drawing (ERD) = **entities** (singular nouns), **attributes** (`#` identifier, `*` must, `o` may), **relationships** (named links).
- **Schema** = the design (rarely changes). **Instance** = the data right now (changes always).
- Entity → table, attribute → column, item → row, identifier → primary key, relationship → foreign key, `*` → NOT NULL.
- Keys: **simple** (one column), **composite** (several columns), **compound** (several columns, all foreign keys).
- The **foreign key** sits on the "many" side. Oracle refuses a child without a parent (ORA-02291) and refuses deleting a parent that has children (ORA-02292).
- **Barred relationship**: the foreign key is part of the child's primary key, because the child cannot be identified without the parent (ORDER LINE, ENROLLMENT).

## Simple glossary

| Word | Meaning in one line |
|---|---|
| Business rule | A plain sentence about what must be stored or what is not allowed |
| Structural rule | About data and links; built into the tables |
| Procedural rule | About steps and limits; needs programming |
| Conceptual data model | The drawing of entities, attributes and relationships |
| ERD | Entity Relationship Diagram — the drawing itself |
| Entity | A thing we store information about |
| Attribute | A fact about an entity |
| Relationship | A named link between two entities |
| Schema | The design of the database (also: one user's set of tables in Oracle) |
| Instance | The data at one moment |
| Unique identifier (UID) | The attribute(s) that identify one item in the drawing |
| Primary key | The column(s) that identify one row in the table; never duplicate, never empty |
| Composite key | A primary key with more than one column |
| Compound key | A composite key whose columns are all foreign keys |
| Foreign key | A column that must match a primary key in another table |
| Barred relationship | The foreign key is part of the child's primary key |
