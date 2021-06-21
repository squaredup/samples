# Percent Free Space `SQL` `SquaredUp for SCOM`

This dashboard was created for a customer that had specific requirements for their Operation Center.  In this case, the customer wanted to present the Free Space informaation in different ways to different audiences, but with very specific requirements.

The dashboard has the same basic SQL query, but presents the data in four different visualization.

## Requirements

- Data is pulled from the SCOM OperationsManagerDW database using the "`global:dw`" connection string.
- Retrieve most recent data (does not change with page date-picker).
 
## Images
![](https://github.com/squaredup/samples/blob/master/dashboards/scom-percent-free-space/images/dashboard.png?raw=true)


## Dashboard breakdown
### SQL Query
All four tiles use the same root query:

    USE OperationsManagerDW
    
    DECLARE @StartDate datetime
    DECLARE @EndDate datetime
    DECLARE @LastPerfDate datetime
    
    SELECT  @LastPerfDate =  max(vPerf.DateTime)
    FROM Perf.vPerfRaw AS vPerf
    
    SET @StartDate = ISNULL(@StartDate, cast(cast(cast(DATEADD(DAY,-1,@LastPerfDate) as int) as float) as datetime));
    SET @EndDate = ISNULL(@EndDate, cast(cast(cast(DATEADD(DAY,0,GetDate()) as int) as float) as datetime));
    
    --These statements select the counter we want to retreive from the Data Warehouse
    --Data is pulled and then placed into a temporary table
    DECLARE @CounterIDs TABLE(RuleRowID INT, ObjectName NVARCHAR(60), CounterName NVARCHAR(60))
    INSERT INTO @CounterIDs
    SELECT RuleRowId, ObjectName, CounterName
    FROM vPerformanceRule vPR
    --Use this for Windows
    WHERE objectName in ('LogicalDisk') AND (counterName = '% Free Space')
    --WHERE objectName in ('LogicalDisk') AND ((counterName = '% Free Space' ) OR (counterName = 'Free Megabytes'))
    --Use this for Linux
    --WHERE objectName in ('Logical Disk') AND ((counterName = '% Free Space' ) OR (counterName = 'Free Megabytes'))
    
    --DEBUG: Display the records that have been selected
    --SELECT * FROM @CounterIDs
    
    --Using a Common Table Expression to group the data and select the top values
    DECLARE @CounterResults TABLE([DateTime] datetime, PercentFree int, Path nvarchar(255), GUID UniqueIdentifier, MERowID INT, RuleRowID INT, InstanceName nvarchar(255), ObjectName nvarchar(255), CounterName nvarchar(255))
    ;WITH cte AS
    (
      SELECT
      Path as Computer
    , ManagedEntityGuid
    , vManagedEntity.ManagedEntityRowId
    , DisplayName as InstanceName
    , ObjectName
    , CounterName
    , SampleValue
    , DateTime
    , vPRI.RuleRowId
    , ROW_NUMBER() OVER (PARTITION BY vPRI.RuleRowId, Path, DisplayName ORDER BY DateTime DESC) AS rn
      FROM Perf.vPerfRaw as p INNER JOIN
       vPerformanceRuleInstance vPRI ON p.PerformanceRuleInstanceRowId = vPRI.PerformanceRuleInstanceRowId INNER JOIN
       vManagedEntity ON p.ManagedEntityRowId = vManagedEntity.ManagedEntityRowId
       INNER JOIN @CounterIDs cID ON vPRI.RuleRowId = cID.RuleRowID
      WHERE p.DateTime >= @StartDate
    )
    INSERT INTO @CounterResults
    SELECT DateTime
     , SampleValue
     , Computer
     , ManagedEntityGuid
     , ManagedEntityRowId
     , RuleRowId
     , InstanceName
     , ObjectName
     , CounterName
    FROM cte
    WHERE rn = 1
  

For the SQL (grid) and the SQL (bar) tiles, add the following SQL code:

	SELECT * 
    FROM @CounterResults
    WHERE PercentFree < 40
    Order by PercentFree    

For the SQL Status (icons) and the SQL Status (block) tiles, add this block of SQL code:
 
	SELECT top 12 [DateTime]
	, PercentFree
	, Path as name
	, GUID as ID
	, MERowID
	, RuleRowID
	, InstanceName
	, ObjectName
	, CounterName
	, case
	    WHEN PercentFree < 40 THEN 'Critical'
	    WHEN PercentFree >= 40 AND PercentFree < 60 THEN 'Warning'
			ELSE 'Healthy'
	 	end as state
	FROM @CounterResults
	--WHERE PercentFree < 40
	Order by PercentFree


### Custom Grid Column
For the SQL (grid) tile, a custom label was applied that looks like this:

![](https://github.com/squaredup/samples/blob/master/dashboards/scom-percent-free-space/images/SQL%20(grid)%20tile.png?raw=true)

Code:

    <img alt="Embedded Image" src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAacAAAAZCAMAAACihhEbAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAADMUExURQCPpwCPqACPqQCQqQCQqgCRqgCRqwCSqwCSrACTrACTrQCUrgCVrwCUrwCVsACWsACWsQCXsQCXsgCYsgCYswCZswCZtACZtQCatQCatgCbtgCbtwCctwCcuACduACduQCeugCfuwCeuwCfvACgvACgvQChvQChvgCivgCivwCjvwCjwACkwQCjwQCkwgClwgClwwCmwwCmxACnxACnxQCoxgCoxQCoxwCpxwCpyACqyACqyQCryQCrygCsygCsywCtzACUrQCtywCeuR0ryowAAAAJcEhZcwAADsMAAA7DAcdvqGQAAAJCSURBVGhD7ZXbVhpREAUH1BiTeCEqCiK5GIwmgIoiSIiS+P//ZHWfnpmzZsiah8hbV31Cre6dJDWo19Zqa3WEddxYD77ZQNjEt5sIW/hONN6LxgdxG2EHd3cQ9rCxF/zYQNjHg32Ew4NmUDlqHovQwrbYardO2upJB0876mkXP4nGZ9H4In5FOMNvZwg9PO8Fv58jXODlBcIP/CkafXHQV4b9q/7VEOEab67F0Y06usW70d0twjh4P4bJeCpOpvCAs+nsQfw1Q5jj7znCIz6JxkJcJAmFQqW4EUgj6VNqtIXwB5c0Uii0rJEUopEUihtZpUIjqVRo1F7aqLviRgaFyo1AGkmhuNF9KKSNtJAYNwJpNJ9JoUKjR4S/GBoJ4Z6s1H+22g6tDEpZKyllrUKphnYSrZV2OgyltFPz+CiUohWd2pB2ylqBtuqGUs+4pJVS3eryH60GUSu9Jm0lndJWhWuSVopek6GdJtE9yTWlrbRUVaskqYevV8sa2dfTn8fXKzV69Z8X35N1MtJ7CpWsU7inTnRP2kkbPUeNrFLWCKVRD0r3JBqlexqErzeUTqWfZ51AO2X3pBdlnezrKXpP2kl/nnXSRlTKfp5WSn9efk++T75Pvk9m3Mj3yfcpbeT7lN9T2sn3qfj78nvyffJ9MrSR4fvk+1TdyvfJ98n3CX2f8ntabSPD98n3qbqV75Pvk+8T+j7l97TaRobvk+9TdSvfJ98n3yf0fcrvabWNDN8n36fqVr5Pvk++T/gq+7RYvAAy+UTDp8jJTAAAAABJRU5ErkJggg=="  width={{value*4}} height=15 /><img alt="Embedded Image" src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAO4AAAAZCAMAAAABp+KxAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAABFUExURSwxNy0xNywxNi0xNi0yNy4yOC0yOC4zOC4zOS8zOS80OS80OjA0OjA1OjA1OzE1OzE2OzE2PDI2PDI3PDI3PTM3PTM4PmYWE4sAAAAJcEhZcwAADsMAAA7DAcdvqGQAAAE3SURBVFhH7dNLcoQwDARQmMGAAWM+Ge5/1LQk2wiSmiTrSF3N/hXuqqofyLN+NHVdNyquaVGV1rWdO9Mjvus7n9P7fqD6gepHysAdJsooCZQpjPOUElJwEVm4y7xSIjeuC5JuQ3d8P3I2dMdX3Qs97qGrKjCfVyZVpXVN55xioh1RC1OohVmoQKKjUAOVmSEzhTrPIRYqMdErk6knc9dUYu5sTHcAq5DEFCpd+ruUG7tFmXtllz98stMf/gsbec+OwpY/TOyY2XTbV/YK6Y19+8PEpr97DdNUNJGZmijM/Ig5ieiZ+ItHrInqEQvx8og3AG/Enx7xC9Vn27Xtcmy7iWnbPdm23cz85hHbdm27hWjbpbPtytl2NRGx7QrbtivMN4/YtjvbdgvRtmvbte3adun+1XaP4xMyMh9m2isL3gAAAABJRU5ErkJggg=="  width={{(100-value)*4}} height=15 /> {{value}} %

For the SQL Status (Block) tile, a custom sublabel was applied that looks like this:

![](https://github.com/squaredup/samples/blob/master/dashboards/scom-percent-free-space/images/SQL%20Status%20(block).png?raw=true)  

Code:

    <img alt="Embedded Image" src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAIAAACQd1PeAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAADsMAAA7DAcdvqGQAAAAMSURBVBhXY2BgYAAAAAQAAVzN/2kAAAAASUVORK5CYII="  width={{properties.percentFree*2}} height=25 /><img alt="Embedded Image" src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAIAAACQd1PeAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAADsMAAA7DAcdvqGQAAAAMSURBVBhXY2hoaAAAAwQBgeEJFSwAAAAASUVORK5CYII="  width={{(100-properties.percentFree)*2}} height=25 /> {{properties.percentFree}} % <br> {{properties.instanceName}}

### Grid Options Row Link

Since the query returns the GUID of the object, we can use the Link Option Item Link option:

	https://fqdn.server.com/SCOM5/drilldown/scomobject?id={{id}}

Where `{{id}}` is the parameter that is returned via the SQL query.
