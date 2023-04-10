# StaticArray

Codegenerated array with a constant size and basic arithmetics support. Available dimensions from 2 to 27.

## Examples

**Get**:
```swift
let a = StaticArray4(values: (1, 2, 3, 4))
let b = a.get2(from: 2) // [3, 4]
```

**Set**:
```swift
var a = StaticArray4(values: (1, 2, 3, 4))
let b = StaticArray2(repeating: 9)
a.set2(b, at: 1) // [1, 9, 9, 4]
```

**Map**:
```swift
let a = StaticArray2(values: (1, 2))
let b = a.map { $0 * 4 } // [4, 8]
```

**Zip**:
```swift
let a = StaticArray2(values: (1, 2))
let b = StaticArray2(values: (3, 4))
let c = zip(a, b) // [(1, 4), (2, 4)]
```

**Sum of arrays**:
```swift
let a = StaticArray2(values: (1, 2))
let b = StaticArray2(values: (3, 4))
let c = a + b // [4, 6]
```

**Multiplication of an array and a literal**:
```swift
let a = StaticArray2(values: (1, 2))
let b = a * 3 // [3, 6]
```


## License: [MIT](LICENSE)
