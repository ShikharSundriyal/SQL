Spark vs SQL :
  - Converting a string to Date format
    - SQL : DATE_FORMAT(date_column,"%Y-%m")  
    - Spark : df.withColumn('col_name',to_date(col(name of column), 'M/d/y'))



SPARK :
  - From a single column extracting multiple columns using regular expression if all the records are following a pattern usually in log analytics
  - df_new = df.select(regexp_extract('col_name', regexp_pattern, element number out of all elements in regexp).alias("newcol_name"),
              regexp_extract('col_name', regexp_pattern, element number out of all elements in regexp).alias("newcol_name"))

  - Concatenate 3 columns of a dataframe to make a new column 
    - Approach 1 : SQL WAY

    - Approach 2 : DSL WAY

```python
#create a new column from concatinating 3 columns
#Approach 1 using sql expression way
df_nw = df.select('FlightNum','DepDelay',expr("to_date(concat(Year,Month,DayofMonth),'yyyymmdd') as FlightDate"))
df_nw.show(10,truncate = False)
```

```python
#create a new column from concatinating 3 columns
#Approach 1 using DSL way
df_nw = df.select('FlightNum','DepDelay',to_date(concat("Year","Month","DayofMonth"),'yyyymmdd').alias('FlightDate'))
df_nw.show(10,truncate = False)
```
