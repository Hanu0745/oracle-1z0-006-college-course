# Day 03 — Entities, Attributes, Supertypes and Unique Identifiers

**Exam syllabus points covered today (1Z0-006 → "Data Modeling — Creating the Physical Model")**
- Supertype and Subtype: describe an example of an entity; define supertype and subtype entities; implement rules for supertype and subtype entities
- Using Attributes: describe attributes for a given entity; identify and give examples of instances; mandatory vs optional attributes; volatile vs non-volatile attributes
- Using Unique Identifiers: define the types of UIDs; select a UID using business rules; define a candidate UID; define an artificial UID

**By the end of today, a student can:**
1. Pick the entities out of a story, reject the things that are not entities, and give instances of each.
2. List the attributes of an entity and mark each one `#`, `*` or `o`.
3. Tell a volatile attribute from a non-volatile one and say what to store instead.
4. Draw a supertype with its subtypes and state the rules that make the drawing correct.
5. Name the types of UID (simple, composite, candidate, primary, secondary, artificial) with a College example of each.
6. Choose the UID of an entity from its business rules and defend the choice.

---

## Today's topics

**0. Recap**
- Five quick questions from Day 2

**1. Entities**
- 1.1 What an entity is
- 1.2 Entity, instance, attribute — the three-question test
- 1.3 Naming rules

**2. Attributes**
- 2.1 Describing the attributes of an entity
- 2.2 One value only
- 2.3 Mandatory (`*`) vs optional (`o`)
- 2.4 Volatile vs non-volatile
- 2.5 Values we do not store (derived values)

**3. Supertype and subtype**
- 3.1 The problem: students and teachers share a lot
- 3.2 The idea and the drawing
- 3.3 The rules for supertypes and subtypes
- 3.4 When to use subtypes, and when not to

**4. Unique identifiers (UIDs)**
- 4.1 What a UID is
- 4.2 Simple and composite UIDs
- 4.3 Candidate, primary and secondary UIDs
- 4.4 Artificial UIDs
- 4.5 Choosing the UID from the business rules
- 4.6 UID walk-through for the College entities

**5. Practice**
- 5.1 Draw the ten College entities
- 5.2 Decide the UIDs
- 5.3 Classify ten attributes

**6. 10 exam-style MCQs**

---
## Time plan

| Time | Block | What we do |
|---|---|---|
| 0:00 – 0:10 | 0 | Recap: 5 quick questions from last class |
| 0:10 – 0:30 | 1 | Entities, instances, naming rules |
| 0:30 – 1:00 | 2 | Attributes: one value, mandatory/optional, volatile/non-volatile |
| 1:00 – 1:10 | — | Break |
| 1:10 – 1:40 | 3 | Supertype and subtype |
| 1:40 – 2:15 | 4 | Unique identifiers |
| 2:15 – 2:45 | 5 | Practice on paper |
| 2:45 – 2:55 | 6 | 10 MCQs |
| 2:55 – 3:00 | last | Key points, homework |

---

## Block 0 — Recap (10 min)

Ask quickly, one student each:
1. Name the three kinds of business rules. (Structural, procedural, needs extra programming.)
2. "Fees must be paid before the exam hall ticket is given." Which kind? (Procedural.)
3. What is one row of a table called, and what is one column called? (Row = record; column = field.)
4. Entity, attribute, instance — which one becomes a table, which a column, which a row? (Entity → table, attribute → column, instance → row.)
5. What is the difference between a schema and an instance of a database? (Schema = the design; instance = the data in it at one moment.)

---

## Block 1 — Entities (20 min)

### 1.1 What an entity is

**Entity** = a *thing of importance* about which the college needs to store data. It can be a real thing (STUDENT, BOOK), a place (BRANCH), an event (LOAN, FEE PAYMENT) or an idea (SUBJECT).

**Instance** = one real example of an entity. Ravi Kumar is an instance of STUDENT; CS201 Database Systems is an instance of SUBJECT. Each instance becomes one row in the table later.

> **In simple words:** "An entity is a *kind* of thing, written in capitals. An instance is *one* of those things, with real values. STUDENT is an entity; Ravi with roll number 101 is an instance."

