# Calculating “expected maximum” from the Actual CPU %

This KQL example will shows a calculated “expected maximum” from the Actual CPU % in a Line Graph visualization which could helping quickly identify anomalies (standard deviations from the normal range) on this Virtual Machine.

`
InsightsMetrics 
| where Computer startswith "{{scope[0].name}}" 
| where Namespace == "Processor" 
| where Name == "UtilizationPercentage" 
| summarize stdev(Val), avg(Val) by Computer 
| summarize ExpectedMax = sum(avg_Val + stdev_Val) by Computer 
| join kind=inner 
    InsightsMetrics on Computer 
    | where Computer startswith "{{scope[0].name}}" 
    | where Namespace == "Processor" 
    | where Name == "UtilizationPercentage" 
    | summarize Actual = avg(Val) by bin(TimeGenerated, 5m), ExpectedMax, Namespace 
`
![image](https://user-images.githubusercontent.com/18680913/122296356-37e39000-cef2-11eb-85a3-786db24ab01a.png)
