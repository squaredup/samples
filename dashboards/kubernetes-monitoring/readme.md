# Kubernetes Monitoring Dashboard (with Prometheus)

This dashboard visualizes the performance of a Kubernetes cluster by getting metrics from [Prometheus](https://prometheus.io/) using PromQL in the SquaredUp WebAPI and PowerShell tiles. 

- Basic cluster information displayed in a grid
- Network traffic sent and received for the cluster
- CPU, memory and disk utilization for the cluster
- CPU, memory and disk used by each node in the cluster

The tiles on this dashboard automatically adjust the queries to Prometheus based of the page time frame being selected. The Rate and Step variables are handled in the [PowerShell Profile script](https://github.com/squaredup/samples/blob/Kubernetes-Dashboard/dashboards/kubernetes-monitoring/prometheus-profile.ps1) and can be amended to suit your use case.

## How to use this dashboard

### Prerequisities
* A running Kubernetes cluster (this dashboard was tested with an [AWS EKS](https://aws.amazon.com/eks) deployment)
* Prometheus is deployed and collecting metrics for the cluster
* Prometheus API end point is externally accessible
* **SquaredUp minimum version 5.2** --> [Download](https://download.squaredup.com/)

### Setup the Web API integration
- Navigate to System > Integrations
- Create new Web API integration called "Prometheus"
- Enter base url for your Prometheus instance API endpoint: i.e. `https://<your-prometheus-url/api/v1/`
- Save with appropriate authentication details

### Setup the PowerShell Profile
- Navigate to System > PowerShell
- Create new Profile called "Prometheus"
- Copy and paste the sample profile script: [prometheus-profile.ps1](https://github.com/squaredup/samples/blob/Kubernetes-Dashboard/dashboards/kubernetes-monitoring/prometheus-profile.ps1) 

```
# Set the end point of the Prometheus API endpoint
$uri = "https://<your-prometheus-url/api/v1/query_range"

# Changes step and rate values based on the timeframe of the page.
switch ($timeFrame) {
    "last1Hour" { $step = '60'; $timeago = -1; $rate = '2m' }
    "last12Hours" { $step = '600'; $timeago = -12; $rate = '30m' }
    "last24Hours" { $step = '900'; $timeago = -24; $rate = '1h' }
    "last7Days" { $step = '1200'; $timeago = -168; $rate = '6h' }
    "last30Days" { $step = '1800'; $timeago = -720; $rate = '1d' }
    "last3Months" { $step = '7200'; $timeago = -2160; $rate = '1d' }
    "last6Months" { $step = '10800'; $timeago = -4320; $rate = '7d' }
    "last12Months" { $step = '21600'; $timeago = -8640; $rate = '7d' }
}

# Get the page timeframe start and end
$end = Get-Date -Date (Get-Date) -UFormat %s
$start = Get-Date -Date ((Get-Date).AddHours($timeago)) -UFormat %s
```

- Update the PowerShell Profile script with your Prometheus instance API endpoint
- Modify the PowerShell Profile script to handle the authentication method required by your deployment of Prometheus
- **Save**

### Setup the dashboard
- Copy the JSON from this project
- Create a new dashboard, select the </> on the top right and paste the content of the .json and click **Apply Changes**.
- Click **Publish** and you're done!

## Screenshot
![Kubernetes Monitoring](https://github.com/squaredup/samples/blob/Kubernetes-Dashboard/dashboards/kubernetes-monitoring/images/Kubernetes%20Monitoring.png)
