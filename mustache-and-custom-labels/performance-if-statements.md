# Performance Tile If Statements
## Uses

If statements can be used on returned values to adjust the way the data is displayed. For example, changing the values color to display a threshold that has been breached.


# Examples
## Color replacement
Simple replacement based on the value using < (less than), > (greater than), or == (equals to). Along with specifying our color, for example, Low (Yellow), Warning (Orange), Critical (Red).

In the example below we have entered a threshold of < 70 (less than 70), and we have specified this to display in red. This means the text next to any displayed value that is less than 70 will display in red:

![image](https://user-images.githubusercontent.com/50104140/126457666-a5d4852e-adfc-4f63-8887-53037e98ebb8.png)


### Custom Label

```
{{#each values}}<span {{#if value < 70}}style="color:red"{{/if}}>{{key.counter}} [{{key.instance}}] - {{key.managedEntityPath}}</span>{{/each}}
```


