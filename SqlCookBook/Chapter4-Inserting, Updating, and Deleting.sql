/*
CHAPTER 4 Inserting, Updating, and Deleting

The past few chapters have focused on basic query techniques, all centered around
the task of getting data out of a database. This chapter turns the tables and focuses on
the following three topic areas:
• Inserting new records into your database
• Updating existing records
• Deleting records that you no longer want
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

--4.6 Inserting into Multiple Tables at Once-- not suported by sql server--4.7 Blocking Inserts to Certain Columns
CREATE VIEW new_emps AS SELECT empno, ename, job FROM emp;
SELECT * FROM emp;
SELECT * FROM new_emps
SELECT * FROM emp
INSERT INTO new_emps(empno, ename, job) VALUES(1, 'JONATHAN', 'EDITOR')

--4.8 Modifying Records in a TableSELECT	deptno, ename, salFROM	empWHERE	deptno = 20		ORDER BY 1, 3;UPDATE	emp		SET sal = sal * 1.10WHERE	deptno = 20;SELECT	deptno		, ename		, sal	as orig_sal		, sal	* .10 as amt_to_add		, sal	* 1.10 as new_salFROM	 empWHERE	deptno = 20		ORDER BY 1, 5-- 4.9 Updating When Corresponding Rows Existselect * from emp_bonusselect * from empSELECT	empno, ename FROM	emp_bonus;UPDATE	empSET		sal = sal*1.20WHERE empno in (SELECT empno from emp_bonus)-- UPDATE	empSET		sal = sal*1.20WHERE	EXISTS (SELECT NULL 					FROM emp_bonus					WHERE emp.empno = emp_bonus.empno)-- 4.10 Updating with Values from Another TableCREATE TABLE new_sal(	id_new_sal INT PRIMARY KEY IDENTITY (1,1) NOT NULL	, deptno int NOT NULL	, sal decimal);INSERT INTO new_sal(deptno, sal) values (10, 4000);select * from new_salselect deptno,ename,sal,comm
 from emp
 order by 1UPDATE	eSET		e.sal = ns.sal		, e.comm = ns.sal / 2FROM	emp AS e		, new_sal AS nsWHERE ns.deptno = e.deptno--4.11 Merging RecordsMERGE	INTO emp_commission ecUSING	(SELECT * FROM emp) emp		ON (ec.empno = emp.empno)		WHEN MATCHED THENUPDATE	SET ec.comm = 1000		DELETE WHERE (sal < 2000)		WHEN NOT MATCHED THEN			INSERT (ec.empno,ec.ename, ec.deptno, ec.comm)			VALUES (emp.empno, emp.ename, emp.deptno, emp.comm)--4.12 Deleting All Records from a TableDELETE	FROM emp-- 4.13 Deleting Specific RecordsDELETE	FROM emp WHERE deptno = 10;--4.14 Deleting a Single RecordDELETE	FROM emp WHERE empno = 7782;--4.15 Deleting Referential Integrity ViolationsDELETE	FROM empWHERE	NOT EXISTS (	SELECT * FROM dept 	WHERE dept.deptno = emp.deptno);--DELETE	FROM empWHERE	deptno NOT IN (SELECT deptno FROM dept)--4.16 Deleting Duplicate RecordsCREATE	TABLE dupes (id INT, name VARCHAR(10));INSERT INTO dupes VALUES (1, 'NAPOLEON');INSERT INTO dupes VALUES (2, 'DYNAMITE');INSERT INTO dupes VALUES (3, 'DYNAMITE');INSERT INTO dupes VALUES (4, 'SHE SELLS');INSERT INTO dupes VALUES (5, 'SEA SHELLS');INSERT INTO dupes VALUES (6, 'SEA SHELLS');INSERT INTO dupes VALUES (7, 'SEA SHELLS');SELECT * FROM dupes ORDER BY 1DELETE	FROM dupesWHERE	id NOT IN ( SELECT min(id)					FROM dupes					GROUP BY name)--4.17 Deleting Records Referenced from Another TableCREATE	TABLE dept_accidents(	dept int	, accident_name varchar(20));EXEC sp_rename 'dept_accidents.deptno', 'dept';INSERT INTO dept_accidents VALUES (10, 'BROKEN FOOT');INSERT INTO dept_accidents VALUES (10, 'FLESH WOUND');INSERT INTO dept_accidents VALUES (20, 'FIRE');INSERT INTO dept_accidents VALUES (20, 'FIRE');INSERT INTO dept_accidents VALUES (20, 'FLOOD');INSERT INTO dept_accidents VALUES (30, 'BRUISED GLUTE');SELECT	* FROM dept_accidents;DELETE	FROM empWHERE	deptno IN( SELECT deptno					FROM dept_accidents					GROUP BY deptno					HAVING COUNT(*) >= 3);