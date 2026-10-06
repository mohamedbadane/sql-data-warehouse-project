if OBJECT_ID('bronze.crm_prd_info ' , 'u') is not null
	drop table bronze.crm_prd_info ;
	-- si la table existe suprrimer la table et re la creer
create table bronze.crm_prd_info (
	prd_id INT,
	prd_key NVARCHAR(50),
	prd_nm NVARCHAR(50),
	prd_cost INT,
	prd_line NVARCHAR(50),
	prd_start_dt  DATETIME,
	prd_end_dt DATETIME
);

create table bronze.crm_sales_details (
	sls_ord_num  NVARCHAR(50),
	sls_prd_key NVARCHAR(50),
	sls_cust_id INT,
	sls_order_dt INT,
	sls_ship_dt INT,
	sls_due_dt INT,
	sls_sales INT,
	sls_quantity INT,
	sls_price INT
);

create table bronze.erp_loc_a101 (
	cid  NVARCHAR(50),
	cntry NVARCHAR(50),
	
);
create table bronze.erp_cust_az12 (
	cid  NVARCHAR(50),
	bdate DATE,
	cntry NVARCHAR(50)
	
);

create table bronze.erp_px_cat_g1v2 (
	id  NVARCHAR(50),
	cat NVARCHAR(50),
	subcat NVARCHAR(50),
	maintenance NVARCHAR(50)
	
);

--inserer bcp de ligne dans une seule commande 
truncate table bronze.crm_cust_info
  BULK INSERT bronze.crm_cust_info
  from 'C:\Users\simob\Documents\Data_enginnering\sql-data-warehouse-project-main\datasets\source_crm\cust_info.csv'
  WITH (
       
	   FIRSTROW = 2, -- ON DIT LA BASE  de donnes qu les donnes comment a partir de la 2eme ligne car la 1er contient header
       FIELDTERMINATOR = ',',--deliimeter du fichier , 
	   TABLOCK
  );

  select count(*) from bronze.crm_cust_info

truncate table bronze.crm_prd_info
  BULK INSERT  bronze.crm_prd_info
  from 'C:\Users\simob\Documents\Data_enginnering\sql-data-warehouse-project-main\datasets\source_crm\prd_info.csv'
  WITH (
       
	   FIRSTROW = 2, 
       FIELDTERMINATOR = ',', 
	   TABLOCK
  );

 select count(*) from  bronze.crm_prd_info


  truncate table bronze.crm_sales_details
  BULK INSERT  bronze.crm_sales_details
  from 'C:\Users\simob\Documents\Data_enginnering\sql-data-warehouse-project-main\datasets\source_crm\sales_details.csv'
  WITH (
       
	   FIRSTROW = 2, 
       FIELDTERMINATOR = ',', 
	   TABLOCK
  );

  select count(*) from  bronze.crm_sales_details


  truncate table bronze.erp_cust_az12
  BULK INSERT  bronze.erp_cust_az12
  from 'C:\Users\simob\Documents\Data_enginnering\sql-data-warehouse-project-main\datasets\source_erp\CUST_AZ12.csv'
  WITH (
       
	   FIRSTROW = 2, 
       FIELDTERMINATOR = ',', 
	   TABLOCK
  );
  select count(*) from bronze.erp_cust_az12;

  
  truncate table bronze.erp_loc_a101
  BULK INSERT bronze.erp_loc_a101
  from 'C:\Users\simob\Documents\Data_enginnering\sql-data-warehouse-project-main\datasets\source_erp\LOC_A101.csv'
  WITH (
       
	   FIRSTROW = 2, 
       FIELDTERMINATOR = ',', 
	   TABLOCK
  );
  select count(*) from bronze.erp_loc_a101;


  
  truncate table bronze.erp_px_cat_g1v2
  BULK INSERT  bronze.erp_px_cat_g1v2
  from 'C:\Users\simob\Documents\Data_enginnering\sql-data-warehouse-project-main\datasets\source_erp\PX_CAT_G1V2.csv'
  WITH (
       
	   FIRSTROW = 2, 
       FIELDTERMINATOR = ',', 
	   TABLOCK
  );
  select count(*) from bronze.erp_px_cat_g1v2;
------------------------------------------------------------------------
--precodure---