```
 Entity (the kind)              Instances (real examples, one per row later)
 ┌──────────────────┐           101  Ravi Kumar     ravi@college.edu   CSE
 │ STUDENT          │  ─────►   102  Priya Sharma   priya@college.edu  ECE
 │ # roll number    │           103  Arjun Reddy    arjun@college.edu  CSE
 │ * name           │
 │ * email          │           Each line = 1 instance = 1 row
 └──────────────────┘
```

### 1.2 Entity, instance, attribute — the three-question test

Take every noun in the requirements text and ask three questions:

| Question | STUDENT | "Ravi Kumar" | "roll number" | "the college" |
|---|---|---|---|---|
| 1. Is it a thing (a noun)? | Yes | Yes | Yes | Yes |
| 2. Do we store **several facts** about it? | Yes: roll number, name, email… | — | No, it *is* one fact | Yes, but… |
| 3. Can there be **many** of them? | Yes | No, he is *one* student | — | No, only one college |
| **Result** | **Entity** | **Instance** of STUDENT | **Attribute** of STUDENT | **Not an entity** in this system |

More nouns from the College story:

| Noun | Entity? | Why |
|---|---|---|
| Teacher | Yes | Many teachers, several facts each |
| Fee payment | Yes | Many payments; amount, date, pay mode |
| Semester | No (here) | We only need the number 1–8 → an attribute of ENROLLMENT |
| Dr. Rao | No | One instance of TEACHER |
| Library | No | Only one library → not an entity in this system |

> 📌 **Exam-likely:** the exam gives a list of words and asks "which is an entity?" Pick the one that is a **kind** of thing with many examples (TEACHER), not a single example (Dr. Rao) and not a fact (teacher id).

### 1.3 Naming rules

1. **Singular** noun: STUDENT, not STUDENTS. (One box stands for the kind; the table made from it later gets the plural name.)
2. **Capital letters** in the diagram.
3. Name what the thing **is**, not what it does: BOOK, not "BORROWING". Events are fine as nouns: LOAN, FEE PAYMENT.

---

## Block 2 — Attributes (30 min)

### 2.1 Describing the attributes of an entity

**Attribute** = one fact we store about an entity. Every instance has one value for it (or no value, if the attribute is optional).

To describe the attributes of an entity, ask: "What do I need to know about *one* student to do the college's work?" Then write the list with a symbol in front of each:

| Symbol | Meaning | Plain question |
|---|---|---|
| `#` | Part of the **unique identifier** (UID) — the value that picks out one instance | "Which one is it?" |
| `*` | **Mandatory** — every instance must have a value | "Can I save it without this?" → No |
| `o` | **Optional** — an instance may have no value | "Can I save it without this?" → Yes |

```
 ┌──────────────────────┐
 │ STUDENT              │
 │ # roll number        │   ← identifies the student
 │ * name               │   ← must be known on day one
 │ * email              │
 │ o phone              │   ← may be empty
 │ o date of birth      │
 │ * admission date     │
 └──────────────────────┘
```

> **In simple words:** "An attribute answers one question about one instance. 'What is Ravi's email?' → one answer. If the question has a list as its answer — 'What are Ravi's subjects?' — it is not an attribute; it is a relationship to another entity."

### 2.2 One value only

Each attribute holds **one value** per instance. This rule is the base of good design (Day 6 calls it first normal form).

| Wrong attribute | Why | What to do |
|---|---|---|
| STUDENT: phone numbers | Plural — one student may have three | Keep one `o phone`, or make a separate entity PHONE |
| BOOK: copies | A list | Separate entity COPY |

Also: an attribute belongs to **one** entity. "branch name" belongs to BRANCH, not to STUDENT. The student is *linked* to a branch by a relationship, so we never copy the branch name into STUDENT.

### 2.3 Mandatory (`*`) vs optional (`o`)

| Kind | Meaning | College examples |
|---|---|---|
| **Mandatory** `*` | Every instance must have a value | STUDENT name, email, admission date; BOOK title, author; LOAN issue date, due date |
| **Optional** `o` | An instance may have no value (the cell stays empty) | STUDENT phone, date of birth; BRANCH head name (a new branch has no head yet); LOAN return date (not returned yet); ENROLLMENT marks (exam not held yet) |

> **In simple words:** "Ask: *Can this thing exist without this fact?* A loan can exist before the book comes back, so return date is optional. A loan cannot exist without an issue date, so issue date is mandatory."

Rules of thumb:
- A `#` attribute is always mandatory (it is drawn with `#`, not `#*`).
- "Not known yet" (return date, marks) and "not everyone has it" (phone, publisher) are the two usual reasons for `o`.

