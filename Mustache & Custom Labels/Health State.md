## Health state

#### Convert specific property values
This converts the value of a given property to determine health state, for example converting a number to a readable word. In this example, if the property of `state` is `0` we convert to `healthy`, if its `1` or `2` we convert to `warning`, and if all else fails, we convert to `critical`.

`{{ state == 0 ? healthy : ((state == 1 || state == 2) ? warning : criticial }}`


#### Convert from a range or threshold
This uses a range of possible values in the `responsetime` property to determine health state, for example under/over a tolerance limit. In this example, if `responsetime` is less than `100` we return `healthy`, if its over `500` we return `critical`, and for everything else / in-between, we return `warning`.

`{{ responsetime < 100 ? healthy : responsetime > 500 ? critical : warning }}`