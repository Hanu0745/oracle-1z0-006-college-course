# Day 02 — Requirements, Business Rules, and the Parts of a Table

**Exam syllabus points covered today (1Z0-006 → "What is a Database?", "The Language of Database and Data Modeling", "Data Modeling — Creating the Physical Model")**
- Gathering Requirements for Database Design: gather requirements to implement a database solution; explain business rules
- Documenting Business Requirements and Rules: why clearly communicating and accurately capturing requirements matters; identify structural business rules; identify procedural business rules; identify rules that must be enforced by additional programming
- Defining a Table in a Database: describe the structure of a single table
- Using Conceptual Data Modeling: describe a conceptual data model; explain the components of a conceptual/logical model
- Defining Instance and Schema: examples of an entity and the corresponding table; examples of an attribute and the corresponding column; explain instances and schemas

**By the end of today, a student can:**
1. Say where requirements come from and why capturing them accurately matters.
2. Read the College requirements text and pick out the things, the facts and the rules in it.
3. Tell a structural rule from a procedural rule, and spot a rule that needs extra programming.
4. Name the parts of a table: table, row, column, cell, primary key, foreign key.
5. Tell the difference between a schema (the design) and an instance (the data at one moment).
6. Name the three components of a conceptual model and match each to its table word.
7. Draw STUDENT and BRANCH as soft boxes with `#`, `*` and `o` marks.

---

## Today's topics

**0. Recap**
- 5 quick questions from Day 1; homework check

**1. Gathering requirements**
- 1.1 Design does not start with tables
- 1.2 Why capturing requirements accurately matters
- 1.3 Where requirements come from
- 1.4 The College requirements text (what the office says it wants)
- 1.5 What we write down at the end

**2. Business rules**
- 2.1 What a business rule is
- 2.2 Structural rules
- 2.3 Procedural rules
- 2.4 Rules that need extra programming
- 2.5 Twelve College rules, classified

**3. The parts of a table**
- 3.1 Table, row, column, cell
- 3.2 Primary key and foreign key
- 3.3 STUDENT and BRANCH as two filled tables
- 3.4 Schema vs instance

**4. The conceptual model**
- 4.1 Entity, attribute, relationship, instance
- 4.2 Entity → table, attribute → column, instance → row
- 4.3 First look at the ERD notation: soft box, #, *, o
- 4.4 Conceptual/logical vs physical, in one line

**5. Practice (paper)**
- 5.1 Nouns in the requirements text → entities and attributes
- 5.2 Twelve rules from the text, classified
- 5.3 Draw STUDENT and BRANCH as tables with 3 rows; mark PK and FK

**6. 10 exam-style MCQs**

---
## Time plan

| Time | Block | What we do |
|---|---|---|
| 0:00 – 0:10 | 0 | Recap: 5 quick questions from last class; homework check |
| 0:10 – 0:50 | 1 | Gathering requirements; read the College requirements text together |
| 0:50 – 1:25 | 2 | Business rules: structural, procedural, needs programming; classify 12 rules |
| 1:25 – 1:35 | — | Break |
| 1:35 – 2:05 | 3 | Parts of a table; primary and foreign key; schema vs instance |
| 2:05 – 2:25 | 4 | The conceptual model; first look at the ERD notation |
| 2:25 – 2:45 | 5 | Practice on paper |
| 2:45 – 2:55 | 6 | 10 exam-style MCQs |
| 2:55 – 3:00 | 6 | Key points, homework |

---

## Block 0 — Recap (10 min)

Ask quickly, one-line answers:
1. Database vs DBMS? (Data itself vs the software that manages it.)
2. Name the 5 components of a database system. (Hardware, software, data, procedures, people.)
3. Which two models link records with pointers? (Hierarchical and network.)
4. In a relational database, how are tables linked? (By matching values.)
5. The three levels, top to bottom? (External/view, conceptual/logical, internal/physical.)

Homework check: two or three students read out the boxes they found on a college form (homework 4). Keep the lists — we use them in Block 1.3.

---

## Block 1 — Gathering requirements (40 min)

### 1.1 Design does not start with tables

