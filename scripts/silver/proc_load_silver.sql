EXEC silver.load_silver

CREATE OR ALTER PROCEDURE silver.load_silver AS
BEGIN
	DECLARE @start_time DATETIME, @end_time DATETIME, @batch_start_time DATETIME, @batch_end_time DATETIME;
	BEGIN TRY
		SET @batch_start_time = GETDATE();
		PRINT '================================================================';
		PRINT 'Loading Silver Layer';
		PRINT '================================================================';

		PRINT '----------------------------------------------------------------';
		PRINT 'Loading CRM Tables';
		PRINT '----------------------------------------------------------------';
		PRINT '###########################################1###############################################'
		-- Loading [silver].[rcpt_dtls]
		SET @start_time = GETDATE();
		PRINT '>> Truncating Table: [silver].[rcpt_dtls]'
		TRUNCATE TABLE [FinanceWarehouseAnalytics].[silver].[rcpt_dtls]
		PRINT '>> Inserting Data into [silver].[rcpt_dtls]'
		INSERT INTO [FinanceWarehouseAnalytics].[silver].[rcpt_dtls](
			[item_name],
      [item_amt],
      [item_typ],
      [rcpt_ref],[rcpt_rmk],[rcpt_id])
		SELECT 
      tsc_id,
      tsc_dt
      CASE WHEN TRIM(tsc_cat) = 'car' THEN 'Car'
			 WHEN TRIM(tsc_cat) = '' OR tsc_cat IS NULL THEN 'n/a'
			 ELSE TRIM(tsc_cat)
		  --ISNULL(tsc_cat, 'n/a') AS tsc_cat
      --ISNULL(tsc_descrp, 'n/a') AS tsc_descrp
			FROM bank.acc1_tsc
			WHERE tsc_id IS NOT NULL
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '>> -----------------------';
