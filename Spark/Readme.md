Spark vs SQL :
  - Converting a string to Date format
    - SQL : DATE_FORMAT(date_column,"%Y-%m")  
    - Spark : df.withColumn('col_name',to_date(col(name of column), 'M/d/y'))