> **In simple words:** "It does **not** begin with tables. It begins with **people and their problems**. Before we draw a single box, we must find out what the college actually needs to keep, and what rules it follows. If we get this step wrong, everything built on top of it is wrong too."

```
  Talk to people  →  Write the requirements  →  Write the business rules  →  Draw the diagram
  (Day 2)            (Day 2)                    (Day 2)                       (Days 3–6)
                                                                                  │
                                       Tables in Oracle (Days 9–10)  ←  Table design (Day 7)  ◄─┘
```

### 1.2 Why capturing requirements accurately matters

| If we get it wrong | What happens later |
|---|---|
| We forget that a student pays fees in **parts** | The system can store only one payment; the office goes back to paper |
| We assume every teacher belongs to a branch | The sports teacher cannot be entered at all |
| Two offices use the word "course" for two different things | Half the data goes into the wrong place |

Fixing a mistake **on paper** costs ten minutes. Fixing it **after the tables are built and full of data** costs weeks. So we read, we ask, we write it down, and we get the office to **agree in writing** before we draw.

### 1.3 Where requirements come from

| Source | How | College example |
|---|---|---|
| **Interviews** with the people who will use it | Sit with them, ask questions, listen for nouns and rules | The registrar, a teacher, a student, the librarian, the accounts clerk |
| **Existing forms and registers** | Read them; every box on a form is a possible column | Admission form, mark sheet, fee receipt, library register |
| **Documents** | Rule books, notices, reports the college already produces | The exam rules ("no fees, no hall ticket"), the library rules |
| **Observing the work** | Sit and watch for an hour | One hour at the library counter shows you the issue-and-return steps |
| **Questionnaires** | For large groups, a short written set of questions | Ask 200 students what the portal should show them |

### 1.4 The College requirements text (what the office says it wants)

**The College office says:**

1. We have four branches: CSE, ECE, MECH and CIVIL. Each branch has a short code, a full name and, usually, a head of branch — but a new branch may have no head yet.
2. Every student is admitted into exactly one branch and has a roll number that never changes. We also record the student's name, email, phone, date of birth and admission date. Name, email and admission date are compulsory; phone and date of birth may be left out. No two students may share an email.
3. Every teacher has a teacher id given by the office, a name, and possibly an email and a joining date. A teacher normally belongs to one branch, but a visiting teacher may belong to none.
4. Most teachers report to a head, and the head is also a teacher. The most senior teachers report to nobody.
5. Every subject has a code, a title and a credit value between 1 and 5. A subject is usually offered by one branch, but a few subjects such as HS101 Communication Skills are common to all branches and belong to no branch.
6. Each semester a student takes several subjects, and each subject is taken by many students. For each student in each subject we record the semester, and later the marks (0 to 100) and a grade. Marks and grade are empty until the exam is over.
7. A teacher can teach several subjects, and a subject can be taught by more than one teacher.
8. Students pay fees in parts. Every payment gets a payment id, and we record the amount, the date paid and the pay mode: cash, UPI, card or net banking. We must keep every payment forever, never just the latest one.
9. Fees for a semester must be paid in full before the student is allowed to sit the semester exam.
10. The library keeps books. Each book title has an ISBN, a title, an author and possibly a publisher. We may have several physical copies of the same book; the copies are numbered 1, 2, 3… within each ISBN.
11. Each copy is always in one state: available, issued or lost.
12. When a copy is lent out we record a loan: a loan id, the issue date, the due date, and later the return date. A loan is for one copy only, and once recorded it can never be moved to another copy.
13. A loan is made either by a student or by a teacher — never both, and never nobody.
14. A student may hold at most 3 books at one time; a teacher may hold at most 5. A late return is fined 2 rupees per day.
15. Salaries, the hostel and the timetable are **not** part of this system.

> **In simple words:** "Line 15 is the **scope** — what is in and what is out. Always write the scope down. Half of all project fights are about something one side thought was included."

### 1.5 What we write down at the end

