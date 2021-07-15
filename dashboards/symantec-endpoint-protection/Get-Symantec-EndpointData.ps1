Import-Module dbatools

[string]$userName = 'XXX'
[string]$userPassword = 'vU'

[securestring]$secStringPassword = ConvertTo-SecureString $userPassword -AsPlainText -Force
[pscredential]$credObject = New-Object System.Management.Automation.PSCredential ($userName, $secStringPassword)

$checkInQry = @"
Use SEP12;

SELECT SEM_COMPUTER.COMPUTER_NAME AS 'Computer name',
PATTERN.Version AS 'Virus definition used',
dateadd(second, SEM_AGENT.LAST_UPDATE_TIME/1000, '1970-01-01') AS 'Last check-in (GMT)', SEM_AGENT.AGENT_VERSION
FROM SEM_COMPUTER
INNER JOIN SEM_AGENT ON SEM_AGENT.COMPUTER_ID=SEM_COMPUTER.COMPUTER_ID
INNER JOIN SEM_CONTENT ON SEM_CONTENT.AGENT_ID=SEM_AGENT.AGENT_ID
INNER JOIN PATTERN ON PATTERN.PATTERN_IDX=SEM_AGENT.PATTERN_IDX
INNER JOIN (
SELECT SEM_COMPUTER.COMPUTER_NAME AS 'TempHostName',
MAX(SEM_AGENT.LAST_UPDATE_TIME) AS 'TempMax'
FROM SEM_COMPUTER
INNER JOIN SEM_AGENT ON SEM_AGENT.COMPUTER_ID=SEM_COMPUTER.COMPUTER_ID
GROUP BY COMPUTER_NAME)
TestTable ON TestTable.TempHostName=SEM_COMPUTER.COMPUTER_NAME
AND TestTable.TempMax=SEM_AGENT.LAST_UPDATE_TIME
WHERE PATTERN.PATTERN_TYPE='VIRUS_DEFS'
AND PATTERN.DELETED='0'
AND SEM_CONTENT.DELETED='0'
AND SEM_AGENT.DELETED='0'
AND SEM_COMPUTER.DELETED='0'
GROUP BY SEM_COMPUTER.COMPUTER_NAME, SEM_AGENT.LAST_UPDATE_TIME, PATTERN.Version, SEM_AGENT.AGENT_VERSION
ORDER BY SEM_COMPUTER.COMPUTER_NAME ASC, SEM_AGENT.LAST_UPDATE_TIME DESC;
"@

$checkIn = Invoke-DbaQuery -SqlInstance SQLServer\InstanceName -SqlCredential $credObject -Query $checkInQry
 
$rsl = $checkIn | Select-Object -Property 'Computer name','Virus definition used','Last check-in (GMT)',  @{Name = 'VirusDefDate'; Expression = { [datetime]::ParseExact(($_.'Virus definition used'.Substring(0,10)),"yyyy-MM-dd",$null) }} 
        

$green = ($rsl | Where-Object {($_.VirusDefDate -lt (Get-Date)) -and ($_.VirusDefDate -gt (Get-Date).AddDays(-3)) } ).count
$yellow = ($rsl | Where-Object {($_.VirusDefDate -lt (Get-Date).AddDays(-3)) -and ($_.VirusDefDate -gt (Get-Date).AddDays(-7)) } ).count
$red = ($rsl | Where-Object {($_.VirusDefDate -lt (Get-Date).AddDays(-7))  } ).count

#AV Definitions
$rslArr = New-Object -TypeName System.Collections.ArrayList
$rslArr.Add(@{ state = "healthy"; id = "1"; name = "Within 3 days"; metric = $green })      
$rslArr.Add(@{ state = "warning"; id = "2"; name = "Between 3 days and 7 days"; metric = $yellow }) 
$rslArr.Add(@{ state = "critical"; id = "3"; name = "Older than 7 days"; metric = $red })
$rslArr | ConvertTo-Json | Out-File C:\Temp\SEP-SquaredUp-AvDevintions.json -Force


