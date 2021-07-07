The Microsoft Teams dashboard here is used to monitor Microsoft Teams used by the College of Science at Purdue University for teaching Chemistry and Biology lecture and lab classes, and does not monitor the entire Teams infrastructure used by Purdue University.  The Dashboard is designed to be dynamic based on a table in the database for the current semester.  Modifying the table would modify the semester looked at.

Required Public PowerShell Modules:
	MicrosoftTeams
	ExchangeOnlineManagement

Required Other PowerShell Modules:
	Database interaction with your DBMS of choice.  I use CosDatabase, a legacy private module for database access in the College of Science.  You will need to update the database calls to use your module.

Definitions:

	Section - This is the "class" that a student signs up for - it meets at a specific time and place.
	
	Class - This is the Subject, such as Chem 101.  A student taking Chem 101 will have a lecture section and a lab section, and there will normally be more than one instance of each.
	
	Empty Team - This is a team with no "member" users.  We monitor for this to ensure we have not incorrectly populated the database with innacurate section data.
	
	Unowned Team - Each team technically must require at least one "owner" user.  Our service account is an owner on every team so that it can update the membership daily.  An "Unowned Team" is a team with only one owner - the service account.  Commonly this is because the departments have not entered "Instructor of Record" into the LMS.
	
	Lecture Teams Properly Configured - Due to the maturity level of some students, we must lock down who can send emails to lecture teams.  This test looks to ensure that those properties are not empty (empty means anyone can send for those properties)
	
Profile Specifics:

	Variables used in the PowerShell Tiles from the profile:
	
		$ConnectionString - This is the connection string formatted for the DBMS and Module you use to connect to your DBMS
	
		$Credential - This is the System.Management.Automation.PSCredential object that contains the username and password used in Connect-MicrosoftTeams and Connect-ExchangeOnline (assuming they are the same. If not, you will need to provide both and update the PowerShell Tiles as needed).
	
		$SemesterCode - This is the string that identifies the semester.  Purdue uses a 6-digit code.
			202110 - Fall of 2020
			202120 - Spring of 2021
			202130 - Summer of 2021
			202210 - Fall of 2022
			202220 - Spring of 2022
			202230 - Summer of 2022
		
	There is value in monitoring previous semesters' teams so I have included a way to make the dashboard dynamic based on the value in the CurrentSemester table.  This table contains the ID of the current semester in the Semester Table.  I use separate PowerShell Profiles to pick the semester with different SQL queries (this is only the $SemesterCode portion of the profiles).
		Current Semester: 
			$QueryCurrentSemester = "SELECT semestercode FROM Semester JOIN CurrentSemester on Semester.ID = CurrentSemester.ID"
			$SemesterCode = (Invoke-CoSDBMSSQLSelectQuery -ConnectionString $connectionString -Query $QueryCurrentSemester).tables[0].rows[0].semestercode
		Previous Semester:
			$QueryCurrentSemester = "SELECT * FROM Semester JOIN CurrentSemester on Semester.ID = CurrentSemester.ID"
			$CurrentSemester = (Invoke-CoSDBMSSQLSelectQuery -ConnectionString $connectionString -Query $QueryCurrentSemester).tables[0].rows[0]
			$PreviousSemesterID = $CurrentSemester.ID - 1
			$QueryPreviousSemester = "SELECT semestercode FROM Semester WHERE ID = '$PreviousSemesterID'"
			$SemesterCode = (Invoke-CosDBMSSQLSelectQuery -ConnectionString $connectionString -Query $QueryPreviousSemester).tables[0].rows[0].SemesterCode
			
Steps to create the Dashboard:
1. Create the database (database-creation.ps1 contains the table definitions for MS SQL that I use.  The only required part in the TeamsTable for this is the TeamGroupID, the rest is used for other functions relating to managing the Teams outside of the Dashboard).
2. Populate the database data.  
3. Create Dashboard Server Profiles for each Semester you wish to monitor.
4. Create the Dashboard by copying the .json file.
5. Update each tile to pick the correct PowerShell profile.
6. On Dashboard Server 5.2 and later, update the environment section of each PowerShell Tile for interval and timeout to fit your environment.  Note that the MicrosoftTeams and ExchangeOnlineManagement modules do not process large numbers of teams quickly.  Searching for deleted teams out of 200 teams takes 6-7 minutes.  An alternative to this is to have the PowerShell run on the server as a Scheduled Task and write the output to a file and have the Dashboard PowerShell Tile pick that data up for visualization.
