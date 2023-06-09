import Foundation

public struct StaticArray11<T> {
    public typealias Values = (T, T, T, T, T, T, T, T, T, T, T)

    private var values: Values

    public init(values: Values) {
        self.values = values
    }

    public init(repeating value: T) {
        self.values = (
            value,
            value,
            value,
            value,
            value,
            value,
            value,
            value,
            value,
            value,
            value
        )
    }

    init(array: [T]) {
        guard array.count == 11 else { fatalError("array size mismatch") }
        self.values = (
            array[0],
            array[1],
            array[2],
            array[3],
            array[4],
            array[5],
            array[6],
            array[7],
            array[8],
            array[9],
            array[10]
        )
    }

    public subscript(_ index: Int) -> T {
        get {
            switch index {
            case 0: return self.values.0
            case 1: return self.values.1
            case 2: return self.values.2
            case 3: return self.values.3
            case 4: return self.values.4
            case 5: return self.values.5
            case 6: return self.values.6
            case 7: return self.values.7
            case 8: return self.values.8
            case 9: return self.values.9
            case 10: return self.values.10
            default: fatalError("index out of range")
            }
        }
        set {
            switch index {
            case 0: self.values.0 = newValue
            case 1: self.values.1 = newValue
            case 2: self.values.2 = newValue
            case 3: self.values.3 = newValue
            case 4: self.values.4 = newValue
            case 5: self.values.5 = newValue
            case 6: self.values.6 = newValue
            case 7: self.values.7 = newValue
            case 8: self.values.8 = newValue
            case 9: self.values.9 = newValue
            case 10: self.values.10 = newValue
            default: fatalError("index out of range")
            }
        }
    }

    @inlinable public func get2(from offset: Int = 0) ->  StaticArray2<T> {
        switch offset {
         case 0:
            return StaticArray2(values: (
                self[0],
                self[1]
            ))
         case 1:
            return StaticArray2(values: (
                self[1],
                self[2]
            ))
         case 2:
            return StaticArray2(values: (
                self[2],
                self[3]
            ))
         case 3:
            return StaticArray2(values: (
                self[3],
                self[4]
            ))
         case 4:
            return StaticArray2(values: (
                self[4],
                self[5]
            ))
         case 5:
            return StaticArray2(values: (
                self[5],
                self[6]
            ))
         case 6:
            return StaticArray2(values: (
                self[6],
                self[7]
            ))
         case 7:
            return StaticArray2(values: (
                self[7],
                self[8]
            ))
         case 8:
            return StaticArray2(values: (
                self[8],
                self[9]
            ))
         case 9:
            return StaticArray2(values: (
                self[9],
                self[10]
            ))
        default:
            fatalError("offset out of available range")
        }
    }

    @inlinable public func get3(from offset: Int = 0) ->  StaticArray3<T> {
        switch offset {
         case 0:
            return StaticArray3(values: (
                self[0],
                self[1],
                self[2]
            ))
         case 1:
            return StaticArray3(values: (
                self[1],
                self[2],
                self[3]
            ))
         case 2:
            return StaticArray3(values: (
                self[2],
                self[3],
                self[4]
            ))
         case 3:
            return StaticArray3(values: (
                self[3],
                self[4],
                self[5]
            ))
         case 4:
            return StaticArray3(values: (
                self[4],
                self[5],
                self[6]
            ))
         case 5:
            return StaticArray3(values: (
                self[5],
                self[6],
                self[7]
            ))
         case 6:
            return StaticArray3(values: (
                self[6],
                self[7],
                self[8]
            ))
         case 7:
            return StaticArray3(values: (
                self[7],
                self[8],
                self[9]
            ))
         case 8:
            return StaticArray3(values: (
                self[8],
                self[9],
                self[10]
            ))
        default:
            fatalError("offset out of available range")
        }
    }