1. **Scope** — what the system covers and what it does not (line 15).
2. **The list of business rules** — the most important output (Block 2).
3. **A word list** — the agreed meaning of each word. Does "book" mean the title or the physical copy? The office uses one word for both; we will use two (BOOK and COPY).
4. **The diagram** — drawn from the rules (Days 3–6).

---

## Block 2 — Business rules (35 min)

### 2.1 What a business rule is

**Simple definition:**
> A business rule is a **short plain-English sentence** that says **what the business keeps**, **how things are related**, or **what is and is not allowed**.

A good business rule is short, specific, and can be checked as **true or false**. "Students should be handled properly" is not a rule. "Every student belongs to exactly one branch" is a rule.

The exam sorts business rules into three kinds. Learn the three kinds and one example of each.

### 2.2 Structural rules

> A **structural rule** says **what data exists** and **how the pieces are related**. It describes the shape of the data, not the steps of the work.

Structural rules become the boxes, the lines and the marks of the diagram, and later the tables and keys.

| Structural rule from the text | What it tells the designer |
|---|---|
| Every student belongs to exactly one branch. | A link STUDENT → BRANCH; a student **must** have a branch |
| A branch may have no head yet. | "head name" is optional |
| No two students share an email. | Email must be unique |
| A copy belongs to one book; copies are numbered within the ISBN. | A link COPY → BOOK; a copy is known only together with its book |
| Marks are between 0 and 100. | A rule about the values a fact may hold |

### 2.3 Procedural rules

> A **procedural rule** says **what must happen**, **in what order**, or **under what condition**. It is about the steps of the work.

| Procedural rule from the text | Why it is procedural |
|---|---|
| Fees for a semester must be paid before the student may sit the exam. | It is an order of events: pay first, then exam |
| Marks and grade stay empty until the exam is over. | A step in time |
| A copy becomes ISSUED when lent out and AVAILABLE when returned. | A change of state caused by an action |

Some procedural rules can still be **shown** in the design (we store the return date, so we can tell whether the copy is back). Others cannot be drawn at all — that is the third kind.

### 2.4 Rules that need extra programming

> A rule that **cannot be shown in the diagram or enforced by the table design** must be enforced by **additional programming** in the application (the portal, the library software).

The test: can a table, a key, a "must have a value" mark, or a list of allowed values enforce it? If not, it needs a program.

| Rule from the text | Why a table alone cannot enforce it |
|---|---|
| A student may hold at most 3 books at one time. | You must **count** the open loans of that student every time a loan is made |
| A late return is fined 2 rupees per day. | You must **calculate** days late × 2 |
| Fees must be paid in full before the exam. | You must **add up** all the payments and compare with the fee due |

> **In simple words:** "Structural = what the data looks like. Procedural = what must happen and when. Needs programming = a rule that counts, adds or compares across many rows, so a program must check it."

### 2.5 Twelve College rules, classified

Put these on the board one at a time and let the class shout the kind before you reveal it.

| # | Rule (from the requirements text) | Kind |
|---|---|---|
| 1 | Every student belongs to exactly one branch. | Structural |
| 2 | Every student has a roll number that never changes; no two students share an email. | Structural |
| 3 | A student takes many subjects and a subject is taken by many students. | Structural |
| 4 | Phone and date of birth may be left out; name and email are compulsory. | Structural |
| 5 | A teacher may report to a head, and the head is also a teacher. | Structural |
| 6 | A loan is made by either a student or a teacher — never both, never nobody. | Structural |
| 7 | Every copy belongs to exactly one book, numbered within the ISBN. | Structural |
| 8 | Marks are between 0 and 100; credits are between 1 and 5. | Structural (a rule about allowed values) |
| 9 | Fees for the semester must be paid before the student sits the exam. | Procedural — needs programming (adds up payments) |
| 10 | Marks and grade are entered only after the exam is over. | Procedural |
| 11 | A copy becomes ISSUED when lent out and AVAILABLE when returned. | Procedural |
| 12 | A student may hold at most 3 books at one time. | Procedural — needs programming (counts open loans) |

> 📌 **Exam-style wording:** "Which rule must be enforced by additional programming?" — look for **counting, adding, comparing, or a limit** ("at most", "no more than", "before"). "Which is a structural rule?" — look for **belongs to, has, may be, must have, unique, one or more**.