### 2.4 Volatile vs non-volatile

**Volatile** attribute = its value changes often, or changes by itself as time passes.
**Non-volatile** attribute = its value stays the same unless someone deliberately changes it.

| Attribute | Volatile? | Why | Store it? |
|---|---|---|---|
| Date of birth | Non-volatile | Fixed for life | Yes |
| Phone | Volatile | People change numbers | Yes, but expect updates |
| Marks (per subject) | Volatile | Change with every exam | Yes, with the semester so we keep history (Day 6) |
| Copy status (AVAILABLE / ISSUED / LOST) | Volatile | Changes with every loan | Yes, it is real current information |
| Age | Volatile, and derived | Goes up every year with no one touching the database | **No** — store date of birth |
| Years of service | Volatile, and derived | Changes every year | **No** — store joining date |
| Days overdue | Volatile, and derived | Changes every day | **No** — store due date |

> **In simple words:** "Volatile does not mean forbidden. Marks and copy status change often and we must store them. The attribute to avoid is the one that goes wrong *just by waiting* — age. Store the fixed fact it comes from."

> 📌 **Exam-likely:** "Which attribute is volatile?" → age, current semester, days overdue. "What should be stored instead of age?" → date of birth.

### 2.5 Values we do not store (derived values)

A **derived** value is one that can be worked out from other stored values: age from date of birth, total fees paid from the payments, number of books on loan from the loans. We do not store a derived value as an attribute; we calculate it when needed. One line for the exam: *store the source, calculate the result.*

---

## Break (10 min)

---

## Block 3 — Supertype and subtype (30 min)

### 3.1 The problem: students and teachers share a lot

Look at STUDENT and TEACHER side by side. Both have a name, an email and a phone; both can borrow library books. Only students have a roll number and an admission date; only teachers have a teacher id and a joining date. If we draw two separate boxes, name, email and phone are written twice and "can borrow books" must be drawn twice. Is there a cleaner way?

### 3.2 The idea and the drawing

**Supertype** = the general entity that holds the attributes and relationships **shared by all** its kinds.
**Subtype** = one **kind** of the supertype; it holds only the attributes and relationships that are **special to that kind**.

> **In simple words:** "A STUDENT *is a kind of* PERSON. A TEACHER *is a kind of* PERSON. Whatever is true for every person — name, email, phone — we write once in PERSON. Whatever is true only for students goes in STUDENT."

We draw subtypes as **boxes inside the supertype box**:

```
 ┌───────────────────────────────────────────────────────┐
 │ PERSON                                                │  ← supertype: what everyone shares
 │ # person id                                           │
 │ * name                                                │
 │ o email                                               │
 │ o phone                                               │
 │                                                       │
 │   ┌─────────────────────┐   ┌─────────────────────┐   │
 │   │ STUDENT             │   │ TEACHER             │   │  ← subtypes: only what is special
 │   │ * roll number       │   │ * teacher id        │   │
 │   │ * admission date    │   │ o joining date      │   │
 │   │ o date of birth     │   │                     │   │
 │   └─────────────────────┘   └─────────────────────┘   │
 └───────────────────────────────────────────────────────┘
```

Reading the drawing:
- Ravi is a STUDENT, so he is also a PERSON: he has a person id, a name, and may have an email and a phone (inherited) **plus** a roll number and an admission date (his own).
- A relationship can be attached at either level. "Each PERSON may borrow one or more LOANs" is drawn once, on the supertype, and every student and teacher gets it. "Each STUDENT must be enrolled in one BRANCH" is drawn on the subtype, because only students are enrolled.

### 3.3 The rules for supertypes and subtypes

