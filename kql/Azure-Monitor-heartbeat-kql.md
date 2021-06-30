# Azure Monitor Heartbeat Data
This Kusto query will return timeseries data on Azure Monitor activities from an Azure Log Analytics Workspace.

```
Heartbeat
| summarize Count=count() by  Computer, bin(TimeGenerated, 1s)
```

## How to use in SquaredUp
1. Create a dashboard with the Azure Log Analytics line graph tile
2. Select the workspace that contains the virtual machine metrics
3. Paste the query above into the Query field

![image](https://user-images.githubusercontent.com/18680913/123939291-e88c6d80-d98f-11eb-8f1a-e62bef4e6014.png)


