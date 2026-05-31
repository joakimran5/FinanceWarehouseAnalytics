/**********************ACCOUNT ANALYSIS****************************************/
------------------------------------------------------
----View total amount of credited and debit ----------
SELECT
	tsc_type,
	SUM(tsc_amt) AS total_amt
FROM [FinanceWarehouseAnalytics].[bank].acc1_tsc
WHERE tsc_type IN ('CDT', 'DBT')
GROUP BY tsc_type;

----View all transaction----------------------------------
SELECT tsc_dt,tsc_cat, tsc_descrp, tsc_amt
FROM [FinanceWarehouseAnalytics].[bank].acc1_tsc

-------View transaction based on details---------------
SELECT
	tsc_cat,
	tsc_descrp,
	SUM(tsc_amt) AS total_amt
FROM [FinanceWarehouseAnalytics].[bank].acc1_tsc
GROUP BY tsc_cat, tsc_descrp
ORDER BY tsc_cat DESC;

-------View transaction based on category-------------
SELECT
	tsc_cat,
	SUM(tsc_amt) AS total_amt
FROM [FinanceWarehouseAnalytics].[bank].acc1_tsc
GROUP BY tsc_cat
ORDER BY tsc_cat DESC;

-------Get first & last balance from month transcation table-------------
SELECT
    FORMAT(tsc_mth_dt, 'MMM-yyyy') AS month_year,
	(tsc_end_bal + ttl_dbt - ttl_cdt) AS beginning_balance,
	tsc_end_bal
FROM [FinanceWarehouseAnalytics].[bank].[acc1_mth_tsc];

-----View transaction balance baseed on month transcation table-------------
SELECT
	*,
	-- Forward running balance (start from beginning)-------------
	1474.77 -- begin balance from month transcation table -- Hardcode
	+ SUM(
		CASE
			WHEN tsc_type = 'CDT' THEN tsc_amt
			WHEN tsc_type = 'DBT' THEN -tsc_amt
		END
	)
	OVER (
		ORDER BY tsc_id
		ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
	) AS running_balance,

	-- Reverse running balance (start from ending)------------
	2031.37 -- last balance from month transcation table -- Hardcode
	+ SUM(
		CASE 
			WHEN tsc_type = 'CDT' THEN -tsc_amt
			WHEN tsc_type = 'DBT' THEN +tsc_amt
		END
	)
	OVER (
		ORDER BY tsc_id DESC
		ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
	) AS reverse_balance

FROM [FinanceWarehouseAnalytics].[bank].acc1_tsc
ORDER BY tsc_id 
------------------------------------------------------------------
/*******************TRANSPORTATION ANALYSIS******************************/
-----------------------------------------------------
---View sum of Petrol consumption for a month -------
SELECT
	SUM(tsc_amt) AS total_petrol_expense
FROM bank.acc1_tsc
WHERE tsc_descrp = 'petrol'
	AND tsc_type = 'DBT'
	AND MONTH(tsc_dt) = 4
	AND YEAR(tsc_dt) = 2026;

---Amount Spend for transportation for a month-------
SELECT sum(tsc_amt), tsc_descrp, tsc_type
FROM bank.acc1_tsc
WHERE tsc_cat = 'Transportation' 
	AND MONTH(tsc_dt) = 4
	AND YEAR(tsc_dt) = 2026
group by tsc_descrp, tsc_type;

---Amount Spend for petrol & sustaining car for a month-------
SELECT 
    SUM(CASE 
            WHEN tsc_cat = 'transportation' 
                 AND tsc_descrp <> 'petrol'
				 AND MONTH(tsc_dt) = 4
				 AND YEAR(tsc_dt) = 2026
            THEN tsc_amt
            ELSE 0
        END) AS 'Total Sustaining',

    SUM(CASE 
            WHEN tsc_cat = 'transportation' 
                 AND tsc_descrp = 'petrol'
				 AND MONTH(tsc_dt) = 4
				 AND YEAR(tsc_dt) = 2026
            THEN tsc_amt
            ELSE 0
        END) AS 'Petrol Consumption'
FROM [FinanceWarehouseAnalytics].[bank].acc1_tsc;

---------------------------------------------------------------
/********************INCOME ANALYSIS*********************************/
--------Income By Date--------------------------
SELECT *
FROM [FinanceWarehouseAnalytics].[bank].acc1_tsc
WHERE tsc_cat='Income' 
AND MONTH(tsc_dt) = 4 AND YEAR(tsc_dt) = 2026

--------Total income into account------------------------------
SELECT sum(tsc_amt) AS total_income_amt
FROM [FinanceWarehouseAnalytics].[bank].acc1_tsc
WHERE tsc_cat='Income'
		AND MONTH(tsc_dt) = 4
		AND YEAR(tsc_dt) = 2026

