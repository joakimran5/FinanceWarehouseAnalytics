SELECT *
  FROM [FinanceWarehouseAnalytics].[bank].[acc1_tsc]

INSERT INTO [FinanceWarehouseAnalytics].[bank].[acc1_tsc]
( tsc_dt, tsc_descrp, tsc_amt, tsc_type, amt_bal)
VALUES
( '2026/04/02', 'petrol', 60, 'DBT', 1414.77);

--DELETE FROM [FinanceWarehouseAnalytics].[bank].[acc1_tsc] 
--WHERE tsc_id = 2;
