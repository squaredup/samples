# Pingdom Dashboard
This dashboard gives an overview of Pingdom checks using PowerShell scripts against the Pingdom API

- Check Health - Status block showcasing health and last response time
- Check Status - Donut sumarrizing checks by status
- Checks by Type - Donut summarizing checks by check type
- Last Response Time - Scalar values for single checks
- Last Response Time - Bar of all checks' last response time
- Multiple Reponse Times - Line graph of two checks (easily adapted to include more than two checks)
- Single Response Time - Line graph for single check
- Checks Detail - Full check output


## How to use this dashboard
### Setup a PowerShell Profile
- Navigate to System > PowerShell
- Create a new profile called Pingdom containing following (add your own Bearer token without the asterix):

```$url = "https://api.pingdom.com/api/3.1/"

$headers = @{
            authorization = "Bearer ***TOKEN GOES HERE***"
} 
```


### Setup the dashboard
- Copy the JSON from this project
- Create a new dashboard, select the </> on the top right and paste the content of the .json and click **Apply Changes**.
- Dashboard should display as shown below, with high level insight into the Deployments and Tasks from your OctopusDeploy instance