#Last Server Checkin   
$rslArr = New-Object -TypeName System.Collections.ArrayList
$lastServerCheckin = $checkIn | Select-Object -Property 'Computer name','Virus definition used','Last check-in (GMT)', `
            @{Name = 'LastCheckinDay'; Expression = {($_.'Last check-in (GMT)')| Get-Date -Format "yyyy-MM"}}`
            | Group-Object -Property LastCheckinDay
	
            $lastServerCheckin | Where-Object {$_.Name } | ForEach-Object {              
                $obj = [pscustomobject]@{
                    Count = $_.Count -as [double]
                    Name = $_.Name -as [string]
                    Computer = ($_.Group.'Computer name'  | Select-object -first 1) -join ','
                }
                $rslArr.Add($obj)
            }		

 $rslArr | Sort-Object -Property Count |  Select-Object -Last 5 | Export-Csv -LiteralPath C:\Temp\SEP-SquaredUp-LastServerCheckin.csv -NoTypeInformation -Force



 #Last Full Scan
 $checkInQry = @"
Use SEP12;
SELECT DISTINCT
    "SEM_CLIENT"."COMPUTER_NAME" "Computer Name"
  , "SEM_AGENT"."AGENT_VERSION" "SEP Version"
  ,    "SEM_COMPUTER"."OPERATION_SYSTEM" "Operation System"
  , "PATTERN"."VERSION" "AV Revision"
  , dateadd(s,convert(bigint,"SEM_AGENT"."CREATION_TIME")/1000,'01-01-1970 00:00:00') CREATION_DTTM
  , dateadd(s,convert(bigint,"SEM_AGENT"."LAST_UPDATE_TIME")/1000,'01-01-1970 00:00:00') "Last Update Time"
  , dateadd(s, convert(bigint,LAST_SCAN_TIME)/1000, '01-01-1970 00:00:00')"Last Scan Time"
  , "SEM_CLIENT"."USER_NAME" "User Name"
  , "IP_ADDR1_TEXT" "IP Address"
  , "IDENTITY_MAP"."NAME" "Group Name"
  , "SEM_AGENT"."DELETED" "Marked for deletion"
FROM (((("SEM_AGENT" "SEM_AGENT" INNER JOIN "SEM_CLIENT" "SEM_CLIENT"
  ON (("SEM_AGENT"."COMPUTER_ID"="SEM_CLIENT"."COMPUTER_ID")
  AND ("SEM_AGENT"."DOMAIN_ID"="SEM_CLIENT"."DOMAIN_ID"))
  AND ("SEM_AGENT"."GROUP_ID"="SEM_CLIENT"."GROUP_ID")) INNER JOIN "SEM_COMPUTER" "SEM_COMPUTER"
  ON (("SEM_AGENT"."COMPUTER_ID"="SEM_COMPUTER"."COMPUTER_ID")
  AND ("SEM_AGENT"."DOMAIN_ID"="SEM_COMPUTER"."DOMAIN_ID"))
  AND ("SEM_AGENT"."DELETED"="SEM_COMPUTER"."DELETED")) INNER JOIN "PATTERN" "PATTERN"
  ON "SEM_AGENT"."PATTERN_IDX"="PATTERN"."PATTERN_IDX") INNER JOIN "IDENTITY_MAP" "IDENTITY_MAP"
  ON "SEM_CLIENT"."GROUP_ID"="IDENTITY_MAP"."ID") INNER JOIN "V_SEM_COMPUTER" "V_SEM_COMPUTER"
  ON "SEM_COMPUTER"."COMPUTER_ID"="V_SEM_COMPUTER"."COMPUTER_ID"
  AND "SEM_AGENT"."DELETED"=0
ORDER BY "Computer Name"
"@

$lastScan = Invoke-DbaQuery -SqlInstance SQLServer\InstanceName -SqlCredential $credObject -Query $checkInQry
$lastScanRsl = $lastScan | Select-Object -Property 'Computer Name',  @{Name = 'LastScanDate'; Expression = {($_.'Last Scan Time')| Get-Date -Format "yyyy-MM"}} | Where-Object {$_.LastScanDate -ne '1970-01'} | Group-Object LastScanDate 

$rslArr = New-Object -TypeName System.Collections.ArrayList
$lastScanRsl | Where-Object {$_.Name } | ForEach-Object {              
                $obj = [pscustomobject]@{
                    Count = $_.Count -as [double]
                    Name = $_.Name -as [string]
                    Computer = ($_.Group.'Computer name'  | Select-object -first 1) -join ','
                }
                $rslArr.Add($obj)
            }		

 $rslArr | Sort-Object -Property Count |  Select-Object -Last 3 | ConvertTo-Json | Out-File C:\Temp\SEP-SquaredUp-LastFullScan.json -Force




 # App Version
 $checkInQry = @"