    @inlinable public func get4(from offset: Int = 0) ->  StaticArray4<T> {
        switch offset {
         case 0:
            return StaticArray4(values: (
                self[0],
                self[1],
                self[2],
                self[3]
            ))
         case 1:
            return StaticArray4(values: (
                self[1],
                self[2],
                self[3],
                self[4]
            ))
         case 2:
            return StaticArray4(values: (
                self[2],
                self[3],
                self[4],
                self[5]
            ))
         case 3:
            return StaticArray4(values: (
                self[3],
                self[4],
                self[5],
                self[6]
            ))
         case 4:
            return StaticArray4(values: (
                self[4],
                self[5],
                self[6],
                self[7]
            ))
         case 5:
            return StaticArray4(values: (
                self[5],
                self[6],
                self[7],
                self[8]
            ))
         case 6:
            return StaticArray4(values: (
                self[6],
                self[7],
                self[8],
                self[9]
            ))
         case 7:
            return StaticArray4(values: (
                self[7],
                self[8],
                self[9],
                self[10]
            ))
        default:
            fatalError("offset out of available range")
        }
    }

    @inlinable public func get5(from offset: Int = 0) ->  StaticArray5<T> {
        switch offset {
         case 0:
            return StaticArray5(values: (
                self[0],
                self[1],
                self[2],
                self[3],
                self[4]
            ))
         case 1:
            return StaticArray5(values: (
                self[1],
                self[2],
                self[3],
                self[4],
                self[5]
            ))
         case 2:
            return StaticArray5(values: (
                self[2],
                self[3],
                self[4],
                self[5],
                self[6]
            ))
         case 3:
            return StaticArray5(values: (
                self[3],
                self[4],
                self[5],
                self[6],
                self[7]
            ))
         case 4:
            return StaticArray5(values: (
                self[4],
                self[5],
                self[6],
                self[7],
                self[8]
            ))
         case 5:
            return StaticArray5(values: (
                self[5],
                self[6],
                self[7],
                self[8],
                self[9]
            ))
         case 6:
            return StaticArray5(values: (
                self[6],
                self[7],
                self[8],
                self[9],
                self[10]
            ))
        default:
            fatalError("offset out of available range")
        }
    }

