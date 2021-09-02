# Label printers statuses Dashboard
This dashboard gives an overview of your Label Printers (or any other printers) installed on a list of servers


## How to use this dashboard
### Setup a PowerShell profil
- Navigate to System > PowerShell
- Create new "Printer Status" Profile tu list your servers OR scope them if you are using SquaredUp for SCOM
![screenshot](PrinterProfil.png)

### Setup the dashboard
- Copy the JSON from this project
- Create a new dashboard, select the </> on the top right and paste the content of the .json and click **Apply Changes**.
- For each tile check the PowerShell script to update eventually your scoped print server (I've splitted them by Regions)
![screenshot](PrinterByDCs.png)

- Once all the the tiles are working for your needs, click **Publish** and you're done!

> **NOTE:**  each blocks are link to the printer server manager URL based on the printer name or port number
  
![screenshot](PrinterLink.png)




