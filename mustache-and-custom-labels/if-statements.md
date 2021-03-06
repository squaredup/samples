# If Statements
## Uses

If statements can be used on returned values to adjust the way the data is displayed. For example, replacing the value ```healthy``` with a healthy status image (check mark), or changing the displayed values color to display a threshold that has been breached.


# Examples
## Color replacement
Simple replacement based on the value uses HTML tags. For example, Low (Yellow), Warning (Orange), Critical (Red):

![image](https://user-images.githubusercontent.com/45064152/125918677-0844f670-8b79-4deb-af1a-290bd886f980.png)

### Custom Label

```
{{#if value == "low" }} <p style="color:Yellow;">{{value}} </p> {{elseif value == "critical" }} <p style="color:Red;">{{value}} </p>{{elseif value == "warning" }}  <p style="color:Orange;">{{value}} </p> {{/if}}
```

## Image replacement
In the image below, you can see the grid tile (SQL, PowerShell, Web API) is used with replacements of different values for the severity and integration logo:

![image](https://user-images.githubusercontent.com/45064152/125915926-e30ec5d6-c685-43dd-a6b3-749d46665e41.png)

This relies on an the referenced image being stored in the ```/images/``` folder within ```/inetpub/wwwroot/``` on the SquaredUp server.

The if statement is added in the grid columns configuration for Severity:

![image](https://user-images.githubusercontent.com/45064152/125916323-a3ca51d4-86b9-436c-ae66-35b1f3904f4a.png)

### Custom Label

```
{{#if value == "low" }}<img src="/images/healthy.png" width="16" />{{elseif value == "critical" }}<img src="/images/critical.png" width="16" />{{elseif value == "warning" }}<img src="/images/warning.png" width="16" />{{/if}}
```

And the Integrations column:

![image](https://user-images.githubusercontent.com/45064152/125917819-5cc1feb7-3e83-4c68-9412-2e91cde23c86.png)

### Custom Label

```
{{#if value.integration.summary == "Pingdom" }}<img src="/images/pingdom-dark.png" width="60" />{{/if}}
```

You'll note the above has a different key path to where the data is located - This can be found in the response data of your tile, or by using the mustache picker ```{{}}```
