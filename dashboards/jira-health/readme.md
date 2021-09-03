# Jira Health dashboard

The goal was to have one dashboard that gives you a quick view into the state of your next release and the overall Jira project.

One of the main issues to overcome when returning a large number of issues from Jira is the API has a 100 issue limit. We solve this by using a PowerShell tile and making multiple API calls.

Release completion is calculated by total issues Closed or Merged, divided by the total issues in the release. This could be further fine tuned to only look at specific issue types that you care about by changing the API call in the script.
Similarly on the Project side the Top 10 list (Web API) could be set to be any issue type by adjusting the API call.
The trend line is calculated by creating an array


## How to use this dashboard

### Prerequisities
* A Jira cloud instance with at least one project and version in it.
* **SquaredUp minimum version 5.2** --> [Download](https://download.squaredup.com/)

### Setup the Web API integration
- Navigate to System > Integrations
- Create new Web API integration called "Jira"
- Enter base url for your Jira instance API endpoint: i.e. `https://<your-prometheus-url/api/v1/`
- Save with appropriate authentication details

### Setup the PowerShell tile
- The Default provider can be used
- Add a profile that contains the details you will send in the Header variable of your API. This will be an encoded version of your username and password pair - https://community.atlassian.com/t5/Jira-questions/JIRA-API-with-Powershell/qaq-p/992343
- In the dashboard the profile is called Jira PS

### Setup the dashboard
- Copy the JSON from this project
- Create a new dashboard, select the </> on the top right and paste the content of the .json and click **Apply Changes**.
- Click **Publish** and you're done!
