IF OBJECT_ID ('wallet.tng_tsc', 'U') IS NOT NULL
	DROP TABLE wallet.tng_tsc;
CREATE TABLE wallet.tng_tsc (
	tsc_id INT PRIMARY KEY IDENTITY(1,1),
	tsc_dt DATE,
	tsc_descrp NVARCHAR(50),
	tsc_amt DECIMAL(8,2),
	tsc_type NVARCHAR(3),
	amt_bal DECIMAL(8,2)
);

IF OBJECT_ID ('wallet.rsv_csh', 'U') IS NOT NULL
	DROP TABLE wallet.rsv_csh;
CREATE TABLE wallet.rsv_csh (
	rsv_id INT PRIMARY KEY IDENTITY(1,1),
	rsv_dt DATE,
	rsv_amt INT,
	rsv_RM1 INT,
	rsv_RM5 INT,
	rsv_RM10 INT,
	rsv_RM20 INT,
	rsv_RM50 INT,
	rsv_RM100 INT,
	tsc_id INT
		FOREIGN KEY (tsc_id)
		REFERENCES bank.acc1_tsc(tsc_id)
);



IF OBJECT_ID ('debt.ln_tsc', 'U') IS NOT NULL
	DROP TABLE debt.ln_tsc;
CREATE TABLE debt.ln_tsc (
	ln_tsc_id INT PRIMARY KEY IDENTITY(1,1),
	tsc_id INT,
	ln_id INT,
	tsc_amt DECIMAL(8,2),
	amt_bal DECIMAL(8,2), 
	ln_out DECIMAL(8,2),
		FOREIGN KEY (ln_id)
				REFERENCES debt.ln_acc_info(ln_id),
		FOREIGN KEY (tsc_id)
		REFERENCES bank.acc1_tsc(tsc_id)
);





IF OBJECT_ID ('invest.asb_tsc', 'U') IS NOT NULL
	DROP TABLE invest.asb_tsc;
CREATE TABLE invest.asb_tsc (
	asb_tsc_id INT PRIMARY KEY IDENTITY(1,1),
	asb_id INT,
	tsc_dt DATE,
	tsc_amt DECIMAL(8,2),
	amt_bal DECIMAL(8,2), 
	bank_tsc_id INT NULL,
		FOREIGN KEY (asb_id)
				REFERENCES invest.asb_acc_info(asb_id),
		FOREIGN KEY (bank_tsc_id)
			REFERENCES bank.acc1_tsc(tsc_id)
);





IF OBJECT_ID ('debt.ln_acc_info', 'U') IS NOT NULL
	DROP TABLE debt.ln_acc_info;
CREATE TABLE debt.ln_acc_info (
	ln_id INT PRIMARY KEY IDENTITY(1,1),
	ln_code VARCHAR(10) UNIQUE,
	ln_type CHAR(3),
	ln_amt DECIMAL(8,2),
	ln_dur INT,
	ln_rt DECIMAL(4,2)
);

IF OBJECT_ID ('bank.acc1_tsc', 'U') IS NOT NULL
	DROP TABLE bank.acc1_tsc;
CREATE TABLE bank.acc1_tsc (
	tsc_id INT PRIMARY KEY IDENTITY(1,1),
	tsc_dt DATE,
	tsc_descrp NVARCHAR(50),
	tsc_amt DECIMAL(8,2),
	tsc_type NVARCHAR(3),
	amt_bal DECIMAL(8,2)
);

IF OBJECT_ID ('invest.asb_acc_info', 'U') IS NOT NULL
	DROP TABLE invest.asb_acc_info;
CREATE TABLE invest.asb_acc_info (
	asb_id INT PRIMARY KEY IDENTITY(1,1),
	asb_code VARCHAR(10) UNIQUE,
	asb_name VARCHAR(50),
	asb_year INT,
	asb_rt DECIMAL(4,2),
	asb_type VARCHAR(10),
	asb_amt DECIMAL(9,2)
);