    @inlinable public func get6(from offset: Int = 0) ->  StaticArray6<T> {
        switch offset {
         case 0:
            return StaticArray6(values: (
                self[0],
                self[1],
                self[2],
                self[3],
                self[4],
                self[5]
            ))
         case 1:
            return StaticArray6(values: (
                self[1],
                self[2],
                self[3],
                self[4],
                self[5],
                self[6]
            ))
         case 2:
            return StaticArray6(values: (
                self[2],
                self[3],
                self[4],
                self[5],
                self[6],
                self[7]
            ))
         case 3:
            return StaticArray6(values: (
                self[3],
                self[4],
                self[5],
                self[6],
                self[7],
                self[8]
            ))
         case 4:
            return StaticArray6(values: (
                self[4],
                self[5],
                self[6],
                self[7],
                self[8],
                self[9]
            ))
         case 5:
            return StaticArray6(values: (
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10]
            ))
        default:
            fatalError("offset out of available range")
        }
    }

    @inlinable public func get7(from offset: Int = 0) ->  StaticArray7<T> {
        switch offset {
         case 0:
            return StaticArray7(values: (
                self[0],
                self[1],
                self[2],
                self[3],
                self[4],
                self[5],
                self[6]
            ))
         case 1:
            return StaticArray7(values: (
                self[1],
                self[2],
                self[3],
                self[4],
                self[5],
                self[6],
                self[7]
            ))
         case 2:
            return StaticArray7(values: (
                self[2],
                self[3],
                self[4],
                self[5],
                self[6],
                self[7],
                self[8]
            ))
         case 3:
            return StaticArray7(values: (
                self[3],
                self[4],
                self[5],
                self[6],
                self[7],
                self[8],
                self[9]
            ))
         case 4:
            return StaticArray7(values: (
                self[4],
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10]
            ))
        default:
            fatalError("offset out of available range")
        }
    }

    @inlinable public func get8(from offset: Int = 0) ->  StaticArray8<T> {
        switch offset {
         case 0:
            return StaticArray8(values: (
                self[0],
                self[1],
                self[2],
                self[3],
                self[4],
                self[5],
                self[6],
                self[7]
            ))
         case 1:
            return StaticArray8(values: (
                self[1],
                self[2],
                self[3],
                self[4],
                self[5],
                self[6],
                self[7],
                self[8]
            ))
         case 2:
            return StaticArray8(values: (
                self[2],
                self[3],
                self[4],
                self[5],
                self[6],
                self[7],
                self[8],
                self[9]
            ))
         case 3:
            return StaticArray8(values: (
                self[3],
                self[4],
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10]
            ))
        default:
            fatalError("offset out of available range")
        }
    }

    @inlinable public func get9(from offset: Int = 0) ->  StaticArray9<T> {
        switch offset {
         case 0:
            return StaticArray9(values: (
                self[0],
                self[1],
                self[2],
                self[3],
                self[4],
                self[5],
                self[6],
                self[7],
                self[8]
            ))
         case 1:
            return StaticArray9(values: (
                self[1],
                self[2],
                self[3],
                self[4],
                self[5],
                self[6],
                self[7],
                self[8],
                self[9]
            ))
         case 2:
            return StaticArray9(values: (
                self[2],
                self[3],
                self[4],
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10]
            ))
        default:
            fatalError("offset out of available range")
        }
    }

    @inlinable public func get10(from offset: Int = 0) ->  StaticArray10<T> {
        switch offset {
         case 0:
            return StaticArray10(values: (
                self[0],
                self[1],
                self[2],
                self[3],
                self[4],
                self[5],
                self[6],
                self[7],
                self[8],
                self[9]
            ))
         case 1:
            return StaticArray10(values: (
                self[1],
                self[2],
                self[3],
                self[4],
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10]
            ))
        default:
            fatalError("offset out of available range")
        }
    }

    @inlinable public mutating func set2(_ array: StaticArray2<T>, at offset: Int = 0) {
        switch offset {
         case 0:
            self[0] = array[0]
            self[1] = array[1]
         case 1:
            self[1] = array[0]
            self[2] = array[1]
         case 2:
            self[2] = array[0]
            self[3] = array[1]
         case 3:
            self[3] = array[0]
            self[4] = array[1]
         case 4:
            self[4] = array[0]
            self[5] = array[1]
         case 5:
            self[5] = array[0]
            self[6] = array[1]
         case 6:
            self[6] = array[0]
            self[7] = array[1]
         case 7:
            self[7] = array[0]
            self[8] = array[1]
         case 8:
            self[8] = array[0]
            self[9] = array[1]
         case 9:
            self[9] = array[0]
            self[10] = array[1]
        default:
            fatalError("offset out of available range")
        }
    }

    @inlinable public mutating func set3(_ array: StaticArray3<T>, at offset: Int = 0) {
        switch offset {
         case 0:
            self[0] = array[0]
            self[1] = array[1]
            self[2] = array[2]
         case 1:
            self[1] = array[0]
            self[2] = array[1]
            self[3] = array[2]
         case 2:
            self[2] = array[0]
            self[3] = array[1]
            self[4] = array[2]
         case 3:
            self[3] = array[0]
            self[4] = array[1]
            self[5] = array[2]
         case 4:
            self[4] = array[0]
            self[5] = array[1]
            self[6] = array[2]
         case 5:
            self[5] = array[0]
            self[6] = array[1]
            self[7] = array[2]
         case 6:
            self[6] = array[0]
            self[7] = array[1]
            self[8] = array[2]
         case 7:
            self[7] = array[0]
            self[8] = array[1]
            self[9] = array[2]
         case 8:
            self[8] = array[0]
            self[9] = array[1]
            self[10] = array[2]
        default:
            fatalError("offset out of available range")
        }
    }

    @inlinable public mutating func set4(_ array: StaticArray4<T>, at offset: Int = 0) {
        switch offset {
         case 0:
            self[0] = array[0]
            self[1] = array[1]
            self[2] = array[2]
            self[3] = array[3]
         case 1:
            self[1] = array[0]
            self[2] = array[1]
            self[3] = array[2]
            self[4] = array[3]
         case 2:
            self[2] = array[0]
            self[3] = array[1]
            self[4] = array[2]
            self[5] = array[3]
         case 3:
            self[3] = array[0]
            self[4] = array[1]
            self[5] = array[2]
            self[6] = array[3]
         case 4:
            self[4] = array[0]
            self[5] = array[1]
            self[6] = array[2]
            self[7] = array[3]
         case 5:
            self[5] = array[0]
            self[6] = array[1]
            self[7] = array[2]
            self[8] = array[3]
         case 6:
            self[6] = array[0]
            self[7] = array[1]
            self[8] = array[2]
            self[9] = array[3]
         case 7:
            self[7] = array[0]
            self[8] = array[1]
            self[9] = array[2]
            self[10] = array[3]
        default:
            fatalError("offset out of available range")
        }
    }

    @inlinable public mutating func set5(_ array: StaticArray5<T>, at offset: Int = 0) {
        switch offset {
         case 0:
            self[0] = array[0]
            self[1] = array[1]
            self[2] = array[2]
            self[3] = array[3]
            self[4] = array[4]
         case 1:
            self[1] = array[0]
            self[2] = array[1]
            self[3] = array[2]
            self[4] = array[3]
            self[5] = array[4]
         case 2:
            self[2] = array[0]
            self[3] = array[1]
            self[4] = array[2]
            self[5] = array[3]
            self[6] = array[4]
         case 3:
            self[3] = array[0]
            self[4] = array[1]
            self[5] = array[2]
            self[6] = array[3]
            self[7] = array[4]
         case 4:
            self[4] = array[0]
            self[5] = array[1]
            self[6] = array[2]
            self[7] = array[3]
            self[8] = array[4]
         case 5:
            self[5] = array[0]
            self[6] = array[1]
            self[7] = array[2]
            self[8] = array[3]
            self[9] = array[4]
         case 6:
            self[6] = array[0]
            self[7] = array[1]
            self[8] = array[2]
            self[9] = array[3]
            self[10] = array[4]
        default:
            fatalError("offset out of available range")
        }
    }

    @inlinable public mutating func set6(_ array: StaticArray6<T>, at offset: Int = 0) {
        switch offset {
         case 0:
            self[0] = array[0]
            self[1] = array[1]
            self[2] = array[2]
            self[3] = array[3]
            self[4] = array[4]
            self[5] = array[5]
         case 1:
            self[1] = array[0]
            self[2] = array[1]
            self[3] = array[2]
            self[4] = array[3]
            self[5] = array[4]
            self[6] = array[5]
         case 2:
            self[2] = array[0]
            self[3] = array[1]
            self[4] = array[2]
            self[5] = array[3]
            self[6] = array[4]
            self[7] = array[5]
         case 3:
            self[3] = array[0]
            self[4] = array[1]
            self[5] = array[2]
            self[6] = array[3]
            self[7] = array[4]
            self[8] = array[5]
         case 4:
            self[4] = array[0]
            self[5] = array[1]
            self[6] = array[2]
            self[7] = array[3]
            self[8] = array[4]
            self[9] = array[5]
         case 5:
            self[5] = array[0]
            self[6] = array[1]
            self[7] = array[2]
            self[8] = array[3]
            self[9] = array[4]
            self[10] = array[5]
        default:
            fatalError("offset out of available range")
        }
    }

    @inlinable public mutating func set7(_ array: StaticArray7<T>, at offset: Int = 0) {
        switch offset {
         case 0:
            self[0] = array[0]
            self[1] = array[1]
            self[2] = array[2]
            self[3] = array[3]
            self[4] = array[4]
            self[5] = array[5]
            self[6] = array[6]
         case 1:
            self[1] = array[0]
            self[2] = array[1]
            self[3] = array[2]
            self[4] = array[3]
            self[5] = array[4]
            self[6] = array[5]
            self[7] = array[6]
         case 2:
            self[2] = array[0]
            self[3] = array[1]
            self[4] = array[2]
            self[5] = array[3]
            self[6] = array[4]
            self[7] = array[5]
            self[8] = array[6]
         case 3:
            self[3] = array[0]
            self[4] = array[1]
            self[5] = array[2]
            self[6] = array[3]
            self[7] = array[4]
            self[8] = array[5]
            self[9] = array[6]
         case 4:
            self[4] = array[0]
            self[5] = array[1]
            self[6] = array[2]
            self[7] = array[3]
            self[8] = array[4]
            self[9] = array[5]
            self[10] = array[6]
        default:
            fatalError("offset out of available range")
        }
    }

    @inlinable public mutating func set8(_ array: StaticArray8<T>, at offset: Int = 0) {
        switch offset {
         case 0:
            self[0] = array[0]
            self[1] = array[1]
            self[2] = array[2]
            self[3] = array[3]
            self[4] = array[4]
            self[5] = array[5]
            self[6] = array[6]
            self[7] = array[7]
         case 1:
            self[1] = array[0]
            self[2] = array[1]
            self[3] = array[2]
            self[4] = array[3]
            self[5] = array[4]
            self[6] = array[5]
            self[7] = array[6]
            self[8] = array[7]
         case 2:
            self[2] = array[0]
            self[3] = array[1]
            self[4] = array[2]
            self[5] = array[3]
            self[6] = array[4]
            self[7] = array[5]
            self[8] = array[6]
            self[9] = array[7]
         case 3:
            self[3] = array[0]
            self[4] = array[1]
            self[5] = array[2]
            self[6] = array[3]
            self[7] = array[4]
            self[8] = array[5]
            self[9] = array[6]
            self[10] = array[7]
        default:
            fatalError("offset out of available range")
        }
    }

    @inlinable public mutating func set9(_ array: StaticArray9<T>, at offset: Int = 0) {
        switch offset {
         case 0:
            self[0] = array[0]
            self[1] = array[1]
            self[2] = array[2]
            self[3] = array[3]
            self[4] = array[4]
            self[5] = array[5]
            self[6] = array[6]
            self[7] = array[7]
            self[8] = array[8]
         case 1:
            self[1] = array[0]
            self[2] = array[1]
            self[3] = array[2]
            self[4] = array[3]
            self[5] = array[4]
            self[6] = array[5]
            self[7] = array[6]
            self[8] = array[7]
            self[9] = array[8]
         case 2:
            self[2] = array[0]
            self[3] = array[1]
            self[4] = array[2]
            self[5] = array[3]
            self[6] = array[4]
            self[7] = array[5]
            self[8] = array[6]
            self[9] = array[7]
            self[10] = array[8]
        default:
            fatalError("offset out of available range")
        }
    }

    @inlinable public mutating func set10(_ array: StaticArray10<T>, at offset: Int = 0) {
        switch offset {
         case 0:
            self[0] = array[0]
            self[1] = array[1]
            self[2] = array[2]
            self[3] = array[3]
            self[4] = array[4]
            self[5] = array[5]
            self[6] = array[6]
            self[7] = array[7]
            self[8] = array[8]
            self[9] = array[9]
         case 1:
            self[1] = array[0]
            self[2] = array[1]
            self[3] = array[2]
            self[4] = array[3]
            self[5] = array[4]
            self[6] = array[5]
            self[7] = array[6]
            self[8] = array[7]
            self[9] = array[8]
            self[10] = array[9]
        default:
            fatalError("offset out of available range")
        }
    }

    @inlinable public  func toArray() -> [T] {
        [
            self[0],
            self[1],
            self[2],
            self[3],
            self[4],
            self[5],
            self[6],
            self[7],
            self[8],
            self[9],
            self[10]
        ]
    }

    @inlinable public func map<M>(_ transform: (T) throws -> M) rethrows -> StaticArray11<M> {
        try StaticArray11<M>(values: (
            transform(self[0]),
            transform(self[1]),
            transform(self[2]),
            transform(self[3]),
            transform(self[4]),
            transform(self[5]),
            transform(self[6]),
            transform(self[7]),
            transform(self[8]),
            transform(self[9]),
            transform(self[10])
        ))
    }
}

