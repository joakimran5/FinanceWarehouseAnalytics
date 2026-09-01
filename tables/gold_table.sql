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
  	tsc_source NVARCHAR(10)  --Bank/Tng
);
