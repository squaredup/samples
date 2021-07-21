# Octopus Dashboard
This dashboard gives an overview of deployments and tasks from Octopus Deploy

- Deployments - High level view of all deployments
- Tasks - High level view of all tasks


## How to use this dashboard
### Octopus Logo
- The images folder needs to exist specifically in the IIS root i.e. C:\inetpub\wwwroot and the structure of \logos\ should be maintained (or the dashboard JSON updated to suit)
- Copy the Octopus.png logo from the images folder in the repo to this folder
### Setup a Web API integration
- Navigate to System > Integrations
- Create new WebAPI integration, using Simple auth, called "OctopusDeploy"
- Enter base url for the Octopus API i.e. https://octopus.company.com/api
- Add the x-Octopus-ApiKey default header with your token i.e. ```API-LKASJDLKAJDLKASLDKJ```


### Setup the dashboard
- Copy the JSON from this project
- Create a new dashboard, select the </> on the top right and paste the content of the .json and click **Apply Changes**.
- Dashboard should display as shown below, with high level insight into the Deployments and Tasks from your OctopusDeploy instance
