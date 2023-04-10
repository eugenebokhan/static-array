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
a.set2(b, at: 1) // 1, 9, 9, 4
```

**Map**:
```swift
StaticArray2(values: (1, 2)).map { $0 * 4 } // [4, 8]
```

**Zip**:
```swift
let a = StaticArray2(values: (1, 2))
let b = a
let c = zip(a, b).map { $0.1 - $0.1 } // [0, 0]
```

**Sum of arrays**:
```swift
StaticArray2(values: (1, 2)) + StaticArray2(values: (3, 4)) // [4, 6]
```

**Sum of array and a literal**:
```swift
StaticArray2(values: (1, 2)) + 3 // [4, 5]
```


## License: [MIT](LICENSE)
