## Timeago

Timeago takes a few parameters:.

`function  (dateTime, showAbsolute, showTime, withoutSuffix, withPrefix)`

| Name | Type | Optional | Default | Purpose |
|--|--|--|--|--|
| dateTime | int/string | no | N/A | timestamp to convert |
| showAbsolute | true/false | yes | N/A | Show absolute date (eg Aug 10 2018) or period (5 mins) |
| showTime | true/false | yes | true | Add time onto date (eg Aug 10 2018 16:20) |
| withoutSuffix | true/false | yes | false | adds "ago" onto the end (eg 2 hours ago) |
| withPrefix | true/false | yes | false | Adds for/since onto the start (eg since Aug 10 2018) |

#### Examples

```
timeago(<some time>, true, false)
// August 24th

timeago(<some time>, false)
// 5 minutes ago

timeago(<some time>, false, false, true)
// 20 minutes

timeago(<some time>, true, true, false, true)
// since August 24th 16:20

// this is a silly example but is perfectly valid
timeago(<some time>, false, false, false, true)
// for 15 minutes ago
```