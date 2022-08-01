CREATE DATABASE	 SqlCookbook;

USE SqlCookbook;
exec sp_help SqlCookbook;
exec sp_columns SqlCookbook;
exec sp_helpdb SqlCookbook;
select * from information_schema.TABLES;
DROP TABLE emp, dept, emp_bonus;
SELECT * FROM dept;
SELECT * FROM emp;
SELECT * FROM emp_bonus;
drop view v;
drop table emp;
/*
Alter table:
ALTER TABLE old_table_name RENAME new_table_name; The second way is to use RENAME TABLE :
*/

/*---------- TABLE dept ----------*/
CREATE TABLE dept (deptid INT IDENTITY PRIMARY KEY
				 , deptno INT NOT NULL
				 , dname VARCHAR(50)
				 , loc VARCHAR(50));
SET IDENTITY_INSERT dept OFF
INSERT INTO dept (deptno, dname, Loc)
values (10, 'ACCOUNTING', 'NEW YORK')
	   , (20, 'RESEARCH', 'DALLAS')
	   , (30, 'SALES', 'CHICAGO')
	   , (40, 'OPERATIONS', 'BOSTON'); 
SET IDENTITY_INSERT dept ON;

/*---------- TABLE emp ----------*/
CREATE TABLE emp (empid INT IDENTITY PRIMARY KEY NOT NULL
				, empno INT NOT NULL
				, ename VARCHAR(50)
				, job VARCHAR(50)
				, mgr VARCHAR(50)
				, hiredate date
				, sal INT
				, comm VARCHAR(50)
				, deptno INT
				,fkdptid INT FOREIGN KEY REFERENCES dept(deptid))
SET IDENTITY_INSERT emp OFF
INSERT INTO emp (empno 
				, ename 
				, job 
				, mgr 
				, hiredate 
				, sal 
				, comm 
				,deptno)
VALUES (7369, 'SMITH', 'CLERK', 7902 , null,800, null, 20),
(7499, 'ALLEN', 'SALESMAN', 7698,  null, 1600, 300, 30),
 (7521, 'WARD', 'SALESMAN', 7698,  null, 1250, 500, 30),
 (7566, 'JONES', 'MANAGER', 7839,  null, 2975, null, 20),
 (7654, 'MARTIN', 'SALESMAN', 7698,  null, 1250, 1400, 30),
 (7698, 'BLAKE', 'MANAGER', 7839,  null, 2850, null, 30),
 (7782, 'CLARK', 'MANAGER', 7839,  null, 2450, null, 10),
 (7788, 'SCOTT', 'ANALYST', 7566,  null, 3000,  null,20),
 (7839, 'KING', 'PRESIDENT',  null,  null, 5000, null, 10),
 (7844, 'TURNER', 'SALESMAN', 7698, null, 1500, 0, 30),
 (7876, 'ADAMS', 'CLERK', 7788,  null, 1100, null, 20),
 (7900, 'JAMES', 'CLERK', 7698,  null, 950,  null,30),
 (7902, 'FORD', 'ANALYST', 7566,  null, 3000, null, 20),
 (7934, 'MILLER', 'CLERK', 7782,  null, 1300, null, 10);
 

UPDATE emp SET hiredate = '2005-12-17' where empno = 7369;
UPDATE emp SET hiredate = '2006-01-20' where empno = 7499;
UPDATE emp SET hiredate = '2006-01-22' where empno = 7521;
UPDATE emp SET hiredate = '2006-04-01' where empno = 7566;
UPDATE emp SET hiredate = '2006-09-28' where empno = 7654;
UPDATE emp SET hiredate = '2006-05-01' where empno = 7698;
UPDATE emp SET hiredate = '2006-06-09' where empno = 7782;
UPDATE emp SET hiredate = '2007-12-09' where empno = 7788;
UPDATE emp SET hiredate = '2006-11-17' where empno = 7839;
UPDATE emp SET hiredate = '2006-09-08' where empno = 7844;
UPDATE emp SET hiredate = '2008-01-12' where empno = 7876;
UPDATE emp SET hiredate = '2006-12-03' where empno = 7900;
UPDATE emp SET hiredate = '2006-12-03' where empno = 7902;
UPDATE emp SET hiredate = '2007-01-23' where empno = 7934;
UPDATE emp
SET    fkdptid= dept.deptid
FROM   emp
       INNER JOIN dept
               ON emp.deptno = dept.deptno;


/*---------- TABLE emp_bonus ----------*/
DROP TABLE	emp_bonus;
CREATE TABLE emp_bonus (empbonusid INT IDENTITY PRIMARY KEY
					, empno INT
					, received date
					, type int
					, fkempid INT FOREIGN KEY REFERENCES emp(empid) );
INSERT INTO emp_bonus(empno, received, type)
VALUES
(7934, '2005-03-17', 1),
(7934, '2005-02-15', 2),
(7839, '2005-02-15', 3),
(7782, '2005-02-15', 1);

