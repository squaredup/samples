# SolarWinds Orion Nodes `API`

This dashboard gives an overview of nodes alongside summary of heatlh from SolarWinds Orion using the powerful Web API and dashboard sharing capabilities of SquaredUp. 

## Requirements

- Copy the images repository on the SquaredUp IIS folder (or individually if the images repository already exists)
- Create a WebAPI (Basic Auth) provider under Settings > Integrations. Name it exactly “Solarwinds” (if you name it differently, you will need to select the provider manually for each tile on the dashboard). Fill in all the required details to connect to your own SolarWinds environment (url, username, password, ignore invalid ssl, etc).
- Create a new dashboard, select the <> on the top right and copy the content of the dashboard.json file and click Apply Changes
 
## Images
![SolarWinds](https://user-images.githubusercontent.com/86045911/122592867-c3793000-d05c-11eb-9a13-df82b298eb60.png)