/**********************CREDIT*********************************/
--------List of Credit into account----------------------------
SELECT *
FROM [FinanceWarehouseAnalytics].[bank].acc1_tsc
WHERE MONTH(tsc_dt) = 4 AND YEAR(tsc_dt) = 2026
AND tsc_type= 'CDT'

--------Total Credit into account----------------------------
SELECT sum(tsc_amt) AS 'Total Credited'
FROM [FinanceWarehouseAnalytics].[bank].acc1_tsc
WHERE MONTH(tsc_dt) = 4 AND YEAR(tsc_dt) = 2026
AND tsc_type= 'CDT'

-------Total Credit into account with Descrption---------------
SELECT sum(tsc_amt) AS 'Total Credited', tsc_descrp AS 'Details'
FROM [FinanceWarehouseAnalytics].[bank].acc1_tsc
WHERE tsc_type = 'CDT'
		AND MONTH(tsc_dt) = 4
		AND YEAR(tsc_dt) = 2026
group by tsc_descrp 
---------------------------------------------------------------
/**********************DEBIT ANALYSIS*********************************/
--------List of debit into account----------------------------
SELECT *
FROM [FinanceWarehouseAnalytics].[bank].acc1_tsc
WHERE MONTH(tsc_dt) = 4 AND YEAR(tsc_dt) = 2026
AND tsc_type= 'DBT'

--------Total debit into account----------------------------
SELECT sum(tsc_amt) AS 'Total Credited'
FROM [FinanceWarehouseAnalytics].[bank].acc1_tsc
WHERE MONTH(tsc_dt) = 4 AND YEAR(tsc_dt) = 2026
AND tsc_type= 'DBT'

-------Total debit into account with Category---------------
SELECT sum(tsc_amt) AS 'Total Credited', tsc_cat AS 'Category'
FROM [FinanceWarehouseAnalytics].[bank].acc1_tsc
WHERE tsc_type = 'DBT'
		AND MONTH(tsc_dt) = 4
		AND YEAR(tsc_dt) = 2026
group by tsc_cat 

-------Total debit into account with Descrption---------------
SELECT sum(tsc_amt) AS 'Total Credited', tsc_descrp AS 'Details'
FROM [FinanceWarehouseAnalytics].[bank].acc1_tsc
WHERE tsc_type = 'DBT'
		AND MONTH(tsc_dt) = 4
		AND YEAR(tsc_dt) = 2026
group by tsc_descrp 

---------------------------------------------------------------
/******************SPENDING ANALYSIS***********************/
-------Food Spending---------------
SELECT *
FROM [FinanceWarehouseAnalytics].[bank].acc1_tsc
WHERE tsc_cat='Food'

-------Food Spending by Type(Descripton)---------------
SELECT tsc_descrp,
    COUNT(tsc_descrp) AS unit_spending,
	SUM(tsc_amt) AS total_spending,
	CAST(
        SUM(tsc_amt) * 1.0 / COUNT(tsc_descrp)
        AS DECIMAL(8,2)
    ) AS mean_price
FROM [FinanceWarehouseAnalytics].[bank].acc1_tsc
WHERE tsc_cat='Food'
group by tsc_descrp

-------Food Spending by Type(Descripton)---------------
SELECT *
FROM (
    SELECT
        tsc_descrp,
        COUNT(*) AS unit_spending,
        SUM(tsc_amt) AS total_spending,
        CAST(
            SUM(tsc_amt) * 1.0 / COUNT(*)
            AS DECIMAL(8,2)
        ) AS mean_price
    FROM [FinanceWarehouseAnalytics].[bank].acc1_tsc
    WHERE tsc_cat = 'Food'
    GROUP BY tsc_descrp
) AS food_summary
WHERE total_spending > 50;

-------Food Indulgence Spending---------------
SELECT 
FORMAT(tsc_dt, 'd-MMM') AS 'date',
tsc_descrp, tsc_amt
FROM [FinanceWarehouseAnalytics].[bank].acc1_tsc
WHERE tsc_cat='Food' AND tsc_amt > 15

-------Food Indulgence Spending over date---------------
SELECT 
FORMAT(tsc_dt, 'd-MMM') AS 'date',
SUM(tsc_amt) AS amount_spend_day
FROM [FinanceWarehouseAnalytics].[bank].acc1_tsc
WHERE tsc_cat='Food' AND tsc_amt > 15
group by tsc_dt

-------Groceries Spending---------------
SELECT 
    *
FROM [FinanceWarehouseAnalytics].[bank].acc1_tsc
WHERE tsc_cat='Groceries'

-------Groceries Spending based on unit-item ---------------
SELECT 
    tsc_descrp 'items',
	SUM(tsc_amt) 'total',
	COUNT(tsc_descrp) AS unit
FROM [FinanceWarehouseAnalytics].[bank].acc1_tsc
WHERE tsc_cat='Groceries'
group by tsc_descrp
