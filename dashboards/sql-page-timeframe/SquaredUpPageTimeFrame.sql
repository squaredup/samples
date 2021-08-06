IF OBJECT_ID(N'tempdb..#SqupPTF') IS NOT NULL DROP TABLE #SqupPTF;
DECLARE @StartDate AS Datetime
DECLARE @DateText  as nvarchar(25)

--Create a temporary table to hold our display values
CREATE TABLE #SqupPTF ([Description]  nvarchar(255)
                     , [strFormatted]  nvarchar(255)
                     , [asDateTime] datetime
                     , [timeAgo] datetime
                     , [timeAgoDt] datetime
                     , [timeAgoHowLong] datetime )


--Using the SquaredUp Page TimeFrame value, set our StartDate parameter
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

--Again, using the SquaredUp Page Timeframe value, set a DateText parameter
SET @DateText = CASE  {{timeframe.isoDuration}}
         WHEN 'PT1H'  THEN 'StartDate  -1 hour'
         WHEN 'PT12H' THEN 'StartDate -12 hours'
         WHEN 'PT24H' THEN 'StartDate -24 hours'
         WHEN 'P7D'   THEN 'StartDate  -7 days'
         WHEN 'P30D'  THEN 'StartDate -30 days'
         WHEN 'P3M'   THEN 'StartDate  -3 months'
         WHEN 'P6M'   THEN 'StartDate  -6 months'
         WHEN 'P12M'  THEN 'StartDate -12 months'
         ELSE 'All Dates'
      END

--Insert our custom Page TimeFrame into the table
INSERT INTO #SqupPTF
SELECT @DateText as [Description]
     , FORMAT (@StartDate, 'yyyy-MM-dd hh:mm:ss tt') as [strFormatted]
     , @StartDate as [asDateTime]
     , @StartDate as [timeAgo]
     , @StartDate as [timeAgoDT]
     , @StartDate as [timeAgoHowLong]

--End Date
INSERT INTO #SqupPTF SELECT 'End Date', FORMAT (GETDATE(), 'yyyy-MM-dd hh:mm:ss tt'), GETDATE(), GETDATE(), GETDATE(), GETDATE()

--Midnight
INSERT INTO #SqupPTF SELECT 'Midnight'
  , FORMAT (DATEADD(Day, 0, DATEDIFF(Day, 0, @StartDate)), 'yyyy-MM-dd hh:mm:ss tt')
  , DATEADD(Day, 0, DATEDIFF(Day, 0, @StartDate))
  , DATEADD(Day, 0, DATEDIFF(Day, 0, @StartDate))
  , DATEADD(Day, 0, DATEDIFF(Day, 0, @StartDate))
  , DATEADD(Day, 0, DATEDIFF(Day, 0, @StartDate))

--Dump out the table for SquaredUp to display on the dashboard
SELECT * FROM #SqupPTF
