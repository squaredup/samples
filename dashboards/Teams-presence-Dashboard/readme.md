# Teams Presence Dashboard
This dashboard is a proof of concept on how to create an overview over the office/home office location of your team, as well as give an overview on the teams status (available, offline, busy, presenting and so on).

The dashboard reads from a JSON file for each person.

# Configure client
To configure the client you need to change the following variables:

| variable | Description |
| ----------- | ----------- |
| myguid | Enter a random guid |
| HomeIP | enter your home ip |
| WorkIP | enter your office ip |
| Name | Name to show on the dashboard |
| ProfilePicture | web path to a profile picture(150x150) |
| JsonPath | central path to store the json file in |

# Run client
To update the json file, simply leave the client running, it will update teams status when the logfile changes

# Steps to import dashboard

## Create dashboard
To create the dashboard you need to create a new dashboard and copy the JSON code from [teams-dashboard.json](teams-dashboard.json) into the dashboard.
![editjson](editjson.png)
