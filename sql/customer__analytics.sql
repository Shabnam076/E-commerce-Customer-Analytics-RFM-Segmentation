/*
PROJECT: E-commerce Customer Analytics & RFM Segmentation
TOOL: SQL Server Management Studio (SSMS)*/

------------------------------------------------------------
-- STEP 1: CREATE THE PROJECT DATABASE
------------------------------------------------------------

CREATE DATABASE EcommerceCustomerAnalytics;
GO

USE EcommerceCustomerAnalytics;
GO


------------------------------------------------------------
-- STEP 2: VALIDATE ROW COUNTS AFTER IMPORT
------------------------------------------------------------

SELECT COUNT(*) AS Rows_2009_2010
FROM dbo.[Year 2009-2010];

SELECT COUNT(*) AS Rows_2010_2011
FROM dbo.[Year 2010-2011];


------------------------------------------------------------
-- STEP 3: COMBINE BOTH SOURCE TABLES AND CONVERT DATA TYPES
------------------------------------------------------------

SELECT
    Invoice,
    StockCode,
    Description,
    Quantity,
    COALESCE(
        TRY_CONVERT(datetime2, InvoiceDate, 120),
        TRY_CONVERT(datetime2, InvoiceDate, 105)
    ) AS InvoiceDate,
    TRY_CONVERT(decimal(10,2), Price) AS Price,
    Customer_ID,
    Country,
    '2009-2010' AS SourceSheet
INTO dbo.RetailCombined
FROM dbo.[Year 2009-2010]

UNION ALL

SELECT
    Invoice,
    StockCode,
    Description,
    Quantity,
    COALESCE(
        TRY_CONVERT(datetime2, InvoiceDate, 120),
        TRY_CONVERT(datetime2, InvoiceDate, 105)
    ) AS InvoiceDate,
    TRY_CONVERT(decimal(10,2), Price) AS Price,
    Customer_ID,
    Country,
    '2010-2011' AS SourceSheet
FROM dbo.[Year 2010-2011];


------------------------------------------------------------
-- STEP 4: VALIDATE THE COMBINED TABLE AND CONVERSIONS
------------------------------------------------------------

SELECT COUNT(*) AS Total_Rows
FROM dbo.RetailCombined;

SELECT COUNT(*) AS Failed_Dates
FROM dbo.RetailCombined
WHERE InvoiceDate IS NULL;

SELECT COUNT(*) AS Failed_Prices
FROM dbo.RetailCombined
WHERE Price IS NULL;


------------------------------------------------------------
-- STEP 5: EXPLORE DATA QUALITY ISSUES
------------------------------------------------------------

-- Check missing Customer IDs
SELECT COUNT(*) AS Missing_CustomerID
FROM dbo.RetailCombined
WHERE Customer_ID IS NULL;


-- Check zero or negative quantities
SELECT COUNT(*) AS Negative_Qty
FROM dbo.RetailCombined
WHERE Quantity <= 0;


-- Check missing product descriptions
SELECT COUNT(*) AS Missing_Description
FROM dbo.RetailCombined
WHERE Description IS NULL;


-- Identify exact duplicate groups across the listed transaction columns
SELECT
    Invoice,
    StockCode,
    Description,
    Quantity,
    InvoiceDate,
    Price,
    Customer_ID,
    Country,
    COUNT(*) AS ExactDupeCount
FROM dbo.RetailCombined
GROUP BY
    Invoice,
    StockCode,
    Description,
    Quantity,
    InvoiceDate,
    Price,
    Customer_ID,
    Country
HAVING COUNT(*) > 1;


------------------------------------------------------------
-- STEP 6: REMOVE EXACT DUPLICATES AND CREATE THE CLEANED TABLE
------------------------------------------------------------

WITH Deduped AS (
    SELECT
        *,
        ROW_NUMBER() OVER (
            PARTITION BY
                Invoice,
                StockCode,
                Description,
                Quantity,
                InvoiceDate,
                Price,
                Customer_ID,
                Country
            ORDER BY (SELECT NULL)
        ) AS RowNum
    FROM dbo.RetailCombined
)
SELECT
    Invoice,
    StockCode,
    Description,
    Quantity,
    InvoiceDate,
    Price,
    Customer_ID,
    Country,
    SourceSheet
INTO dbo.RetailCleaned
FROM Deduped
WHERE RowNum = 1;


------------------------------------------------------------
-- STEP 7: CHECK THE FINAL CLEANED TABLE
------------------------------------------------------------

SELECT COUNT(*) AS Cleaned_Rows
FROM dbo.RetailCleaned;

SELECT *
FROM dbo.RetailCleaned;


------------------------------------------------------------
-- STEP 8: EXPORT FOR PYTHON / JUPYTER NOTEBOOK
------------------------------------------------------------

SELECT *
FROM dbo.RetailCleaned;
