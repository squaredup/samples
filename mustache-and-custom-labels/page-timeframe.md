# Page timeframe

---

### Use page timeframe values to set a query parameter
This example takes the difference between the `{{timeframe.unixStart}}` and `{{timeframe.unixEnd}}` mustaches and uses that difference to return a number that grows as the timeframe is increased. A simple use case is returning a value for an API query that controls something like data granularity. The longer the timeframe, the higher number. This returns `15` when the timeframe is 1 hour, `60` when the timeframe is 12 hours, `120` when the timeframe is 24 hours...

`{{ (timeframe.unixEnd - timeframe.unixStart) <= 3600000 ? 15 : (timeframe.unixEnd - timeframe.unixStart) <= 43200000 ? 60 : (timeframe.unixEnd - timeframe.unixStart) <= 86400000 ? 120 : (timeframe.unixEnd - timeframe.unixStart) <= 604800000 ? 600 : (timeframe.unixEnd - timeframe.unixStart) <= 2592000000 ? 3600 : (timeframe.unixEnd - timeframe.unixStart) <= 7768800000 ? 7200 : (timeframe.unixEnd - timeframe.unixStart) <= 15703200000? 21600 : 43200 }}`

---