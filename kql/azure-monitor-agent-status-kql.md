# Azure Monitor Agent Status Information

This Kusto query will retrieve the following table of data for all virtual machines in an Azure Log Analytics Workspace.

| Computer 	| State 	| Environment 	| OS      	| Azure Resource 	| Last Heartbeat 	|
|----------	|-------	|-------------	|---------	|----------------	|----------------	|
| HostName 	| 🟢     	| Azure       	| Windows 	| Name           	| timeago        	|

```
Heartbeat
| where TimeGenerated > ago(30m)
| summarize LastHeartbeat = max(TimeGenerated) by Computer
| extend State = iff(LastHeartbeat < ago(1h), '🔴', '🟢')
| extend TimeFromNow = now() - LastHeartbeat
| extend ["TimeAgo"] = strcat(case(TimeFromNow < 2m, strcat(toint(TimeFromNow / 1m), ' seconds'), TimeFromNow < 2h, strcat(toint(TimeFromNow / 1m), ' minutes'), TimeFromNow < 2d, strcat(toint(TimeFromNow / 1h), ' hours'), strcat(toint(TimeFromNow / 1d), ' days')), ' ago')
| join (
    Heartbeat
    | where TimeGenerated > ago(30m)
    | extend Packed = pack_all()
    )
    on Computer
| where TimeGenerated == LastHeartbeat
| join (
    Heartbeat
    | where TimeGenerated > ago(30m)
    | make-series InternalTrend=iff(count() > 0, 1, 0) default = 0 on TimeGenerated from ago(30m) to now() step 1h by Computer
    | extend Trend=array_slice(InternalTrend, array_length(InternalTrend) - 30, array_length(InternalTrend) - 1)
    | extend (s_min, s_minId, s_max, s_maxId, s_avg, s_var, s_stdev) = series_stats(Trend)
    | project Computer, Trend, s_avg
    )
    on Computer
| order by State, s_avg asc, TimeAgo
| project Computer=strcat('🖥️ ', Computer), State, ["Environment"] = iff(ComputerEnvironment == "Azure", ComputerEnvironment, Category), ["OS"]=iff(isempty(OSName), OSType, OSName), ["Azure Resource"]=split(['ResourceId'], "/")[-1], ["Time"]=strcat('🕒 ', TimeAgo), ["Heartbeat Trend"]=Trend, ["Details"]=Packed
```

## How to use in SquaredUp
1. Create a dashboard with the Azure Log Analytics grid tile
2. Select the workspace that contains the virtual machine metrics
3. Paste the query above into the Query field
4. Choose the columns you wish to be displayed

![image](https://user-images.githubusercontent.com/18680913/123931171-47e67f80-d988-11eb-97ea-5e0cdbfa4f42.png)
