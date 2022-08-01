/*
Chapter 3 - Working with Multiple Tables

This chapter introduces the use of joins and set operations to combine data from
multiple tables. Joins are the foundation of SQL. Set operations are also important. If
you want to master the complex queries found in the later chapters of this book, you
must start here, with joins and set operations.
*/
--3.1 Stacking One Rowset atop AnotherSELECT ename AS ename_and_dname,
       deptno
FROM   emp
WHERE  deptno = 10
UNION ALL
SELECT '----------',
       NULL
FROM   dept
UNION ALL
SELECT dname,
       deptno
FROM   dept --3.2 Combining Related RowsSELECT E.ename,
       D.loc
FROM   emp AS E,
       dept AS D
WHERE  E.deptno = D.deptno
       AND E.deptno = 10 

select e.ename, d.loc
 from emp e inner join dept d
 on (e.deptno = d.deptno)
 where e.deptno = 10SELECT E.ename,
       D.loc
FROM   emp AS E
       INNER JOIN dept AS D
				ON ( E.deptno = D.deptno )
WHERE  E.deptno = 10 
--3.3 Finding Rows in Common Between Two Tablescreate view V
as
select ename,job,sal
 from emp
 where job = 'CLERK' select * from VSELECT e.empno,
       e.ename,
       e.job,
       e.sal,
       e.deptno 
FROM   emp e,
       V 
WHERE  e.ename = v.ename 
AND    e.job = v.job 
AND    e.sal = v.sal

--3.4 Retrieving Values from One Table That Do Not Exist in Another
SELECT	DeptNo
FROM	Dept
EXCEPT	
SELECT	DeptNo 
FROM	Emp

--3.5 Retrieving Rows from One Table That Do Not Correspond to Rows in Another
SELECT	D.*
FROM	Dept AS D LEFT OUTER JOIN Emp AS E
		ON (D.DeptNo = E.DeptNo)
WHERE	E.DeptNo IS NULL

--3.6 Adding Joins to a Query Without Interfering with Other Joins
SELECT	e.ename, d.loc
from	emp e, dept d
where	e.deptno=d.deptno;

SELECT	e.ename, d.loc, eb.received
from	emp e, dept d, emp_bonus eb
where	e.deptno=d.deptno
and		e.empno=eb.empno;

select	e.ename, d.loc, eb.received,
case    when eb.received is null then 'bonus not received'
		--when eb.received is not null eb.received
		end as status
from	emp e join dept d		
on		(e.deptno=d.deptno)
		left join
		emp_bonus eb
on		(e.empno=eb.empno)
		order by 2;
-----------------------------
select	e.ename, d.loc, eb.received as bonus_status,
case    when eb.received is null then 'bonus not received'
		else 'received on ' + (SELECT CONVERT(VARCHAR(10), eb.received, 23) AS bonus_date)
		end as bonus_status
from	emp e join dept d		
on		(e.deptno=d.deptno)
		left join
		emp_bonus eb
on		(e.empno=eb.empno)
		order by 2;


select	e.ename, d.loc,
case    when eb.received is null then 'bonus not received'
		else 'received on ' + (SELECT CONVERT(VARCHAR(10), eb.received, 23) AS bonus_date)
		end as bonus_status
from	emp e join dept d		
on		(e.deptno=d.deptno)
		left join
		emp_bonus eb
on		(e.empno=eb.empno)
		order by 2;

select	e.ename, d.loc,
case	when eb.received is null then 'bonus not received'
		else 'received on ' + (select convert(varchar(10), eb.received, 23) as bonus_date)
		end as bonus_status
from	emp e join dept d
on		(e.deptno=d.deptno)
		left join
		emp_bonus eb
on		(e.empno=eb.empno)
		order by 2;

--3.7 Determining Whether Two Tables Have the Same Data
select * from information_schema.TABLES;

drop view V;

CREATE VIEW v
AS
SELECT * FROM emp WHERE deptno != 10
UNION ALL
SELECT * FROM emp WHERE ename = 'WARD';

--this select must be separated from create view query
SELECT v.empno, v.ename, v.job, v.mgr, v.hiredate, v.sal, v.comm, v.deptno FROM v

