/* CHAPTER 9
Date Manipulation

The recipes in this chapter form an important
foundation for future work as you move on to more complex queries involving
not only dates, but times, too.
Before getting into the recipes, we want to reinforce the concept (mentioned in the
preface) of using these solutions as guidelines to solving your specific problems. Try
to think “big picture.” For example, if a recipe solves a problem for the current
month, keep in mind that you may be able to use the recipe for any month (with
minor modifications), not just the month used in the recipe.
*/

--9.1 Determining Whether a Year Is a Leap Year
select coalesce
 (day
 (cast(concat
 (year(getdate()),'-02-29')
 as datetime))
 ,28);

--9.2 Determining the Number of Days in a YearSELECT DATEDIFF(d,curr_year, DATEADD(yy, 1, curr_year))
FROM (
SELECT DATEADD(d, -DATEPART(dy, GETDATE()) +1, GETDATE()) curr_year
FROM t1) x

--9.3 Extracting Units of Time from a Date
select 
datepart( year, getdate()) yr,
datepart( month, getdate()) mon,
datepart( day, getdate()) dy,
datepart( hour, getdate()) hr,
datepart( minute,getdate()) min,
datepart( second,getdate()) sec
from t1--9.4 Determining the First and Last Days of a MonthSELECT DATEADD(DAY,-DAY(GETDATE())+1,GETDATE()) firstday,
 DATEADD(DAY,
 -DAY(DATEADD(MONTH,1,GETDATE())),
 DATEADD(MONTH,1,GETDATE())) lastday
 FROM t1 SELECT	DATEADD(DAY		, -DAY(GETDATE())+1		, GETDATE()) AS firstday		, DATEADD(			DAY			, -DAY(DATEADD(MONTH,1,GETDATE()))			, DATEADD(MONTH,1,GETDATE())) AS lastday	FROM t1;--9.5 Determining All Dates for a Particular Weekday Throughout a YearWITH x (D, yr)
     AS (SELECT D,
                Year(D) yr
         FROM   (SELECT Getdate() - Datepart(D, Getdate()) + 1 D
                 FROM   t1) tmp1
         UNION ALL
         SELECT Dateadd(dd, 1, D),
                yr
         FROM   x
         WHERE  Year(Dateadd(dd, 1, D)) = yr)
SELECT x.D
FROM   x
WHERE  Datename(dw, x.D) = 'Friday'
OPTION (maxrecursion 400) 

--9.6 Determining the Date of the First and Last Occurrences of a Specific Weekday in a Month
WITH x (dy, mth, is_monday)
     AS (SELECT dy,
                mth,
                CASE
                  WHEN Datepart(dw, dy) = 2 THEN 1
                  ELSE 0
                END
         FROM   (SELECT Dateadd(day, 1
						, Dateadd(day, -Day(Getdate()), Getdate())
                        ) dy,
                        Month(Getdate())
                        mth
                 FROM   t1) tmp1
         UNION ALL
         SELECT Dateadd(day, 1, dy),
                mth,
                CASE
                  WHEN Datepart(dw, Dateadd(day, 1, dy)) = 2 THEN 1
                  ELSE 0
                END
         FROM   x
         WHERE  Month(Dateadd(day, 1, dy)) = mth)
SELECT Min(dy) first_monday,
       Max(dy) last_monday
FROM   x
WHERE  is_monday = 1--9.7 Creating a CalendarWITH x(dy, dm, mth, dw, wk)
     AS (SELECT dy,
                Day(dy)          dm,
                Datepart(m, dy)  mth,
                Datepart(dw, dy) dw,
                CASE
                  WHEN Datepart(dw, dy) = 1 THEN Datepart(ww, dy) - 1
                  ELSE Datepart(ww, dy)
                END              wk
         FROM   (SELECT Dateadd(day, -Day(Getdate()) + 1, Getdate()) dy
                 FROM   t1) x
         UNION ALL
         SELECT Dateadd(d, 1, dy),
                Day(Dateadd(d, 1, dy)),
                mth,
                Datepart(dw, Dateadd(d, 1, dy)),
                CASE
                  WHEN Datepart(dw, Dateadd(d, 1, dy)) = 1 THEN
                  Datepart(wk, Dateadd(d, 1, dy)) - 1
                  ELSE Datepart(wk, Dateadd(d, 1, dy))
                END
         FROM   x
         WHERE  Datepart(m, Dateadd(d, 1, dy)) = mth)
