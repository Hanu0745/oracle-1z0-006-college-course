# Answers — Day 09 — SQL Starts Here: What SQL Is, and Creating Tables (DDL)

Use this only after you have tried the questions yourself.

**Sample solution:** the four statements in 4.3, 4.4, 4.5 and 4.6 exactly as printed.

---

**Sample solution** for 15 (the correct form):
```sql
CREATE TABLE enrollments2 (
    roll_no       NUMBER(6),
    subject_code  VARCHAR2(10),
    CONSTRAINT pk_enrollments2 PRIMARY KEY (roll_no, subject_code)
);
DROP TABLE enrollments2;
```

> **Trainer note:** At the end of 6.2 every student must have the four tables `branches`, `students`, `subjects`, `enrollments` present and **empty**, exactly as in 4.3–4.6, with `ck_enroll_marks` back in place. Day 10 inserts rows into them. Walk the room and check the Schema tab of anyone who is unsure.

---

**Answers:** 1-B, 2-C, 3-A, 4-B, 5-B, 6-A, 7-C, 8-B, 9-B, 10-B
Why (hardest three): 2 — UNIQUE stops duplicates but a missing value is not a duplicate, so NULL is allowed; only PRIMARY KEY is "unique and not null". 7 — TRUNCATE is DDL, so it is permanent; DELETE is DML and can be rolled back. 9 — a rule that names two columns has no single column to sit next to, so it goes at table level.

---