SELECT	* FROM (
		SELECT e.empno, e.ename, e.job, e.mgr, e.hiredate 
				, e.sal, e.comm, e.deptno, COUNT(*) AS cnt
		FROM emp AS e
			GROUP BY empno, ename, job, mgr, hiredate, sal, comm, deptno
		) e

WHERE	NOT EXISTS (
		SELECT NULL FROM (
			SELECT v.empno, v.ename, v.job, v.mgr, v.hiredate
					, v.sal, v.comm, v.deptno, COUNT(*) AS cnt
			FROM v
				GROUP BY empno, ename, job, mgr, hiredate, sal, comm, deptno
		) v
WHERE			v.empno		= e.empno
		AND		v.ename		= e.ename
		AND		v.job		= e.job
		AND		v.mgr		= e.mgr
		AND		v.hiredate	= e.hiredate
		AND		v.sal		= e.sal
		AND		v.comm		= e.comm
		AND		v.deptno	= e.deptno
AND		COALESCE(v.comm, 0) = COALESCE(e.comm, 0))

UNION ALL

SELECT	* FROM (
		SELECT v.empno, v.ename, v.job, v.mgr, v.hiredate
				, v.sal, v.comm, v.deptno, COUNT(*) AS cnt
		FROM v
			GROUP BY empno, ename, job, mgr, hiredate, sal, comm, deptno
		) v
WHERE	NOT EXISTS (
		SELECT NULL FROM (
			SELECT e.empno, e.ename, e.job, e.mgr, e.hiredate 
				, e.sal, e.comm, e.deptno, COUNT(*) AS cnt
		FROM emp e
			GROUP BY empno, ename, job, mgr, hiredate, sal, comm, deptno
		) e

WHERE			v.empno		= e.empno
		AND		v.ename		= e.ename
		AND		v.job		= e.job
		AND		COALESCE(v.mgr,0) = COALESCE(e.mgr,0)
		AND		v.hiredate	= e.hiredate
		AND		v.sal		= e.sal
		AND		v.comm		= e.comm
		AND		v.deptno	= e.deptno
		AND		COALESCE(v.comm, 0) = COALESCE(e.comm, 0))

--3.8 Identifying and Avoiding Cartesian Products
SELECT	e.ename, d.loc
FROM	emp e, dept d
WHERE	e.deptno = 10
AND		d.deptno = e.deptno

--3.9 Performing Joins When Using Aggregates

SELECT	* FROM	emp_bonus

SELECT	e.empno, e.ename, e.sal, e.deptno
		, e.sal * CASE WHEN eb.typebonus = 1 THEN .1
						WHEN eb.typebonus = 2 THEN .2
						ELSE .3
				END AS bonus
FROM	emp e, emp_bonus eb
WHERE	e.empno = eb.empno
AND		e.deptno = 10

select e.empno,
 e.ename,
 e.sal,
 e.deptno,
 e.sal*case when eb.type = 1 then .1
 when eb.type = 2 then .2
 else .3
 end as bonus
 from emp e, emp_bonus eb
where e.empno = eb.empno
 and e.deptno = 10 select * from information_schema.TABLES; exec sp_helpdb SqlCookbook; EXEC sp_monitor
-- 3.10 Performing Outer Joins When Using Aggregates 
 
SELECT d.deptno,
       d.total_sal,
       Sum(e.sal * CASE
                     WHEN eb.type = 1 THEN .1
                     WHEN eb.type = 2 THEN .2
                     ELSE .3
                   END) AS total_bonus
FROM   emp e,
       emp_bonus eb,
       (SELECT deptno,
               Sum(sal) AS total_sal
        FROM   emp
        WHERE  deptno = 10
        GROUP  BY deptno) d
WHERE  e.deptno = d.deptno
       AND e.empno = eb.empno
GROUP  BY d.deptno,
          d.total_sal 

--3.11 Returning Missing Data from Multiple Tables
SELECT	d.deptno
		, d.dname
		, e.ename
FROM	dept d FULL OUTER JOIN emp e
		ON (d.deptno = e.deptno)

--3.12 Using NULLs in Operations and Comparisons
SELECT	ename, COALESCE(comm, 0)
FROM	emp
WHERE	COALESCE(comm, 0) < ( SELECT comm
									FROM emp
									WHERE ename = 'WARD')