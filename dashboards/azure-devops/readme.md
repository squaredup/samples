# Azure DevOps Dashboard
This dashboard gives an overview of the performance of build and release pipelines by using the WebAPI tile to query https://analytics.dev.azure.com to get the data.

- Build – a simple summary of the number of failed builds in the last 14 days.
- Build Duration – average time for build completion.
- Build Failures – number of failures in any release pipeline per day. 
- Build Failure By Stage Name – a count of fails per release stage. 
- Job Queue – count of the number of requests per day that end up in a queue. 
- MS Agent Usage – number of MS hosted agents that are in use.
- E2ETesting Failures – three tiles showing the count of fails for specific automation tests in that release pipeline stage.
- Average E2E Testing Time – three tiles returning the average run time for automation stages.

## How to use this dashboard
### Setup a Web API integration
- Navigate to System > Integrations
- Create new Web API integration called "Azure Devops"
- Enter base url for your Azure DevOps Analytics account: i.e. https://analytics.dev.azure.com/your-org/tenant-id/
- Save with appropriate authentication details

### Setup the dashboard
- Copy the JSON from this project
- Create a new dashboard, select the </> on the top right and paste the content of the .json and click **Apply Changes**.
- For each tile check the **http mode** panel and update relevant IDs
![image](https://user-images.githubusercontent.com/18680913/124292713-cc362f80-db4d-11eb-8621-ca4b6490ab2b.png)
- Once all the the tiles are working with your IDs click **Publish** and you're done!
  
![screenshot](https://user-images.githubusercontent.com/18680913/124293196-49fa3b00-db4e-11eb-8a5e-a6c327ccce4f.png)
