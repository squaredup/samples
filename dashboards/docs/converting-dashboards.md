# Converting Dashboards

When a dashboard has been created in a different SquaredUp product to the one you are using, there maybe some small changes that you need to make to the JSON.

Simply convert the tile names by using a find and replace, the following table contains all the tile names for each product that may need converting.


| Tile Name & Type                     	| SquaredUp for SCOM                 	| Dashboard Server                       	| SquaredUp for Azure                  	|
|-------------------------------------	|-----------------------------------	|----------------------------------------	|-------------------------------------	|
| Web API - Scalar                    	| webapi-as-scalar                  	| generic-webapi-scalar                  	| azure-resources-webapi-scalar       	|
| Web API - Grid                      	| webapi-as-table                   	| generic-webapi-table                   	| azure-resources-webapi-table        	|
| Web API - Bar Graph                 	| scom-webapi-as-bargraph           	| generic-webapi-bargraph                	| azure-resources-webapi-bargraph     	|
| Web API - Line Graph                	| scom-webapi-as-linegraph          	| generic-webapi-linegraph               	| azure-resources-webapi-linegraph    	|
| Web API - Donut                     	| scom-webapi-as-donut              	| generic-webapi-donut                   	| azure-resources-webapi-donut        	|
| Web API - Sparklines                	| scom-webapi-as-sparklines         	| generic-webapi-sparklines              	| azure-resources-webapi-sparklines   	|
| Web API - Status Icons              	| scom-webapi-as-status             	| generic-webapi-status                  	| azure-resources-webapi-status       	|
| Web API - Status Blocks             	| scom-webapi-as-status-block       	| generic-webapi-status-block            	| azure-resources-webapi-status-block 	|
| App Insights - Scalar               	| azureappinsights-as-scalar        	| generic-azureappinsights-scalar        	| azure-resources-appinsights-scalar  	|
| App Insights - Grid                 	| azureappinsights-as-table         	| generic-azureappinsights-table         	| azure-resources-appinsights-table   	|
| Azure Log Analytics - Scalar        	| azureloganalytics-as-scalar       	| generic-azureloganalytics-scalar       	| azure-resources-logs-scalar         	|
| Azure Log Analytics - Grid          	| azureloganalytics-as-table        	| generic-azureloganalytics-table        	| azure-resources-logs-table          	|
| Azure Log Analytics - Line Graph    	| azureloganalytics-as-linegraph    	| generic-azureloganalytics-linegraph    	| azure-resources-logs-linegraph      	|
| Azure Log Analytics - Bar Graph     	| azureloganalytics-as-bargraph     	| generic-azureloganalytics-bargraph     	| azure-resources-logs-bargraph       	|
| Azure Log Analytics- Donut          	| azureloganalytics-as-donut        	| generic-azureloganalytics-donut        	| azure-resources-logs-donut          	|
| Azure Log Analytics - Status Icons  	| azureloganalytics-as-status       	| generic-azureloganalytics-status       	| azure-resources-logs-status         	|
| Azure Log Analytics - Status Blocks 	| azureloganalytics-as-status-block 	| generic-azureloganalytics-status-block 	| azure-resources-logs-status-block   	|
| Elasticsearch - Scalar              	| scom-elasticsearch-scalar         	| generic-elasticsearch-scalar           	| azure-elasticsearch-scalar          	|
| Elasticsearch - Grid                	| scom-elasticsearch-table          	| generic-elasticsearch-table            	| azure-elasticsearch-table           	|
| Elasticsearch - Bar Graph           	| scom-elasticsearch-bargraph       	| generic-elasticsearch-bargraph         	| azure-elasticsearch-bargraph        	|
| Elasticsearch - Line Graph          	| scom-elasticsearch-linegraph      	| generic-elasticsearch-linegraph        	| azure-elasticsearch-linegraph       	|
| Elasticsearch - Donut               	| scom-elasticsearch-donut          	| generic-elasticsearch-donut            	| azure-elasticsearch-donut           	|
| Elasticsearch - Sparklines          	| scom-elasticsearch-sparklines     	| generic-elasticsearch-sparklines       	| azure-elasticsearch-sparklines      	|
| Elasticsearch - Status Icons        	| scom-elasticsearch-status         	| generic-elasticsearch-status           	| azure-elasticsearch-status          	|
| Elasticsearch - Status Blocks       	| scom-elasticsearch-status-block   	| generic-elasticsearch-status-block     	| azure-elasticsearch-status-block    	|
| ServiceNow - Scalar                 	| scom-servicenow-scalar            	| generic-servicenow-scalar              	| azure-servicenow-scalar             	|
| ServiceNow - Grid                   	| scom-servicenow-table             	| generic-servicenow-table               	| azure-servicenow-table              	|
| ServiceNow - Donut                  	| scom-servicenow-donut             	| generic-servicenow-donut               	| azure-servicenow-donut              	|
| Splunk - Grid                       	| scom-splunk-table                 	| generic-splunk-table                   	| azure-resources-splunk-table        	|
| Splunk - Line Graph                 	| scom-splunk-linegraph             	| generic-splunk-linegraph               	| azure-resources-splunk-linegraph    	|
| Splunk - Status Icons               	| scom-splunk-status                	| generic-splunk-status                  	| azure-resources-splunk-status       	|
| Splunk - Status Blocks              	| scom-splunk-status-block          	| generic-splunk-status-block            	| azure-resources-splunk-status-block 	|
