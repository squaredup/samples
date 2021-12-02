#Page time frame query
switch ($timeFrame) {
    "last1Hour" { $TimeQuery = "RELATIVEGT@hour@ago@1" }
    "last12Hours" { $TimeQuery = "RELATIVEGE@hour@ago@12"}
    "last24Hours"  { $TimeQuery = "RELATIVEGT@hour@ago@24" }
    "last7Days"  { $TimeQuery = "RELATIVEGT@dayofweek@ago@7" }
    "last30Days" { $TimeQuery = "RELATIVEGT@dayofweek@ago@30" }
    "last3Months" { $TimeQuery = "RELATIVEGT@month@ago@3" }
    "last6Months" { $TimeQuery = "RELATIVEGT@month@ago@6" }
    "last12Months" { $TimeQuery = "RELATIVEGT@month@ago@12" }
}

# Query returns the fields (number, sys_created_on & assignment_group) for all incidents created in the last xx days based on the page time frame
$SNOWQuery = $BaseUrl+"table/incident?sysparm_query=assignment_group.name=ASA^sys_created_on"+$TimeQuery+"&sysparm_display_value=true&sysparm_fields=number%2C%20sys_created_on%2C%20priority"

$Connection = Invoke-RestMethod -Method GET -Uri $SNOWQuery -TimeoutSec 100 -Headers $headers
$Response = $Connection.result
$Results = @()
ForEach ($item in $Response) {
    $v = $item.number
    $g = $item.priority
    $d = Convert-DateEuropeToUS($item.sys_created_on)
   

 $obj = New-Object PSObject
    $obj | Add-Member -type Noteproperty -name Value -value $v
    $obj | Add-Member -type Noteproperty -name Created_On -value $d 
    $obj | Add-Member -type Noteproperty -name Priority -value $g
 $Results += $obj
 }

$Final = $Results | Group-Object -Property Created_On, Priority |
         Select-Object @{n='Date'; e={[datetime]::Parse($_.Values[0]) }},
                       @{n='Name'; e={$_.Values[1] }}, Count

$Final | Select Date, Name, Count