public func zip<L, R>(_ lhs: StaticArray11<L>, _ rhs: StaticArray11<R>) -> StaticArray11<(L, R)> {
    StaticArray11(values: (
        (lhs[0], rhs[0]),
        (lhs[1], rhs[1]),
        (lhs[2], rhs[2]),
        (lhs[3], rhs[3]),
        (lhs[4], rhs[4]),
        (lhs[5], rhs[5]),
        (lhs[6], rhs[6]),
        (lhs[7], rhs[7]),
        (lhs[8], rhs[8]),
        (lhs[9], rhs[9]),
        (lhs[10], rhs[10])
    ))
}

extension StaticArray11: Collection {
    public typealias Index = Int
    public var startIndex: Index { 0 }
    public var endIndex: Index { 11 }
    @inlinable public func index(after i: Index) -> Index { i + 1 }
}

extension StaticArray11: Sequence {
    public struct Iterator: IteratorProtocol {
        private var index = 0
        private let array: StaticArray11<T>

        init(_ array: StaticArray11<T>) {
            self.array = array
        }

        public mutating func next() -> T? {
            guard self.index < self.array.count else { return nil }
            let value = self.array[self.index]
            self.index += 1
            return value
        }
    }

    public func makeIterator() -> Iterator {
        Iterator(self)
    }
}