| # | Rule | Plain meaning | PERSON example |
|---|---|---|---|
| 1 | Every instance of the supertype is an instance of **exactly one** subtype | Everyone goes into one inner box, never two, never none | Ravi is a STUDENT, not also a TEACHER, and not "just a person" |
| 2 | Subtypes are **mutually exclusive** | The inner boxes do not overlap | Nobody is both student and teacher |
| 3 | Subtypes together **cover the whole supertype** (exhaustive) | No instance is left outside every inner box | Every person is a student or a teacher; if a librarian must be stored, add a subtype |
| 4 | A subtype **inherits** the supertype's attributes, UID and relationships | What the outer box has, every inner box has too | STUDENT gets person id, name, email, phone and "may borrow LOANs" for free |
| 5 | A subtype **may have its own** attributes and relationships | The inner box adds what only it needs | STUDENT adds roll number and "enrolled in BRANCH" |
| 6 | Nesting is possible, but keep to **one level** | A subtype could have subtypes; do not, unless the business needs it | STUDENT → DAY SCHOLAR / HOSTELLER is possible but not needed here |
| 7 | An **OTHER** subtype is used when the list is not complete | If some instances fit none of the named kinds, add OTHER so rule 3 still holds | PERSON → STUDENT / TEACHER / OTHER (librarian, office staff) |
| 8 | There are always **at least two** subtypes | One subtype alone means the supertype is enough | STUDENT and TEACHER |

> **In simple words:** "Rules 1, 2 and 3 are one idea said three ways: **every** person is in **exactly one** inner box. Rules 4 and 5 are: inner boxes **get everything** from the outer box and **add** their own."

### 3.4 When to use subtypes, and when not to

Use a supertype/subtype when **both** are true:
1. Some instances have **extra attributes or relationships** that the others do not have.
2. There are attributes or relationships **shared by all** of them.

| Situation | Subtypes? | Why |
|---|---|---|
| PERSON: students (roll number, branch) and teachers (teacher id), all with name/phone | Yes | Shared facts + special facts |
| SUBJECT: theory subjects and lab subjects (lab room, batch size), all with code/title/credits | Yes | Lab subjects have extra facts |
| STUDENT: CSE students and ECE students | **No** | Same attributes; branch is just a value |

> 📌 **Exam-likely:** "Which is true of subtypes?" → mutually exclusive, exhaustive, at least two, each subtype instance is also a supertype instance, inherits the supertype's attributes and UID. "When is a subtype NOT needed?" → when the kinds have exactly the same attributes and relationships.

---

## Block 4 — Unique identifiers (UIDs) (35 min)

### 4.1 What a UID is

**Unique identifier (UID)** = the attribute, or group of attributes (sometimes together with a relationship), whose value picks out **exactly one instance** of an entity. It is marked `#` in the diagram and becomes the **primary key** of the table later.

> **In simple words:** "If I say 'the student called Ravi', you ask 'which Ravi?'. If I say 'roll number 101', there is only one. The UID is the fact that never needs a 'which one?'."

### 4.2 Simple and composite UIDs

| Kind | Meaning | College example |
|---|---|---|
| **Simple UID** | One attribute alone is enough | STUDENT `#` roll number; BOOK `#` ISBN; SUBJECT `#` code |
| **Composite UID** | Two or more things are needed **together**; each alone is not unique | COPY: copy number **plus** the book it belongs to (copy 2 *of which book?*). ISBN + copy number together are unique |

Copy number 1 exists for every book, so copy number alone is not unique; only ISBN and copy number *together* pick out one copy. How to draw the "plus the book" part is shown on Day 5.

Composite UIDs are common for "part of a whole" entities: a copy of a book, a room in a hostel, a line on a bill. Day 5 shows the barred-relationship drawing; Day 7 shows how it becomes a composite primary key.

### 4.3 Candidate, primary and secondary UIDs

**Candidate UID** = any attribute (or group) that *could* serve as the UID because it is unique for every instance.
**Primary UID** = the candidate we **choose**; it gets the `#`.
**Secondary UID** = a candidate we did **not** choose; it is still unique and worth noting (some books draw it as `(#)`).

STUDENT has two candidates: roll number and email (the college never gives two students the same email). We choose roll number as the primary UID; email stays a secondary UID.

> **In simple words:** "Candidates are all the possible choices. The one we pick is the primary UID. The ones we leave are secondary UIDs. They are not wasted — on Day 7 a secondary UID becomes a 'must be unique' rule on the column."

### 4.4 Artificial UIDs

**Artificial UID** = a made-up number with no business meaning, created only to identify the instance (also called a *surrogate key*). We invent one when nothing natural is safe.

| Entity | Why nothing natural works | Artificial UID |
|---|---|---|
| TEACHER | Two teachers can share a name; email is optional and may change | `#` teacher id |
| FEE PAYMENT | Amount + date is not unique — two students may pay ₹25,000 on the same day | `#` payment id |
| LOAN | Copy + borrower + issue date would work but is long and clumsy | `#` loan id |