---

## Break (10 min)

---

## Block 3 — The parts of a table (30 min)

### 3.1 Table, row, column, cell

```
 Table name:  STUDENTS
              ┌──────────┬────────────┬─────────────────────┬──────────────┬─────────────┐
 Columns ───► │ ROLL NO  │ NAME       │ EMAIL               │ PHONE        │ BRANCH CODE │
 Kind    ───► │ number   │ text       │ text                │ text         │ text        │
              ├──────────┼────────────┼─────────────────────┼──────────────┼─────────────┤
 Row 1   ───► │ 101      │ Ravi       │ ravi@college.edu    │ 9800000001   │ CSE         │
 Row 2   ───► │ 102      │ Priya      │ priya@college.edu   │ (empty)      │ CSE         │
 Row 3   ───► │ 103      │ Arjun      │ arjun@college.edu   │ 9600000003   │ ECE         │
              └──────────┴────────────┴─────────────────────┴──────────────┴─────────────┘
                   ▲                                              ▲
             primary key                                   one cell = one value
```

| Part | Plain meaning | Old word | Example |
|---|---|---|---|
| **Table** | A grid that holds all the facts about **one kind of thing** | file | STUDENTS |
| **Column** | One property, the same for every row; has a name and a kind of value (number, text, date) | field | NAME |
| **Row** | One item — all the facts about one student | record | 102, Priya, priya@college.edu, (empty), CSE |
| **Cell** | Where one row meets one column: holds **one value** or is **empty** | field value | "Priya" |

**Rules a table must follow (exam list):**
1. The table has a **name**. Each column has a **different name** and holds **one kind** of value (all numbers, all text, or all dates).
2. **No two rows are the same** — the primary key makes sure of it.
3. One cell = **one value**. If the value is missing, the cell is **empty** — the database word for empty is **NULL** (meaning "unknown" or "not given", not zero and not a blank space).
4. Rows and columns have **no fixed order**.
5. Columns are the **properties**; rows are the **individual items**.

### 3.2 Primary key and foreign key

**Primary key (PK)**:
> The column (or small group of columns) whose value is **different in every row**, so that it points to exactly one row. It is **never empty** and **never repeated**.

**Foreign key (FK)**:
> A column in one table whose values **must match the primary key of another table** (or be empty, if the link is optional). It is how two tables are **linked**.

| Table | Primary key | Why this one |
|---|---|---|
| STUDENTS | ROLL NO | Given on day one, unique, never changes, short |
| BRANCHES | CODE | Names get changed ("Computer Science" → "Computer Science and Engineering"); codes stay |

> **In simple words:** "The primary key answers *which one?* The foreign key answers *which one does it belong to?* A foreign key always points at a primary key somewhere else. That is the whole trick of a relational database: no pointers, only matching values."

**Rule of thumb:** the foreign key sits on the **"many" side**. Many students belong to one branch → the branch code goes into STUDENTS, not the other way round.

### 3.3 STUDENT and BRANCH as two filled tables

```
 BRANCHES  (the "one" side — the parent)         STUDENTS  (the "many" side — the child)
 CODE | NAME                      | HEAD NAME     ROLL NO | NAME  | EMAIL             | PHONE  | BRANCH CODE
 -----+---------------------------+-----------    --------+-------+-------------------+--------+------------
 CSE  | Computer Science          | Dr. Rao   ◄── 101     | Ravi  | ravi@college.edu  | 98xxx  | CSE
 ECE  | Electronics               | Dr. Iyer  ◄── 102     | Priya | priya@college.edu | (empty)| CSE
 MECH | Mechanical                | (empty)       103     | Arjun | arjun@college.edu | 96xxx  | ECE
 CIVIL| Civil                     | (empty)       104     | Meena | meena@college.edu | 95xxx  | XYZ  ✗
        ▲ primary key                              ▲ primary key                        ▲ foreign key
```

