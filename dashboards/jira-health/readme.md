# Jira Health dashboard

The goal was to have one dashboard that gives you a quick view into the state of your next release and the overall Jira project.

One of the main issues to overcome when returning a large number of issues from Jira is the API has a 100 issue limit. We solve this by using a PowerShell tile and making multiple API calls.

Release completion is calculated by total issues Closed or Merged, divided by the total issues in the release. This could be further fine tuned to only look at specific issue types that you care about by changing the API call in the script.
Similarly on the Project side the Top 10 list (Web API) could be set to be any issue type by adjusting the API call.
The trend line is calculated by creating an array.

## How to use this dashboard

### Prerequisities
- A Jira cloud instance with at least one project and version in it.
- **SquaredUp minimum version 5.2** --> [Download](https://download.squaredup.com/)

### Setup the Web API integration
- Create a Web API token in Jira - https://support.siteimprove.com/hc/en-gb/articles/360004317332-How-to-create-an-API-token-from-your-Atlassian-account
- Navigate to System > Integrations
- Create a new 'Basic Auth' Web API integration called "Jira API basic"
- Enter base url for your Jira instance API endpoint: i.e. `https://<JIRA domain>.atlassian.net/rest/api/3/`
- Save with appropriate authentication details, using the API token as the password.

### Setup the PowerShell Profile
- Add a profile called named "Jira PS"
- The profile will contain the details you will send in the Header variable of your API. This will be an encoded version of your username and password pair
- Copy and paste the sample below and update accordingly
```
$user = 'username'
$pass = 'password'
$pair = "$($user):$($pass)"

$encodedCreds = [System.Convert]::ToBase64String([System.Text.Encoding]::ASCII.GetBytes($pair))

$basicAuthValue = "Basic $encodedCreds"

$Headers = @{
 Authorization = $basicAuthValue
}

Invoke-WebRequest -Uri 'https://<jira_base_url>/rest/api/2/search?jql=project = CIT AND issuetype = "JIRA Request" AND (created >= startOfDay(-30d) OR updated >= startOfDay(-30d))' `
-Headers $Headers
```

### Setup the dashboard
- Copy the JSON from this project
- Create a new dashboard, select the </> on the top right and paste the content of the .json and click **Apply Changes**.
- Click **Publish** and you're done!
