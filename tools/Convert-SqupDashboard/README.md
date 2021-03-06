# Convert-SqupDashboard #

Convert SquaredUp dashboard JSON from one product version to another.

## Description ##

The `Convert-SqupDashboard` cmdlet is a PowerShell script that will read in a JSON file and then save the equivalent version for a different SquaredUp product.

For example, given a dashboard for "SquaredUp for SCOM", there are tiles that are specific to that product.  Running this script against the dashboard JSON will convert the tile names to a target product, like SquaredUp for Azure.

## Examples ##

### Example 1: Call `Convert-SqupDashboard` cmdlet to convert dashboard JSON ###

1. Make note of your working directory path, for example `C:\Users\TempUser\Desktop\Convert Dashboards`.
2. Download your dashboard JSON as `squaredup-for-scom.json`.
3. Make note of the Tile List conversion table file name, for example `converting-dashboards.csv`.
4. Choose a target type of `SCOM`, `Azure`, or `DS`.
5. Choose a target file name (and optional path), for example `Output\Generic2.json`. 

**PowerShell:**

    PS C:\>.\Convert-SqupDashboard.ps1 -source "squaredup-for-scom.json" -tileList "converting-dashboards.csv" -target "Azure" -path "C:\Users\TempUser\Desktop\" -OutFile "Output\Generic2.json"


**Output:**

    Convert-SqupDashboard.ps1
	Copyright 2018 Squared Up Limited, All Rights Reserved.
	
	NOTE: Converting dashboard
	NOTE: Setting up CSV conversion table
	INFO: CSV input file exists
	INFO: Dashboard JSON input file exists
	NOTE: Converting SCOM to Azure
	NOTE: Finsihed

### Example 2: Call `Convert-SqupDashboard` cmdlet, but use the GitHub conversion list ###

1. Make note of your working directory path, for example `C:\Users\TempUser\Desktop\Convert Dashboards`.
2. Download your dashboard JSON as `squaredup-for-scom.json`.
4. Choose a target type of `SCOM`, `Azure`, or `DS`.
5. Choose a target file name (and optional path), for example `Output\Generic2.json`. 


**PowerShell:**

    PS C:\>.\Convert-SqupDashboard.ps1 -source "squaredup-for-scom.json" -target "Azure" -path "C:\Users\TempUser\Desktop\" -OutFile "Output\Generic2.json"


**Output:**

    Convert-SqupDashboard.ps1
	Copyright 2018 Squared Up Limited, All Rights Reserved.
	
	NOTE: Converting dashboard
	NOTE: Retreiving conversion table from GitHub
	INFO: Dashboard JSON input file exists
	NOTE: Converting SCOM to Azure
	NOTE: Finsihed



## Parameters ##

### -Source ###

(Required) The name of the file that contains the source JSON.  The Path parameter will be prepended to this parameter.

### -TileList ###

(Optional) The name of the CSV file that contains the cross-walk for conversion.  If not supplied, the script will download a copy from GitHub to perform the conversion.

### -Target ###

(Required) Specifies one of three target types:  SCOM, Azure, or DS.

### -Path ###

(Required) Specifies the main path to where the source file and Tile List are located.  


### -OutFile ###

(Required) Specifies the name (and path) to where the converted file will be saved.  The Path parameter will be prepended to this parameter.