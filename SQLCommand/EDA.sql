/**********************BANK****************************************/
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
	(tsc_end_bal + ttl_dbt - ttl_cdt) AS beginning_balance,
	tsc_end_bal
FROM [FinanceWarehouseAnalytics].[bank].[acc1_mth_tsc];

-----View transaction balance baseed on month transcation table-------------
SELECT
	*,
	-- Forward running balance (start from beginning)-------------
	1474.77 -- begin balance from month transcation table
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
	2031.37 -- last balance from month transcation table
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
/**********************TRANSPORTATION******************************/
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
/**********************INCOME*********************************/
---------------------------------------------------------------
--------Total Credit into account----------------------------
SELECT sum(tsc_amt) AS 'Total Credited'
FROM [FinanceWarehouseAnalytics].[bank].acc1_tsc
WHERE MONTH(tsc_dt) = 4 AND YEAR(tsc_dt) = 2026

-------Total Credit into account with Descrption---------------
SELECT sum(tsc_amt) AS 'Total Credited', tsc_descrp AS 'Details'
FROM [FinanceWarehouseAnalytics].[bank].acc1_tsc
WHERE tsc_type = 'CDT'
		AND MONTH(tsc_dt) = 4
		AND YEAR(tsc_dt) = 2026
group by tsc_descrp 

--------Total income into account------------------------------
SELECT sum(tsc_amt) AS total_income_amt
FROM [FinanceWarehouseAnalytics].[bank].acc1_tsc
WHERE tsc_type = 'CDT' AND NOT tsc_descrp='Refund-postpaid'
		AND MONTH(tsc_dt) = 4
		AND YEAR(tsc_dt) = 2026
---------------------------------------------------------------