Use SEP12;

SELECT SEM_COMPUTER.COMPUTER_NAME AS 'Computer name',
PATTERN.Version AS 'Virus definition used',
dateadd(second, SEM_AGENT.LAST_UPDATE_TIME/1000, '1970-01-01') AS 'Last check-in (GMT)', SEM_AGENT.AGENT_VERSION
FROM SEM_COMPUTER
INNER JOIN SEM_AGENT ON SEM_AGENT.COMPUTER_ID=SEM_COMPUTER.COMPUTER_ID
INNER JOIN SEM_CONTENT ON SEM_CONTENT.AGENT_ID=SEM_AGENT.AGENT_ID
INNER JOIN PATTERN ON PATTERN.PATTERN_IDX=SEM_AGENT.PATTERN_IDX
INNER JOIN (
SELECT SEM_COMPUTER.COMPUTER_NAME AS 'TempHostName',
MAX(SEM_AGENT.LAST_UPDATE_TIME) AS 'TempMax'
FROM SEM_COMPUTER
INNER JOIN SEM_AGENT ON SEM_AGENT.COMPUTER_ID=SEM_COMPUTER.COMPUTER_ID
GROUP BY COMPUTER_NAME)
TestTable ON TestTable.TempHostName=SEM_COMPUTER.COMPUTER_NAME
AND TestTable.TempMax=SEM_AGENT.LAST_UPDATE_TIME
WHERE PATTERN.PATTERN_TYPE='VIRUS_DEFS'
AND PATTERN.DELETED='0'
AND SEM_CONTENT.DELETED='0'
AND SEM_AGENT.DELETED='0'
AND SEM_COMPUTER.DELETED='0'
GROUP BY SEM_COMPUTER.COMPUTER_NAME, SEM_AGENT.LAST_UPDATE_TIME, PATTERN.Version, SEM_AGENT.AGENT_VERSION
ORDER BY SEM_COMPUTER.COMPUTER_NAME ASC, SEM_AGENT.LAST_UPDATE_TIME DESC;
"@

$checkIn = Invoke-DbaQuery -SqlInstance SQLServer\InstanceName -SqlCredential $credObject -Query $checkInQry
$rslt = $checkIn | Group-Object -Property AGENT_VERSION -NoElement
$rslt | Select-Object -First 5 -Property Count, Name | Sort-Object -Property Name -Descending  | Export-Csv -LiteralPath C:\Temp\SEP-SquaredUp-AppVersions.csv -NoTypeInformation -Force



#Malware - Top 5 & Computer infections Top 5

$checkInQry = @"
Use SEP12;

SELECT ALERTS.ALERTDATETIME,  ALERTS.ALERTINSERTTIME, ALERTS.ALERTENDDATETIME, USER_NAME, V_SEM_COMPUTER.COMPUTER_NAME, V_SEM_COMPUTER.IP_ADDR1_TEXT, VIRUS.VIRUSNAME, SOURCE, NOOFVIRUSES, FILEPATH, DESCRIPTION, A1.Actualaction,
A2.Actualaction as Requestedaction, A3.Actualaction as Secondaryaction, SOURCE_COMPUTER_NAME, SOURCE_COMPUTER_IP
FROM ALERTS
INNER JOIN V_SEM_COMPUTER ON COMPUTER_IDX = COMPUTER_ID
INNER JOIN VIRUS ON ALERTS.VIRUSNAME_IDX = VIRUS.VIRUSNAME_IDX
INNER JOIN Actualaction A1 on ALERTS.Actualaction_idx = A1.Actualaction_idx
INNER JOIN Actualaction A2 on ALERTS.Requestedaction_idx = A2.Actualaction_idx 
INNER JOIN Actualaction A3 on ALERTS.Secondaryaction_Idx = A3.Actualaction_idx
WHERE ALERTDATETIME >= DATEADD(day, -7, CURRENT_TIMESTAMP)
order by ALERTDATETIME
"@

$sepAlerts = Invoke-DbaQuery -SqlInstance SQLServer\InstanceName -SqlCredential $credObject -Query $checkInQry
$sepAlertsRsl = $sepAlerts | Where-Object {$_.VIRUSNAME -ne 'WS.Reputation.1'} | Where-Object {$_.ALERTDATETIME -ge (Get-date).AddDays(-7) } | Group-Object -Property VIRUSNAME -NoElement | Sort-Object -Property Count -Descending | Select-Object -First 5 
$sepAlertsRsl | ConvertTo-Json | Out-File C:\Temp\SEP-SquaredUp-MalWare-Top5.json -Force

