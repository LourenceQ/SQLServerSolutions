--https://docs.microsoft.com/en-us/sql/relational-databases/tables/rename-columns-database-engine?view=sql-server-2017
use projeto_db;
exec sp_help estudante;
exec sp_helpconstraint estudante;
exec sp_helpdb;
exec sp_helpdevice;
use Northwind;
exec sp_helpextendedproc;
EXEC sp_helpfile;
EXEC sp_helpfilegroup;  
USE AdventureWorks2012;  
GO  
EXEC sp_helpindex N'Sales.Customer';  
GO  

USE master  
EXEC sp_monitor  
---------------
exec sp_helpdb projeto_db;

use projeto_db

exec sp_help estudante;

exec sp_columns estudante

select * from sysobjects where xtype = 'U';

select name, crdate from sysobjects where xtype = 'U';

select * from information_schema.TABLES;

select * from projeto_db.information_schema.TABLES;

exec sp_rename 'Categories.CategoryID', 'Id', 'COLUMN';

EXEC SP_RENAME 'dept.DptNo', 'dept_no';

--list constraints
SELECT table_view,
       object_type,
       constraint_type,
       constraint_name,
       details
FROM   (SELECT Schema_name(t.schema_id) + '.' + t.[name]         AS table_view,
               CASE
                 WHEN t.[type] = 'U' THEN 'Table'
                 WHEN t.[type] = 'V' THEN 'View'
               END                                               AS
               [object_type],
               CASE
                 WHEN c.[type] = 'PK' THEN 'Primary key'
                 WHEN c.[type] = 'UQ' THEN 'Unique constraint'
                 WHEN i.[type] = 1 THEN 'Unique clustered index'
                 WHEN i.type = 2 THEN 'Unique index'
               END                                               AS
               constraint_type,
               Isnull(c.[name], i.[name])                        AS
               constraint_name,
               Substring(column_names, 1, Len(column_names) - 1) AS [details]
        FROM   sys.objects t
               LEFT OUTER JOIN sys.indexes i
                            ON t.object_id = i.object_id
               LEFT OUTER JOIN sys.key_constraints c
                            ON i.object_id = c.parent_object_id
                               AND i.index_id = c.unique_index_id
               CROSS apply (SELECT col.[name] + ', '
                            FROM   sys.index_columns ic
                                   INNER JOIN sys.columns col
                                           ON ic.object_id = col.object_id
                                              AND ic.column_id = col.column_id
                            WHERE  ic.object_id = t.object_id
                                   AND ic.index_id = i.index_id
                            ORDER  BY col.column_id
                            FOR xml path ('')) D (column_names)
        WHERE  is_unique = 1
               AND t.is_ms_shipped <> 1
        UNION ALL
        SELECT Schema_name(fk_tab.schema_id) + '.'
               + fk_tab.NAME AS foreign_table,
               'Table',
               'Foreign key',
               fk.NAME       AS fk_constraint_name,
               Schema_name(pk_tab.schema_id) + '.'
               + pk_tab.NAME
        FROM   sys.foreign_keys fk
               INNER JOIN sys.tables fk_tab
                       ON fk_tab.object_id = fk.parent_object_id
               INNER JOIN sys.tables pk_tab
                       ON pk_tab.object_id = fk.referenced_object_id
               INNER JOIN sys.foreign_key_columns fk_cols
                       ON fk_cols.constraint_object_id = fk.object_id
        UNION ALL
        SELECT Schema_name(t.schema_id) + '.' + t.[name],
               'Table',
               'Check constraint',
               con.[name] AS constraint_name,
               con.[definition]
        FROM   sys.check_constraints con
               LEFT OUTER JOIN sys.objects t
                            ON con.parent_object_id = t.object_id
               LEFT OUTER JOIN sys.all_columns col
                            ON con.parent_column_id = col.column_id
                               AND con.parent_object_id = col.object_id
        UNION ALL
        SELECT Schema_name(t.schema_id) + '.' + t.[name],
               'Table',
               'Default constraint',
               con.[name],
               col.[name] + ' = ' + con.[definition]
        FROM   sys.default_constraints con
               LEFT OUTER JOIN sys.objects t
                            ON con.parent_object_id = t.object_id
               LEFT OUTER JOIN sys.all_columns col
                            ON con.parent_column_id = col.column_id
                               AND con.parent_object_id = col.object_id) a
ORDER  BY table_view,
          constraint_type,
          constraint_name 

/*
INFORMATION_SCHEMA.TABLE_CONSTRAINTS view returns one row for each table constraint
in the current database.

INFORMATION_SCHEMA.CONSTRAINT_COLUMN_USAGE view returns one row for each 
column in the current database that has a constraint defined on the column.
*/

-- Query information schema views to get metadata on constraints on hcm.departments table:
SELECT 
	tc.TABLE_SCHEMA,
	tc.TABLE_NAME,
	tc.CONSTRAINT_TYPE,
	ccu.COLUMN_NAME
FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS tc 
JOIN INFORMATION_SCHEMA.CONSTRAINT_COLUMN_USAGE ccu
ON tc.CONSTRAINT_NAME = ccu.CONSTRAINT_NAME
AND tc.TABLE_NAME = ccu.TABLE_NAME
AND tc.TABLE_SCHEMA = ccu.TABLE_SCHEMA
WHERE tc.TABLE_SCHEMA = 'hcm' AND tc.TABLE_NAME = 'departments';
