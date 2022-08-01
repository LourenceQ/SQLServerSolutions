/*
CHAPTER 5 Metadata QueriesThis chapter presents recipes that allow you to find information about a given
schema. For example, you may want to know what tables you’ve created or which for‐
eign keys are not indexed. All of the RDBMSs in this book provide tables and views
for obtaining such data. The recipes in this chapter will get you started on gleaning
information from those tables and views.*/-- 5.1 Listing Tables in a SchemaSELECT	* FROM INFORMATION_SCHEMA.TABLESWHERE TABLE_SCHEMA = 'SqlCookbook';