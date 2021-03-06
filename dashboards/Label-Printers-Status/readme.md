# Label printers statuses Dashboard
This dashboard gives an overview of your Label Printers (or any other printers) installed on a list of servers


## How to use this dashboard
### Setup a PowerShell profile
- Navigate to System > PowerShell
- Create new "Printer Status" Profile to list your servers OR scope them if you are using SquaredUp for SCOM

![screenshot](images/PrinterProfil.png)

### Setup the dashboard
- Copy the JSON from this project
- Create a new dashboard, select the </> on the top right and paste the content of the [dashboard.json](dashboard.json) and click **Apply Changes**.
- For each tile check the PowerShell script to update eventually your scoped print server (I've splitted them by Regions)

![screenshot](images/PrinterByDCs.png)

- Once all the the tiles are working for your needs, click **Publish** and you're done!

> **NOTE:**  each blocks are linked to the printer server manager URL based on the printer name or port number
  
![screenshot](images/PrinterLink.png)

### And voila
![screenshot](Label-printer-status-dashboard.png)
