# Answers — Day 10 — Adding and Changing Data (DML) and Transactions (TCL)

Use this only after you have tried the questions yourself.

**Solution** notes for the trainer: after exercise 19 the four tables hold 4 branches, 4 students, 3 subjects, 3 enrollments — all identical to rows of the College script, so Block 6 replaces them cleanly. The two intentional errors are 10 (foreign key) and 13 (check); ask students to read the constraint name aloud before fixing.

---

**Answers:** 1-B, 2-C, 3-C, 4-B, 5-B, 6-B, 7-B, 8-D, 9-B, 10-B
Why (hardest three): 4 — the child row points at a parent that is missing, so it is the "parent key not found" side of the foreign key; 02292 is the opposite (deleting a parent that has children). 8 — TRUNCATE is DDL, so it commits and is permanent; the three DML commands can be rolled back. 10 — every DDL statement commits first; SELECT, SAVEPOINT and UPDATE do not end the transaction.

---
