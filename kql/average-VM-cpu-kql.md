# Average VM CPU
This Kusto query will retrieve the following table of data for all virtual machines in an Azure Log Analytics Workspace.

| Computer 	| Avg CPU % 	|
|----------	|-----------	|
| Name     	| 50        	|
| Name     	| 50        	|


```
Perf 
| where TimeGenerated > ago(5m) 
| where ObjectName == "Processor" and CounterName == "% Processor Time" and InstanceName == "_Total" 
| summarize AvgCPUPercentage = avg(CounterValue) by Computer
| project Computer, toint(AvgCPUPercentage)
| sort by Computer asc
```

## How to use in SquaredUp
1. Create a dashboard with the Azure Log Analytics grid tile
2. Select the workspace that contains the virtual machine metrics
3. Paste the query above into the Query field
4. Choose the columns you wish to be displayed

![image](https://user-images.githubusercontent.com/18680913/123929632-ea056800-d986-11eb-9d40-951beafae029.png)