SELECT Max(CASE dw
             WHEN 2 THEN dm
           END) AS Mo,
       Max(CASE dw
             WHEN 3 THEN dm
           END) AS Tu,
       Max(CASE dw
             WHEN 4 THEN dm
           END) AS We,
       Max(CASE dw
             WHEN 5 THEN dm
           END) AS Th,
       Max(CASE dw
             WHEN 6 THEN dm
           END) AS Fr,
       Max(CASE dw
             WHEN 7 THEN dm
           END) AS Sa,
       Max(CASE dw
             WHEN 1 THEN dm
           END) AS Su
FROM   x
GROUP  BY wk
ORDER  BY wk 
--Discussion
Select	dia
		, day(dia) as dia_do_mes
		, datepart(month, dia) as mes
		, datepart(weekday, dia) as dia_da_semana
		, case when datepart(weekday, dia) = 1
				then datepart(week, dia) - 1
				else datepart(week, dia)
			end semana
from (
Select dateadd(day, -day(getdate())+1, getdate()) dia
from t1) x

--
with x(dia, dia_do_mes, mes, dia_da_semana, semana)
as(
Select	dia
		, day(dia) as dia_do_mes
		, datepart(month, dia) as mes
		, datepart(weekday, dia) as dia_da_semana
		, case when datepart(weekday, dia) = 1
				then datepart(week, dia) - 1
				else datepart(week, dia)
			end semana
from (
Select dateadd(day, -day(getdate())+1, getdate()) dia
from t1) x
union all 
select dateadd(d, 1 , dia), day(dateadd(d, 1, dia)), mes,
		datepart(weekday, dateadd(d, 1 , dia)),
		case when datepart(weekday, dateadd(d, 1, dia)) = 1
			then DATEPART(weekday, dateadd(d, 1, dia))-1
			else datepart(WEEKDAY, dateadd(d, 1, dia))
		end
from x
where datepart(m, dateadd(d, 1, dia)) = mes)
select * from x

--
with x(dia, dia_do_mes, mes, dia_da_semana, semana)
as(
Select	dia
		, day(dia) as dia_do_mes
		, datepart(month, dia) as mes
		, datepart(weekday, dia) as dia_da_semana
		, case when datepart(weekday, dia) = 1
				then datepart(week, dia) - 1
				else datepart(week, dia)
			end semana
from (
Select dateadd(day, -day(getdate())+1, getdate()) dia
from t1) x
union all 
select dateadd(d, 1 , dia), day(dateadd(d, 1, dia)), mes,
		datepart(weekday, dateadd(d, 1 , dia)),
		case when datepart(weekday, dateadd(d, 1, dia)) = 1
			then DATEPART(weekday, dateadd(d, 1, dia))-1
			else datepart(WEEKDAY, dateadd(d, 1, dia))
		end
from x
where datepart(m, dateadd(d, 1, dia)) = mes)
select case weekday when 2 then dia_do_mes end as Mo,
 case weekday when 3 then dia_do_mes end as Tu,
 case weekday when 4 then dia_do_mes end as We,
 case weekday when 5 then dia_do_mes end as Th,
 case weekday when 6 then dia_do_mes end as Fr,
 case weekday when 7 then dia_do_mes end as Sa,
 case weekday when 1 then dia_do_mes end as Su
 from x



 with x(dy,dm,mth,dw,wk)
 as (
select dy,
 day(dy) dm,
 datepart(m,dy) mth,
 datepart(dw,dy) dw,
 case when datepart(dw,dy) = 1
 then datepart(ww,dy)-1
 else datepart(ww,dy)
 end wk
 from (
select dateadd(day,-day(getdate())+1,getdate()) dy
 from t1
 ) x
 union all
 select dateadd(d,1,dy), day(dateadd(d,1,dy)), mth,
 datepart(dw,dateadd(d,1,dy)),
 case when datepart(dw,dateadd(d,1,dy)) = 1
 then datepart(wk,dateadd(d,1,dy))-1
 else datepart(wk,dateadd(d,1,dy))
 end
 from x
 where datepart(m,dateadd(d,1,dy)) = mth
)
select case dw when 2 then dm end as Mo,
 case dw when 3 then dm end as Tu,
 case dw when 4 then dm end as We,
 case dw when 5 then dm end as Th,
 case dw when 6 then dm end as Fr,
 case dw when 7 then dm end as Sa,
 case dw when 1 then dm end as Su
 from x --9.8 Listing Quarter Start and End Dates for the Year