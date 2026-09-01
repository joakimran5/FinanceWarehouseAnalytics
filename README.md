# FinanceWarehouseAnalytics

### Consist of 3 layer
1. (Bronze layer) consist of raw data, not set to agreemnet kind of data. Due to personal use, this level act as testing for db design as it is less prone to error and avoid tedious work that demotivated as all process are being done by one person. In business use, this is dangerous as original data can be corrupted. It is advice to create another db for testing.
2. (Silver layer) Here we kept the original data with agreeing db design and data naming. here we just clean two table which require cleaning. Relation are kept or may adjusting. 
3. (Gold layer) Simple and readibility. Process for data analysis with no join with any table. All data in one table. 
