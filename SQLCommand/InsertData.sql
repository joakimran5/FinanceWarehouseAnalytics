SELECT *
  FROM [FinanceWarehouseAnalytics].[bank].[acc1_tsc]
INSERT INTO [FinanceWarehouseAnalytics].[bank].[acc1_tsc]
  
( tsc_dt, tsc_cat,tsc_descrp, tsc_amt, tsc_type, amt_bal)
VALUES
( '2026/04/04','Food', 'pizza', 0.00, 'DBT', 0.00),
( '2026/04/05',NULL, NULL, 0.00, 'DBT', 0.00),
( '2026/04/05','Transportation', 'petrol', 0.00, 'DBT', 0.00),
( '2026/04/06','Income', 'bolt', 0.00, 'CDT', 0.00),
( '2026/04/08','Food', 'coffee', 00.00, 'DBT', 0.00),
( '2026/04/09','Transportation', 'petrol', 0.00, 'DBT', 0.00),
( '2026/04/11','Transportation', 'psv-license', 0.00, 'DBT', 0.00),
( '2026/04/12','Transportation', 'petrol', 0.00, 'DBT', 0.00);

--DELETE FROM [FinanceWarehouseAnalytics].[bank].[acc1_tsc] 
--WHERE tsc_id = 2;
