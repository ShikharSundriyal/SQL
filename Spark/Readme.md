Spark vs SQL :
  - Converting a string to Date format
    - SQL : DATE_FORMAT(date_column,"%Y-%m")  
    - Spark : df.withColumn('col_name',to_date(col(name of column), 'M/d/y'))



SPARK :
  - From a single column extracting multiple columns using regular expression if all the records are following a pattern usually in log analytics
  - df_new = df.select(regexp_extract('col_name', regexp_pattern, element number out of all elements in regexp).alias("newcol_name"),
              regexp_extract('col_name', regexp_pattern, element number out of all elements in regexp).alias("newcol_name"))
