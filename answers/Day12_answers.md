# Answers — Day 12 — Sorting Data: ORDER BY, and Query Practice

Use this only after you have tried the questions yourself.

**Sample solution**

| # | Answer | Rows | First row |
|---|---|---|---|
| 1 | `SELECT name FROM students WHERE branch_code = 'ECE' ORDER BY name;` | 2 | Arjun Reddy |
| 2 | `SELECT title FROM subjects WHERE credits = 4 ORDER BY title DESC;` | 4 | Thermodynamics |
| 3 | `SELECT payment_id, roll_no, paid_on FROM fee_payments WHERE amount = 45000 ORDER BY paid_on DESC;` | 7 | 5008 (2025-08-04) |
| 4 | `SELECT name, joining_date FROM teachers WHERE hod_id = 1 ORDER BY joining_date;` | 2 | Prof. Lakshmi |
| 5 | `SELECT isbn, copy_no, status FROM copies WHERE status <> 'AVAILABLE' ORDER BY isbn, copy_no;` | 4 | 9780073523323 copy 1 ISSUED |
| 6 | `SELECT roll_no, subject_code, marks, grade FROM enrollments WHERE grade IN ('C', 'D') ORDER BY marks;` | 3 | 103 EC202 58 D |
| 7 | `SELECT roll_no, name FROM students WHERE phone IS NULL ORDER BY roll_no DESC;` | 2 | 106 Sneha Patel |
| 8 | `SELECT subject_code \|\| ': ' \|\| title AS subject_label FROM subjects WHERE branch_code <> 'CSE' ORDER BY subject_label;` | 3 | EC201: Digital Electronics |
| 9 | `SELECT loan_id, return_date FROM loans WHERE return_date IS NOT NULL ORDER BY return_date DESC;` | 2 | 9005 |
| 10 | `SELECT name, dob FROM students WHERE dob BETWEEN DATE '2006-01-01' AND DATE '2006-12-31' ORDER BY dob DESC;` | 5 | Vikram Nair |

Question 8 gives only 3 rows, not 4: HS101 has a NULL branch, and `NULL <> 'CSE'` is unknown, so that row is left out. To include it you would write `WHERE branch_code <> 'CSE' OR branch_code IS NULL`.

---

**Answers:** 1-B, 2-B, 3-A, 4-B, 5-C, 6-B, 7-B, 8-B, 9-B, 10-C
Why: **7** — DESC alone puts NULLs first; NULLS LAST pushes them down. **8** — with DISTINCT you may sort only by a column you show. **9** — DESC on date of birth means the youngest first; Anjali (2007) is the youngest CSE student.

---
