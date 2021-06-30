# Virtual Machine Free Disk Space

This KQL snippet will retrieve the following table of data for all virtual machines in an Azure Log Analytics Workspace.

| Computer   	| Disk 	| % Free Space 	| Free Space GB 	| Time Generated 	|
|------------	|------	|--------------	|---------------	|----------------	|
| Name 	      | C:   	| 50           	| 20            	| 06-30-2021     	|
| Name       	| D:   	| 30           	| 10            	| 06-30-2021     	|


```
let disk_free_space_percent=
Perf 
| where TimeGenerated > ago(30m) 
| where ObjectName == "LogicalDisk" and CounterName == "% Free Space" 
| summarize (TimeGenerated, Free_Space_Percent)=arg_max(TimeGenerated, CounterValue) by Computer, InstanceName 
| where strlen(InstanceName) ==2 and InstanceName contains ":";
let disk_free_MB=
Perf 
| where TimeGenerated > ago(30m) 
| where ObjectName == "LogicalDisk" and CounterName == "Free Megabytes" 
| summarize (TimeGenerated, Free_MB)=arg_max(TimeGenerated, CounterValue) by Computer, InstanceName 
| where strlen(InstanceName) ==2 and InstanceName contains ":";
disk_free_space_percent 
| join (
   disk_free_MB 
) on Computer, InstanceName
| project Computer, InstanceName, toint(Free_Space_Percent), toint(Free_MB * 0.001) , format_datetime(TimeGenerated, 'MM-dd-yyyy')
| order by Free_Space_Percent asc
```

## How to use in SquaredUp
1. Create a dashboard with the Azure Log Analytics grid tile
2. Select the workspace that contains the virtual machine metrics
3. Paste the query above into the Query field
4. Choose the columns you wish to be displayed

![diskspacekql](https://user-images.githubusercontent.com/18680913/123928080-71ea7280-d985-11eb-8724-605c213a7527.png)
