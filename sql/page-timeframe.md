#  #Page Timeframe (SQL Tile)

## Official Support ##

Be sure to check out the official documentation on [How to use the SQL tile](https://support.squaredup.com/hc/en-us/articles/360019292177-How-to-use-the-SQL-tile "How to use the SQL tile") with page time frame.  Any changes to the behavior or functionality will be reflected in the KB.

## Using the page timeframe variables ##

In order to have your query update dynamically with the page time frame, you must take some extra steps with your query.

### Method 1 - isoStart and isoEnd 

There are two different methods to dynamically update the date/time values on a SquaredUp dashboard.  The first method is to use the isoStart and isoEnd variables.  Use these parameters when when need the starting point to be "now minus page *timeframe*". The page *timeframe* will be inserted as a starting time according to the ISO 8601 standard.

Using *isoStart* and *isoEnd* is a quick and easy way to make your query dynamic.

**isoStart example**

1. Insert the appropriate *timeframe* parameter into your query.


**sample SQL Code**

    SELECT * 
    FROM #SqupPTF
    WHERE DateTime >= {{timeframe.isoStart}} AND DateTime <= {{timeframe.isoEnd}}

In the example above, it really isn't necessary to include *isoEnd* since the end value is always "now," but if your data source has future values, including an end date is good practice for performance reasons (buy not retrieving more records than necessary).

### Method 2 -isoDuration

The second method uses the isoDuration variable.  This variable gives you total control over the actual date that is passed into your SQL statements.  It is recommended to use isoDuration when you need to change the behavior that is actually calculated.  

For example, when a user selects 1 hours, they actually need two hours worth of data.  Another example would be if you 1 month ago versus 30 calendar days ago (depending on the month, you might get more or less days).  A final example would be if you want to always have the time start at midnight.

**isoDuration example:**

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

**#1** Please be aware of differences between the time zone of the server and the time zone of the user.  Sometimes, the values shown are shown in the local time zone, not the actual time zone for the server.  

**#2** There are several other page *timeframe* variables that have not been discussed in this post; like *timeframe.unixStart* and *timeframe.unixEnd*.  Please see the KB article for additional information. 
 

## Reference Dashboard ##

A dashboard demonstrating this technique is published to the repository at this address:   [https://github.com/squaredup/samples/tree/master/dashboards/sql-page-timeframe](https://github.com/squaredup/samples/tree/master/dashboards/sql-page-timeframe "sql-page-timeframe")