$sepAlertsRsl = $sepAlerts | Where-Object {$_.VIRUSNAME -ne 'WS.Reputation.1'} | Where-Object {$_.ALERTDATETIME -ge (Get-date).AddDays(-7) } | Group-Object -Property COMPUTER_NAME -NoElement | Sort-Object -Property Count -Descending | Select-Object -First 5 
$sepAlertsRsl | ConvertTo-Json | Out-File C:\Temp\SEP-SquaredUp-MalWareComputer-Top5.json -Force





$checkInQry = @"
Use SEP12;

SELECT ALERTS.ALERTDATETIME,  ALERTS.ALERTINSERTTIME, ALERTS.ALERTENDDATETIME, USER_NAME, V_SEM_COMPUTER.COMPUTER_NAME, V_SEM_COMPUTER.IP_ADDR1_TEXT, VIRUS.VIRUSNAME, SOURCE, NOOFVIRUSES, FILEPATH, DESCRIPTION, A1.Actualaction,
A2.Actualaction as Requestedaction, A3.Actualaction as Secondaryaction, SOURCE_COMPUTER_NAME, SOURCE_COMPUTER_IP
FROM ALERTS
INNER JOIN V_SEM_COMPUTER ON COMPUTER_IDX = COMPUTER_ID
INNER JOIN VIRUS ON ALERTS.VIRUSNAME_IDX = VIRUS.VIRUSNAME_IDX
INNER JOIN Actualaction A1 on ALERTS.Actualaction_idx = A1.Actualaction_idx
INNER JOIN Actualaction A2 on ALERTS.Requestedaction_idx = A2.Actualaction_idx 
INNER JOIN Actualaction A3 on ALERTS.Secondaryaction_Idx = A3.Actualaction_idx
WHERE ALERTDATETIME >= DATEADD(day, -30, CURRENT_TIMESTAMP)
order by ALERTDATETIME
"@

$sepAlerts = Invoke-DbaQuery -SqlInstance SQLServer\InstanceName -SqlCredential $credObject -Query $checkInQry
$alertHistory = $sepAlerts | Where-Object {$_.VIRUSNAME -ne 'WS.Reputation.1'} | Select-Object COMPUTER_NAME, @{Name = 'ALERTDATETIMED'; Expression = {($_.'ALERTDATETIME')| Get-Date -Format "yyyy-MM-dd"}}  | Group-Object ALERTDATETIMED
$alertBySiteCode = $sepAlerts | Where-Object {$_.VIRUSNAME -ne 'WS.Reputation.1'} | Select-Object COMPUTER_NAME, @{Name = 'ALERTDATETIMED'; Expression = {($_.'ALERTDATETIME')| Get-Date -Format "yyyy-MM-dd"}}, @{Name = 'SiteCode'; Expression =  {($_.'COMPUTER_NAME').Substring(0,5)}}  | Group-Object SiteCode  | Sort-Object -Property Count -Descending

$rslArr = New-Object -TypeName System.Collections.ArrayList
$alertHistory | Where-Object {$_.Name } | ForEach-Object {              
                $obj = [pscustomobject]@{
                    Count = $_.Count -as [Int]
                    Name = $_.Name -as [DateTime]
                    Computer = ($_.Group.'COMPUTER_NAME'  | Select-object -first 1) -join ','
                }
                $rslArr.Add($obj)
            }		

$rslArr | Export-csv -LiteralPath C:\Temp\SEP-SquaredUp-AlertHistory.csv -Force -NoTypeInformation


$rslArr = New-Object -TypeName System.Collections.ArrayList
$alertBySiteCode | Where-Object {$_.Name } | ForEach-Object {              
                $obj = [pscustomobject]@{
                    Count = $_.Count -as [Int]
                    Name = $_.Name -as [String]
                    Computer = ($_.Group.'COMPUTER_NAME'  | Select-object -first 1) -join ','
                }
                $rslArr.Add($obj)
            }		

$rslArr | Export-csv -LiteralPath C:\Temp\SEP-SquaredUp-AlertBySiteCode.csv -Force -NoTypeInformation
