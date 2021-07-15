# Teams Presence Dashboard
This dashboard is a proof of concept on how to create an overview over the office/home office location of your team, as well as give an overview on the teams status (available, offline, busy, presenting and so on).

The dashboard reads from a JSON file for each person.

## How to use this dashboard

### Client script
The [GetTeamsStatus.ps1](GetTeamsStatus.ps1) PowerShell script will generate the JSON for the dashboard to run on the machine where Teams is running.

#### Configure the script
To configure the client you need to change the following variables:

| variable | Description |
| ----------- | ----------- |
| myguid | Enter a random guid |
| HomeIP | enter your home ip |
| WorkIP | enter your office ip |
| Name | Name to show on the dashboard |
| ProfilePicture | web path to a profile picture(150x150) |
| JsonPath | central path to store the json file in |

#### Run client script
To update the JSON file, simply leave the client running, it will update teams status when the logfile changes

### Setup the dashboard
- Copy JSON from [teams-dashboard.json](teams-dashboard.json) 
- Create a new dashboard, select the </> on the top right and paste the content of the .json and click **Apply Changes**.
- Click **Publish** and you're done!

![editjson](editjson.png)
