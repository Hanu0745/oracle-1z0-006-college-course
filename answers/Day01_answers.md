# Answers — Day 01 — What is a Database?

Use this only after you have tried the questions yourself.

**Sample solution**

| # | Model | Why |
|---|---|---|
| 1 | Flat file | One table, repeated data, no links |
| 2 | Hierarchical | A tree; every child has exactly one parent |
| 3 | Network | Many parents, linked by pointers |
| 4 | Relational | Many tables linked by matching values |
| 5 | Object-oriented | Objects, classes, inheritance |
| 6 | Flat file | One list, nothing linked |

---

**Sample solution**

(a) Tree:
```
                     COLLEGE
                    /        \
          CSE (Dr. Rao)      ECE (Dr. Iyer)
           /        \              |
    101 Ravi     102 Priya     103 Arjun
        |            |             |
  CS201 Databases  CS202 OS   CS201 Databases   ← "CS201 Databases" written twice
```

(b) Tables:
```
BRANCHES                     STUDENTS                        SUBJECTS
CODE | NAME | HEAD           ROLL | NAME  | BRANCH CODE      CODE  | TITLE
CSE  | CSE  | Dr. Rao        101  | Ravi  | CSE              CS201 | Databases
ECE  | ECE  | Dr. Iyer       102  | Priya | CSE              CS202 | Operating Systems
                             103  | Arjun | ECE
```
(c) In the tree, "CS201 Databases" is written twice. In the tables it is written once — and "who takes what" needs a small fourth table (Day 2 and Day 5 will show it). Also: in the tree, the head's name sits under the branch once, which is fine; but if a subject were taught in two branches it would have to be written under both.

---

**Sample solution**
1 conceptual, 2 internal, 3 external, 4 conceptual, 5 external, 6 internal, 7 internal, 8 external.

---

**Answers:** 1-B, 2-B, 3-B, 4-C, 5-C, 6-B, 7-C, 8-C, 9-D, 10-B
Why: Q6 — in a relational database rows have no fixed order; we find rows by value. Q7 — hierarchical (1960s) came before relational (1970), which came before object-oriented (1990s). Q10 — the internal (physical) level can change without touching the conceptual or external level; that is data independence.

---
