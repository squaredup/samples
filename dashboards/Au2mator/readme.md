# Au2mator Dashboard

In the first half, we use SQL and PowerShell tiles to present Performance and Health Counters for the au2mator- Self Service Portal and a Web Tile to directly open the Self Service Portal in a new Tab.

### Total Requests
The SQL Donut Tile is displaying the actual State of all Requests and their State. Here we are using the “Timeframe-Option.”

### Heavy Users
Then we used the PowerShell Donut Tile cause the au2mator DB stored the SamAccountName, and with PowerShell, we get the Displayneme from Active Directory.

### Total Services
Just a Count on the number of our au2mator Services.

### Top 8 Service Usage
Also, a SQL Donut Tile to present the Top 8 Service by usage

### Start au2mator
A Web Tile to start the au2mator – Self Service Portal in a new Tab

![image](https://user-images.githubusercontent.com/37934234/129005052-d158c62f-dea7-478a-b15b-e6fccf84a195.png)

The second half is intended to present a quick Overview of our Automation Engines. So we see System Center Orchestrator and Azure Automation Runbook Health in that Area. All of these Tiles are not configured to use the “Timeframe-Option.”

### Runbooks Job Status
See all Runbook Jobs which have the state of failed, warning, or success with a SQL Donut Tile

### Running Runbooks
A Quick View with SQL Grid to get a list of all Running and Queued Runbook Jobs

### Azure Automation
Using the Azure Log Analytics to present the Azure Automation Runbook Jobs Sate as a Donut Tile
 
 ![image](https://user-images.githubusercontent.com/37934234/129005106-33ca3271-9c60-4234-9000-e9db372de93e.png)
 
## Au2mator Logo
- The images folder needs to exist specifically in the IIS root i.e. C:\inetpub\wwwroot and the structure of \logos\ should be maintained (or the dashboard JSON updated to suit)
- Copy the PagerDuty.png logo from the images folder in the repo to this folder
Setup the dashboard
- Copy the JSON from this project
- Create a new dashboard, select the </> on the top right and paste the content of the .json and click **Apply Changes**.
- For each tile check the *connection string* and replace with the right one.
- Once all the tiles are working with your connection strings click **Publish** and you're done!
  

