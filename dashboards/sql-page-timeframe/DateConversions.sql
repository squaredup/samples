IF OBJECT_ID(N'tempdb..#Native') IS NOT NULL DROP TABLE #Native;

--Create a temporary table to hold our display values
CREATE TABLE #Native ([Description]  nvarchar(255)
                    , [strFormatted]  nvarchar(255)
                    , [asDateTime] datetime
                    , [timeAgo] datetime
                    , [timeAgoDt] datetime
                    , [timeAgoHowLong] datetime )

--Insert some differnt types of date conversions using native SQL
--Current Date and Time
INSERT INTO #Native SELECT 'Current Date and Time', FORMAT (GETDATE(), 'yyyy-MM-dd hh:mm:ss tt'), GETDATE(), GETDATE(), GETDATE(), GETDATE()

--1 hour
INSERT INTO #Native SELECT 'StartDate  -1 hour', FORMAT (DATEADD(HOUR, -1, GETDATE()), 'yyyy-MM-dd hh:mm:ss tt'), DATEADD(HOUR, -1, GETDATE()), DATEADD(HOUR, -1, GETDATE()), DATEADD(HOUR, -1, GETDATE()), DATEADD(HOUR, -1, GETDATE())

--12 hours
INSERT INTO #Native SELECT 'StartDate -12 hour', FORMAT (DATEADD(HOUR, -12, GETDATE()), 'yyyy-MM-dd hh:mm:ss tt'), DATEADD(HOUR, -12, GETDATE()), DATEADD(HOUR, -12, GETDATE()), DATEADD(HOUR, -12, GETDATE()), DATEADD(HOUR, -12, GETDATE())

--1 day
INSERT INTO #Native SELECT 'StartDate -24 hour', FORMAT (DATEADD(HOUR, -24, GETDATE()), 'yyyy-MM-dd hh:mm:ss tt'), DATEADD(HOUR, -24, GETDATE()), DATEADD(HOUR, -24, GETDATE()), DATEADD(HOUR, -24, GETDATE()), DATEADD(HOUR, -24, GETDATE())

--7 days
INSERT INTO #Native SELECT 'StartDate  -7 days', FORMAT (DATEADD(d, -7, GETDATE()), 'yyyy-MM-dd hh:mm:ss tt'), DATEADD(d, -7, GETDATE()), DATEADD(d, -7, GETDATE()), DATEADD(d, -7, GETDATE()), DATEADD(d, -7, GETDATE())

--30 days
INSERT INTO #Native SELECT 'StartDate -30 days', FORMAT (DATEADD(d, -30, GETDATE()), 'yyyy-MM-dd hh:mm:ss tt'), DATEADD(d, -30, GETDATE()), DATEADD(d, -30, GETDATE()), DATEADD(d, -30, GETDATE()), DATEADD(d, -30, GETDATE())
INSERT INTO #Native SELECT 'StartDate  -1 months', FORMAT (DATEADD(MM, -1, GETDATE()), 'yyyy-MM-dd hh:mm:ss tt'), DATEADD(MM, -1, GETDATE()), DATEADD(MM, -1, GETDATE()), DATEADD(MM, -1, GETDATE()), DATEADD(MM, -1, GETDATE())

--3 months (90 days)
INSERT INTO #Native SELECT 'StartDate -90 days', FORMAT (DATEADD(d, -90, GETDATE()), 'yyyy-MM-dd hh:mm:ss tt'), DATEADD(d, -90, GETDATE()), DATEADD(d, -90, GETDATE()), DATEADD(d, -90, GETDATE()), DATEADD(d, -90, GETDATE())
INSERT INTO #Native SELECT 'StartDate  -3 months', FORMAT (DATEADD(MM, -3, GETDATE()), 'yyyy-MM-dd hh:mm:ss tt'), DATEADD(MM, -3, GETDATE()), DATEADD(MM, -3, GETDATE()), DATEADD(MM, -3, GETDATE()), DATEADD(MM, -3, GETDATE())

--6 months (180 days)
INSERT INTO #Native SELECT 'StartDate  -6 months', FORMAT (DATEADD(MM, -6, GETDATE()), 'yyyy-MM-dd hh:mm:ss tt'), DATEADD(MM, -6, GETDATE()), DATEADD(MM, -6, GETDATE()), DATEADD(MM, -6, GETDATE()), DATEADD(MM, -6, GETDATE())

--12 months (240 days)
INSERT INTO #Native SELECT 'StartDate -12 months', FORMAT (DATEADD(MM, -12, GETDATE()), 'yyyy-MM-dd hh:mm:ss tt'), DATEADD(MM, -12, GETDATE()), DATEADD(MM, -12, GETDATE()), DATEADD(MM, -12, GETDATE()), DATEADD(MM, -12, GETDATE())

--all data
INSERT INTO #Native SELECT 'StartDate All Days', FORMAT (convert(datetime,0), 'yyyy-MM-dd hh:mm:ss tt'), convert(datetime,0), convert(datetime,0),convert(datetime,0), convert(datetime,0)

--End Date
INSERT INTO #Native SELECT 'End Date', FORMAT (GETDATE(), 'yyyy-MM-dd hh:mm:ss tt'), GETDATE(), GETDATE(),GETDATE(), GETDATE()

--Midnight
INSERT INTO #Native SELECT 'Midnight', FORMAT (DATEADD(Day, 0, DATEDIFF(Day, 0, GetDate())), 'yyyy-MM-dd hh:mm:ss tt'), DATEADD(Day, 0, DATEDIFF(Day, 0, GetDate())),DATEADD(Day, 0, DATEDIFF(Day, 0, GetDate())),DATEADD(Day, 0, DATEDIFF(Day, 0, GetDate())),DATEADD(Day, 0, DATEDIFF(Day, 0, GetDate()))

--Dump out the table for SquaredUp to display on the dashboard
SELECT * FROM #Native
