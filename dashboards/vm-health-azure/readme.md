# Azure Virtual Machines Health `KQL`

This SquaredUp for Azure dashboard gives an overview of Virtual Machine Health focused on free disk space, heartbeat and CPU utilization using Kusto Query Language (KQL) to query a workspace in Azure.

o	Free space shows the amount of free space for each disk shown by computer, disk, including a bar chart for the % free disk space as well as the free space in GB and when the data was generated.
o	Computer AVG CPU shows the computer and the average CPU in a bar chart.
o	Agent details show the computer and it’s state, the environment it is in, what Operating System it is running, the Azure Resource (if applicable) and when the last heartbeat occurred for that computer. 
o	Agent details (trend) shows the history of heartbeats for the computers in the environment. 

## How to use this dashboard in SquaredUp for Azure
- Ensure your virtual machines are collecting metrics in an Azure Log Analytics Workspace.
- Create a new dashboard, select the </> on the top right and copy the content of the .json file above and click **Apply Changes**.
- Set the Workspace for each tile, select the cog icon and expand **workspace**, select the name of the workspace with the virtual machine metrics and click **done**
- Click publish to save the working dashboard.

## How to use this dashboard in SquaredUp for SCOM or Dashboard Server
The Kusto queries (KQL) used to create this dashboard can be found in the [KQL samples folder](https://github.com/squaredup/samples/tree/master/kql).

## Images
![darkmode](https://user-images.githubusercontent.com/18680913/123941452-12df2a80-d992-11eb-878f-0aa5bed3e09f.png)
