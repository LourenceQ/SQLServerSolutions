/*
3. Sales Representatives
We’d like to see just the FirstName, LastName, and
HireDate of all the employees with the Title of Sales
Representative. Write a SQL statement that returns only
those employees.

Expected Results
FirstName LastName HireDate
---------- -------------------- -----------------------
Nancy Davolio 2010-05-01 00:00:00.000
Janet Leverling 2010-04-01 00:00:00.000
Margaret Peacock 2011-05-03 00:00:00.000
Michael Suyama 2011-10-17 00:00:00.000
Robert King 2012-01-02 00:00:00.000
Anne Dodsworth 2012-11-15 00:00:00.000
(6 row(s) affected)
*/

use Northwind;
select FirstName, LastName, HireDate from Employees
where Title = 'Sales Representative';