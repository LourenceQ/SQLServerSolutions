/*
Chapter 2 - Sorting Query Results

This chapter focuses on customizing how your query results look. By understanding
how to control how your result set is organized, you can provide more readable and
meaningful data.
*/
USE SqlCookbook;

--2.1 Returning Query Results in a Specified Order
SELECT	EmpNo
		, DeptNo
		, Sal 
		, Ename
		,Job
FROM	Emp
ORDER BY	DeptNo
			, Sal DESC

--2.3 Sorting by Substrings
FROM	Emp
ORDER BY	REPLACE(
CASE WHEN	comm IS NULL 
THEN	0 
ELSE	1 
END AS	is_null
FROM	emp
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
          comm DESC 
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