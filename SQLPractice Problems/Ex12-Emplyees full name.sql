/*
12. Employees full name
Show the FirstName and LastName columns from the
Employees table, and then create a new column called
FullName, showing FirstName and LastName joined
together in one column, with a space in-between.
Expected Results
FirstName LastName FullName
---------- -------------------- -------------------------------
Nancy Davolio Nancy Davolio
Andrew Fuller Andrew Fuller
Janet Leverling Janet Leverling
Margaret Peacock Margaret Peacock
Steven Buchanan Steven Buchanan
Michael Suyama Michael Suyama
Robert King Robert King
Laura Callahan Laura Callahan
Anne Dodsworth Anne Dodsworth
(9 row(s) affected)
*/

USE northwind;

SELECT firstname,
       lastname,
       firstname + ' ' + lastname AS FullName
FROM   employees; 