Read the picture with the class:
- CODE is the primary key of BRANCHES: four rows, four different codes, none empty.
- ROLL NO is the primary key of STUDENTS.
- BRANCH CODE in STUDENTS is a foreign key: its values must be one of the codes in BRANCHES. Row 104 says "XYZ" — there is no such branch, so the database **refuses** that row.
- MECH and CIVIL have no students yet — that is allowed. A parent may have no children; a child must have a real parent.
- HEAD NAME is empty for MECH and CIVIL — allowed, because the rule says a branch *may* have no head yet.

**What the DBMS refuses, once we tell it the keys:**

| You try to… | Allowed? | Why |
|---|---|---|
| Add a second student with roll number 101 | No | Primary key repeated |
| Add a student with no roll number | No | Primary key empty |
| Add a student in branch "XYZ" | No | Foreign key does not match any branch |
| Remove branch CSE while Ravi and Priya are in it | No | Children would be left pointing at nothing |
| Remove branch CIVIL, which has no students | Yes | Nothing points at it |

### 3.4 Schema vs instance

| | **Schema** | **Instance** |
|---|---|---|
| Plain meaning | The **design**: which tables, which columns, what kind of value each holds, which keys and rules | The **actual data** inside the tables **at one moment** |
| How often it changes | Rarely — only when the design changes | All the time — every time a row is added, changed or removed |
| Like… | The **blank form** printed by the college | The **filled-in form** of one student |
| College example | STUDENTS has ROLL NO (number), NAME (text), EMAIL (text), PHONE (text), BRANCH CODE (text, must match BRANCHES) | Today: the three rows Ravi, Priya, Arjun. Tomorrow after Meena joins: four rows |

> **In simple words:** "Add a new student → the instance changed, the schema did not. Add a new column 'blood group' to STUDENTS → the schema changed. The exam asks: *the data in the database at a given moment is called the…* — **instance**. *The overall design is called the…* — **schema**."

---

## Block 4 — The conceptual model (20 min)

### 4.1 Entity, attribute, relationship, instance

**Simple definition:**
> A **conceptual data model** is a **drawing** of the *things* the business needs to keep information about, the *facts* about each thing, and *how the things are connected*. It is drawn **before** choosing any software, in words the office can understand.

The drawing is called an **Entity Relationship Diagram** — **ERD** for short.

The three components (the exam asks for exactly these three):

| Component | Plain meaning | College examples |
|---|---|---|
| **Entity** | A **thing** we need to store facts about. Written as a **singular noun in CAPITALS**. | STUDENT, BRANCH, SUBJECT, TEACHER, BOOK |
| **Attribute** | A **fact** about an entity. One value per item. | STUDENT: roll number, name, email, phone |
| **Relationship** | A **named link** between two entities. | STUDENT *enrolled in* BRANCH; TEACHER *teaches* SUBJECT |

And one more word: an **instance** of an entity is **one real example** of it. Ravi is an instance of STUDENT. CSE is an instance of BRANCH.

> **In simple words — the "is it an entity?" test:** Ask three questions. (1) Is it a noun? (2) Do we need to store **more than one fact** about it? (3) Can there be **many** of them? STUDENT passes all three. "Roll number" fails question 2 — it is a fact about a student, so it is an attribute. "College" fails question 3 — there is only one, so it is not an entity in our system.

### 4.2 Entity → table, attribute → column, instance → row

Learn this mapping by heart. The drawing and the table are the same idea in two languages.

| In the drawing (conceptual model) | In the database (table) | College example |
|---|---|---|
| **Entity** | **Table** | STUDENT → the STUDENTS table |
| **Attribute** | **Column** | "roll number" → the ROLL NO column |
| **Instance** (one real example) | **Row** | Ravi → the row 101, Ravi, ravi@college.edu, … |
| **Unique identifier** (the `#` attribute) | **Primary key** | # roll number → ROLL NO as primary key |
| **Relationship** | **Foreign key column** | *enrolled in* → BRANCH CODE in STUDENTS |

Side by side:

```
 Drawing (entity)                       Table
 ┌──────────────────┐                   BRANCHES
 │ BRANCH           │                   CODE  | NAME                | HEAD NAME
 │ # code           │      ──────►      ------+---------------------+----------
 │ * name           │                   CSE   | Computer Science    | Dr. Rao
 │ o head name      │                   ECE   | Electronics         | Dr. Iyer
 └──────────────────┘                   MECH  | Mechanical          | (empty)

 1 entity, 3 attributes                 1 table, 3 columns
 3 instances (CSE, ECE, MECH)           3 rows
```

### 4.3 First look at the ERD notation: soft box, #, *, o

This is the notation Oracle uses and the exam uses. Today only two entities; the full rules for lines come on Day 4.

```
      ┌──────────────────┐                                  ┌──────────────────┐
      │ STUDENT          │                                  │ BRANCH           │
      │ # roll number    │   enrolled in        home of     │ # code           │
      │ * name           ├──────────────────────────────────┤ * name           │
      │ * email          │                                  │ o head name      │
      │ o phone          │                                  │                  │
      │ o date of birth  │                                  └──────────────────┘
      │ * admission date │
      └──────────────────┘
```

| Symbol | Meaning |
|---|---|
| Box with **rounded corners** (a "soft box"), name in CAPITALS, singular | An entity |
| `#` in front of an attribute | This attribute **identifies** one instance — the **unique identifier** (UID) |
| `*` in front of an attribute | **Mandatory** — every instance must have a value |
| `o` in front of an attribute | **Optional** — an instance may have no value |
| A line between two boxes, with a name at each end | A relationship, read in both directions |

Read the picture: "Each STUDENT is *enrolled in* a BRANCH. Each BRANCH is the *home of* STUDENTs." (Day 4 adds "must / may" and "one / many" to these sentences.)

Where the marks come from — straight from the requirements text, line 2: roll number never changes and identifies the student → `#`; name, email and admission date are compulsory → `*`; phone and date of birth may be left out → `o`.

> ✏️ **Activity (5 min):** Using line 3 of the requirements text, draw TEACHER as a soft box with `#`, `*` and `o` marks.

### 4.4 Conceptual/logical vs physical, in one line

> The **conceptual (or logical) model** is the drawing — entities, attributes, relationships — with no software in mind; the **physical model** is the list of real tables, columns, kinds of values and keys for one product such as Oracle. We draw the first on Days 3–6 and convert it to the second on Day 7.

---

## Block 5 — Practice (paper) (20 min)

### 5.1 Nouns in the requirements text → entities and attributes (8 min)

**Do this:** Go through the 15 lines of the College requirements text. (a) Underline every noun that passes the three-question entity test and write it as a singular noun in CAPITALS. (b) Under each entity, list its attributes in words. Do not mark `#`, `*`, `o` yet — that is Day 3.

### 5.2 Twelve rules from the text, classified (7 min)

**Do this:** Without looking at Block 2.5, write 12 rules from the text in your own words and mark each **S** (structural), **P** (procedural) or **P + program** (procedural and needs extra programming).

### 5.3 Draw STUDENT and BRANCH as tables with 3 rows; mark PK and FK (5 min)

**Do this:** Draw the BRANCHES table with 3 rows and the STUDENTS table with 3 rows (invent the data). Label the primary key of each table and the foreign key. Then answer: (a) which table is the parent and which is the child? (b) if CIVIL has no students, is that allowed? (c) if a student's branch code is "XYZ", is that allowed?

---

## Block 6 — 10 exam-style MCQs

1. Which is the best place to find attributes when gathering requirements?
   A. The DBMS manual  B. Existing forms and reports  C. The server specification  D. The SQL standard

2. "Every student must belong to exactly one branch" is a:
   A. Procedural business rule  B. Structural business rule  C. Data type  D. Storage rule

3. Which rule must be enforced by additional programming rather than by the table design?
   A. Roll number must be unique  B. Branch name is compulsory  C. A student may not hold more than 3 books at one time  D. Marks must be a number

4. In a table, one cell holds:
   A. Exactly one value, or is empty  B. A list of values  C. Another table  D. A pointer to a parent record

5. The three components of a conceptual data model are:
   A. Tables, rows, columns  B. Entities, attributes, relationships  C. Files, records, fields  D. Schema, instance, view

