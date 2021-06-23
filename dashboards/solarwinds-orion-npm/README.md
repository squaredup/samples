# SolarWinds Orion Nodes `API`

This dashboard gives an overview of nodes alongside summary of heatlh from SolarWinds Orion using the powerful Web API and dashboard sharing capabilities of SquaredUp. 

## Requirements
- The images folder needs to exist specifically in the IIS root i.e. C:\inetpub\wwwroot and the structure of \health-icons\ and \logos\ should be maintained (or the dashboard JSON updated to suit).
- Create a WebAPI (Basic Auth) provider under Settings > Integrations. Name it exactly “Solarwinds" (case-sensitive, if you name it differently, you will need to select the provider manually for each tile on the dashboard). Fill in all the required details to connect to your own SolarWinds environment (url, username, password, ignore invalid ssl, etc).
- Create a new dashboard, select the </> on the top right and copy the content of the .json file above and click Apply Changes
- Ignore the error about the signed requests, publish the dashboard and refresh the page to clear them
- Edit the Unhealthy Nodes and All Nodes to replace the row link URL to that of your SolarWinds environment
 
## Images
![SolarWinds](https://user-images.githubusercontent.com/86045911/122592867-c3793000-d05c-11eb-9a13-df82b298eb60.png)
