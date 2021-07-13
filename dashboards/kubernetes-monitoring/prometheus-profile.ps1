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