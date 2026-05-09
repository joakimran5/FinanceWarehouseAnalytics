IF OBJECT_ID ('bank.acc1_tsc_info', 'U') IS NOT NULL
	DROP TABLE bank.acc1_tsc_info;
CREATE TABLE bank.acc1_tsc_info (
tsc_id INT PRIMARY KEY IDENTITY(1,1),
tsc_dt DATE,
tsc_descrp NVARCHAR(50),
tsc_amt DECIMAL(8,2),
tsc_type NVARCHAR(3),
amt_bal DECIMAL(8,2)
);

IF OBJECT_ID ('wallet.tng_tsc_info', 'U') IS NOT NULL
	DROP TABLE wallet.tng_tsc_info;
CREATE TABLE wallet.tng_tsc_info (
tsc_id INT PRIMARY KEY IDENTITY(1,1),
tsc_dt DATE,
tsc_descrp NVARCHAR(50),
tsc_amt DECIMAL(8,2),
tsc_type NVARCHAR(3),
amt_bal DECIMAL(8,2)
);

IF OBJECT_ID ('wallet.rsv_info', 'U') IS NOT NULL
	DROP TABLE wallet.rsv_info;
CREATE TABLE wallet.rsv_info (
rsv_id INT,
rsv_dt DATE,
rsv_amt INT,
rsv_RM1 INT,
rsv_RM5 INT,
rsv_RM10 INT,
rsv_RM20 INT,
rsv_RM50 INT,
rsv_RM100 INT,
tsc_id INT,
FOREIGN KEY (tsc_id)
REFERENCES bank.acc1_tsc_info(tsc_id)
);

IF OBJECT_ID ('debt.ln_acc_info', 'U') IS NOT NULL
	DROP TABLE debt.ln_acc_info;
CREATE TABLE debt.ln_acc_info (
ln_id INT PRIMARY KEY,
ln_type CHAR(3),
ln_amt DECIMAL(8,2),
ln_dur INT,
ln_rt DECIMAL(4,2)
);

IF OBJECT_ID ('debt.ln_tsc_info', 'U') IS NOT NULL
	DROP TABLE debt.ln_tsc_info;
CREATE TABLE debt.ln_tsc_info (
	ln_tsc_id INT PRIMARY KEY IDENTITY(1,1),
	tsc_id INT,
	ln_id INT,
	tsc_amt DECIMAL(8,2),
	amt_bal DECIMAL(8,2), 
	ln_out DECIMAL(8,2),
		FOREIGN KEY (ln_id)
				REFERENCES debt.ln_acc_info(ln_id),
		FOREIGN KEY (tsc_id)
		REFERENCES bank.acc1_tsc_info(tsc_id)
);