extension StaticArray11: Equatable where T: Equatable {
    @inlinable public static func == (lhs: Self, rhs: Self) -> Bool {
        zip(lhs, rhs).allSatisfy { $0.0 == $0.1 }
    }
}

extension StaticArray11: Codable where T: Codable {
    public init(from decoder: Decoder) throws {
        try self.init(array: [T](from: decoder))
    }

    public func encode(to encoder: Encoder) throws {
        try self.toArray().encode(to: encoder)
    }
}

extension StaticArray11: AdditiveArithmetic where T: AdditiveArithmetic {
    @inlinable public static func - (lhs: Self, rhs: Self) -> Self {
        zip(lhs, rhs).map { $0.0 - $0.1 }
    }

    @inlinable public static func + (lhs: Self, rhs: Self) -> Self {
        zip(lhs, rhs).map { $0.0 + $0.1 }
    }

    @inlinable public static var zero: Self { Self(repeating: T.zero) }
}

@inlinable public func + <T>(lhs: StaticArray11<T>, rhs: T) -> StaticArray11<T> where T: AdditiveArithmetic {
    lhs.map { $0 + rhs }
}

@inlinable public func + <T>(lhs: T, rhs: StaticArray11<T>) -> StaticArray11<T> where T: AdditiveArithmetic {
    rhs.map { lhs + $0 }
}