CREATE OR ALTER PROCEDURE  bronze.load_bronze AS
BEGIN 
     DECLARE @start_time DATETIME, @end_time DATETIME,@batch_start_time DATETIME,@batch_end_time DATETIME
     BEGIN TRY
	 SET @batch_start_time
		 print '============================================================='	
		  print 'Loading Bronze Layer'
		  print'=============================================================='


		  print '--------------------------------------------------------------'	
		  print 'Loading CRM Tables'
		  print '--------------------------------------------------------------'

		  SET @start_time = GETDATE();
		  print' ** truncating Table : bronze.crm_cust_info '

		  truncate table bronze.crm_cust_info

		   print' ** INSERTING DATA INTO : bronze.crm_cust_info '
		  BULK INSERT bronze.crm_cust_info
		  from 'C:\Users\simob\Documents\Data_enginnering\sql-data-warehouse-project-main\datasets\source_crm\cust_info.csv'
		  WITH (
       
			   FIRSTROW = 2, -- ON DIT LA BASE  de donnes qu les donnes comment a partir de la 2eme ligne car la 1er contient header
			   FIELDTERMINATOR = ',',--deliimeter du fichier , 
			   TABLOCK
		  );
		  SET @end_time = GETDATE();
		  print'**-- LOAD DURATION : ' + CAST(DATEDIFF(second,@start_time,@end_time) as NVARCHAR ) + 'seconds' 
		  print '-------------------------------------------------------------------------------'
		  
		  SET @start_time = GETDATE();
		  print' ** truncating Table : bronze.crm_prd_info '
		  truncate table bronze.crm_prd_info;

		  print' ** INSERTING DATA INTO : bronze.crm_prd_info '
		  BULK INSERT  bronze.crm_prd_info
		  from 'C:\Users\simob\Documents\Data_enginnering\sql-data-warehouse-project-main\datasets\source_crm\prd_info.csv'
		  WITH (
       
			   FIRSTROW = 2, 
			   FIELDTERMINATOR = ',', 
			   TABLOCK
		  );
		   SET @end_time = GETDATE();
		  print'**-- LOAD DURATION : ' + CAST(DATEDIFF(second,@start_time,@end_time) as NVARCHAR ) + 'seconds' 
		  print '-------------------------------------------------------------------------------'

		  SET @start_time = GETDATE();
		  print' ** truncating Table : bronze.crm_sales_details '
		  truncate table bronze.crm_sales_details;
		  print' ** INSERTING DATA INTO : bronze.crm_sales_details '
		  BULK INSERT  bronze.crm_sales_details
		  from 'C:\Users\simob\Documents\Data_enginnering\sql-data-warehouse-project-main\datasets\source_crm\sales_details.csv'
		  WITH (
       
			   FIRSTROW = 2, 
			   FIELDTERMINATOR = ',', 
			   TABLOCK
		  );
		  SET @end_time = GETDATE();
          print'**-- LOAD DURATION : ' + CAST(DATEDIFF(second,@start_time,@end_time) as NVARCHAR ) + 'seconds' 
          print '-------------------------------------------------------------------------------'
		  
		  print '--------------------------------------------------------------'	
		  print 'Loading ERP Tables'
		  print '--------------------------------------------------------------'

		  SET @start_time = GETDATE();
		  print' ** truncating Table : bronze.erp_cust_az12 '
		  truncate table bronze.erp_cust_az12;
		  print' ** INSERTING DATA INTO : bronze.erp_cust_az12 '
		  BULK INSERT  bronze.erp_cust_az12
		  from 'C:\Users\simob\Documents\Data_enginnering\sql-data-warehouse-project-main\datasets\source_erp\CUST_AZ12.csv'
		  WITH (
       
			   FIRSTROW = 2, 
			   FIELDTERMINATOR = ',', 
			   TABLOCK
		  );

		  SET @end_time = GETDATE();
          print'**-- LOAD DURATION : ' + CAST(DATEDIFF(second,@start_time,@end_time) as NVARCHAR ) + 'seconds' 
          print '-------------------------------------------------------------------------------'

		  print' ** truncating Table : bronze.erp_loc_a101 '

		  SET @start_time = GETDATE();
		  truncate table bronze.erp_loc_a101;
		  print' ** INSERTING DATA INTO : bronze.erp_loc_a101 '
		 
		  BULK INSERT bronze.erp_loc_a101
		  from 'C:\Users\simob\Documents\Data_enginnering\sql-data-warehouse-project-main\datasets\source_erp\LOC_A101.csv'
		  WITH (
       
			   FIRSTROW = 2, 
			   FIELDTERMINATOR = ',', 
			   TABLOCK
		  );
		  SET @end_time = GETDATE();
          print'**-- LOAD DURATION : ' + CAST(DATEDIFF(second,@start_time,@end_time) as NVARCHAR ) + 'seconds' 
          print '-------------------------------------------------------------------------------'

		  SET @start_time = GETDATE();
		  print' ** truncating Table : bronze.erp_px_cat_g1v2 '
		  truncate table bronze.erp_px_cat_g1v2;
		  print' ** INSERTING DATA INTO : bronze.erp_px_cat_g1v2 '
		  
		  BULK INSERT  bronze.erp_px_cat_g1v2
		  from 'C:\Users\simob\Documents\Data_enginnering\sql-data-warehouse-project-main\datasets\source_erp\PX_CAT_G1V2.csv'
		  WITH (
       
			   FIRSTROW = 2, 
			   FIELDTERMINATOR = ',', 
			   TABLOCK
		  );

		  SET @end_time = GETDATE();
          print'**-- LOAD DURATION : ' + CAST(DATEDIFF(second,@start_time,@end_time) as NVARCHAR ) + 'seconds' 
          print '-------------------------------------------------------------------------------'
		  print' ** truncating Table : bronze.erp_loc_a101 '

	 END TRY	 

	 BEGIN CATCH
	      print '======================================================='
		  print 'Error Occured Duringn Loading Bronze Layer'
		  print 'Error Message '+ERROR_MESSAGE();
		  print 'Error Message '+ CAST(ERROR_NUMBER() AS NVARCHAR);
		  print 'Error Message '+ CAST(ERROR_STATE() AS NVARCHAR);
		  print '======================================================='
	 END CATCH
END


---------------------

