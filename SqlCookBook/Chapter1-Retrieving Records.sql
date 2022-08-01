/* 
Chapter 1 - Retrieving Records

This chapter focuses on basic SELECT statements. It is important to have a solid
understanding of the basics as many of the topics covered here are not only present in
more difficult recipes but are also found in everyday SQL.
*/
USE SqlCookbook;

--1.1 Retrieving All Rows and Columns from a Table
SELECT * FROM Emp;

--1.2 Retrieving All Rows and Columns from a Table
SELECT * FROM Emp WHERE DeptNo = 10;

--1.3 Finding Rows That Satisfy Multiple Conditions
SELECT * FROM Emp
WHERE	DeptNo = 10
		or Comm is not null 
		or Sal <= 2000 and DeptNo = 20;

--1.3 Finding Rows That Satisfy Multiple Conditions
SELECT * FROM Emp
WHERE	DeptNo = 10
		or Comm is not null 
		or Sal <= 2000 and DeptNo = 20;

SELECT * FROM Emp
WHERE	(DeptNo = 10
		or Comm is not null 
		or Sal <= 2000) and DeptNo = 20;

--1.4 Retrieving a Subset of Columns from a Table
SELECT Ename, DeptNo, Sal FROM Emp

--1.5 Providing Meaningful Names for Columns
SELECT Sal as Salary, Comm as Commission FROM Emp

--1.6 Referencing an Aliased Column in the WHERE Clause
SELECT *
FROM   (SELECT sal  AS Salary,
               comm AS Commission
        FROM   emp) x
WHERE  salary < 5000; 

--1.7 Concatenating Column Values
SELECT	Ename + ' Work as a ' + job as msg
FROM	Emp 
WHERE	DeptNo = 10;

--1.8 Using Conditional Logic in a SELECT Statement
SELECT	Ename
		,Sal
		,CASE 
			WHEN Sal <= 2000 THEN 'Underpaid'
			WHEN sal >= 4000 THEN 'Overpaid'
			ELSE 'Ok'
		END AS	Status
FROM Emp;

--1.9 Limiting the Number of Rows Returned
SELECT TOP 5 * FROM Emp;

--1.10 Returning n Random Records from a Table
SELECT  Ename, Job
FROM Emp
ORDER BY NEWID();

--1.11 Finding Null Values
SELECT * FROM Emp
WHERE	Comm IS NULL;

--1.12 Transforming Nulls into Real Values
SELECT CASE 
	WHEN Comm IS NOT NULL THEN	Comm
	ELSE 0
	END
FROM EMP

SELECT COALESCE(Comm, 0)
FROM Emp

--1.13 Searching for Patterns - Consider the following query and result set:
SELECT	Ename
		, Job
FROM	Emp
WHERE	 DeptNo IN (10, 20);

SELECT	Ename
		, Job
FROM	Emp
WHERE	DeptNo IN (10, 20)
AND		(Ename LIKE '%I%' OR Job LIKE '%er');



