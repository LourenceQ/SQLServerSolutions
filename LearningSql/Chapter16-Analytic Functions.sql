/*
CHAPTER 16
ANALYTIC FUNCTIONS

------------------------------------------------------
Data volumes have been growing at a staggering pace, and organizations are having
difficulty storing all of it, not to mention trying to make sense of it. While data analy‐
sis has traditionally occurred outside of the database server, using specialized tools or
languages such as Excel, R, and Python, the SQL language includes a robust set of
functions useful for analytical processing. If you need to generate rankings to identify
the top 10 salespeople in your company or if you are generating a financial report for
your customer and need to calculate three-month rolling averages, you can use SQL’s
built-in analytic functions to perform these types of calculations
*/

--DATA WINDOWS
use sakila
SELECT Datepart(quarter, payment_date) AS [quarter],
       Datename(mm, payment_date)      AS month_name,
       Sum(amount)                     AS monthly_sales
FROM   payment
WHERE  Year(payment_date) = 2005
GROUP  BY Datepart(quarter, payment_date),
          Datename(mm, payment_date)
ORDER  BY Datename(mm, payment_date) desc ; 
/*
HERE’S THE PREVIOUS QUERY BUT WITH TWO NEW COLUMNS TO CALCULATE 
THE HIGHEST VALUES PROGRAMMATICALLY SHOWING THE MAXIMUM VALUES PER QUARTER AND OVER THE
ENTIRE TIME PERIOD.s
*/
SELECT	Datepart(quarter, payment_date) AS [quarter],
		Datename(mm, payment_date)      AS month_name,
		Sum(amount)                     AS monthly_sales,
		Max(Sum(amount))
			Over (partition by max(amount)) as  max_overall_sales,
		Max(Sum(amount))
			Over(partition By datepart(quarter, payment_date)) as max_quarter_sales
FROM   payment
WHERE  Year(payment_date) = 2005
GROUP  BY Datepart(quarter, payment_date),
          Datename(mm, payment_date)
ORDER  BY Datename(mm, payment_date) desc; 

--LOCALIZED SORTING
SELECT Datepart(quarter, payment_date) AS [quarter],
       Datename(mm, payment_date)      AS month_nm,
       Sum(amount)                     AS monthly_sales,
       Rank()
         OVER (
           ORDER BY Sum(amount) DESC)  AS sales_rank
FROM   payment
WHERE  Year(payment_date) = 2005
GROUP  BY Datepart(quarter, payment_date),
          Datename(mm, payment_date)
ORDER  BY 1, Datename(mm, payment_date) DESC; 