A **natural UID** is the opposite: a value the business already uses to identify the thing, such as ISBN for a book or subject code for a subject.

### 4.5 Choosing the UID from the business rules

Take every candidate and ask four questions. The business rules give the answers.

| Question | Roll number | Email | Aadhaar number | Name |
|---|---|---|---|---|
| Is it **unique** for every student, always? | Yes | Yes | Yes | **No** — two students can share a name |
| Is it **never empty** (known on day one)? | Yes | Yes | Not always (foreign students) | Yes |
| Does it **never change**? | Yes | **No** — students change email | Yes | Rarely, but it can |
| Is it **short and simple**? | Yes | Long text | 12 digits, private data | — |
| **Result** | **Primary UID** | Secondary UID | Rejected | Rejected |

> **In simple words:** "Unique, never empty, never changes, short. Four ticks → primary UID. Four ticks but not chosen → secondary UID. No candidate gets four ticks → invent an artificial UID."

> 📌 **Exam-likely:** "Which is an artificial UID?" → a system-generated number such as payment id. "Email is unique but was not chosen; what is it called?" → a secondary UID (it was a candidate). "A UID made of more than one attribute is…" → composite.

### 4.6 UID walk-through for the College entities

| Entity | Candidates | Chosen UID | Kind |
|---|---|---|---|
| BRANCH | code, name | code | Simple, natural |
| STUDENT | roll number, email | roll number | Simple, natural (email = secondary) |
| TEACHER | teacher id, email | teacher id | Simple, artificial |
| SUBJECT | code, title | code | Simple, natural |
| BOOK | ISBN, title + author | ISBN | Simple, natural |
| COPY | copy number + its BOOK | ISBN + copy number | Composite |
| LOAN | copy + borrower + issue date, or loan id | loan id | Simple, artificial |
| FEE PAYMENT | payment id (nothing else is unique) | payment id | Simple, artificial |
| ENROLLMENT | the student + the subject (+ semester, Day 6) | comes from its relationships | Composite (Day 5) |
| TEACHES | the teacher + the subject | comes from its relationships | Composite (Day 5) |

---

## Block 5 — Practice (30 min)

All on paper, in pairs. Collect one sheet per pair at the end.

### 5.1 Draw the ten College entities (15 min)

Draw each of the ten entities as a soft box with its attributes marked `#`, `*`, `o`. Use the Day 2 requirements text and these extra facts:
- A branch has a code, a name, and (once appointed) a head's name.
- A subject has a code, a title and credits (1 to 5).
- A book is known by its ISBN, title and author; the publisher is not always recorded.
- Every copy of a book has a copy number and a status: AVAILABLE, ISSUED or LOST.
- A loan records the issue date and the due date; the return date is filled when the book comes back.
- A fee payment has an amount, the date it was paid, and sometimes the pay mode (CASH, UPI, CARD, NETBANK).
- An enrollment records the semester and, after the exam, the marks and grade.
- The fact that a teacher teaches a subject has no extra facts of its own.

### 5.2 Decide the UIDs (8 min)

For each of these entities write the candidates, the UID you choose and its kind (simple / composite / artificial; mark any secondary UID): BRANCH, STUDENT, TEACHER, COPY, FEE PAYMENT. Give one reason for each choice using the four questions from 4.5.

### 5.3 Classify ten attributes (7 min)

For each attribute write two labels: **mandatory / optional** and **volatile / non-volatile**. Add "do not store" where the value is derived.

| # | Attribute | Mandatory / optional | Volatile / non-volatile |
|---|---|---|---|
| 1 | STUDENT date of birth | ? | ? |
| 2 | STUDENT phone | ? | ? |
| 3 | STUDENT age | ? | ? |
| 4 | STUDENT admission date | ? | ? |
| 5 | COPY status | ? | ? |
| 6 | LOAN return date | ? | ? |
| 7 | LOAN days overdue | ? | ? |
| 8 | SUBJECT credits | ? | ? |
| 9 | TEACHER years of service | ? | ? |
| 10 | BRANCH head name | ? | ? |

---

## Block 6 — 10 exam-style MCQs

1. Which of these is an entity in the College system?
   A. Ravi Kumar  B. Roll number  C. TEACHER  D. 9800000001

2. "Dr. Rao" in relation to the entity TEACHER is an example of:
   A. An attribute  B. An instance  C. A relationship  D. A subtype

3. An attribute that must have a value for every instance is called:
   A. Optional  B. Volatile  C. Mandatory  D. Composite

