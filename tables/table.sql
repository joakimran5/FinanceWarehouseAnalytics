/**************DROP TABLES SEQUENCES*************************/
/*Drop Child-Parent Rel Tables.*/
IF OBJECT_ID ('wallet.hnd_csh', 'U') IS NOT NULL
	DROP TABLE wallet.hnd_csh;
IF OBJECT_ID ('wallet.rsv_csh', 'U') IS NOT NULL
	DROP TABLE wallet.rsv_csh;
IF OBJECT_ID ('invest.asb_tsc', 'U') IS NOT NULL
	DROP TABLE invest.asb_tsc;
IF OBJECT_ID ('debt.ln_tsc', 'U') IS NOT NULL
	DROP TABLE debt.ln_tsc;
IF OBJECT_ID ('bank.acc1_exps', 'U') IS NOT NULL
	DROP TABLE bank.acc1_exps;
IF OBJECT_ID ('bank.acc1_tsc', 'U') IS NOT NULL
	DROP TABLE bank.acc1_tsc;
IF OBJECT_ID ('bank.acc1_mth_tsc', 'U') IS NOT NULL
	DROP TABLE bank.acc1_mth_tsc;
IF OBJECT_ID ('wallet.tng_tsc', 'U') IS NOT NULL
	DROP TABLE wallet.tng_tsc;
IF OBJECT_ID ('payment.rcpt_dtls', 'U') IS NOT NULL
	DROP TABLE payment.rcpt_dtls;
IF OBJECT_ID ('payment.bill', 'U') IS NOT NULL
	DROP TABLE payment.bill;
IF OBJECT_ID ('payment.warranty', 'U') IS NOT NULL
	DROP TABLE payment.warranty;
IF OBJECT_ID ('payment.rcpts', 'U') IS NOT NULL
	DROP TABLE payment.rcpts;

/**************************************************************/
----------------------PAYMENT----------------------------------
/**************************************************************/
/*Create Table for receipts id*/
CREATE TABLE payment.rcpts (
	rcpt_id INT PRIMARY KEY IDENTITY(1,1), --01
	rcpt_name NVARCHAR(50) 
);

/*Create Table for payment need to monitor items prices*/
CREATE TABLE payment.rcpt_dtls (
	rcpt_dtl_id INT PRIMARY KEY IDENTITY(1,1),
	item_name NVARCHAR(100), 
	item_amt DECIMAL(8,2),  
	item_typ NVARCHAR(30), 
	rcpt_ref NVARCHAR(30), 
	rcpt_rmk NVARCHAR(500), 
	rcpt_id INT 
	FOREIGN KEY (rcpt_id)
		REFERENCES payment.rcpts(rcpt_id)
);

/*Create Table for bill Information*/
IF OBJECT_ID ('payment.bill_info', 'U') IS NOT NULL
	DROP TABLE payment.bill_info;
CREATE TABLE payment.bill_info (
	bill_info_id INT PRIMARY KEY IDENTITY(1,1),
	bill_name NVARCHAR(50), 
	bill_duration NVARCHAR(100),
	acc_no INT
);

/*Create Table for every bill payment*/
CREATE TABLE payment.bill (
	bil_pymt_id INT PRIMARY KEY IDENTITY(1,1),
	item_name NVARCHAR(30), 
	bal_pmt DECIMAL(8,2),  
	bill_rmk NVARCHAR(500),
	bill_no INT, 
	rcpt_id INT
	FOREIGN KEY (rcpt_id)
		REFERENCES payment.rcpts(rcpt_id),
	bill_info_id INT
	FOREIGN KEY (bill_info_id)
		REFERENCES payment.bill_info(bill_info_id)
);

/*Create Table for payment that have warranty*/
CREATE TABLE payment.warranty (
	warranty_id INT PRIMARY KEY IDENTITY(1,1), 
	strt_date DATE, -- 1/6/2026
	end_date DATE, -- 1/6/2029
	warranty_rmk NVARCHAR(500),
	rcpt_id INT 
	FOREIGN KEY (rcpt_id)
		REFERENCES payment.rcpts(rcpt_id)
);

/**************************************************************/
-------------------------BANK ACCOUNT-------------------------
/**************************************************************/
/*Create Table for summary monthly transaction*/
CREATE TABLE bank.acc1_mth_tsc (
	tsc_mth_id INT PRIMARY KEY,
	tsc_mth_dt DATE,
	tsc_end_bal  DECIMAL(8,2),
	ttl_cdt  DECIMAL(8,2),
	ttl_dbt  DECIMAL(8,2),
	tsc_mid_bal  DECIMAL(8,2)
);

