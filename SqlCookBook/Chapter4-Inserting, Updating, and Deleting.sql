/*
CHAPTER 4 Inserting, Updating, and Deleting

The past few chapters have focused on basic query techniques, all centered around
the task of getting data out of a database. This chapter turns the tables and focuses on
the following three topic areas:
� Inserting new records into your database
� Updating existing records
� Deleting records that you no longer want
*/

--4.1 Inserting a New Record
select * from dept
INSERT INTO	dept(deptno, dname, loc)
VALUES		(50,'PORGRAMMING', 'BALTIMORE');

--4.2 Inserting Default Values
create table D (id integer default 0)
insert into D default values

--4.3 Overriding a Default Value with NULL
create table D (id integer default 0, foo VARCHAR(10))

insert into d (id, foo) values (null, 'Brighten')

--4.4 Copying Rows from One Table into Another
SELECT * FROM dept_east
INSERT INTO	dept_east(deptno, dname, loc)
SELECT	deptno, dname, loc
FROM	dept
WHERE	loc IN('NEW YOURK', 'BOSTON')

--4.5 Copying a Table Definition
SELECT * FROM dept_2;

SELECT * INTO dept_2
FROM	dept 
WHERE	1 = 0

SELECT * FROM dept_3;

SELECT * INTO dept_3
FROM	dept 

--4.6 Inserting into Multiple Tables at Once
CREATE VIEW new_emps AS SELECT empno, ename, job FROM emp;
SELECT * FROM emp;
SELECT * FROM new_emps
SELECT * FROM emp
INSERT INTO new_emps(empno, ename, job) VALUES(1, 'JONATHAN', 'EDITOR')

--4.8 Modifying Records in a Table
 from emp
 order by 1