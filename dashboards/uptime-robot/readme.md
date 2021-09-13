# Uptime Robot
Uptime Robot is an uptime monitoring platform, providing a free tier to create up to 50 free monitors for Website, SSL, Port and Ping, as well as heartbeats to monitor reoccurring jobs. 
This dashboard gives an overview of monitoring configured using Uptime Robot’s website monitoring features.


- Response Times – Bar – Displaying current response times for our web tests
- Status – Status Block – Showing health of tests, URL, and response time
- Configuration – Grid - Displaying configuration for the tests



## How to use this dashboard
### Setup a Web API integration
- Navigate to System > Integrations
- Create new WebAPI integration, using Simple auth, called "UptimeRobot"
- Enter base url for the UpTimeRobot API i.e. https://api.uptimerobot.com/v2/ 


### Setup the dashboard
- Copy the JSON from this project
- Create a new dashboard, select the </> on the top right and paste the content of the .json and click **Apply Changes**.
- Add your api_Key to the headers/data section in each tile
- Dashboard should display as shown below, with high level insight into the web monitoring from your UptimeRobot instance
  
  
![image](https://github.com/squaredup/samples/blob/36998533c55160b7d2741856c116c77c4dfb2e50/dashboards/uptime-robot/Images/Uptime%20Robot.png)
 
