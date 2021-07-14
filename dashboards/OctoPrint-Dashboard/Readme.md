# Introduction
This dashboard can pull information from the REST api in octoprint to show you printerstatus, progress and temperatureinformation on your printer.
The dashboard utilizes powershell scripts to connect to the restapi and to do dataconversion on the temperaturedata.

![dashboard](dashboard.png)
# powershell Profile
This dashboard uses the powershell profile to set up the url and apikey for your octoprint instance

# Steps to import dashboard

## Powershell profile
Create a new profile with the following information

`$baseurl = "https://youroctorprinturl"`

`$APIKEY = "youapikey"`

`$header = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"`

`$header.Add("X-API-KEY", $APIKEY)`

![Profilesetup](ProfileSetup.png)


## Create dashboard
To create the dashboard you need to create a new dashboard and copy the json code from the repo into the dashboard.
![editjson](editjson.png)

## Edit interval and timeout
Remember to edit the interval to make sure you dont hammer the webservice on octoprint and ruin your print


## Further documentation

Follow this guide to find your API key for octoprint:

[How to find my octoprint api key](https://docs.octoprint.org/en/master/api/general.html#authorization)

[Octoprint API Documentation](https://docs.octoprint.org/en/master/api/index.html)



