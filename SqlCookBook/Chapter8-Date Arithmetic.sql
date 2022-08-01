/*CHAPTER 8
Date Arithmetic
Being able to successfully manipulate dates with your RDBMS’s built-in functions can
greatly improve your productivity. For all the recipes in this chapter, we try to take
advantage of each RDBMS’s built-in functions. In addition, we have chosen to use
one date format for all the recipes, DD-MON-YYYY.Of course, there are a number
of other commonly used formats, such as DD-MM-YYYY, the ISO standard format.*/

--8.1 Adding and Subtracting Days, Months, and Years
SELECT	DATEADD(DAY, -5, hiredate) AS hd_minus_5D
		, DATEADD(DAY, 5, hiredate) AS hd_plus_5D
		, DATEADD(DAY, -5, hiredate) AS hd_minus_5M
		, DATEADD(MONTH, 5, hiredate) AS hd_plus_5M
		, DATEADD(YEAR, -5, hiredate) AS hd_minus_5Y
		, DATEADD(YEAR, 5, hiredate) AS hd_plus_5Y
		FROM emp
		WHERE deptno = 10

--8.2 Determining the Number of Days Between Two Dates
SELECT Datediff(dd, allen_hd, ward_hd)
FROM   (SELECT hiredate AS ward_hd
        FROM   emp
        WHERE  ename = 'WARD') AS x,
       (SELECT hiredate AS allen_hd
        FROM   emp
        WHERE  ename = 'ALLEN') AS y --SELECT Datediff(dd, blake_hd, clark_hd)
FROM   (SELECT hiredate AS blake_hd
        FROM   emp
        WHERE  ename = 'BLAKE') AS x,
       (SELECT hiredate AS clark_hd
        FROM   emp
        WHERE  ename = 'ClARK') AS y --8.3 Determining the Number of Business Days Between Two DatesSELECT Sum(CASE
             WHEN Datename(dw, clark_hd + t500.id - 1) 
			 IN ( 'SATURDAY', 'SUNDAY' ) 
			 THEN 0
             ELSE 1
           END) AS days
FROM   (SELECT Max(CASE
                     WHEN ename = 'BLAKE' THEN hiredate
                   END) AS blake_hd,
               Max(CASE
                     WHEN ename = 'CLARK' THEN hiredate
                   END) AS clark_hd
        FROM   emp
        WHERE  ename IN ( 'BLAKE', 'CLARK' )) x,
       t500
WHERE  t500.id <= datediff(day, blake_hd,clark_hd) + 1 

select * from emp
select hiredate from emp where ename = 'BLAKE' or ename = 'CLARK'


select case when ename = 'BLAKE'
 then hiredate
 end as blake_hd,
 case when ename = 'ClARK'
 then hiredate
 end as clark_hd
 from emp
 where ename in ( 'BLAKE','CLARK' )

 select max(case when ename = 'BLAKE'
 then hiredate
 end) as blake_hd,
 max(case when ename = 'ClARK'
 then hiredate
 end) as clark_hd
 from emp
 where ename in ( 'BLAKE','CLARK' )


select x.*, t500.*, clark_hd+t500.id-1  as 'clark_hd+T500' from (
select max(case when ename = 'BLAKE' then hiredate end) as blake_hd,
	   max(case when ename = 'CLARK' then hiredate end) as clark_hd 
from emp
where ename in ('BLAKE', 'CLARK')) AS x, t500
where t500.id <= clark_hd - blake_hd + 1

--8.4 Determining the Number of Months or Years Two Dates
SELECT	DATEDIFF(month, min_hd, max_hd) AS month_diff
		, DATEDIFF(year, min_hd, max_hd) AS year_didff
		FROM 
		( SELECT MIN(hiredate) AS min_hd
		, MAX(hiredate) AS max_hd
		FROM emp) x

--8.5 Determining the Number of Seconds, Minutes, or Hours Between Two DatesSELECT	DATEDIFF(HOUR, allen_hd, ward_hd) AS hrs		, DATEDIFF(MINUTE, allen_hd, ward_hd) AS mins		, DATEDIFF(SECOND, allen_hd, ward_hd) AS secs	FROM(		SELECT MAX( CASE WHEN ename = 'WARD'					 THEN hiredate					 END) AS ward_hd,			   MAX (CASE WHEN ename = 'ALLEN'						 THEN hiredate					END) AS allen_hd	FROM emp) x--8.6 Counting the Occurrences of Weekdays in a YearWITH x(start_date, end_date)
     AS (SELECT start_date,
                Dateadd(year, 1, start_date) end_date
         FROM   (SELECT Cast(Cast(Year(Getdate()) AS VARCHAR)
                             + '-01-01' AS DATETIME) start_date
                 FROM   t1) tmp
         UNION ALL
         SELECT Dateadd(day, 1, start_date),
                end_date
         FROM   x
         WHERE  Dateadd(day, 1, start_date) < end_date)
SELECT Datename(dw, start_date),
       Count(*)
FROM   x
GROUP  BY Datename(dw, start_date)
OPTION(maxrecursion 366)



with x (start_date, end_date)
as (
select start_date, 
	dateadd(year, 1, start_date) end_date
from (
select cast(	cast(year(getdate()) as varchar) + '-01-01'		as datetime) start_date from t1) tmpunion all select dateadd(day, 1, start_date), end_date from xwhere dateadd(day, 1, start_date) < end_date)select datename(dw, start_date), count(*)from xgroup by datename(dw, start_date)option (maxrecursion 366)--8.7 Determining the Date Difference Between the Current Record and the Next RecordSELECT x.ename,
       x.hiredate,
       x.next_hd,
       Datediff(day, x.hiredate, x.next_hd) AS diff
FROM   (SELECT deptno,
               ename,
               hiredate,
               Lead(hiredate)
                 OVER(
                   ORDER BY hiredate) AS next_hd
        FROM   emp) x
WHERE  x.deptno = 10  select * from INFORMATION_SCHEMA.tables select * from emp