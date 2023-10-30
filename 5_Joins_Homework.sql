/******************************************************************************
Course videos: https://www.red-gate.com/hub/university/courses/t-sql/tsql-for-beginners
Course scripts: https://litknd.github.io/TSQLBeginners 

JOINs: INNER, OUTER, FULL, CROSS

HOMEWORK FILE

For best results,  work through this homework and test running the queries (learn by "doing" when you can)

Need some help?
	Join the SQL Community Slack group for discussion: https://t.co/w5LWUuDrqG
	Click the + next to 'Channels' and join #tsqlbeginners

*****************************************************************************/


/* Doorstop */
RAISERROR(N'Did you mean to run the whole thing?', 20, 1) WITH LOG;
GO


/******************************************************************************
Homework
*****************************************************************************/

--USE WideWorldImporters;
GO

--The questions in this homework refer to two tables:
EXEC sp_help 'Application.StateProvinces';
GO
EXEC sp_help 'Application.Countries';
GO

--Join column: CountryID





/* 
Q1 
Return two columns: 
    StateProvinceName, CountryName

Return rows for all StateProvinces which have a related CountryID.


This should return 53 rows.
*/


SELECT t1.Stateprovincename,
    t2.CountryName
FROM Application.StateProvinces AS t1
    INNER JOIN Application.Countries AS t2
    ON t1.CountryID = t2.CountryID;
GO






/* 
Q2
Return two columns: 
    StateProvinceName, CountryName

Return rows for all Countries, with a related StateProvideName IF it exists.
The query should return 242 rows.

Write two versions of the query, one with a LEFT OUTER JOIN,
and one with a RIGHT OUTER JOIN
*/


SELECT t2.Stateprovincename,
    t1.CountryName
FROM Application.Countries AS t1
    LEFT OUTER JOIN Application.StateProvinces AS t2
    ON t1.CountryID = t2.CountryID
GO

SELECT t2.Stateprovincename,
    t1.CountryName
FROM Application.Countries AS t1
    RIGHT OUTER JOIN Application.StateProvinces AS t2
    ON t1.CountryID = t2.CountryID
GO


/* 
Q3
Return one column: 
    CountryName

Return rows for all CountryNames which do NOT have a related row in StateProvinces.

The query should return 189 rows.
*/


SELECT Countryname
FROM Application.Countries AS t1
    LEFT OUTER JOIN Application.StateProvinces AS t2
    ON t1.countryname = t2.StateProvinceName
WHERE t2.StateProvinceName IS NULL;
GO

SELECT stateprovincename
FROM Application.StateProvinces;
GO

SELECT countryname
FROM Application.Countries;
GO

/* 
Q4
Return one column: 
    CountryName

Return rows for a DISTINCT list of countries which DO have a related row in StateProvinces.
This should return one row.
*/


SELECT DISTINCT(countryname)
FROM Application.Countries AS t1
    INNER JOIN Application.StateProvinces AS t2
    ON t1.CountryID = t2.CountryID;
GO



/* 
Q5
Return two columns: 
    CountryName, StateProvinceName
Return rows for all CountryNames and related StateProvinceNames
    even if the Country does not have a related StateProvince
    or even if the StateProvince does not have a related country
*/



SELECT CountryName, StateProvinceName
FROM Application.Countries AS t1
    FULL OUTER JOIN Application.StateProvinces AS t2
    ON t1.CountryID = t2.CountryID;
GO


/* 
Q6
Return three columns: CountryName, StateProvinceName, StateProvinceId
List every possible combination of:
      * CountryName
      * StateProvinceName, StateProvinceID

Order the results by:
    CountryName, StateProvinceName, StateProvinceID

Application.Countries has 190 rows,  Application.StateProvinces has 53 rows
So this should return 190 x 53 = 10070 rows
*/



SELECT Countryname, StateProvinceName, StateProvinceID
FROM Application.Countries AS t1
    CROSS JOIN Application.StateProvinces AS t2
ORDER BY CountryName, StateProvinceName, StateProvinceID;
GO




/* 
Q7

SELECT four columns:
    Column 1: The CountryName for CountryID = 100
    Column 2: The LatestRecordedPopulation for CountryID = 100
    Column 3: The CountryName for the Country whose LatestRecordedPopulation 
              is less than, but closest to that of CountryID = 100
    Column 4: The LatestRecordedPopulation for the Country in Column 3 (next lowest population)

Return one row (where CountryID = 100).
Use a self-join to get this result.
*/

SELECT t1.Countryname, t1.LatestRecordedPopulation, t2.CountryName, t2.LatestRecordedPopulation
FROM Application.Countries AS t1
LEFT JOIN Application.Countries AS t2
ON t1.CountryID = t2.CountryID
WHERE t1.CountryID = 100;
GO






--Simple query to check your work on this problem
SELECT CountryID,
    CountryName,
    LatestRecordedPopulation
FROM Application.Countries
ORDER BY LatestRecordedPopulation DESC;
GO


