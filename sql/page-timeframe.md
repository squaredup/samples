#  #Page Timeframe (SQL Tile)

## Official Support ##

Be sure to check out the official documentation on [How to use the SQL tile](https://support.squaredup.com/hc/en-us/articles/360019292177-How-to-use-the-SQL-tile "How to use the SQL tile") with page time frame.  Any changes to the behavior or functionality will be reflected in the KB.

## Using the page time frame variable ##

In order to have your query update dynamically with the page time frame, you must take some extra steps with your query.  

**For example:**

1. Create a variable for the page time frame.
2. Calculate the date based on the dynamic page time frame variable.
3. Update your query to use your new variable.

**Sample SQL Code**

    --Declare a variable to hold the page time frame 
    DECLARE @StartDate AS Datetime
    
    --Depending on the value of the timeframe.isoDuration value, set the @StartDate parameter 
    SET @StartDate = CASE {{timeframe.isoDuration}}
    	 WHEN 'PT1H'  THEN DATEADD(HOUR, -1, GETDATE())
    	 WHEN 'PT12H' THEN DATEADD(HOUR, -12, GETDATE())
    	 WHEN 'PT24H' THEN DATEADD(HOUR, -24, GETDATE())
    	 WHEN 'P7D'   THEN DATEADD(d, -7, GETDATE())
    	 WHEN 'P30D'  THEN DATEADD(d, -30, GETDATE())
    	 WHEN 'P3M'   THEN DATEADD(MM, -3, GETDATE())
    	 WHEN 'P6M'   THEN DATEADD(MM, -6, GETDATE())
    	 WHEN 'P12M'  THEN DATEADD(MM, -12, GETDATE())
    	 ELSE convert(datetime,0)
      END

    --In our query, use the @StartDate parameter as our starting date 
    SELECT * 
    FROM #SqupPTF
    WHERE DateTime >= @StartDate

In the example above, whenever the page time frame changes, the SQL code will be re-run with a new value for *@StartDate*.


## Important ##

Please be aware of differences between the time zone of the server and the time zone of the user.  Sometimes, the values shown are shown in the local time zone, not the actual time zone for the server.  
 

## Reference Dashboard ##

A dashboard demonstrating this technique is published to the repository at this address:   [https://github.com/squaredup/samples/tree/master/dashboards/sql-page-timeframe](https://github.com/squaredup/samples/tree/master/dashboards/sql-page-timeframe "sql-page-timeframe")