UPDATE emp_bonus SET empno=7934, received='2005-03-17', type=1 where empbonusid = 1;
UPDATE emp_bonus SET empno=7934, received='2005-02-15', type=2 where empbonusid = 2;
UPDATE emp_bonus SET empno=7839, received='2005-02-15', type=3 where empbonusid = 3;
UPDATE emp_bonus SET empno=7782, received='2005-02-15', type=1 where empbonusid = 4;

INSERT INTO emp_bonus(empno, received, type) 
VALUES
(7782, '2005-02-15', 1);

UPDATE emp_bonus
SET    fkempid = emp.empid
FROM   emp_bonus
       INNER JOIN emp
               ON emp_bonus.empno = emp.empno;

SELECT * FROM emp;
SELECT * FROM dept;
SELECT * FROM emp_bonus;

exec sp_help emp_bonus;
exec sp_help emp;
exec sp_help dept;

/*---------- TABLE dept_east ----------*/
CREATE TABLE dept_east (deptid INT IDENTITY PRIMARY KEY
				 , deptno INT NOT NULL
				 , dname VARCHAR(50)
				 , loc VARCHAR(50));

/*--------------------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------------------*/

/*
create table emp (empno INT IDENTITY PRIMARY KEY
				, ename varchar(10)
				, job varchar(15)
				, mgr integer
				, hiredate date
				, sal int
				, comm int
				, deptno INT FOREIGN KEY REFERENCES dept(deptid));
SET IDENTITY_INSERT emp ON;
insert into emp
values(7369, 'SMITH',  'CLERK',      7902, '2005-12-17',  800,   NULL , 20),
        (7499, 'ALLEN',  'SALESMAN',   7698, '2006-02-20',  1600,  300 , 30),
        (7521, 'WARD',   'SALESMAN',   7698, '2006-02-22',  1250,  500 , 30),
        (7566, 'JONES',  'MANAGER',    7839, '2006-04-02',  2975,  NULL, 20),
        (7654, 'MARTIN', 'SALESMAN',   7698, '2006-09-28',  1250,  1400, 30),
        (7698, 'BLAKE',  'MANAGER',    7839, '2006-05-01',  2850,  NULL, 30),
        (7782, 'CLARK',  'MANAGER',    7839, '2006-06-09',  2450,  NULL, 10),
        (7788, 'SCOTT',  'ANALYST',    7566, '2007-12-09',  3000,  NULL, 20),
        (7839, 'KING',   'PRESIDENT',  NULL, '2006-11-17',  5000,  NULL, 10),
        (7844, 'TURNER', 'SALESMAN',   7698, '2006-09-08',  1500,  0   , 30),
        (7876, 'ADAMS',  'CLERK',      7788, '2008-01-12',  1100,  NULL, 20),
        (7900, 'JAMES',  'CLERK',      7698, '2006-12-03',  950,   NULL, 30),
        (7902, 'FORD',   'ANALYST',    7566, '2006-12-03',  3000,  NULL, 20),
        (7934, 'MILLER', 'CLERK',      7782, '2007-01-23',  1300,  NULL, 10);
SET IDENTITY_INSERT emp OFF;


create table dept (deptno INT identity primary key, dname varchar(20), loc varchar(20));
SET IDENTITY_INSERT dept ON;
insert into dept
values(10,        'ACCOUNTING',     'NEW YORK'),
      (20,        'RESEARCH',       'DALLAS'),
      (30,        'SALES',          'CHICAGO'),
      (40,        'OPERATIONS',     'BOSTON');
SET IDENTITY_INSERT dept OFF;

create table emp_bonus (empno INT IDENTITY PRIMARY KEY, received date, type int);
insert into emp_bonus
values
(7934, '2005-03-17', 1),
(7934, '2005-02-15', 2),
(7839, '2005-02-15', 3),
(7782, '2005-02-15', 1);


create table t10 (id int);
insert into t10
values(1),(2),(3),(4),(5),(6),(7),(8),(9),(10);
*/

/*
3.7 v

 7369 SMITH  CLERK      7902 17-12-2005  800        20
 7499 ALLEN  SALESMAN   7698 20-02-2006  1600  300  30
 7521 WARD   SALESMAN   7698 22-02-2006  1250  500  30
 7566 JONES  MANAGER    7839 02-04-2006  2975       20
 7654 MARTIN SALESMAN   7698 28-09-2006  1250  1400 30
 7698 BLAKE  MANAGER    7839 01-05-2006  2850       30
 7788 SCOTT  ANALYST    7566 09-12-2007  3000       20
 7844 TURNER SALESMAN   7698 08-09-2006  1500  0    30
 7876 ADAMS  CLERK      7788 12-01-2008  1100       20
 7900 JAMES  CLERK      7698 03-12-2006  950        30
 7902 FORD   ANALYST    7566 03-12-2006  3000       20
 7521 WARD   SALESMAN   7698 22-02-2006  1250  500  30

*/