4. Which attribute should NOT be stored because it changes by itself as time passes?
   A. Date of birth  B. Age  C. Name  D. Admission date

5. Which statement about subtypes is TRUE?
   A. An instance can belong to two subtypes at once
   B. A supertype can have only one subtype
   C. A subtype inherits the attributes and UID of its supertype
   D. Subtypes cannot have their own attributes

6. PERSON has subtypes STUDENT and TEACHER. The college also wants to store office staff, who are neither. What should the designer do?
   A. Nothing; the model is complete
   B. Add a subtype such as OTHER so every person fits exactly one subtype
   C. Remove the supertype
   D. Store office staff as instances of TEACHER

7. A unique identifier made of a single attribute is called:
   A. Composite  B. Simple  C. Artificial  D. Secondary

8. The fee office gives every payment a system-generated number to identify it. This number is a(n):
   A. Candidate UID  B. Composite UID  C. Artificial UID  D. Secondary UID

9. Roll number was chosen as the UID of STUDENT. Email is also unique but was not chosen. Email is a:
   A. Secondary UID  B. Artificial UID  C. Volatile attribute  D. Derived attribute

10. Which is the BEST reason to reject "student name" as a UID?
    A. It is text  B. Two students can have the same name  C. It is too short  D. It is optional

---

## Homework (bring to Day 04)

1. **Entities:** Read this line: *"The college canteen sells items to students and teachers; each sale has a bill number, date and total; each bill has many lines with an item and a quantity."* List the entities, their attributes with `#`, `*`, `o`, and one instance of each entity. Say which UIDs are natural, artificial or composite.
2. **Subtypes:** Draw SUBJECT as a supertype with THEORY SUBJECT and LAB SUBJECT subtypes. Decide which attributes are shared (code, title, credits) and which are special (lab room, batch size). Check your drawing against the eight rules in 3.3.
3. **Read ahead:** Look at the STUDENT and BRANCH boxes from Day 2 and write, in your own words, how one student is connected to one branch. Day 4 turns this into a relationship line.

---

## One-slide summary

- **Entity** = a kind of thing we store data about (STUDENT); **instance** = one real example (Ravi); **attribute** = one fact (email). Entities are singular and in capitals.
- Three-question test: a noun with several facts and many examples → entity; one example → instance; one fact → attribute.
- Every attribute holds **one value** per instance and belongs to **one entity**.
- `#` part of the UID, `*` mandatory (must have a value), `o` optional (may be empty).
- **Volatile** = changes often or by itself; **non-volatile** = stays fixed. Never store a **derived** value (age): store the source (date of birth).
- **Supertype** holds what all kinds share; **subtypes** hold what is special. Drawn as boxes inside a box.
- Subtype rules: every instance in exactly one subtype; mutually exclusive; cover everything (add OTHER if needed); inherit the supertype's attributes, UID and relationships; may add their own; at least two; one level of nesting.
- **UID** picks out one instance: **simple** (roll number) or **composite** (ISBN + copy number).
- **Candidates** are all unique choices; the chosen one is the **primary** UID, the rest are **secondary**; an **artificial** UID is invented when nothing natural is safe.
- Choose a UID with four questions: unique? never empty? never changes? short?

## Simple glossary

| Word | Meaning in one line |
|---|---|
| Entity | A kind of thing of importance that we store information about |
| Instance | One real example of an entity; becomes one row |
| Attribute | One fact about an entity; becomes one column |
| Mandatory attribute | Must have a value for every instance (`*`) |
| Optional attribute | May be left empty (`o`) |
| Volatile / non-volatile attribute | Changes often or by itself as time passes / stays fixed unless changed on purpose |
| Derived value | A value that can be calculated from stored values; not stored |
| Supertype | The general entity holding what all its kinds share |
| Subtype | One kind of the supertype, with its own extra attributes; subtypes never overlap and together cover the supertype |
| Unique identifier (UID) | The attribute(s) whose value picks out exactly one instance (`#`) |
| Simple UID | A UID made of one attribute |
| Composite UID | A UID made of two or more attributes (or attribute plus relationship) |
| Candidate UID | Any attribute or group that could be the UID |
| Primary UID | The candidate chosen as the UID |
| Secondary UID | A candidate that was unique but not chosen |
| Artificial UID | A made-up number with no business meaning, used only to identify |
