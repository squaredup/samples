```{{#each values}}<span {{#if value < 70}}style="color:red"{{/if}}>{{key.counter}} [ {{key.instance}} ] - {{key.managedEntityPath.split('.')[0]}}</span>{{/each}}```
