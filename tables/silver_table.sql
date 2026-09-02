/*Create Silver Layer Table for bank transaction*/
IF OBJECT_ID ('silver.acc1_tsc', 'U') IS NOT NULL
	DROP TABLE silver.acc1_tsc;
CREATE TABLE silver.acc1_tsc (
	tsc_id INT PRIMARY KEY,
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
	tsc_id INT PRIMARY KEY,
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

/*Create  Silver Layer Table for rcpt details*/
IF OBJECT_ID ('silver.[rcpt_dtls]', 'U') IS NOT NULL
	DROP TABLE silver.[rcpt_dtls];
CREATE TABLE silver.rcpt_dtls (
	rcpt_dtl_id INT PRIMARY KEY,
	[item_typ] NVARCHAR(50),  --rice
	[item_brand] NVARCHAR(50), -- JATI ISTIMEWA
	[item_variants] NVARCHAR(50), -- beras putih/ beras siam/hairfall
	[item_unit] NVARCHAR(50), --- 10KG/2*140g
	[item_qty] NVARCHAR(50),  --- 1 pieces
	[ttl_price] DECIMAL(8,2), -- 38.3 
	[item_cat]  NVARCHAR(50),  -- dry-goods/dishware/fresh-goods/body-bath
	item_rmk NVARCHAR(100), -- discount 45%
	[rcpt_id] INT
	FOREIGN KEY (rcpt_id)
		REFERENCES payment.rcpts(rcpt_id)
);
