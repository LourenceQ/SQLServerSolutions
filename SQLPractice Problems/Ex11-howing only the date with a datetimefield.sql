/*
11. Showing only the Date with a DateTime field
In the output of the query above, showing the Employees
in order of BirthDate, we see the time of the BirthDate
field, which we don’t want. Show only the date portion of
the BirthDate field.


Expected Results
FirstName LastName Title DateOnlyBirthDate
---------- -------------------- ------------------------------ -----------------
Margaret Peacock Sales Representative 1955-09-19
Nancy Davolio Sales Representative 1966-12-08
Andrew Fuller Vice President, Sales 1970-02-19
Steven Buchanan Sales Manager 1973-03-04
Laura Callahan Inside Sales Coordinator 1976-01-09
Robert King Sales Representative 1978-05-29
Michael Suyama Sales Representative 1981-07-02
Janet Leverling Sales Representative 1981-08-30
Anne Dodsworth Sales Representative 1984-01-27
(9 row(s) affected)
*/

USE northwind;
/*
SELECT firstname,
       lastname,
       title,
       birthdate
FROM   employees
ORDER  BY birthdate 
*/

 select firstname,
       lastname,
       title,
       (select convert(varchar(10), birthdate, 23) as dateonlybirthdate)
from   employees
order  by birthdate 

/*
    SELECT birthdate,
       CONVERT(VARCHAR(10), birthdate, 23) AS convertedBirth,
       firstname,
       lastname,
       title
FROM   employees
ORDER  BY convertedbirth

SELECT CONVERT(VARCHAR(10), birthdate, 23) AS DateOnlyBirthDate,
       firstname,
       lastname,
       title
FROM   employees
ORDER  BY dateonlybirthdate 
*/





  
