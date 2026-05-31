INSERT INTO [FinanceWarehouseAnalytics].[bank].acc1_mth_tsc
( tsc_mth_id, tsc_end_bal, ttl_cdt, ttl_dbt, tsc_mid_bal)
VALUES
    (526, 2031.37, 2708.40, 2151.80, 1158.27);


INSERT INTO [FinanceWarehouseAnalytics].[bank].[acc1_tsc]
( tsc_dt, tsc_cat,tsc_descrp, tsc_amt, tsc_type, amt_bal, tsc_mth_id)
VALUES
    ('2026-04-01', 'Transportation', 'petrol', '10.0', 'DBT', '1464.77', 526),
    ('2026-04-02', 'Transportation', 'petrol', '50.0', 'DBT', '1414.77', 526),
    ('2026-04-02', 'Clothing', 'sport-attire', '102.2', 'DBT', '1312.57', 526),
    ('2026-04-03', 'Food', 'junk-food', '5.8', 'DBT', '1306.77', 526),
    ('2026-04-03', 'Groceries', 'cigarrete', '1.3', 'DBT', '1305.47', 526),
    ('2026-04-04', 'Food', 'ice-cream', '44.5', 'DBT', '1260.97', 526),
    ('2026-04-04', 'Food', 'pizza', '30.0', 'DBT', '1230.97', 526),
    ('2026-04-05', '', '', '22.0', 'DBT', '1208.97', 526),
    ('2026-04-05', 'Transportation', 'petrol', '50.0', 'DBT', '1158.97', 526),
    ('2026-04-06', 'Income', 'bolt', '118.1', 'CDT', '1277.07', 526),
    ('2026-04-08', 'Food', 'coffee', '8.8', 'DBT', '1268.27', 526),
    ('2026-04-09', 'Transportation', 'petrol', '50.0', 'DBT', '1218.97', 526),
    ('2026-04-11', 'Transportation', 'psv-license', '20.0', 'DBT', '1198.27', 526),
    ('2026-04-12', 'Transportation', 'petrol', '40.0', 'DBT', '1158.27', 526),
    ('2026-04-13', 'Income', 'bolt', '119.94', 'CDT', '1278.21', 526),
    ('2026-04-13', 'Food', 'meal', '7.0', 'DBT', '1271.21', 526),
    ('2026-04-13', 'Groceries', 'cigarette', '1.2', 'DBT', '1271.21', 526),
    ('2026-04-14', 'Transportation', 'petrol', '49.99', 'DBT', '1220.02', 526),
    ('2026-04-14', 'Utilities', 'Refund-postpaid', '188.7', 'CDT', '1408.72', 526),
    ('2026-04-14', 'Food', 'coffee', '15.4', 'DBT', '1393.32', 526),
    ('2026-04-16', 'Transportation', 'petrol', '40.0', 'DBT', '1353.32', 526),
    ('2026-04-16', 'Food', 'coffee', '8.8', 'DBT', '1344.52', 526),
    ('2026-04-17', 'Transportation', 'petrol', '50.0', 'DBT', '1294.52', 526),
    ('2026-04-19', 'Transportation', 'petrol', '40.0', 'DBT', '1254.52', 526),
    ('2026-04-20', 'Income', 'bolt', '125.84', 'CDT', '1380.36', 526),
    ('2026-04-21', 'Transportation', 'petrol', '48.55', 'DBT', '1330.36', 526),
    ('2026-04-22', 'Food', 'coffee', '9.4', 'DBT', '1322.41', 526),
    ('2026-04-23', 'Income', 'cash-deposit', '1260.0', 'CDT', '2582.41', 526),
    ('2026-04-23', 'Groceries', 'food', '3.2', 'DBT', '2579.21', 526),
    ('2026-04-23', 'Groceries', 'food', '13.75', 'DBT', '2563.36', 526),
    ('2026-04-23', 'Transportation', 'petrol', '41.13', 'DBT', '2522.23', 526),
    ('2026-04-24', 'Food', 'coffee', '8.8', 'DBT', '2513.43', 526),
    ('2026-04-25', 'Groceries', 'household', '41.7', 'DBT', '2471.73', 526),
    ('2026-04-25', 'Groceries', 'household', '46.65', 'DBT', '2425.08', 526),
    ('2026-04-26', 'Income', 'grab', '420.38', 'CDT', '2845.46', 526),
    ('2026-04-26', 'Food', 'coffee', '34.0', 'DBT', '2811.46', 526),
    ('2026-04-27', 'Income', 'bolt', '8.34', 'CDT', '2819.8', 526),
    ('2026-04-28', 'Miscellaneous', 'meds', '30.5', 'DBT', '2789.3', 526),
    ('2026-04-26', 'Food', 'ice-cream', '35.0', 'DBT', '2754.3', 526),
    ('2026-04-28', 'Food', 'drink', '3.0', 'DBT', '2751.3', 526),
    ('2026-04-30', 'Transportation', 'petrol', '39.43', 'DBT', '2711.87', 526),
    ('2026-04-30', 'Groceries', 'food', '5.2', 'DBT', '2706.67', 526),
    ('2026-04-30', 'Food', 'meal', '11.0', 'DBT', '2695.67', 526),
    ('2026-04-30', 'Transportation', 'car-maintenance', '260.1', 'DBT', '2435.57', 526),
    ('2026-04-30', 'Loan', 'car', '400.0', 'DBT', '2035.57', 526),
    ('2026-04-30', 'Groceries', 'food', '4.2', 'DBT', '2031.37', 526);

INSERT INTO [FinanceWarehouseAnalytics].[bank].acc1_exps
( tsc_mth_id, acc1_exps_cat, acc1_exps_amt, acc1_exps_typ, acc1_exps_cls, acc1_exps_rmk)
VALUES
     (526, 'income', '2052.90', 'CDT', 'Source', 'need to find time that give the best impact'),
    (526, 'petrol', '509.10', 'DBT', 'Essential', NULL),
    (526, 'entertainment', '216.70', 'DBT', 'Non-essential', NULL),
    (526, 'Groceries', '110.35', 'DBT', 'Essential', NULL),
    (526, 'Food', '53.15', 'DBT', 'Essential', NULL),
    (526, 'Cigarette', '2.50', 'DBT', 'Non-Essential', NULL),
    (526, 'Clothing', '102.20', 'DBT', 'Essential', NULL),
    (526, 'PSV-renew', '20.00', 'DBT', 'Essential', NULL),
    (526, 'gift-med', '30.50', 'DBT', 'misc', NULL),
    (526, 'car-maintenance', '260.10', 'DBT', 'Essential', NULL),
    (526, 'loan-car', '400.00', 'DBT', 'Essential', NULL);