/*Create Table for every transaction*/
CREATE TABLE bank.acc1_tsc (
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

/*Create Table of Bank Account expenses*/
CREATE TABLE bank.acc1_exps (
	tsc_mth_id INT,
	acc1_exps_cat NVARCHAR(30),
	acc1_exps_amt DECIMAL(8,2),
	acc1_exps_typ NVARCHAR(3),
	acc1_exps_cls NVARCHAR(50),
	acc1_exps_rmk NVARCHAR(500),
	acc1_exps_id  INT PRIMARY KEY IDENTITY(1,1),
	FOREIGN KEY (tsc_mth_id)
		REFERENCES bank.acc1_mth_tsc(tsc_mth_id)
);

/**************************************************************/
----------------------WALLET-------------------------------------
/**************************************************************/
/*Create table for E-wallet */
CREATE TABLE wallet.tng_tsc (
	tsc_id INT PRIMARY KEY IDENTITY(1,1),
	tsc_dt DATE,
	tsc_descrp NVARCHAR(50),
	tsc_amt DECIMAL(8,2),
	tsc_type NVARCHAR(3),
	amt_bal DECIMAL(8,2),
	rcpt_id INT
	FOREIGN KEY (rcpt_id)
		REFERENCES payment.rcpts(rcpt_id)
);

/*Create table for Reserve Cash */
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
	rsv_typ NVARCHAR(3),
	tsc_id INT NULL
		FOREIGN KEY (tsc_id)
		REFERENCES bank.acc1_tsc(tsc_id)
);

/*Create table for Cash in wallet*/
CREATE TABLE wallet.hnd_csh (
	csh_id INT PRIMARY KEY IDENTITY(1,1),
	csh_dt DATE,
	csh_amt DECIMAL(5,2),
	csh_dscrp NVARCHAR(30),
	csh_typ NVARCHAR(3),
	rsv_id INT  -- CDT/DBT --
		FOREIGN KEY (rsv_id)
		REFERENCES wallet.rsv_csh(rsv_id),
	rcpt_id INT  -- DBT ---
		FOREIGN KEY (rcpt_id)
		REFERENCES payment.rcpts(rcpt_id)
);

/***************************************************************/
----------------------INVESTMENT---------------------------------
/**************************************************************/
/*Drop table that have FK with ASB account info*/
IF OBJECT_ID ('invest.asb_year_rt', 'U') IS NOT NULL
	DROP TABLE invest.asb_year_rt;
/*Create table for ASB account info*/
IF OBJECT_ID ('invest.asb_acc_info', 'U') IS NOT NULL
	DROP TABLE invest.asb_acc_info;
CREATE TABLE invest.asb_acc_info (
	asb_id INT PRIMARY KEY IDENTITY(1,1),
	asb_code VARCHAR(10) UNIQUE,
	asb_name VARCHAR(50),
	asb_type VARCHAR(10)
);

/*Create table for ASB every year rate and balance*/
CREATE TABLE invest.asb_year_rt (
	asb_rt_id INT PRIMARY KEY IDENTITY(1,1),
	asb_id INT,
	asb_year INT,
	asb_rt DECIMAL(4,2),
	asb_amt DECIMAL(8,2),
	FOREIGN KEY (asb_id)
		REFERENCES invest.asb_acc_info(asb_id),
	UNIQUE (asb_id, asb_year)
);

/*Create table for ASB transactions */
CREATE TABLE invest.asb_tsc (
	asb_tsc_id INT PRIMARY KEY IDENTITY(1,1),
	asb_id INT,
	amt_bal DECIMAL(8,2), 
	bank_tsc_id INT NULL,
	tng_tsc_id INT NULL,
		FOREIGN KEY (asb_id)
				REFERENCES invest.asb_acc_info(asb_id),
		FOREIGN KEY (bank_tsc_id)
			REFERENCES bank.acc1_tsc(tsc_id),
		FOREIGN KEY (tng_tsc_id)
			REFERENCES wallet.tng_tsc(tsc_id)
);

/***************************************************************/
-------------------------DEBT-----------------------------------
/**************************************************************/
/*Create table for loan account info*/
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

/*Create table for loan transactions*/
CREATE TABLE debt.ln_tsc (
	ln_tsc_id INT PRIMARY KEY IDENTITY(1,1),
	tsc_id INT,
	ln_id INT,
	amt_bal DECIMAL(8,2), 
	out_amt DECIMAL(8,2),
		FOREIGN KEY (ln_id)
				REFERENCES debt.ln_acc_info(ln_id),
		FOREIGN KEY (tsc_id)
		REFERENCES bank.acc1_tsc(tsc_id)
);
/**************************************************************/