@inlinable public func - <T>(lhs: StaticArray11<T>, rhs: T) -> StaticArray11<T> where T: AdditiveArithmetic {
    lhs.map { $0 - rhs }
}

@inlinable public func - <T>(lhs: T, rhs: StaticArray11<T>) -> StaticArray11<T> where T: AdditiveArithmetic {
    rhs.map { lhs - $0 }
}

extension StaticArray11: Divisible where T: Divisible {
    @inlinable public static func / (lhs: Self, rhs: Self) -> Self {
        zip(lhs, rhs).map { $0.0 / $0.1 }
    }
}

@inlinable public func / <T>(lhs: StaticArray11<T>, rhs: T) -> StaticArray11<T> where T: Divisible {
    lhs.map { $0 / rhs }
}

@inlinable public func / <T>(lhs: T, rhs: StaticArray11<T>) -> StaticArray11<T> where T: Divisible {
    rhs.map { lhs / $0 }
}

extension StaticArray11: Multipliable where T: Multipliable {
    @inlinable public static func * (lhs: Self, rhs: Self) -> Self {
        zip(lhs, rhs).map { $0.0 * $0.1 }
    }
}

@inlinable public func * <T>(lhs: StaticArray11<T>, rhs: T) -> StaticArray11<T> where T: Multipliable {
    lhs.map { $0 * rhs }
}

@inlinable public func * <T>(lhs: T, rhs: StaticArray11<T>) -> StaticArray11<T> where T: Multipliable {
    rhs.map { lhs * $0 }
}

extension StaticArray11: ABSComputable where T: ABSComputable {
    @inlinable public func abs() -> Self {
        self.map { $0.abs() }
    }
}

