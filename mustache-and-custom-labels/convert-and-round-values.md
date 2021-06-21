# How to convert a value with decimal places

Often an API will respond with values in the smallest possible denomination, but for display purposes you'll want to convert that value into something human readable and you'll probably want control over the number of decimal places at the same time.

This snippet of JavaScript can be used in the SquaredUp mustache and label fields when dealing with metrics.

```{{Number(value/"something").toFixed("decimal")}}```

## Working example: Converting bytes to gigabytes
We're calling an API that responds with the total number amount of space on a disk as 221,300,711,424 bytes, and want to show that in a Scalar tile as Gigabytes to two decimal places.

### Scalar Vaue formatter

```{{Number(value/1024/1024/1024).toFixed(2)}}```

### Result

![image](https://user-images.githubusercontent.com/18680913/122749161-e6862880-d284-11eb-857f-d78a6edf5a55.png)
