$ConnectionString = <yourConnectionString>

$CreateTeamsTable = @"
CREATE TABLE [dbo].[TeamsTable](
	[ID] [int] NOT NULL,
    [GroupID] [varchar](355) NOT NULL,
	[Semester] [nchar](10) NOT NULL,
	[subject] [nchar](10) NOT NULL,
	[number] [nchar](10) NOT NULL,
	[section] [nchar](10) NOT NULL,
	[teamgroupid] [varchar](355) NOT NULL,
	[teamDisplayName] [varchar](355) NOT NULL,
    [Type] [varchar](10) NOT NULL,
    CONSTRAINT PK_TeamsTable_ID PRIMARY KEY (ID)
) ON [PRIMARY]
"@

$CreateCurrentSemester = @"
CREATE TABLE [dbo].[CurrentSemester](
	[ID] [int] NOT NULL
) ON [PRIMARY]
"@

$CreateSemseter = @"

CREATE TABLE [dbo].[Semester](
	[ID] [int] NOT NULL,
	[SemesterCode] [int] NOT NULL
) ON [PRIMARY]
"@

Invoke-CoSDBMSSQLNonSelectQuery -ConnectionString $connectionString -Query $CreateTeamsTable
Invoke-CoSDBMSSQLNonSelectQuery -ConnectionString $connectionString -Query $CreateCurrentSemester
Invoke-CoSDBMSSQLNonSelectQuery -ConnectionString $connectionString -Query $CreateSemester
