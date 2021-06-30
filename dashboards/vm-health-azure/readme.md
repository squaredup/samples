# Azure Virtual Machines Health `KQL`

This SquaredUp for Azure dashboard gives an overview of Virtual Machine Health using Kusto Query Language (KQL) to query a workspace in Azure.

## How to use this dashboard in SquaredUp for Azure
- Ensure your virtual machines are collecting metrics in an Azure Log Analytics Workspace.
- Create a new dashboard, select the </> on the top right and copy the content of the .json file above and click **Apply Changes**.
- Set the Workspace for each tile, select the cog icon and expand **workspace**, select the name of the workspace with the virtual machine metrics and click **done**
- Click publish to save the working dashboard.

## How to use this dashboard in SquaredUp for SCOM or Dashboard Server
The Kusto queries (KQL) used to create this dashboard can be found in the [KQL samples folder](https://github.com/squaredup/samples/tree/master/kql).

## Images
![darkmode](https://user-images.githubusercontent.com/18680913/123941452-12df2a80-d992-11eb-878f-0aa5bed3e09f.png)
