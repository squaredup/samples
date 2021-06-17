## Salesforce Overview `Dashboard Server`

This is a really simple dashboard showing how to use the Salesforce API to query for data using SOQL (Salesforce Object Query Language).

The dashboard has some tiles using the SOQL count function to sum up accounts, contacts and deals, then a simple grid tile showing tasks due to day.

It makes a `GET` request to their `query` endpoint, and provides the SOQL as a query parameter as `q = MY QUERY`

### Requirements

Each tile is looking for a WebAPI provider called `Salesforce`. Set that up first and then paste the JSON into a new blank dashboard.