## Symantec Endpoint Protection (Broadcom)

Provides an overview about your Symantec Endpoint Protection client status.


![Overview](https://github.com/squaredup/samples/blob/master/dashboards/symantec-endpoint-protection/Endpoint-Protection.png?raw=true)


All information is been queried directly from SEP' MSSQL database. The free PowerShell module DBATools sends the queries to the database and returns powershell objects. For better security a SQL user account was created which just has permissions to read the data in the database.

To avoid delays, a Scheduled Task runs the PowerShell-SQL-queries hourly and stores the results in textfiles. The dashboard tiles read the information from the text files. Sometimes they transpose the result a little.


### References:
DBATools: https://dbatools.io/
SEP Queries: https://community.broadcom.com/symantecenterprise/communities/community-home/digestviewer/viewthread?MessageKey=a6295288-d277-46d2-b5cc-66a92bcd4671&CommunityKey=1ecf5f55-9545-44d6-b0f4-4e4a7f5f5e68&tab=digestviewer#bma6295288-d277-46d2-b5cc-66a92bcd4671




