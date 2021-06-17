# String manipulation

---

### Sub-strings
This custom label takes a fixed range of characters from the original string. In this example, the original string was `{{value}}` and we're keeping characters 0 to 50. This can be really useful in a grid tile if one column has a long string and you want to chop it short, of if a key piece of data is contained in a longer string in a consistent position.

`{{value.substr(0,50)}}`

---

### Splits
This custom label splits the original string at a specific character then keeps a specific index of that new array. In this example, the original string was `{{value}}` and we're keeping index 0 of the new split array i.e. the part of the string before the splitting character.

`hello.this.is.a.string` becomes `hello` when index is `0`
`hello.this.is.a.string` becomes `is` when index is `2`

`{{value.split('.')[0]}}`

---