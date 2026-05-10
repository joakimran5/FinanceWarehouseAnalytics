SELECT *
  FROM [FinanceWarehouseAnalytics].[bank].[acc1_tsc]

INSERT INTO [FinanceWarehouseAnalytics].[bank].[acc1_tsc]
( tsc_dt, tsc_descrp, tsc_amt, tsc_type, amt_bal)
VALUES
( '02/04/2026', 'petrol', 60, 'DBT', 1414.77);

--DELETE FROM [FinanceWarehouseAnalytics].[bank].[acc1_tsc] 
--WHERE tsc_id = 2;
