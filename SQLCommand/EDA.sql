/****** Script for SelectTop Rows command from SSMS  ******/
SELECT tsc_dt,tsc_cat, tsc_descrp, tsc_amt,amt_bal
  FROM [FinanceWarehouseAnalytics].[bank].acc1_tsc
  where tsc_descrp = 'petrol'

---Amount Spend for transportation-------
(SELECT SUM(tsc_amt) AS total_amt, tsc_descrp
FROM [FinanceWarehouseAnalytics].[bank].acc1_tsc
WHERE tsc_cat = 'transportation' AND not tsc_descrp='petrol'
group by tsc_descrp)
UNION
(SELECT SUM(tsc_amt), tsc_descrp
FROM [FinanceWarehouseAnalytics].[bank].acc1_tsc
WHERE tsc_cat = 'transportation'AND tsc_descrp='petrol'
group by tsc_descrp)

---Amount Spend for petrol & sustaining-------
SELECT 
    SUM(CASE 
            WHEN tsc_cat = 'transportation' 
                 AND tsc_descrp <> 'petrol'
            THEN tsc_amt
            ELSE 0
        END) AS sustain_amt,

    SUM(CASE 
            WHEN tsc_cat = 'transportation' 
                 AND tsc_descrp = 'petrol'
            THEN tsc_amt
            ELSE 0
        END) AS petrol_amt
FROM [FinanceWarehouseAnalytics].[bank].acc1_tsc;

SELECT sum(tsc_amt) AS total_amt, tsc_descrp
FROM [FinanceWarehouseAnalytics].[bank].acc1_tsc
WHERE tsc_type = 'CDT' AND NOT tsc_descrp= 'Refund-postpaid'
group by tsc_descrp 

SELECT sum(tsc_amt) AS total_income_amt
FROM [FinanceWarehouseAnalytics].[bank].acc1_tsc
WHERE tsc_descrp= 'grab' or tsc_descrp= 'bolt'

SELECT sum(tsc_amt) AS total_amt, tsc_descrp
FROM [FinanceWarehouseAnalytics].[bank].acc1_tsc
WHERE tsc_type = 'CDT' AND NOT tsc_descrp= 'Refund-postpaid'
group by tsc_descrp 

SELECT sum(tsc_amt) AS total_income_amt
FROM [FinanceWarehouseAnalytics].[bank].acc1_tsc
WHERE tsc_descrp= 'grab' or tsc_descrp= 'bolt'


