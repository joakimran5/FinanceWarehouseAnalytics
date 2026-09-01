/*Create Gold Layer Table for bank transaction*/
IF OBJECT_ID ('gold.tsc', 'U') IS NOT NULL
	DROP TABLE gold.tsc;
CREATE TABLE gold.tsc (
	tsc_id INT PRIMARY KEY IDENTITY(1,1),
	tsc_dt DATE,
	tsc_cat NVARCHAR(30),
	tsc_descrp NVARCHAR(50),
	tsc_amt DECIMAL(8,2),
	tsc_type NVARCHAR(3),
  tsc_origin NVARCHAR(10)  --Bank/Tng
);


/*Create Silver Layer Table for bank transaction*/
IF OBJECT_ID ('silver.acc1_tsc', 'U') IS NOT NULL
	DROP TABLE silver.acc1_tsc;
CREATE TABLE silver.acc1_tsc (
	tsc_id INT PRIMARY KEY IDENTITY(1,1),
	tsc_dt DATE,
	tsc_cat NVARCHAR(30),
	tsc_descrp NVARCHAR(50),
	tsc_amt DECIMAL(8,2),
	tsc_type NVARCHAR(3),
	amt_bal DECIMAL(8,2),
	tsc_mth_id INT
	FOREIGN KEY (tsc_mth_id)
		REFERENCES bank.acc1_mth_tsc(tsc_mth_id),
	rcpt_id INT
	FOREIGN KEY (rcpt_id)
		REFERENCES payment.rcpts(rcpt_id)
);

/*Create  Silver Layer Table for TnG transaction*/
IF OBJECT_ID ('silver.tng_tsc', 'U') IS NOT NULL
	DROP TABLE silver.tng_tsc;
CREATE TABLE silver.tng_tsc (
	tsc_id INT PRIMARY KEY IDENTITY(1,1),
	tsc_dt DATE,
	tsc_cat NVARCHAR(30),
	tsc_descrp NVARCHAR(50),
	tsc_amt DECIMAL(8,2),
	tsc_type NVARCHAR(3),
	amt_bal DECIMAL(8,2),
	rcpt_id INT
	FOREIGN KEY (rcpt_id)
		REFERENCES payment.rcpts(rcpt_id)
);
