# SQL Page Timeframe Dashboard #

This dashboard is a proof-of-concept dashboard that demonstrates how to to use SquaredUp's page timeframe functionality.

## Requirements ##

Two versions of the dashboard are supplied; 1) SquaredUp for SCOM and 2) SquaredUp Dashboard Server.  The version for SquaredUp for SCOM uses the *global:dw* connection string.  For the Dashboard Server version, the user is required to change the default *connection string* to something appropriate in their environment.

If needed, update the *connection string*:

![Connection String dialog](https://github.com/squaredup/samples/raw/master/dashboards/sql-page-timeframe/images/connection-string.png)


## Images ##

When working properly, your dashboard should look similar to the following:

![SQL Page Timeframe Example Dashboard](https://github.com/squaredup/samples/raw/master/dashboards/sql-page-timeframe/images/sql-page-timeframe.png)


## Dashboard Breakdown ##

This dashboard was created to demonstrate how to use SquaredUp's page timeframe functionality.  To that end, the dashboard has four SQL Scalar tiles at the top of the dashboard.  

1. The tile labeled *SQL Native* shows the current SERVER time.  
2. The tile labeled *Current Time with Time Zone* has the current time with accompanying time zone nomenclature.  
3. The tile labeled *Page Time Frame* is SquaredUp's page timeframe variable.  
4. And finally, the tile labeled *Timezone of the Server* is the timezone

Whenever the user changes the page timeframe, by clicking on the timeframe bar, the Page Time Frame tile will be updated with the current value.

The next tile labeled *SQL GetDate Function* shows all of the possible date and time values, but hard-coded in the SQL code.  The last tile labeled *Page Time Frame* uses the dynamic page timeframe variable to update the SQL code.


## Supporting Files ##

The SQL code for the last two tiles is included so that users can see the SQL code without having to load the dashboard.

The file titled [Date Conversions.sql](https://github.com/squaredup/samples/blob/master/dashboards/sql-page-timeframe/DateConversions.sql "Date Conversions.sql") contains the hard-coded SQL syntax.

The file titled [SquaredUpPageTimeFrame.sql](https://github.com/squaredup/samples/blob/master/dashboards/sql-page-timeframe/SquaredUpPageTimeFrame.sql "SquaredUpPageTimeFrame.sql") contains the code required to make the dynamic page timeframe variable function with the SQL code.


## Reference ##

For additional information, please refer to the [Page Timeframe](https://github.com/squaredup/samples/blob/master/sql/page-timeframe.md "Page Timeframe") reference page.  