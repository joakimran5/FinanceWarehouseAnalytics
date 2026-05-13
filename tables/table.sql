/**************************************************************/
-------------------------BANK ACCOUNT-------------------------
/**************************************************************/
/*Drop all tables that associate with Account as Foreign Key*/
IF OBJECT_ID ('wallet.rsv_csh', 'U') IS NOT NULL
	DROP TABLE wallet.rsv_csh;
IF OBJECT_ID ('invest.asb_tsc', 'U') IS NOT NULL
	DROP TABLE invest.asb_tsc;
IF OBJECT_ID ('debt.ln_tsc', 'U') IS NOT NULL
	DROP TABLE debt.ln_tsc;
/*Transitive FK as smp_acc1_tsc rely on acc1_mth_tsc and acc1_mth_tsc rely on acc1_tsc*/
IF OBJECT_ID ('bank.smp_acc1_tsc', 'U') IS NOT NULL
	DROP TABLE bank.smp_acc1_tsc;
IF OBJECT_ID ('bank.acc1_mth_tsc', 'U') IS NOT NULL
	DROP TABLE bank.acc1_mth_tsc;

/*Create Table for Bank Account transaction*/
IF OBJECT_ID ('bank.acc1_tsc', 'U') IS NOT NULL
	DROP TABLE bank.acc1_tsc;
CREATE TABLE bank.acc1_tsc (
	tsc_id INT PRIMARY KEY IDENTITY(1,1),
	tsc_dt DATE,
	tsc_cat NVARCHAR(30),
	tsc_descrp NVARCHAR(50),
	tsc_amt DECIMAL(8,2),
	tsc_type NVARCHAR(3),
	amt_bal DECIMAL(8,2)
);

/*Create Table for every Bank Account for summary of monthly transaction*/
CREATE TABLE bank.acc1_mth_tsc (
	tsc_mth_id INT PRIMARY KEY IDENTITY(1,1),
	tsc_mth_dt NVARCHAR(10),
	tsc_end_bal  DECIMAL(8,2),
	ttl_cdt  DECIMAL(8,2),
	ttl_dbt  DECIMAL(8,2),
	tsc_mid_bal  DECIMAL(8,2),
	tsc_id INT
	FOREIGN KEY (tsc_id)
		REFERENCES bank.acc1_tsc(tsc_id)
);

/*Create Table of simplified version of Bank Account transaction*/
CREATE TABLE bank.smp_acc1_tsc (
	tsc_smp_id INT PRIMARY KEY,
	tsc_smp_cat NVARCHAR(30),
	tsc_smp_amt DECIMAL(8,2),
	tsc_smp_type NVARCHAR(3),
	FOREIGN KEY (tsc_smp_id)
		REFERENCES bank.acc1_mth_tsc(tsc_mth_id)
);

/**************************************************************/
----------------------WALLET-------------------------------------
/**************************************************************/
/*Create table for E-wallet */
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
	tsc_id INT NULL
		FOREIGN KEY (tsc_id)
		REFERENCES bank.acc1_tsc(tsc_id)
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
			REFERENCES bank.acc1_tsc(tsc_id)
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
