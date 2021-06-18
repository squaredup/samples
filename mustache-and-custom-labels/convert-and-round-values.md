# How to convert a value with decimal places

Often an API will respond with values in the smallest possible denomination, but for display purposes you'll want to convert that value into something human readable and you'll probably want control over the number of decimal places at the same time.

This snippet of JavaScript can be used in the SquaredUp mustache and label fields when dealing with metrics.

```{{Number(value/"something").toFixed("decimal")}}```

## Working example: Converting bytes to gigabytes
We're calling an API that responds with the total number amount of space on a disk as 221,300,711,424 Bytes, and want to show that in a Scalar tile as Gigabytes to two decimal places.

Scalar Vaue formatter

```{{Number(value/1073741824).toFixed(2)}}```

Result

![image](https://user-images.githubusercontent.com/18680913/122580806-43e46480-d04e-11eb-87ce-bc8ad6ab53eb.png)
