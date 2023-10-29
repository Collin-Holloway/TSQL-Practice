/******************************************************************************
Course videos: https://www.red-gate.com/hub/university/courses/t-sql/tsql-for-beginners
Course scripts: https://litknd.github.io/TSQLBeginners 

Introducing SELECTs and Aliasing

This is your HOMEWORK file

For best results,  work through this homework and test running the queries (learn by "doing" when you can)

Need some help?
	Join the SQL Community Slack group for discussion: https://t.co/w5LWUuDrqG
	Click the + next to 'Channels' and join #tsqlbeginners

*****************************************************************************/



/* ✋🏻 Doorstop ✋🏻  */
RAISERROR(N'Did you mean to run the whole thing?', 20, 1) WITH LOG;
GO


/* 🚌 🚌 🚌 🚌 🚌 🚌 🚌 🚌 🚌 🚌 🚌 🚌 🚌 🚌 🚌 🚌 🚌
Homework documentation:
🚌 🚌 🚌 🚌 🚌 🚌 🚌 🚌 🚌 🚌 🚌 🚌 🚌 🚌 🚌 🚌 🚌 🚌*/

USE WideWorldImporters;
GO

--Not sure how to start? Get stuck? These pages will un-stick you!

--WHERE:    https://docs.microsoft.com/en-us/sql/t-sql/queries/where-transact-sql
--LIKE:     https://docs.microsoft.com/en-us/sql/t-sql/language-elements/like-transact-sql
--ORDER BY: https://docs.microsoft.com/en-us/sql/t-sql/queries/select-order-by-clause-transact-sql




/* 🌮 🌮 🌮 🌮 🌮 🌮 🌮 🌮 🌮 🌮 🌮 🌮 🌮 🌮 🌮 🌮 🌮
Homework 
🌮 🌮 🌮 🌮 🌮 🌮 🌮 🌮 🌮 🌮 🌮 🌮 🌮 🌮 🌮 🌮 🌮 */

USE WideWorldImporters;
GO


/* 
Q1 

Write a query that SELECTS all the rows from Application.People
Return all columns in the table
    Use a "worst practice" to SELECT every column in the table

GO
*/

SELECT *
FROM Application.People;
GO







EXEC sp_help 'Application.People';
GO

SELECT name,
    definition,
    is_persisted
FROM sys.computed_columns AS cc
WHERE cc.object_id = OBJECT_ID('Application.People');  
GO

/* 
Q2


Write a query that SELECTS all the rows from Application.People
Return rows for ONLY three columns:
    FullName 
    PreferredName
    EmailAddress  - alias as: Email
GO
*/

SELECT ap.[FullName],
       ap.[PreferredName],
       ap.[EmailAddress] AS [Email]
FROM Application.people AS ap;
GO








/* 
Q3

Write a query that SELECTS all the rows from Application.People
Return rows for ONLY three columns:
    FullName 
    PreferredName
    EmailAddress  - alias as: Email
Return ONLY rows where Email has not been entered (NULL)
GO
*/


SELECT ap.[FullName],
       ap.[PreferredName],
       ap.[EmailAddress] AS [Email]
FROM Application.people AS ap
WHERE ap.[EmailAddress] IS NULL;
GO


















/* 
Q4

Write a query that SELECTS all the rows from Application.People
Return rows for ONLY three columns:
    FullName 
    PreferredName
    EmailAddress  - alias as: Email
Return ONLY rows where PreferredName is Agrita 
GO
*/



SELECT ap.[FullName],
       ap.[PreferredName],
       ap.[EmailAddress] AS [Email]
FROM Application.people AS ap
WHERE ap.[PreferredName] = 'Agrita';
GO









/* 
Q5

Write a query that SELECTS all the rows from Application.People
Return rows for ONLY three columns:
    FullName 
    PreferredName
    EmailAddress  - alias as: Email
Return ONLY rows where PreferredName starts with the letter A 
GO
*/


SELECT ap.[FullName],
       ap.[PreferredName],
       ap.[EmailAddress] AS [Email]
FROM Application.people AS ap
WHERE ap.[PreferredName] LIKE 'A%'
GO









/* 
Q6

Write a query that SELECTS all the rows from Application.People
Return rows for ONLY three columns:
    FullName 
    PreferredName
    EmailAddress  - alias as: Email
Return ONLY rows where PreferredName starts with the LOWERCASE letter 'a'  
GO
*/

SELECT ap.[FullName],
       ap.[PreferredName],
       ap.[EmailAddress] AS [Email]
FROM Application.people AS ap
WHERE ap.[PreferredName] COLLATE Latin1_General_CI_AS LIKE 'a%';
GO







/* 
Q7

Write a query that SELECTS all the rows from Application.People
Return rows for ONLY three columns:
    FullName 
    PreferredName
    EmailAddress  - alias as: Email
Return ONLY rows where PreferredName contains 'y' or 'Y' anywhere in the string
    AND the email address contains a space
Order the results by EmailAddress Ascending
GO
*/


SELECT ap.[FullName],
       ap.[PreferredName],
       ap.[EmailAddress] AS [Email]
FROM Application.people AS ap
WHERE ap.[PreferredName] LIKE '%y%'
    AND ap.[EmailAddress] LIKE '% %';
GO








/* 
Q8

Write a query that SELECTS all the rows from Application.People
Return rows for ONLY two columns:
    FullName 
    The length (number of characters in) the FullName column, 
        as calculated by the LEN() SQL Server function
        https://docs.microsoft.com/en-us/sql/t-sql/functions/len-transact-sql?view=sql-server-2017
        alias as: Len Full Name
Order the results by the length of FullName, Descending
Return only 10 rows 

Do NOT use SET ROWCOUNT -- instead do everything in a single TSQL statement
GO
*/


SELECT TOP (10) 
       ap.[FullName],
       LEN(ap.[FullName]) AS [Len Full Name]
FROM Application.people AS ap
ORDER BY [Len Full Name] DESC;
GO






/* 
Q9

Write a query that SELECTS all the rows from Application.People
Just like Q8...
Return rows for ONLY two columns:
    FullName 
    The length (number of characters in) the FullName column, 
        as calculated by the LEN() SQL Server function
        https://docs.microsoft.com/en-us/sql/t-sql/functions/len-transact-sql?view=sql-server-2017
        alias as: Len Full Name
Order the results by the length of FullName, Descending
Return only 10 rows 

EXCEPT this time...
    Return rows ONLY #11 - 20 (as ordered by description above)

Do NOT use the TOP keyword, do not use ROW_NUMBER(), and do not use SET ROWCOUNT
GO
*/


SELECT ap.[FullName],
       LEN(ap.[FullName]) AS [Len Full Name]
FROM Application.people AS ap
ORDER BY [Len Full Name] DESC
OFFSET 11 ROWS
FETCH NEXT 20 ROWS ONLY;
GO