6. In an ERD, an entity name should be a:
   A. Plural noun in lower case  B. Singular noun in capital letters  C. Verb  D. Adjective

7. The actual data in the database at one moment is called the:
   A. Schema  B. Instance  C. Model  D. Requirement

8. An entity in the drawing becomes a ______ in the database, and one instance of it becomes a ______.
   A. column, cell  B. row, column  C. table, row  D. table, column

9. A foreign key is:
   A. A column whose values must match the primary key of another table  B. The first column of every table  C. A column that can never be empty  D. A key given by a foreign university

10. "Fees for the semester must be paid before the student may sit the exam" is best described as:
    A. A structural rule about a relationship  B. A procedural rule, enforced by additional programming  C. An attribute of STUDENT  D. A storage rule

---

## Homework (bring to Day 3)

1. **Requirements:** Interview one person (a friend who runs a club, a shopkeeper, the hostel warden). Write the scope in 2 lines and **8 business rules**. Mark each S, P or P + program.
2. **Entities:** From your interview, list the entities (singular, CAPITALS) and 3 attributes each. Draw two of them as soft boxes with `#`, `*` and `o`.
3. **Tables:** Draw SUBJECTS and TEACHERS as tables with 3 rows each, using lines 3 and 5 of the College requirements text. Mark the primary key of each. Which of the two could hold a foreign key to BRANCHES, and can that column be empty?
4. **Think:** Write 4 lines: why is *email* a bad primary key for STUDENT even though no two students share one?

---

## One-slide summary

- Design starts by **talking to people**, reading **forms, registers and documents**, **watching the work**, and for big groups using **questionnaires**. Getting requirements wrong on paper costs minutes; after the tables are built it costs weeks.
- The result is the **scope**, a **word list**, and a list of **business rules**: short sentences that can be checked as true or false.
- **Structural** rules = what data exists and how it is related (belongs to, has, unique, may be empty). **Procedural** rules = what must happen and when (before, after, becomes). Rules that **count, add, compare or set a limit** need **additional programming**.
- A **table** has a name, columns with one kind of value each, rows that are all different (primary key), one value per cell (or empty = NULL), and no fixed order.
- **Primary key** = which one? **Foreign key** = which one does it belong to? The foreign key sits on the "many" side and must match a real primary key.
- **Schema** = the design (rarely changes). **Instance** = the data at one moment (changes all the time).
- **Conceptual model** = the drawing (ERD) = **entities** (singular nouns in CAPITALS), **attributes** (`#` identifier, `*` mandatory, `o` optional), **relationships** (named links).
- Entity → table, attribute → column, instance → row, `#` → primary key, relationship → foreign key.

## Simple glossary

| Word | Meaning in one line |
|---|---|
| Scope | What the system covers and what it leaves out |
| Business rule | A short plain sentence about what is kept, how things relate, or what is allowed |
| Structural rule | A rule about what data exists and how it is related; becomes boxes, lines and keys |
| Procedural rule | A rule about what must happen and in what order |
| Additional programming | Code in the application that enforces a rule the table design cannot |
| Table | A grid holding all the facts about one kind of thing |
| Row / record | One item in a table |
| Column / field | One property, the same for every row |
| NULL | The database word for an empty cell: unknown or not given |
| Primary key | The column(s) that make every row different; never empty, never repeated |
| Foreign key | A column whose values must match the primary key of another table |
| Parent / child | The "one" side / the "many" side of a link; the child holds the foreign key |
| Schema | The design of the database: tables, columns, kinds of value, keys |
| Instance | The data in the database at one moment; also: one real example of an entity |
| Conceptual data model | The drawing of entities, attributes and relationships, made before choosing software |
| ERD | Entity Relationship Diagram — the drawing itself |
| Entity | A thing we store facts about; singular noun in CAPITALS |
| Attribute | A fact about an entity |
| Relationship | A named link between two entities |
| Unique identifier (UID) | The `#` attribute(s) that identify one instance; becomes the primary key |
| Mandatory / optional | `*` must have a value / `o` may be empty |
