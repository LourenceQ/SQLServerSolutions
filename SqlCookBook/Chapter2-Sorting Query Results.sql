/*
Chapter 2 - Sorting Query Results

This chapter focuses on customizing how your query results look. By understanding
how to control how your result set is organized, you can provide more readable and
meaningful data.
*/
USE SqlCookbook;

--2.1 Returning Query Results in a Specified OrderSELECT	Ename		, Job		, SalFROM EmpWHERE	DeptNo IN (10)ORDER BY	Sal ASC;--2.2 Sorting by Multiple Fields
SELECT	EmpNo
		, DeptNo
		, Sal 
		, Ename
		,Job
FROM	Emp
ORDER BY	DeptNo
			, Sal DESC

--2.3 Sorting by SubstringsSELECT	Ename, JobFROM	EmpORDER BY	SUBSTRING(Job, LEN(Job) -1, 2)--2.4 Sorting Mixed Alphanumeric DataSELECT	EmpNoFROM	EmpORDER BY REPLACE( EmpNo				 , REPLACE(				 TRANSLATE(EmpNo, '0123456789', '##########'), '#', ''), '')SELECT	Ename
FROM	Emp
ORDER BY	REPLACE(			TRANSLATE(Ename, '0123456789','##########'),'#','')--2.5 Dealing with Nulls When SortingSELECT	Ename 		, Sal		, CommFROM EmpORDER BY	3 SELECT	Ename		, Sal		, CommFROM (SELECT Ename			, Sal			, Comm 			,CASE 				WHEN Comm IS NULL THEN 0 ELSE 1 			END AS	IS_NULL		FROM Emp) XORDER BY Is_Null		, Comm DESCSELECT		ename,sal,comm,
CASE WHEN	comm IS NULL 
THEN	0 
ELSE	1 
END AS	is_null
FROM	empSELECT ename,
       sal,
       comm
FROM   (SELECT ename,
               sal,
               comm,
               CASE
                 WHEN comm IS NULL THEN 0
                 ELSE 1
               END AS is_null
        FROM   emp) x
ORDER  BY is_null,
          comm DESC --2.6 Sorting on a Data-Dependent KeySELECT	Ename		, Sal		, Job		, CommFROM	EmpORDER BY CASE WHEN Job = 'Salesman' THEN Comm ELSE Sal ENDselect ename,sal,job,comm,
 case when job = 'SALESMAN' then comm else sal end AS ordered
 from emp
 order by 5

select ename, sal, job, comm, 
	case when job = 'salesman' 
	then comm else sal
	end as ordered
	from emp
order by 5

--2.7 Summing Up