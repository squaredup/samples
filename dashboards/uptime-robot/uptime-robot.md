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
- Enter base url for the PagerDuty API i.e. https://api.uptimerobot.com/v2/ 


### Setup the dashboard
- Copy the JSON from this project
- Create a new dashboard, select the </> on the top right and paste the content of the .json and click **Apply Changes**.
- Dashboard should display as shown below, with high level insight into the web monitoring from your UptimeRobot instance
  
  
![image](https://user-images.githubusercontent.com/45064152/125944272-91cf9680-25e0-4bd1-846c-f128ce7fa987.png)
 
