import Foundation

public struct StaticArray2<T> {
    public typealias Values = (T, T)

    private var values: Values

    public init(values: Values) {
        self.values = values
    }

    public init(repeating value: T) {
        self.values = (
            value,
            value
        )
    }

    init(array: [T]) throws {
        guard array.count == 2 else { fatalError("array size mismatch") }
        self.values = (
            array[0],
            array[1]
        )
    }

    public subscript(_ index: Int) -> T {
        get {
            switch index {
            case 0: return self.values.0
            case 1: return self.values.1
            default: fatalError("index out of range")
            }
        }
        set {
            switch index {
            case 0: self.values.0 = newValue
            case 1: self.values.1 = newValue
            default: fatalError("index out of range")
            }
        }
    }

    @inlinable public  func toArray() -> [T] {
        [
            self[0],
            self[1]
        ]
    }

    @inlinable public func map<M>(_ transform: (T) throws -> M) rethrows -> StaticArray2<M> {
        try StaticArray2<M>(values: (
            transform(self[0]),
            transform(self[1])
        ))
    }
}

public func zip<L, R>(_ lhs: StaticArray2<L>, _ rhs: StaticArray2<R>) -> StaticArray2<(L, R)> {
    StaticArray2(values: (
        (lhs[0], rhs[0]),
        (lhs[1], rhs[1])
    ))
}

extension StaticArray2: Collection {
    public typealias Index = Int
    public var startIndex: Index { 0 }
    public var endIndex: Index { 2 }
    @inlinable public func index(after i: Index) -> Index { i + 1 }
}

extension StaticArray2: Sequence {
    public struct Iterator: IteratorProtocol {
        private var index = 0
        private let array: StaticArray2<T>

        init(_ array: StaticArray2<T>) {
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

extension StaticArray2: Equatable where T: Equatable {
    @inlinable public static func == (lhs: Self, rhs: Self) -> Bool {
        zip(lhs, rhs).allSatisfy { $0.0 == $0.1 }
    }
}

extension StaticArray2: Codable where T: Codable {
    public init(from decoder: Decoder) throws {
        try self.init(array: [T](from: decoder))
    }

    public func encode(to encoder: Encoder) throws {
        try self.toArray().encode(to: encoder)
    }
}

extension StaticArray2: AdditiveArithmetic where T: AdditiveArithmetic {
    @inlinable public static func - (lhs: Self, rhs: Self) -> Self {
        zip(lhs, rhs).map { $0.0 - $0.1 }
    }

    @inlinable public static func + (lhs: Self, rhs: Self) -> Self {
        zip(lhs, rhs).map { $0.0 + $0.1 }
    }

    @inlinable public static var zero: Self { Self(repeating: T.zero) }
}

@inlinable public func + <T>(lhs: StaticArray2<T>, rhs: T) -> StaticArray2<T> where T: AdditiveArithmetic {
    lhs.map { $0 + rhs }
}

@inlinable public func + <T>(lhs: T, rhs: StaticArray2<T>) -> StaticArray2<T> where T: AdditiveArithmetic {
    rhs.map { lhs + $0 }
}

@inlinable public func - <T>(lhs: StaticArray2<T>, rhs: T) -> StaticArray2<T> where T: AdditiveArithmetic {
    lhs.map { $0 - rhs }
}

@inlinable public func - <T>(lhs: T, rhs: StaticArray2<T>) -> StaticArray2<T> where T: AdditiveArithmetic {
    rhs.map { lhs - $0 }
}

extension StaticArray2: Divisible where T: Divisible {
    @inlinable public static func / (lhs: Self, rhs: Self) -> Self {
        zip(lhs, rhs).map { $0.0 / $0.1 }
    }
}

@inlinable public func / <T>(lhs: StaticArray2<T>, rhs: T) -> StaticArray2<T> where T: Divisible {
    lhs.map { $0 / rhs }
}

@inlinable public func / <T>(lhs: T, rhs: StaticArray2<T>) -> StaticArray2<T> where T: Divisible {
    rhs.map { lhs / $0 }
}

extension StaticArray2: Multipliable where T: Multipliable {
    @inlinable public static func * (lhs: Self, rhs: Self) -> Self {
        zip(lhs, rhs).map { $0.0 * $0.1 }
    }
}

@inlinable public func * <T>(lhs: StaticArray2<T>, rhs: T) -> StaticArray2<T> where T: Multipliable {
    lhs.map { $0 * rhs }
}

@inlinable public func * <T>(lhs: T, rhs: StaticArray2<T>) -> StaticArray2<T> where T: Multipliable {
    rhs.map { lhs * $0 }
}

extension StaticArray2: ABSComputable where T: ABSComputable {
    @inlinable public func abs() -> Self {
        self.map { $0.abs() }
    }
}

public struct StaticArray3<T> {
    public typealias Values = (T, T, T)

    private var values: Values

    public init(values: Values) {
        self.values = values
    }

    public init(repeating value: T) {
        self.values = (
            value,
            value,
            value
        )
    }

    init(array: [T]) throws {
        guard array.count == 3 else { fatalError("array size mismatch") }
        self.values = (
            array[0],
            array[1],
            array[2]
        )
    }

    public subscript(_ index: Int) -> T {
        get {
            switch index {
            case 0: return self.values.0
            case 1: return self.values.1
            case 2: return self.values.2
            default: fatalError("index out of range")
            }
        }
        set {
            switch index {
            case 0: self.values.0 = newValue
            case 1: self.values.1 = newValue
            case 2: self.values.2 = newValue
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
        default:
            fatalError("offset out of available range")
        }
    }

    @inlinable public  func toArray() -> [T] {
        [
            self[0],
            self[1],
            self[2]
        ]
    }

    @inlinable public func map<M>(_ transform: (T) throws -> M) rethrows -> StaticArray3<M> {
        try StaticArray3<M>(values: (
            transform(self[0]),
            transform(self[1]),
            transform(self[2])
        ))
    }
}

public func zip<L, R>(_ lhs: StaticArray3<L>, _ rhs: StaticArray3<R>) -> StaticArray3<(L, R)> {
    StaticArray3(values: (
        (lhs[0], rhs[0]),
        (lhs[1], rhs[1]),
        (lhs[2], rhs[2])
    ))
}

extension StaticArray3: Collection {
    public typealias Index = Int
    public var startIndex: Index { 0 }
    public var endIndex: Index { 3 }
    @inlinable public func index(after i: Index) -> Index { i + 1 }
}

extension StaticArray3: Sequence {
    public struct Iterator: IteratorProtocol {
        private var index = 0
        private let array: StaticArray3<T>

        init(_ array: StaticArray3<T>) {
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

extension StaticArray3: Equatable where T: Equatable {
    @inlinable public static func == (lhs: Self, rhs: Self) -> Bool {
        zip(lhs, rhs).allSatisfy { $0.0 == $0.1 }
    }
}

extension StaticArray3: Codable where T: Codable {
    public init(from decoder: Decoder) throws {
        try self.init(array: [T](from: decoder))
    }

    public func encode(to encoder: Encoder) throws {
        try self.toArray().encode(to: encoder)
    }
}

extension StaticArray3: AdditiveArithmetic where T: AdditiveArithmetic {
    @inlinable public static func - (lhs: Self, rhs: Self) -> Self {
        zip(lhs, rhs).map { $0.0 - $0.1 }
    }

    @inlinable public static func + (lhs: Self, rhs: Self) -> Self {
        zip(lhs, rhs).map { $0.0 + $0.1 }
    }

    @inlinable public static var zero: Self { Self(repeating: T.zero) }
}

@inlinable public func + <T>(lhs: StaticArray3<T>, rhs: T) -> StaticArray3<T> where T: AdditiveArithmetic {
    lhs.map { $0 + rhs }
}

@inlinable public func + <T>(lhs: T, rhs: StaticArray3<T>) -> StaticArray3<T> where T: AdditiveArithmetic {
    rhs.map { lhs + $0 }
}

@inlinable public func - <T>(lhs: StaticArray3<T>, rhs: T) -> StaticArray3<T> where T: AdditiveArithmetic {
    lhs.map { $0 - rhs }
}

@inlinable public func - <T>(lhs: T, rhs: StaticArray3<T>) -> StaticArray3<T> where T: AdditiveArithmetic {
    rhs.map { lhs - $0 }
}

extension StaticArray3: Divisible where T: Divisible {
    @inlinable public static func / (lhs: Self, rhs: Self) -> Self {
        zip(lhs, rhs).map { $0.0 / $0.1 }
    }
}

@inlinable public func / <T>(lhs: StaticArray3<T>, rhs: T) -> StaticArray3<T> where T: Divisible {
    lhs.map { $0 / rhs }
}

@inlinable public func / <T>(lhs: T, rhs: StaticArray3<T>) -> StaticArray3<T> where T: Divisible {
    rhs.map { lhs / $0 }
}

extension StaticArray3: Multipliable where T: Multipliable {
    @inlinable public static func * (lhs: Self, rhs: Self) -> Self {
        zip(lhs, rhs).map { $0.0 * $0.1 }
    }
}

@inlinable public func * <T>(lhs: StaticArray3<T>, rhs: T) -> StaticArray3<T> where T: Multipliable {
    lhs.map { $0 * rhs }
}

@inlinable public func * <T>(lhs: T, rhs: StaticArray3<T>) -> StaticArray3<T> where T: Multipliable {
    rhs.map { lhs * $0 }
}

extension StaticArray3: ABSComputable where T: ABSComputable {
    @inlinable public func abs() -> Self {
        self.map { $0.abs() }
    }
}

public struct StaticArray4<T> {
    public typealias Values = (T, T, T, T)

    private var values: Values

    public init(values: Values) {
        self.values = values
    }

    public init(repeating value: T) {
        self.values = (
            value,
            value,
            value,
            value
        )
    }

    init(array: [T]) throws {
        guard array.count == 4 else { fatalError("array size mismatch") }
        self.values = (
            array[0],
            array[1],
            array[2],
            array[3]
        )
    }

    public subscript(_ index: Int) -> T {
        get {
            switch index {
            case 0: return self.values.0
            case 1: return self.values.1
            case 2: return self.values.2
            case 3: return self.values.3
            default: fatalError("index out of range")
            }
        }
        set {
            switch index {
            case 0: self.values.0 = newValue
            case 1: self.values.1 = newValue
            case 2: self.values.2 = newValue
            case 3: self.values.3 = newValue
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
        default:
            fatalError("offset out of available range")
        }
    }

    @inlinable public  func toArray() -> [T] {
        [
            self[0],
            self[1],
            self[2],
            self[3]
        ]
    }

    @inlinable public func map<M>(_ transform: (T) throws -> M) rethrows -> StaticArray4<M> {
        try StaticArray4<M>(values: (
            transform(self[0]),
            transform(self[1]),
            transform(self[2]),
            transform(self[3])
        ))
    }
}

public func zip<L, R>(_ lhs: StaticArray4<L>, _ rhs: StaticArray4<R>) -> StaticArray4<(L, R)> {
    StaticArray4(values: (
        (lhs[0], rhs[0]),
        (lhs[1], rhs[1]),
        (lhs[2], rhs[2]),
        (lhs[3], rhs[3])
    ))
}

extension StaticArray4: Collection {
    public typealias Index = Int
    public var startIndex: Index { 0 }
    public var endIndex: Index { 4 }
    @inlinable public func index(after i: Index) -> Index { i + 1 }
}

extension StaticArray4: Sequence {
    public struct Iterator: IteratorProtocol {
        private var index = 0
        private let array: StaticArray4<T>

        init(_ array: StaticArray4<T>) {
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

extension StaticArray4: Equatable where T: Equatable {
    @inlinable public static func == (lhs: Self, rhs: Self) -> Bool {
        zip(lhs, rhs).allSatisfy { $0.0 == $0.1 }
    }
}

extension StaticArray4: Codable where T: Codable {
    public init(from decoder: Decoder) throws {
        try self.init(array: [T](from: decoder))
    }

    public func encode(to encoder: Encoder) throws {
        try self.toArray().encode(to: encoder)
    }
}

extension StaticArray4: AdditiveArithmetic where T: AdditiveArithmetic {
    @inlinable public static func - (lhs: Self, rhs: Self) -> Self {
        zip(lhs, rhs).map { $0.0 - $0.1 }
    }

    @inlinable public static func + (lhs: Self, rhs: Self) -> Self {
        zip(lhs, rhs).map { $0.0 + $0.1 }
    }

    @inlinable public static var zero: Self { Self(repeating: T.zero) }
}

@inlinable public func + <T>(lhs: StaticArray4<T>, rhs: T) -> StaticArray4<T> where T: AdditiveArithmetic {
    lhs.map { $0 + rhs }
}

@inlinable public func + <T>(lhs: T, rhs: StaticArray4<T>) -> StaticArray4<T> where T: AdditiveArithmetic {
    rhs.map { lhs + $0 }
}

@inlinable public func - <T>(lhs: StaticArray4<T>, rhs: T) -> StaticArray4<T> where T: AdditiveArithmetic {
    lhs.map { $0 - rhs }
}

@inlinable public func - <T>(lhs: T, rhs: StaticArray4<T>) -> StaticArray4<T> where T: AdditiveArithmetic {
    rhs.map { lhs - $0 }
}

extension StaticArray4: Divisible where T: Divisible {
    @inlinable public static func / (lhs: Self, rhs: Self) -> Self {
        zip(lhs, rhs).map { $0.0 / $0.1 }
    }
}

@inlinable public func / <T>(lhs: StaticArray4<T>, rhs: T) -> StaticArray4<T> where T: Divisible {
    lhs.map { $0 / rhs }
}

@inlinable public func / <T>(lhs: T, rhs: StaticArray4<T>) -> StaticArray4<T> where T: Divisible {
    rhs.map { lhs / $0 }
}

extension StaticArray4: Multipliable where T: Multipliable {
    @inlinable public static func * (lhs: Self, rhs: Self) -> Self {
        zip(lhs, rhs).map { $0.0 * $0.1 }
    }
}

@inlinable public func * <T>(lhs: StaticArray4<T>, rhs: T) -> StaticArray4<T> where T: Multipliable {
    lhs.map { $0 * rhs }
}

@inlinable public func * <T>(lhs: T, rhs: StaticArray4<T>) -> StaticArray4<T> where T: Multipliable {
    rhs.map { lhs * $0 }
}

extension StaticArray4: ABSComputable where T: ABSComputable {
    @inlinable public func abs() -> Self {
        self.map { $0.abs() }
    }
}

public struct StaticArray5<T> {
    public typealias Values = (T, T, T, T, T)

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
            value
        )
    }

    init(array: [T]) throws {
        guard array.count == 5 else { fatalError("array size mismatch") }
        self.values = (
            array[0],
            array[1],
            array[2],
            array[3],
            array[4]
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
            self[4]
        ]
    }

    @inlinable public func map<M>(_ transform: (T) throws -> M) rethrows -> StaticArray5<M> {
        try StaticArray5<M>(values: (
            transform(self[0]),
            transform(self[1]),
            transform(self[2]),
            transform(self[3]),
            transform(self[4])
        ))
    }
}

public func zip<L, R>(_ lhs: StaticArray5<L>, _ rhs: StaticArray5<R>) -> StaticArray5<(L, R)> {
    StaticArray5(values: (
        (lhs[0], rhs[0]),
        (lhs[1], rhs[1]),
        (lhs[2], rhs[2]),
        (lhs[3], rhs[3]),
        (lhs[4], rhs[4])
    ))
}

extension StaticArray5: Collection {
    public typealias Index = Int
    public var startIndex: Index { 0 }
    public var endIndex: Index { 5 }
    @inlinable public func index(after i: Index) -> Index { i + 1 }
}

extension StaticArray5: Sequence {
    public struct Iterator: IteratorProtocol {
        private var index = 0
        private let array: StaticArray5<T>

        init(_ array: StaticArray5<T>) {
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

extension StaticArray5: Equatable where T: Equatable {
    @inlinable public static func == (lhs: Self, rhs: Self) -> Bool {
        zip(lhs, rhs).allSatisfy { $0.0 == $0.1 }
    }
}

extension StaticArray5: Codable where T: Codable {
    public init(from decoder: Decoder) throws {
        try self.init(array: [T](from: decoder))
    }

    public func encode(to encoder: Encoder) throws {
        try self.toArray().encode(to: encoder)
    }
}

extension StaticArray5: AdditiveArithmetic where T: AdditiveArithmetic {
    @inlinable public static func - (lhs: Self, rhs: Self) -> Self {
        zip(lhs, rhs).map { $0.0 - $0.1 }
    }

    @inlinable public static func + (lhs: Self, rhs: Self) -> Self {
        zip(lhs, rhs).map { $0.0 + $0.1 }
    }

    @inlinable public static var zero: Self { Self(repeating: T.zero) }
}

@inlinable public func + <T>(lhs: StaticArray5<T>, rhs: T) -> StaticArray5<T> where T: AdditiveArithmetic {
    lhs.map { $0 + rhs }
}

@inlinable public func + <T>(lhs: T, rhs: StaticArray5<T>) -> StaticArray5<T> where T: AdditiveArithmetic {
    rhs.map { lhs + $0 }
}

@inlinable public func - <T>(lhs: StaticArray5<T>, rhs: T) -> StaticArray5<T> where T: AdditiveArithmetic {
    lhs.map { $0 - rhs }
}

@inlinable public func - <T>(lhs: T, rhs: StaticArray5<T>) -> StaticArray5<T> where T: AdditiveArithmetic {
    rhs.map { lhs - $0 }
}

extension StaticArray5: Divisible where T: Divisible {
    @inlinable public static func / (lhs: Self, rhs: Self) -> Self {
        zip(lhs, rhs).map { $0.0 / $0.1 }
    }
}

@inlinable public func / <T>(lhs: StaticArray5<T>, rhs: T) -> StaticArray5<T> where T: Divisible {
    lhs.map { $0 / rhs }
}

@inlinable public func / <T>(lhs: T, rhs: StaticArray5<T>) -> StaticArray5<T> where T: Divisible {
    rhs.map { lhs / $0 }
}

extension StaticArray5: Multipliable where T: Multipliable {
    @inlinable public static func * (lhs: Self, rhs: Self) -> Self {
        zip(lhs, rhs).map { $0.0 * $0.1 }
    }
}

@inlinable public func * <T>(lhs: StaticArray5<T>, rhs: T) -> StaticArray5<T> where T: Multipliable {
    lhs.map { $0 * rhs }
}

@inlinable public func * <T>(lhs: T, rhs: StaticArray5<T>) -> StaticArray5<T> where T: Multipliable {
    rhs.map { lhs * $0 }
}

extension StaticArray5: ABSComputable where T: ABSComputable {
    @inlinable public func abs() -> Self {
        self.map { $0.abs() }
    }
}

public struct StaticArray6<T> {
    public typealias Values = (T, T, T, T, T, T)

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
            value
        )
    }

    init(array: [T]) throws {
        guard array.count == 6 else { fatalError("array size mismatch") }
        self.values = (
            array[0],
            array[1],
            array[2],
            array[3],
            array[4],
            array[5]
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
            self[5]
        ]
    }

    @inlinable public func map<M>(_ transform: (T) throws -> M) rethrows -> StaticArray6<M> {
        try StaticArray6<M>(values: (
            transform(self[0]),
            transform(self[1]),
            transform(self[2]),
            transform(self[3]),
            transform(self[4]),
            transform(self[5])
        ))
    }
}

public func zip<L, R>(_ lhs: StaticArray6<L>, _ rhs: StaticArray6<R>) -> StaticArray6<(L, R)> {
    StaticArray6(values: (
        (lhs[0], rhs[0]),
        (lhs[1], rhs[1]),
        (lhs[2], rhs[2]),
        (lhs[3], rhs[3]),
        (lhs[4], rhs[4]),
        (lhs[5], rhs[5])
    ))
}

extension StaticArray6: Collection {
    public typealias Index = Int
    public var startIndex: Index { 0 }
    public var endIndex: Index { 6 }
    @inlinable public func index(after i: Index) -> Index { i + 1 }
}

extension StaticArray6: Sequence {
    public struct Iterator: IteratorProtocol {
        private var index = 0
        private let array: StaticArray6<T>

        init(_ array: StaticArray6<T>) {
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

extension StaticArray6: Equatable where T: Equatable {
    @inlinable public static func == (lhs: Self, rhs: Self) -> Bool {
        zip(lhs, rhs).allSatisfy { $0.0 == $0.1 }
    }
}

extension StaticArray6: Codable where T: Codable {
    public init(from decoder: Decoder) throws {
        try self.init(array: [T](from: decoder))
    }

    public func encode(to encoder: Encoder) throws {
        try self.toArray().encode(to: encoder)
    }
}

extension StaticArray6: AdditiveArithmetic where T: AdditiveArithmetic {
    @inlinable public static func - (lhs: Self, rhs: Self) -> Self {
        zip(lhs, rhs).map { $0.0 - $0.1 }
    }

    @inlinable public static func + (lhs: Self, rhs: Self) -> Self {
        zip(lhs, rhs).map { $0.0 + $0.1 }
    }

    @inlinable public static var zero: Self { Self(repeating: T.zero) }
}

@inlinable public func + <T>(lhs: StaticArray6<T>, rhs: T) -> StaticArray6<T> where T: AdditiveArithmetic {
    lhs.map { $0 + rhs }
}

@inlinable public func + <T>(lhs: T, rhs: StaticArray6<T>) -> StaticArray6<T> where T: AdditiveArithmetic {
    rhs.map { lhs + $0 }
}

@inlinable public func - <T>(lhs: StaticArray6<T>, rhs: T) -> StaticArray6<T> where T: AdditiveArithmetic {
    lhs.map { $0 - rhs }
}

@inlinable public func - <T>(lhs: T, rhs: StaticArray6<T>) -> StaticArray6<T> where T: AdditiveArithmetic {
    rhs.map { lhs - $0 }
}

extension StaticArray6: Divisible where T: Divisible {
    @inlinable public static func / (lhs: Self, rhs: Self) -> Self {
        zip(lhs, rhs).map { $0.0 / $0.1 }
    }
}

@inlinable public func / <T>(lhs: StaticArray6<T>, rhs: T) -> StaticArray6<T> where T: Divisible {
    lhs.map { $0 / rhs }
}

@inlinable public func / <T>(lhs: T, rhs: StaticArray6<T>) -> StaticArray6<T> where T: Divisible {
    rhs.map { lhs / $0 }
}

extension StaticArray6: Multipliable where T: Multipliable {
    @inlinable public static func * (lhs: Self, rhs: Self) -> Self {
        zip(lhs, rhs).map { $0.0 * $0.1 }
    }
}

@inlinable public func * <T>(lhs: StaticArray6<T>, rhs: T) -> StaticArray6<T> where T: Multipliable {
    lhs.map { $0 * rhs }
}

@inlinable public func * <T>(lhs: T, rhs: StaticArray6<T>) -> StaticArray6<T> where T: Multipliable {
    rhs.map { lhs * $0 }
}

extension StaticArray6: ABSComputable where T: ABSComputable {
    @inlinable public func abs() -> Self {
        self.map { $0.abs() }
    }
}

public struct StaticArray7<T> {
    public typealias Values = (T, T, T, T, T, T, T)

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
            value
        )
    }

    init(array: [T]) throws {
        guard array.count == 7 else { fatalError("array size mismatch") }
        self.values = (
            array[0],
            array[1],
            array[2],
            array[3],
            array[4],
            array[5],
            array[6]
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
            self[6]
        ]
    }

    @inlinable public func map<M>(_ transform: (T) throws -> M) rethrows -> StaticArray7<M> {
        try StaticArray7<M>(values: (
            transform(self[0]),
            transform(self[1]),
            transform(self[2]),
            transform(self[3]),
            transform(self[4]),
            transform(self[5]),
            transform(self[6])
        ))
    }
}

public func zip<L, R>(_ lhs: StaticArray7<L>, _ rhs: StaticArray7<R>) -> StaticArray7<(L, R)> {
    StaticArray7(values: (
        (lhs[0], rhs[0]),
        (lhs[1], rhs[1]),
        (lhs[2], rhs[2]),
        (lhs[3], rhs[3]),
        (lhs[4], rhs[4]),
        (lhs[5], rhs[5]),
        (lhs[6], rhs[6])
    ))
}

extension StaticArray7: Collection {
    public typealias Index = Int
    public var startIndex: Index { 0 }
    public var endIndex: Index { 7 }
    @inlinable public func index(after i: Index) -> Index { i + 1 }
}

extension StaticArray7: Sequence {
    public struct Iterator: IteratorProtocol {
        private var index = 0
        private let array: StaticArray7<T>

        init(_ array: StaticArray7<T>) {
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

extension StaticArray7: Equatable where T: Equatable {
    @inlinable public static func == (lhs: Self, rhs: Self) -> Bool {
        zip(lhs, rhs).allSatisfy { $0.0 == $0.1 }
    }
}

extension StaticArray7: Codable where T: Codable {
    public init(from decoder: Decoder) throws {
        try self.init(array: [T](from: decoder))
    }

    public func encode(to encoder: Encoder) throws {
        try self.toArray().encode(to: encoder)
    }
}

extension StaticArray7: AdditiveArithmetic where T: AdditiveArithmetic {
    @inlinable public static func - (lhs: Self, rhs: Self) -> Self {
        zip(lhs, rhs).map { $0.0 - $0.1 }
    }

    @inlinable public static func + (lhs: Self, rhs: Self) -> Self {
        zip(lhs, rhs).map { $0.0 + $0.1 }
    }

    @inlinable public static var zero: Self { Self(repeating: T.zero) }
}

@inlinable public func + <T>(lhs: StaticArray7<T>, rhs: T) -> StaticArray7<T> where T: AdditiveArithmetic {
    lhs.map { $0 + rhs }
}

@inlinable public func + <T>(lhs: T, rhs: StaticArray7<T>) -> StaticArray7<T> where T: AdditiveArithmetic {
    rhs.map { lhs + $0 }
}

@inlinable public func - <T>(lhs: StaticArray7<T>, rhs: T) -> StaticArray7<T> where T: AdditiveArithmetic {
    lhs.map { $0 - rhs }
}

@inlinable public func - <T>(lhs: T, rhs: StaticArray7<T>) -> StaticArray7<T> where T: AdditiveArithmetic {
    rhs.map { lhs - $0 }
}

extension StaticArray7: Divisible where T: Divisible {
    @inlinable public static func / (lhs: Self, rhs: Self) -> Self {
        zip(lhs, rhs).map { $0.0 / $0.1 }
    }
}

@inlinable public func / <T>(lhs: StaticArray7<T>, rhs: T) -> StaticArray7<T> where T: Divisible {
    lhs.map { $0 / rhs }
}

@inlinable public func / <T>(lhs: T, rhs: StaticArray7<T>) -> StaticArray7<T> where T: Divisible {
    rhs.map { lhs / $0 }
}

extension StaticArray7: Multipliable where T: Multipliable {
    @inlinable public static func * (lhs: Self, rhs: Self) -> Self {
        zip(lhs, rhs).map { $0.0 * $0.1 }
    }
}

@inlinable public func * <T>(lhs: StaticArray7<T>, rhs: T) -> StaticArray7<T> where T: Multipliable {
    lhs.map { $0 * rhs }
}

@inlinable public func * <T>(lhs: T, rhs: StaticArray7<T>) -> StaticArray7<T> where T: Multipliable {
    rhs.map { lhs * $0 }
}

extension StaticArray7: ABSComputable where T: ABSComputable {
    @inlinable public func abs() -> Self {
        self.map { $0.abs() }
    }
}

public struct StaticArray8<T> {
    public typealias Values = (T, T, T, T, T, T, T, T)

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
            value
        )
    }

    init(array: [T]) throws {
        guard array.count == 8 else { fatalError("array size mismatch") }
        self.values = (
            array[0],
            array[1],
            array[2],
            array[3],
            array[4],
            array[5],
            array[6],
            array[7]
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
            self[7]
        ]
    }

    @inlinable public func map<M>(_ transform: (T) throws -> M) rethrows -> StaticArray8<M> {
        try StaticArray8<M>(values: (
            transform(self[0]),
            transform(self[1]),
            transform(self[2]),
            transform(self[3]),
            transform(self[4]),
            transform(self[5]),
            transform(self[6]),
            transform(self[7])
        ))
    }
}

public func zip<L, R>(_ lhs: StaticArray8<L>, _ rhs: StaticArray8<R>) -> StaticArray8<(L, R)> {
    StaticArray8(values: (
        (lhs[0], rhs[0]),
        (lhs[1], rhs[1]),
        (lhs[2], rhs[2]),
        (lhs[3], rhs[3]),
        (lhs[4], rhs[4]),
        (lhs[5], rhs[5]),
        (lhs[6], rhs[6]),
        (lhs[7], rhs[7])
    ))
}

extension StaticArray8: Collection {
    public typealias Index = Int
    public var startIndex: Index { 0 }
    public var endIndex: Index { 8 }
    @inlinable public func index(after i: Index) -> Index { i + 1 }
}

extension StaticArray8: Sequence {
    public struct Iterator: IteratorProtocol {
        private var index = 0
        private let array: StaticArray8<T>

        init(_ array: StaticArray8<T>) {
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

extension StaticArray8: Equatable where T: Equatable {
    @inlinable public static func == (lhs: Self, rhs: Self) -> Bool {
        zip(lhs, rhs).allSatisfy { $0.0 == $0.1 }
    }
}

extension StaticArray8: Codable where T: Codable {
    public init(from decoder: Decoder) throws {
        try self.init(array: [T](from: decoder))
    }

    public func encode(to encoder: Encoder) throws {
        try self.toArray().encode(to: encoder)
    }
}

extension StaticArray8: AdditiveArithmetic where T: AdditiveArithmetic {
    @inlinable public static func - (lhs: Self, rhs: Self) -> Self {
        zip(lhs, rhs).map { $0.0 - $0.1 }
    }

    @inlinable public static func + (lhs: Self, rhs: Self) -> Self {
        zip(lhs, rhs).map { $0.0 + $0.1 }
    }

    @inlinable public static var zero: Self { Self(repeating: T.zero) }
}

@inlinable public func + <T>(lhs: StaticArray8<T>, rhs: T) -> StaticArray8<T> where T: AdditiveArithmetic {
    lhs.map { $0 + rhs }
}

@inlinable public func + <T>(lhs: T, rhs: StaticArray8<T>) -> StaticArray8<T> where T: AdditiveArithmetic {
    rhs.map { lhs + $0 }
}

@inlinable public func - <T>(lhs: StaticArray8<T>, rhs: T) -> StaticArray8<T> where T: AdditiveArithmetic {
    lhs.map { $0 - rhs }
}

@inlinable public func - <T>(lhs: T, rhs: StaticArray8<T>) -> StaticArray8<T> where T: AdditiveArithmetic {
    rhs.map { lhs - $0 }
}

extension StaticArray8: Divisible where T: Divisible {
    @inlinable public static func / (lhs: Self, rhs: Self) -> Self {
        zip(lhs, rhs).map { $0.0 / $0.1 }
    }
}

@inlinable public func / <T>(lhs: StaticArray8<T>, rhs: T) -> StaticArray8<T> where T: Divisible {
    lhs.map { $0 / rhs }
}

@inlinable public func / <T>(lhs: T, rhs: StaticArray8<T>) -> StaticArray8<T> where T: Divisible {
    rhs.map { lhs / $0 }
}

extension StaticArray8: Multipliable where T: Multipliable {
    @inlinable public static func * (lhs: Self, rhs: Self) -> Self {
        zip(lhs, rhs).map { $0.0 * $0.1 }
    }
}

@inlinable public func * <T>(lhs: StaticArray8<T>, rhs: T) -> StaticArray8<T> where T: Multipliable {
    lhs.map { $0 * rhs }
}

@inlinable public func * <T>(lhs: T, rhs: StaticArray8<T>) -> StaticArray8<T> where T: Multipliable {
    rhs.map { lhs * $0 }
}

extension StaticArray8: ABSComputable where T: ABSComputable {
    @inlinable public func abs() -> Self {
        self.map { $0.abs() }
    }
}

public struct StaticArray9<T> {
    public typealias Values = (T, T, T, T, T, T, T, T, T)

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
            value
        )
    }

    init(array: [T]) throws {
        guard array.count == 9 else { fatalError("array size mismatch") }
        self.values = (
            array[0],
            array[1],
            array[2],
            array[3],
            array[4],
            array[5],
            array[6],
            array[7],
            array[8]
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
            self[8]
        ]
    }

    @inlinable public func map<M>(_ transform: (T) throws -> M) rethrows -> StaticArray9<M> {
        try StaticArray9<M>(values: (
            transform(self[0]),
            transform(self[1]),
            transform(self[2]),
            transform(self[3]),
            transform(self[4]),
            transform(self[5]),
            transform(self[6]),
            transform(self[7]),
            transform(self[8])
        ))
    }
}

public func zip<L, R>(_ lhs: StaticArray9<L>, _ rhs: StaticArray9<R>) -> StaticArray9<(L, R)> {
    StaticArray9(values: (
        (lhs[0], rhs[0]),
        (lhs[1], rhs[1]),
        (lhs[2], rhs[2]),
        (lhs[3], rhs[3]),
        (lhs[4], rhs[4]),
        (lhs[5], rhs[5]),
        (lhs[6], rhs[6]),
        (lhs[7], rhs[7]),
        (lhs[8], rhs[8])
    ))
}

extension StaticArray9: Collection {
    public typealias Index = Int
    public var startIndex: Index { 0 }
    public var endIndex: Index { 9 }
    @inlinable public func index(after i: Index) -> Index { i + 1 }
}

extension StaticArray9: Sequence {
    public struct Iterator: IteratorProtocol {
        private var index = 0
        private let array: StaticArray9<T>

        init(_ array: StaticArray9<T>) {
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

extension StaticArray9: Equatable where T: Equatable {
    @inlinable public static func == (lhs: Self, rhs: Self) -> Bool {
        zip(lhs, rhs).allSatisfy { $0.0 == $0.1 }
    }
}

extension StaticArray9: Codable where T: Codable {
    public init(from decoder: Decoder) throws {
        try self.init(array: [T](from: decoder))
    }

    public func encode(to encoder: Encoder) throws {
        try self.toArray().encode(to: encoder)
    }
}

extension StaticArray9: AdditiveArithmetic where T: AdditiveArithmetic {
    @inlinable public static func - (lhs: Self, rhs: Self) -> Self {
        zip(lhs, rhs).map { $0.0 - $0.1 }
    }

    @inlinable public static func + (lhs: Self, rhs: Self) -> Self {
        zip(lhs, rhs).map { $0.0 + $0.1 }
    }

    @inlinable public static var zero: Self { Self(repeating: T.zero) }
}

@inlinable public func + <T>(lhs: StaticArray9<T>, rhs: T) -> StaticArray9<T> where T: AdditiveArithmetic {
    lhs.map { $0 + rhs }
}

@inlinable public func + <T>(lhs: T, rhs: StaticArray9<T>) -> StaticArray9<T> where T: AdditiveArithmetic {
    rhs.map { lhs + $0 }
}

@inlinable public func - <T>(lhs: StaticArray9<T>, rhs: T) -> StaticArray9<T> where T: AdditiveArithmetic {
    lhs.map { $0 - rhs }
}

@inlinable public func - <T>(lhs: T, rhs: StaticArray9<T>) -> StaticArray9<T> where T: AdditiveArithmetic {
    rhs.map { lhs - $0 }
}

extension StaticArray9: Divisible where T: Divisible {
    @inlinable public static func / (lhs: Self, rhs: Self) -> Self {
        zip(lhs, rhs).map { $0.0 / $0.1 }
    }
}

@inlinable public func / <T>(lhs: StaticArray9<T>, rhs: T) -> StaticArray9<T> where T: Divisible {
    lhs.map { $0 / rhs }
}

@inlinable public func / <T>(lhs: T, rhs: StaticArray9<T>) -> StaticArray9<T> where T: Divisible {
    rhs.map { lhs / $0 }
}

extension StaticArray9: Multipliable where T: Multipliable {
    @inlinable public static func * (lhs: Self, rhs: Self) -> Self {
        zip(lhs, rhs).map { $0.0 * $0.1 }
    }
}

@inlinable public func * <T>(lhs: StaticArray9<T>, rhs: T) -> StaticArray9<T> where T: Multipliable {
    lhs.map { $0 * rhs }
}

@inlinable public func * <T>(lhs: T, rhs: StaticArray9<T>) -> StaticArray9<T> where T: Multipliable {
    rhs.map { lhs * $0 }
}

extension StaticArray9: ABSComputable where T: ABSComputable {
    @inlinable public func abs() -> Self {
        self.map { $0.abs() }
    }
}

public struct StaticArray10<T> {
    public typealias Values = (T, T, T, T, T, T, T, T, T, T)

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
            value
        )
    }

    init(array: [T]) throws {
        guard array.count == 10 else { fatalError("array size mismatch") }
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
            array[9]
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
            self[9]
        ]
    }

    @inlinable public func map<M>(_ transform: (T) throws -> M) rethrows -> StaticArray10<M> {
        try StaticArray10<M>(values: (
            transform(self[0]),
            transform(self[1]),
            transform(self[2]),
            transform(self[3]),
            transform(self[4]),
            transform(self[5]),
            transform(self[6]),
            transform(self[7]),
            transform(self[8]),
            transform(self[9])
        ))
    }
}

public func zip<L, R>(_ lhs: StaticArray10<L>, _ rhs: StaticArray10<R>) -> StaticArray10<(L, R)> {
    StaticArray10(values: (
        (lhs[0], rhs[0]),
        (lhs[1], rhs[1]),
        (lhs[2], rhs[2]),
        (lhs[3], rhs[3]),
        (lhs[4], rhs[4]),
        (lhs[5], rhs[5]),
        (lhs[6], rhs[6]),
        (lhs[7], rhs[7]),
        (lhs[8], rhs[8]),
        (lhs[9], rhs[9])
    ))
}

extension StaticArray10: Collection {
    public typealias Index = Int
    public var startIndex: Index { 0 }
    public var endIndex: Index { 10 }
    @inlinable public func index(after i: Index) -> Index { i + 1 }
}

extension StaticArray10: Sequence {
    public struct Iterator: IteratorProtocol {
        private var index = 0
        private let array: StaticArray10<T>

        init(_ array: StaticArray10<T>) {
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

extension StaticArray10: Equatable where T: Equatable {
    @inlinable public static func == (lhs: Self, rhs: Self) -> Bool {
        zip(lhs, rhs).allSatisfy { $0.0 == $0.1 }
    }
}

extension StaticArray10: Codable where T: Codable {
    public init(from decoder: Decoder) throws {
        try self.init(array: [T](from: decoder))
    }

    public func encode(to encoder: Encoder) throws {
        try self.toArray().encode(to: encoder)
    }
}

extension StaticArray10: AdditiveArithmetic where T: AdditiveArithmetic {
    @inlinable public static func - (lhs: Self, rhs: Self) -> Self {
        zip(lhs, rhs).map { $0.0 - $0.1 }
    }

    @inlinable public static func + (lhs: Self, rhs: Self) -> Self {
        zip(lhs, rhs).map { $0.0 + $0.1 }
    }

    @inlinable public static var zero: Self { Self(repeating: T.zero) }
}

@inlinable public func + <T>(lhs: StaticArray10<T>, rhs: T) -> StaticArray10<T> where T: AdditiveArithmetic {
    lhs.map { $0 + rhs }
}

@inlinable public func + <T>(lhs: T, rhs: StaticArray10<T>) -> StaticArray10<T> where T: AdditiveArithmetic {
    rhs.map { lhs + $0 }
}

@inlinable public func - <T>(lhs: StaticArray10<T>, rhs: T) -> StaticArray10<T> where T: AdditiveArithmetic {
    lhs.map { $0 - rhs }
}

@inlinable public func - <T>(lhs: T, rhs: StaticArray10<T>) -> StaticArray10<T> where T: AdditiveArithmetic {
    rhs.map { lhs - $0 }
}

extension StaticArray10: Divisible where T: Divisible {
    @inlinable public static func / (lhs: Self, rhs: Self) -> Self {
        zip(lhs, rhs).map { $0.0 / $0.1 }
    }
}

@inlinable public func / <T>(lhs: StaticArray10<T>, rhs: T) -> StaticArray10<T> where T: Divisible {
    lhs.map { $0 / rhs }
}

@inlinable public func / <T>(lhs: T, rhs: StaticArray10<T>) -> StaticArray10<T> where T: Divisible {
    rhs.map { lhs / $0 }
}

extension StaticArray10: Multipliable where T: Multipliable {
    @inlinable public static func * (lhs: Self, rhs: Self) -> Self {
        zip(lhs, rhs).map { $0.0 * $0.1 }
    }
}

@inlinable public func * <T>(lhs: StaticArray10<T>, rhs: T) -> StaticArray10<T> where T: Multipliable {
    lhs.map { $0 * rhs }
}

@inlinable public func * <T>(lhs: T, rhs: StaticArray10<T>) -> StaticArray10<T> where T: Multipliable {
    rhs.map { lhs * $0 }
}

extension StaticArray10: ABSComputable where T: ABSComputable {
    @inlinable public func abs() -> Self {
        self.map { $0.abs() }
    }
}

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

    init(array: [T]) throws {
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

public struct StaticArray12<T> {
    public typealias Values = (T, T, T, T, T, T, T, T, T, T, T, T)

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
            value,
            value
        )
    }

    init(array: [T]) throws {
        guard array.count == 12 else { fatalError("array size mismatch") }
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
            array[10],
            array[11]
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
            case 11: return self.values.11
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
            case 11: self.values.11 = newValue
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
         case 10:
            return StaticArray2(values: (
                self[10],
                self[11]
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
         case 9:
            return StaticArray3(values: (
                self[9],
                self[10],
                self[11]
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
         case 8:
            return StaticArray4(values: (
                self[8],
                self[9],
                self[10],
                self[11]
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
         case 7:
            return StaticArray5(values: (
                self[7],
                self[8],
                self[9],
                self[10],
                self[11]
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
         case 6:
            return StaticArray6(values: (
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11]
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
         case 5:
            return StaticArray7(values: (
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11]
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
         case 4:
            return StaticArray8(values: (
                self[4],
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11]
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
         case 3:
            return StaticArray9(values: (
                self[3],
                self[4],
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11]
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
         case 2:
            return StaticArray10(values: (
                self[2],
                self[3],
                self[4],
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11]
            ))
        default:
            fatalError("offset out of available range")
        }
    }

    @inlinable public func get11(from offset: Int = 0) ->  StaticArray11<T> {
        switch offset {
         case 0:
            return StaticArray11(values: (
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
            ))
         case 1:
            return StaticArray11(values: (
                self[1],
                self[2],
                self[3],
                self[4],
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11]
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
         case 10:
            self[10] = array[0]
            self[11] = array[1]
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
         case 9:
            self[9] = array[0]
            self[10] = array[1]
            self[11] = array[2]
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
         case 8:
            self[8] = array[0]
            self[9] = array[1]
            self[10] = array[2]
            self[11] = array[3]
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
         case 7:
            self[7] = array[0]
            self[8] = array[1]
            self[9] = array[2]
            self[10] = array[3]
            self[11] = array[4]
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
         case 6:
            self[6] = array[0]
            self[7] = array[1]
            self[8] = array[2]
            self[9] = array[3]
            self[10] = array[4]
            self[11] = array[5]
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
         case 5:
            self[5] = array[0]
            self[6] = array[1]
            self[7] = array[2]
            self[8] = array[3]
            self[9] = array[4]
            self[10] = array[5]
            self[11] = array[6]
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
         case 4:
            self[4] = array[0]
            self[5] = array[1]
            self[6] = array[2]
            self[7] = array[3]
            self[8] = array[4]
            self[9] = array[5]
            self[10] = array[6]
            self[11] = array[7]
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
         case 3:
            self[3] = array[0]
            self[4] = array[1]
            self[5] = array[2]
            self[6] = array[3]
            self[7] = array[4]
            self[8] = array[5]
            self[9] = array[6]
            self[10] = array[7]
            self[11] = array[8]
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
            self[11] = array[9]
        default:
            fatalError("offset out of available range")
        }
    }

    @inlinable public mutating func set11(_ array: StaticArray11<T>, at offset: Int = 0) {
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
            self[10] = array[10]
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
            self[11] = array[10]
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
            self[10],
            self[11]
        ]
    }

    @inlinable public func map<M>(_ transform: (T) throws -> M) rethrows -> StaticArray12<M> {
        try StaticArray12<M>(values: (
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
            transform(self[10]),
            transform(self[11])
        ))
    }
}

public func zip<L, R>(_ lhs: StaticArray12<L>, _ rhs: StaticArray12<R>) -> StaticArray12<(L, R)> {
    StaticArray12(values: (
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
        (lhs[10], rhs[10]),
        (lhs[11], rhs[11])
    ))
}

extension StaticArray12: Collection {
    public typealias Index = Int
    public var startIndex: Index { 0 }
    public var endIndex: Index { 12 }
    @inlinable public func index(after i: Index) -> Index { i + 1 }
}

extension StaticArray12: Sequence {
    public struct Iterator: IteratorProtocol {
        private var index = 0
        private let array: StaticArray12<T>

        init(_ array: StaticArray12<T>) {
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

extension StaticArray12: Equatable where T: Equatable {
    @inlinable public static func == (lhs: Self, rhs: Self) -> Bool {
        zip(lhs, rhs).allSatisfy { $0.0 == $0.1 }
    }
}

extension StaticArray12: Codable where T: Codable {
    public init(from decoder: Decoder) throws {
        try self.init(array: [T](from: decoder))
    }

    public func encode(to encoder: Encoder) throws {
        try self.toArray().encode(to: encoder)
    }
}

extension StaticArray12: AdditiveArithmetic where T: AdditiveArithmetic {
    @inlinable public static func - (lhs: Self, rhs: Self) -> Self {
        zip(lhs, rhs).map { $0.0 - $0.1 }
    }

    @inlinable public static func + (lhs: Self, rhs: Self) -> Self {
        zip(lhs, rhs).map { $0.0 + $0.1 }
    }

    @inlinable public static var zero: Self { Self(repeating: T.zero) }
}

@inlinable public func + <T>(lhs: StaticArray12<T>, rhs: T) -> StaticArray12<T> where T: AdditiveArithmetic {
    lhs.map { $0 + rhs }
}

@inlinable public func + <T>(lhs: T, rhs: StaticArray12<T>) -> StaticArray12<T> where T: AdditiveArithmetic {
    rhs.map { lhs + $0 }
}

@inlinable public func - <T>(lhs: StaticArray12<T>, rhs: T) -> StaticArray12<T> where T: AdditiveArithmetic {
    lhs.map { $0 - rhs }
}

@inlinable public func - <T>(lhs: T, rhs: StaticArray12<T>) -> StaticArray12<T> where T: AdditiveArithmetic {
    rhs.map { lhs - $0 }
}

extension StaticArray12: Divisible where T: Divisible {
    @inlinable public static func / (lhs: Self, rhs: Self) -> Self {
        zip(lhs, rhs).map { $0.0 / $0.1 }
    }
}

@inlinable public func / <T>(lhs: StaticArray12<T>, rhs: T) -> StaticArray12<T> where T: Divisible {
    lhs.map { $0 / rhs }
}

@inlinable public func / <T>(lhs: T, rhs: StaticArray12<T>) -> StaticArray12<T> where T: Divisible {
    rhs.map { lhs / $0 }
}

extension StaticArray12: Multipliable where T: Multipliable {
    @inlinable public static func * (lhs: Self, rhs: Self) -> Self {
        zip(lhs, rhs).map { $0.0 * $0.1 }
    }
}

@inlinable public func * <T>(lhs: StaticArray12<T>, rhs: T) -> StaticArray12<T> where T: Multipliable {
    lhs.map { $0 * rhs }
}

@inlinable public func * <T>(lhs: T, rhs: StaticArray12<T>) -> StaticArray12<T> where T: Multipliable {
    rhs.map { lhs * $0 }
}

extension StaticArray12: ABSComputable where T: ABSComputable {
    @inlinable public func abs() -> Self {
        self.map { $0.abs() }
    }
}

public struct StaticArray13<T> {
    public typealias Values = (T, T, T, T, T, T, T, T, T, T, T, T, T)

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
            value,
            value,
            value
        )
    }

    init(array: [T]) throws {
        guard array.count == 13 else { fatalError("array size mismatch") }
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
            array[10],
            array[11],
            array[12]
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
            case 11: return self.values.11
            case 12: return self.values.12
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
            case 11: self.values.11 = newValue
            case 12: self.values.12 = newValue
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
         case 10:
            return StaticArray2(values: (
                self[10],
                self[11]
            ))
         case 11:
            return StaticArray2(values: (
                self[11],
                self[12]
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
         case 9:
            return StaticArray3(values: (
                self[9],
                self[10],
                self[11]
            ))
         case 10:
            return StaticArray3(values: (
                self[10],
                self[11],
                self[12]
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
         case 8:
            return StaticArray4(values: (
                self[8],
                self[9],
                self[10],
                self[11]
            ))
         case 9:
            return StaticArray4(values: (
                self[9],
                self[10],
                self[11],
                self[12]
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
         case 7:
            return StaticArray5(values: (
                self[7],
                self[8],
                self[9],
                self[10],
                self[11]
            ))
         case 8:
            return StaticArray5(values: (
                self[8],
                self[9],
                self[10],
                self[11],
                self[12]
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
         case 6:
            return StaticArray6(values: (
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11]
            ))
         case 7:
            return StaticArray6(values: (
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12]
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
         case 5:
            return StaticArray7(values: (
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11]
            ))
         case 6:
            return StaticArray7(values: (
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12]
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
         case 4:
            return StaticArray8(values: (
                self[4],
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11]
            ))
         case 5:
            return StaticArray8(values: (
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12]
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
         case 3:
            return StaticArray9(values: (
                self[3],
                self[4],
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11]
            ))
         case 4:
            return StaticArray9(values: (
                self[4],
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12]
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
         case 2:
            return StaticArray10(values: (
                self[2],
                self[3],
                self[4],
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11]
            ))
         case 3:
            return StaticArray10(values: (
                self[3],
                self[4],
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12]
            ))
        default:
            fatalError("offset out of available range")
        }
    }

    @inlinable public func get11(from offset: Int = 0) ->  StaticArray11<T> {
        switch offset {
         case 0:
            return StaticArray11(values: (
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
            ))
         case 1:
            return StaticArray11(values: (
                self[1],
                self[2],
                self[3],
                self[4],
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11]
            ))
         case 2:
            return StaticArray11(values: (
                self[2],
                self[3],
                self[4],
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12]
            ))
        default:
            fatalError("offset out of available range")
        }
    }

    @inlinable public func get12(from offset: Int = 0) ->  StaticArray12<T> {
        switch offset {
         case 0:
            return StaticArray12(values: (
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
                self[10],
                self[11]
            ))
         case 1:
            return StaticArray12(values: (
                self[1],
                self[2],
                self[3],
                self[4],
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12]
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
         case 10:
            self[10] = array[0]
            self[11] = array[1]
         case 11:
            self[11] = array[0]
            self[12] = array[1]
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
         case 9:
            self[9] = array[0]
            self[10] = array[1]
            self[11] = array[2]
         case 10:
            self[10] = array[0]
            self[11] = array[1]
            self[12] = array[2]
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
         case 8:
            self[8] = array[0]
            self[9] = array[1]
            self[10] = array[2]
            self[11] = array[3]
         case 9:
            self[9] = array[0]
            self[10] = array[1]
            self[11] = array[2]
            self[12] = array[3]
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
         case 7:
            self[7] = array[0]
            self[8] = array[1]
            self[9] = array[2]
            self[10] = array[3]
            self[11] = array[4]
         case 8:
            self[8] = array[0]
            self[9] = array[1]
            self[10] = array[2]
            self[11] = array[3]
            self[12] = array[4]
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
         case 6:
            self[6] = array[0]
            self[7] = array[1]
            self[8] = array[2]
            self[9] = array[3]
            self[10] = array[4]
            self[11] = array[5]
         case 7:
            self[7] = array[0]
            self[8] = array[1]
            self[9] = array[2]
            self[10] = array[3]
            self[11] = array[4]
            self[12] = array[5]
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
         case 5:
            self[5] = array[0]
            self[6] = array[1]
            self[7] = array[2]
            self[8] = array[3]
            self[9] = array[4]
            self[10] = array[5]
            self[11] = array[6]
         case 6:
            self[6] = array[0]
            self[7] = array[1]
            self[8] = array[2]
            self[9] = array[3]
            self[10] = array[4]
            self[11] = array[5]
            self[12] = array[6]
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
         case 4:
            self[4] = array[0]
            self[5] = array[1]
            self[6] = array[2]
            self[7] = array[3]
            self[8] = array[4]
            self[9] = array[5]
            self[10] = array[6]
            self[11] = array[7]
         case 5:
            self[5] = array[0]
            self[6] = array[1]
            self[7] = array[2]
            self[8] = array[3]
            self[9] = array[4]
            self[10] = array[5]
            self[11] = array[6]
            self[12] = array[7]
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
         case 3:
            self[3] = array[0]
            self[4] = array[1]
            self[5] = array[2]
            self[6] = array[3]
            self[7] = array[4]
            self[8] = array[5]
            self[9] = array[6]
            self[10] = array[7]
            self[11] = array[8]
         case 4:
            self[4] = array[0]
            self[5] = array[1]
            self[6] = array[2]
            self[7] = array[3]
            self[8] = array[4]
            self[9] = array[5]
            self[10] = array[6]
            self[11] = array[7]
            self[12] = array[8]
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
            self[11] = array[9]
         case 3:
            self[3] = array[0]
            self[4] = array[1]
            self[5] = array[2]
            self[6] = array[3]
            self[7] = array[4]
            self[8] = array[5]
            self[9] = array[6]
            self[10] = array[7]
            self[11] = array[8]
            self[12] = array[9]
        default:
            fatalError("offset out of available range")
        }
    }

    @inlinable public mutating func set11(_ array: StaticArray11<T>, at offset: Int = 0) {
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
            self[10] = array[10]
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
            self[11] = array[10]
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
            self[11] = array[9]
            self[12] = array[10]
        default:
            fatalError("offset out of available range")
        }
    }

    @inlinable public mutating func set12(_ array: StaticArray12<T>, at offset: Int = 0) {
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
            self[10] = array[10]
            self[11] = array[11]
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
            self[11] = array[10]
            self[12] = array[11]
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
            self[10],
            self[11],
            self[12]
        ]
    }

    @inlinable public func map<M>(_ transform: (T) throws -> M) rethrows -> StaticArray13<M> {
        try StaticArray13<M>(values: (
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
            transform(self[10]),
            transform(self[11]),
            transform(self[12])
        ))
    }
}

public func zip<L, R>(_ lhs: StaticArray13<L>, _ rhs: StaticArray13<R>) -> StaticArray13<(L, R)> {
    StaticArray13(values: (
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
        (lhs[10], rhs[10]),
        (lhs[11], rhs[11]),
        (lhs[12], rhs[12])
    ))
}

extension StaticArray13: Collection {
    public typealias Index = Int
    public var startIndex: Index { 0 }
    public var endIndex: Index { 13 }
    @inlinable public func index(after i: Index) -> Index { i + 1 }
}

extension StaticArray13: Sequence {
    public struct Iterator: IteratorProtocol {
        private var index = 0
        private let array: StaticArray13<T>

        init(_ array: StaticArray13<T>) {
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

extension StaticArray13: Equatable where T: Equatable {
    @inlinable public static func == (lhs: Self, rhs: Self) -> Bool {
        zip(lhs, rhs).allSatisfy { $0.0 == $0.1 }
    }
}

extension StaticArray13: Codable where T: Codable {
    public init(from decoder: Decoder) throws {
        try self.init(array: [T](from: decoder))
    }

    public func encode(to encoder: Encoder) throws {
        try self.toArray().encode(to: encoder)
    }
}

extension StaticArray13: AdditiveArithmetic where T: AdditiveArithmetic {
    @inlinable public static func - (lhs: Self, rhs: Self) -> Self {
        zip(lhs, rhs).map { $0.0 - $0.1 }
    }

    @inlinable public static func + (lhs: Self, rhs: Self) -> Self {
        zip(lhs, rhs).map { $0.0 + $0.1 }
    }

    @inlinable public static var zero: Self { Self(repeating: T.zero) }
}

@inlinable public func + <T>(lhs: StaticArray13<T>, rhs: T) -> StaticArray13<T> where T: AdditiveArithmetic {
    lhs.map { $0 + rhs }
}

@inlinable public func + <T>(lhs: T, rhs: StaticArray13<T>) -> StaticArray13<T> where T: AdditiveArithmetic {
    rhs.map { lhs + $0 }
}

@inlinable public func - <T>(lhs: StaticArray13<T>, rhs: T) -> StaticArray13<T> where T: AdditiveArithmetic {
    lhs.map { $0 - rhs }
}

@inlinable public func - <T>(lhs: T, rhs: StaticArray13<T>) -> StaticArray13<T> where T: AdditiveArithmetic {
    rhs.map { lhs - $0 }
}

extension StaticArray13: Divisible where T: Divisible {
    @inlinable public static func / (lhs: Self, rhs: Self) -> Self {
        zip(lhs, rhs).map { $0.0 / $0.1 }
    }
}

@inlinable public func / <T>(lhs: StaticArray13<T>, rhs: T) -> StaticArray13<T> where T: Divisible {
    lhs.map { $0 / rhs }
}

@inlinable public func / <T>(lhs: T, rhs: StaticArray13<T>) -> StaticArray13<T> where T: Divisible {
    rhs.map { lhs / $0 }
}

extension StaticArray13: Multipliable where T: Multipliable {
    @inlinable public static func * (lhs: Self, rhs: Self) -> Self {
        zip(lhs, rhs).map { $0.0 * $0.1 }
    }
}

@inlinable public func * <T>(lhs: StaticArray13<T>, rhs: T) -> StaticArray13<T> where T: Multipliable {
    lhs.map { $0 * rhs }
}

@inlinable public func * <T>(lhs: T, rhs: StaticArray13<T>) -> StaticArray13<T> where T: Multipliable {
    rhs.map { lhs * $0 }
}

extension StaticArray13: ABSComputable where T: ABSComputable {
    @inlinable public func abs() -> Self {
        self.map { $0.abs() }
    }
}

public struct StaticArray14<T> {
    public typealias Values = (T, T, T, T, T, T, T, T, T, T, T, T, T, T)

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
            value,
            value,
            value,
            value
        )
    }

    init(array: [T]) throws {
        guard array.count == 14 else { fatalError("array size mismatch") }
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
            array[10],
            array[11],
            array[12],
            array[13]
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
            case 11: return self.values.11
            case 12: return self.values.12
            case 13: return self.values.13
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
            case 11: self.values.11 = newValue
            case 12: self.values.12 = newValue
            case 13: self.values.13 = newValue
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
         case 10:
            return StaticArray2(values: (
                self[10],
                self[11]
            ))
         case 11:
            return StaticArray2(values: (
                self[11],
                self[12]
            ))
         case 12:
            return StaticArray2(values: (
                self[12],
                self[13]
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
         case 9:
            return StaticArray3(values: (
                self[9],
                self[10],
                self[11]
            ))
         case 10:
            return StaticArray3(values: (
                self[10],
                self[11],
                self[12]
            ))
         case 11:
            return StaticArray3(values: (
                self[11],
                self[12],
                self[13]
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
         case 8:
            return StaticArray4(values: (
                self[8],
                self[9],
                self[10],
                self[11]
            ))
         case 9:
            return StaticArray4(values: (
                self[9],
                self[10],
                self[11],
                self[12]
            ))
         case 10:
            return StaticArray4(values: (
                self[10],
                self[11],
                self[12],
                self[13]
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
         case 7:
            return StaticArray5(values: (
                self[7],
                self[8],
                self[9],
                self[10],
                self[11]
            ))
         case 8:
            return StaticArray5(values: (
                self[8],
                self[9],
                self[10],
                self[11],
                self[12]
            ))
         case 9:
            return StaticArray5(values: (
                self[9],
                self[10],
                self[11],
                self[12],
                self[13]
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
         case 6:
            return StaticArray6(values: (
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11]
            ))
         case 7:
            return StaticArray6(values: (
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12]
            ))
         case 8:
            return StaticArray6(values: (
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13]
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
         case 5:
            return StaticArray7(values: (
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11]
            ))
         case 6:
            return StaticArray7(values: (
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12]
            ))
         case 7:
            return StaticArray7(values: (
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13]
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
         case 4:
            return StaticArray8(values: (
                self[4],
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11]
            ))
         case 5:
            return StaticArray8(values: (
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12]
            ))
         case 6:
            return StaticArray8(values: (
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13]
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
         case 3:
            return StaticArray9(values: (
                self[3],
                self[4],
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11]
            ))
         case 4:
            return StaticArray9(values: (
                self[4],
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12]
            ))
         case 5:
            return StaticArray9(values: (
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13]
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
         case 2:
            return StaticArray10(values: (
                self[2],
                self[3],
                self[4],
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11]
            ))
         case 3:
            return StaticArray10(values: (
                self[3],
                self[4],
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12]
            ))
         case 4:
            return StaticArray10(values: (
                self[4],
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13]
            ))
        default:
            fatalError("offset out of available range")
        }
    }

    @inlinable public func get11(from offset: Int = 0) ->  StaticArray11<T> {
        switch offset {
         case 0:
            return StaticArray11(values: (
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
            ))
         case 1:
            return StaticArray11(values: (
                self[1],
                self[2],
                self[3],
                self[4],
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11]
            ))
         case 2:
            return StaticArray11(values: (
                self[2],
                self[3],
                self[4],
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12]
            ))
         case 3:
            return StaticArray11(values: (
                self[3],
                self[4],
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13]
            ))
        default:
            fatalError("offset out of available range")
        }
    }

    @inlinable public func get12(from offset: Int = 0) ->  StaticArray12<T> {
        switch offset {
         case 0:
            return StaticArray12(values: (
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
                self[10],
                self[11]
            ))
         case 1:
            return StaticArray12(values: (
                self[1],
                self[2],
                self[3],
                self[4],
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12]
            ))
         case 2:
            return StaticArray12(values: (
                self[2],
                self[3],
                self[4],
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13]
            ))
        default:
            fatalError("offset out of available range")
        }
    }

    @inlinable public func get13(from offset: Int = 0) ->  StaticArray13<T> {
        switch offset {
         case 0:
            return StaticArray13(values: (
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
                self[10],
                self[11],
                self[12]
            ))
         case 1:
            return StaticArray13(values: (
                self[1],
                self[2],
                self[3],
                self[4],
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13]
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
         case 10:
            self[10] = array[0]
            self[11] = array[1]
         case 11:
            self[11] = array[0]
            self[12] = array[1]
         case 12:
            self[12] = array[0]
            self[13] = array[1]
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
         case 9:
            self[9] = array[0]
            self[10] = array[1]
            self[11] = array[2]
         case 10:
            self[10] = array[0]
            self[11] = array[1]
            self[12] = array[2]
         case 11:
            self[11] = array[0]
            self[12] = array[1]
            self[13] = array[2]
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
         case 8:
            self[8] = array[0]
            self[9] = array[1]
            self[10] = array[2]
            self[11] = array[3]
         case 9:
            self[9] = array[0]
            self[10] = array[1]
            self[11] = array[2]
            self[12] = array[3]
         case 10:
            self[10] = array[0]
            self[11] = array[1]
            self[12] = array[2]
            self[13] = array[3]
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
         case 7:
            self[7] = array[0]
            self[8] = array[1]
            self[9] = array[2]
            self[10] = array[3]
            self[11] = array[4]
         case 8:
            self[8] = array[0]
            self[9] = array[1]
            self[10] = array[2]
            self[11] = array[3]
            self[12] = array[4]
         case 9:
            self[9] = array[0]
            self[10] = array[1]
            self[11] = array[2]
            self[12] = array[3]
            self[13] = array[4]
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
         case 6:
            self[6] = array[0]
            self[7] = array[1]
            self[8] = array[2]
            self[9] = array[3]
            self[10] = array[4]
            self[11] = array[5]
         case 7:
            self[7] = array[0]
            self[8] = array[1]
            self[9] = array[2]
            self[10] = array[3]
            self[11] = array[4]
            self[12] = array[5]
         case 8:
            self[8] = array[0]
            self[9] = array[1]
            self[10] = array[2]
            self[11] = array[3]
            self[12] = array[4]
            self[13] = array[5]
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
         case 5:
            self[5] = array[0]
            self[6] = array[1]
            self[7] = array[2]
            self[8] = array[3]
            self[9] = array[4]
            self[10] = array[5]
            self[11] = array[6]
         case 6:
            self[6] = array[0]
            self[7] = array[1]
            self[8] = array[2]
            self[9] = array[3]
            self[10] = array[4]
            self[11] = array[5]
            self[12] = array[6]
         case 7:
            self[7] = array[0]
            self[8] = array[1]
            self[9] = array[2]
            self[10] = array[3]
            self[11] = array[4]
            self[12] = array[5]
            self[13] = array[6]
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
         case 4:
            self[4] = array[0]
            self[5] = array[1]
            self[6] = array[2]
            self[7] = array[3]
            self[8] = array[4]
            self[9] = array[5]
            self[10] = array[6]
            self[11] = array[7]
         case 5:
            self[5] = array[0]
            self[6] = array[1]
            self[7] = array[2]
            self[8] = array[3]
            self[9] = array[4]
            self[10] = array[5]
            self[11] = array[6]
            self[12] = array[7]
         case 6:
            self[6] = array[0]
            self[7] = array[1]
            self[8] = array[2]
            self[9] = array[3]
            self[10] = array[4]
            self[11] = array[5]
            self[12] = array[6]
            self[13] = array[7]
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
         case 3:
            self[3] = array[0]
            self[4] = array[1]
            self[5] = array[2]
            self[6] = array[3]
            self[7] = array[4]
            self[8] = array[5]
            self[9] = array[6]
            self[10] = array[7]
            self[11] = array[8]
         case 4:
            self[4] = array[0]
            self[5] = array[1]
            self[6] = array[2]
            self[7] = array[3]
            self[8] = array[4]
            self[9] = array[5]
            self[10] = array[6]
            self[11] = array[7]
            self[12] = array[8]
         case 5:
            self[5] = array[0]
            self[6] = array[1]
            self[7] = array[2]
            self[8] = array[3]
            self[9] = array[4]
            self[10] = array[5]
            self[11] = array[6]
            self[12] = array[7]
            self[13] = array[8]
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
            self[11] = array[9]
         case 3:
            self[3] = array[0]
            self[4] = array[1]
            self[5] = array[2]
            self[6] = array[3]
            self[7] = array[4]
            self[8] = array[5]
            self[9] = array[6]
            self[10] = array[7]
            self[11] = array[8]
            self[12] = array[9]
         case 4:
            self[4] = array[0]
            self[5] = array[1]
            self[6] = array[2]
            self[7] = array[3]
            self[8] = array[4]
            self[9] = array[5]
            self[10] = array[6]
            self[11] = array[7]
            self[12] = array[8]
            self[13] = array[9]
        default:
            fatalError("offset out of available range")
        }
    }

    @inlinable public mutating func set11(_ array: StaticArray11<T>, at offset: Int = 0) {
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
            self[10] = array[10]
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
            self[11] = array[10]
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
            self[11] = array[9]
            self[12] = array[10]
         case 3:
            self[3] = array[0]
            self[4] = array[1]
            self[5] = array[2]
            self[6] = array[3]
            self[7] = array[4]
            self[8] = array[5]
            self[9] = array[6]
            self[10] = array[7]
            self[11] = array[8]
            self[12] = array[9]
            self[13] = array[10]
        default:
            fatalError("offset out of available range")
        }
    }

    @inlinable public mutating func set12(_ array: StaticArray12<T>, at offset: Int = 0) {
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
            self[10] = array[10]
            self[11] = array[11]
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
            self[11] = array[10]
            self[12] = array[11]
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
            self[11] = array[9]
            self[12] = array[10]
            self[13] = array[11]
        default:
            fatalError("offset out of available range")
        }
    }

    @inlinable public mutating func set13(_ array: StaticArray13<T>, at offset: Int = 0) {
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
            self[10] = array[10]
            self[11] = array[11]
            self[12] = array[12]
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
            self[11] = array[10]
            self[12] = array[11]
            self[13] = array[12]
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
            self[10],
            self[11],
            self[12],
            self[13]
        ]
    }

    @inlinable public func map<M>(_ transform: (T) throws -> M) rethrows -> StaticArray14<M> {
        try StaticArray14<M>(values: (
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
            transform(self[10]),
            transform(self[11]),
            transform(self[12]),
            transform(self[13])
        ))
    }
}

public func zip<L, R>(_ lhs: StaticArray14<L>, _ rhs: StaticArray14<R>) -> StaticArray14<(L, R)> {
    StaticArray14(values: (
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
        (lhs[10], rhs[10]),
        (lhs[11], rhs[11]),
        (lhs[12], rhs[12]),
        (lhs[13], rhs[13])
    ))
}

extension StaticArray14: Collection {
    public typealias Index = Int
    public var startIndex: Index { 0 }
    public var endIndex: Index { 14 }
    @inlinable public func index(after i: Index) -> Index { i + 1 }
}

extension StaticArray14: Sequence {
    public struct Iterator: IteratorProtocol {
        private var index = 0
        private let array: StaticArray14<T>

        init(_ array: StaticArray14<T>) {
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

extension StaticArray14: Equatable where T: Equatable {
    @inlinable public static func == (lhs: Self, rhs: Self) -> Bool {
        zip(lhs, rhs).allSatisfy { $0.0 == $0.1 }
    }
}

extension StaticArray14: Codable where T: Codable {
    public init(from decoder: Decoder) throws {
        try self.init(array: [T](from: decoder))
    }

    public func encode(to encoder: Encoder) throws {
        try self.toArray().encode(to: encoder)
    }
}

extension StaticArray14: AdditiveArithmetic where T: AdditiveArithmetic {
    @inlinable public static func - (lhs: Self, rhs: Self) -> Self {
        zip(lhs, rhs).map { $0.0 - $0.1 }
    }

    @inlinable public static func + (lhs: Self, rhs: Self) -> Self {
        zip(lhs, rhs).map { $0.0 + $0.1 }
    }

    @inlinable public static var zero: Self { Self(repeating: T.zero) }
}

@inlinable public func + <T>(lhs: StaticArray14<T>, rhs: T) -> StaticArray14<T> where T: AdditiveArithmetic {
    lhs.map { $0 + rhs }
}

@inlinable public func + <T>(lhs: T, rhs: StaticArray14<T>) -> StaticArray14<T> where T: AdditiveArithmetic {
    rhs.map { lhs + $0 }
}

@inlinable public func - <T>(lhs: StaticArray14<T>, rhs: T) -> StaticArray14<T> where T: AdditiveArithmetic {
    lhs.map { $0 - rhs }
}

@inlinable public func - <T>(lhs: T, rhs: StaticArray14<T>) -> StaticArray14<T> where T: AdditiveArithmetic {
    rhs.map { lhs - $0 }
}

extension StaticArray14: Divisible where T: Divisible {
    @inlinable public static func / (lhs: Self, rhs: Self) -> Self {
        zip(lhs, rhs).map { $0.0 / $0.1 }
    }
}

@inlinable public func / <T>(lhs: StaticArray14<T>, rhs: T) -> StaticArray14<T> where T: Divisible {
    lhs.map { $0 / rhs }
}

@inlinable public func / <T>(lhs: T, rhs: StaticArray14<T>) -> StaticArray14<T> where T: Divisible {
    rhs.map { lhs / $0 }
}

extension StaticArray14: Multipliable where T: Multipliable {
    @inlinable public static func * (lhs: Self, rhs: Self) -> Self {
        zip(lhs, rhs).map { $0.0 * $0.1 }
    }
}

@inlinable public func * <T>(lhs: StaticArray14<T>, rhs: T) -> StaticArray14<T> where T: Multipliable {
    lhs.map { $0 * rhs }
}

@inlinable public func * <T>(lhs: T, rhs: StaticArray14<T>) -> StaticArray14<T> where T: Multipliable {
    rhs.map { lhs * $0 }
}

extension StaticArray14: ABSComputable where T: ABSComputable {
    @inlinable public func abs() -> Self {
        self.map { $0.abs() }
    }
}

public struct StaticArray15<T> {
    public typealias Values = (T, T, T, T, T, T, T, T, T, T, T, T, T, T, T)

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
            value,
            value,
            value,
            value,
            value
        )
    }

    init(array: [T]) throws {
        guard array.count == 15 else { fatalError("array size mismatch") }
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
            array[10],
            array[11],
            array[12],
            array[13],
            array[14]
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
            case 11: return self.values.11
            case 12: return self.values.12
            case 13: return self.values.13
            case 14: return self.values.14
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
            case 11: self.values.11 = newValue
            case 12: self.values.12 = newValue
            case 13: self.values.13 = newValue
            case 14: self.values.14 = newValue
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
         case 10:
            return StaticArray2(values: (
                self[10],
                self[11]
            ))
         case 11:
            return StaticArray2(values: (
                self[11],
                self[12]
            ))
         case 12:
            return StaticArray2(values: (
                self[12],
                self[13]
            ))
         case 13:
            return StaticArray2(values: (
                self[13],
                self[14]
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
         case 9:
            return StaticArray3(values: (
                self[9],
                self[10],
                self[11]
            ))
         case 10:
            return StaticArray3(values: (
                self[10],
                self[11],
                self[12]
            ))
         case 11:
            return StaticArray3(values: (
                self[11],
                self[12],
                self[13]
            ))
         case 12:
            return StaticArray3(values: (
                self[12],
                self[13],
                self[14]
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
         case 8:
            return StaticArray4(values: (
                self[8],
                self[9],
                self[10],
                self[11]
            ))
         case 9:
            return StaticArray4(values: (
                self[9],
                self[10],
                self[11],
                self[12]
            ))
         case 10:
            return StaticArray4(values: (
                self[10],
                self[11],
                self[12],
                self[13]
            ))
         case 11:
            return StaticArray4(values: (
                self[11],
                self[12],
                self[13],
                self[14]
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
         case 7:
            return StaticArray5(values: (
                self[7],
                self[8],
                self[9],
                self[10],
                self[11]
            ))
         case 8:
            return StaticArray5(values: (
                self[8],
                self[9],
                self[10],
                self[11],
                self[12]
            ))
         case 9:
            return StaticArray5(values: (
                self[9],
                self[10],
                self[11],
                self[12],
                self[13]
            ))
         case 10:
            return StaticArray5(values: (
                self[10],
                self[11],
                self[12],
                self[13],
                self[14]
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
         case 6:
            return StaticArray6(values: (
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11]
            ))
         case 7:
            return StaticArray6(values: (
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12]
            ))
         case 8:
            return StaticArray6(values: (
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13]
            ))
         case 9:
            return StaticArray6(values: (
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14]
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
         case 5:
            return StaticArray7(values: (
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11]
            ))
         case 6:
            return StaticArray7(values: (
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12]
            ))
         case 7:
            return StaticArray7(values: (
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13]
            ))
         case 8:
            return StaticArray7(values: (
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14]
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
         case 4:
            return StaticArray8(values: (
                self[4],
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11]
            ))
         case 5:
            return StaticArray8(values: (
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12]
            ))
         case 6:
            return StaticArray8(values: (
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13]
            ))
         case 7:
            return StaticArray8(values: (
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14]
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
         case 3:
            return StaticArray9(values: (
                self[3],
                self[4],
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11]
            ))
         case 4:
            return StaticArray9(values: (
                self[4],
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12]
            ))
         case 5:
            return StaticArray9(values: (
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13]
            ))
         case 6:
            return StaticArray9(values: (
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14]
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
         case 2:
            return StaticArray10(values: (
                self[2],
                self[3],
                self[4],
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11]
            ))
         case 3:
            return StaticArray10(values: (
                self[3],
                self[4],
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12]
            ))
         case 4:
            return StaticArray10(values: (
                self[4],
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13]
            ))
         case 5:
            return StaticArray10(values: (
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14]
            ))
        default:
            fatalError("offset out of available range")
        }
    }

    @inlinable public func get11(from offset: Int = 0) ->  StaticArray11<T> {
        switch offset {
         case 0:
            return StaticArray11(values: (
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
            ))
         case 1:
            return StaticArray11(values: (
                self[1],
                self[2],
                self[3],
                self[4],
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11]
            ))
         case 2:
            return StaticArray11(values: (
                self[2],
                self[3],
                self[4],
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12]
            ))
         case 3:
            return StaticArray11(values: (
                self[3],
                self[4],
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13]
            ))
         case 4:
            return StaticArray11(values: (
                self[4],
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14]
            ))
        default:
            fatalError("offset out of available range")
        }
    }

    @inlinable public func get12(from offset: Int = 0) ->  StaticArray12<T> {
        switch offset {
         case 0:
            return StaticArray12(values: (
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
                self[10],
                self[11]
            ))
         case 1:
            return StaticArray12(values: (
                self[1],
                self[2],
                self[3],
                self[4],
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12]
            ))
         case 2:
            return StaticArray12(values: (
                self[2],
                self[3],
                self[4],
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13]
            ))
         case 3:
            return StaticArray12(values: (
                self[3],
                self[4],
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14]
            ))
        default:
            fatalError("offset out of available range")
        }
    }

    @inlinable public func get13(from offset: Int = 0) ->  StaticArray13<T> {
        switch offset {
         case 0:
            return StaticArray13(values: (
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
                self[10],
                self[11],
                self[12]
            ))
         case 1:
            return StaticArray13(values: (
                self[1],
                self[2],
                self[3],
                self[4],
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13]
            ))
         case 2:
            return StaticArray13(values: (
                self[2],
                self[3],
                self[4],
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14]
            ))
        default:
            fatalError("offset out of available range")
        }
    }

    @inlinable public func get14(from offset: Int = 0) ->  StaticArray14<T> {
        switch offset {
         case 0:
            return StaticArray14(values: (
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
                self[10],
                self[11],
                self[12],
                self[13]
            ))
         case 1:
            return StaticArray14(values: (
                self[1],
                self[2],
                self[3],
                self[4],
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14]
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
         case 10:
            self[10] = array[0]
            self[11] = array[1]
         case 11:
            self[11] = array[0]
            self[12] = array[1]
         case 12:
            self[12] = array[0]
            self[13] = array[1]
         case 13:
            self[13] = array[0]
            self[14] = array[1]
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
         case 9:
            self[9] = array[0]
            self[10] = array[1]
            self[11] = array[2]
         case 10:
            self[10] = array[0]
            self[11] = array[1]
            self[12] = array[2]
         case 11:
            self[11] = array[0]
            self[12] = array[1]
            self[13] = array[2]
         case 12:
            self[12] = array[0]
            self[13] = array[1]
            self[14] = array[2]
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
         case 8:
            self[8] = array[0]
            self[9] = array[1]
            self[10] = array[2]
            self[11] = array[3]
         case 9:
            self[9] = array[0]
            self[10] = array[1]
            self[11] = array[2]
            self[12] = array[3]
         case 10:
            self[10] = array[0]
            self[11] = array[1]
            self[12] = array[2]
            self[13] = array[3]
         case 11:
            self[11] = array[0]
            self[12] = array[1]
            self[13] = array[2]
            self[14] = array[3]
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
         case 7:
            self[7] = array[0]
            self[8] = array[1]
            self[9] = array[2]
            self[10] = array[3]
            self[11] = array[4]
         case 8:
            self[8] = array[0]
            self[9] = array[1]
            self[10] = array[2]
            self[11] = array[3]
            self[12] = array[4]
         case 9:
            self[9] = array[0]
            self[10] = array[1]
            self[11] = array[2]
            self[12] = array[3]
            self[13] = array[4]
         case 10:
            self[10] = array[0]
            self[11] = array[1]
            self[12] = array[2]
            self[13] = array[3]
            self[14] = array[4]
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
         case 6:
            self[6] = array[0]
            self[7] = array[1]
            self[8] = array[2]
            self[9] = array[3]
            self[10] = array[4]
            self[11] = array[5]
         case 7:
            self[7] = array[0]
            self[8] = array[1]
            self[9] = array[2]
            self[10] = array[3]
            self[11] = array[4]
            self[12] = array[5]
         case 8:
            self[8] = array[0]
            self[9] = array[1]
            self[10] = array[2]
            self[11] = array[3]
            self[12] = array[4]
            self[13] = array[5]
         case 9:
            self[9] = array[0]
            self[10] = array[1]
            self[11] = array[2]
            self[12] = array[3]
            self[13] = array[4]
            self[14] = array[5]
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
         case 5:
            self[5] = array[0]
            self[6] = array[1]
            self[7] = array[2]
            self[8] = array[3]
            self[9] = array[4]
            self[10] = array[5]
            self[11] = array[6]
         case 6:
            self[6] = array[0]
            self[7] = array[1]
            self[8] = array[2]
            self[9] = array[3]
            self[10] = array[4]
            self[11] = array[5]
            self[12] = array[6]
         case 7:
            self[7] = array[0]
            self[8] = array[1]
            self[9] = array[2]
            self[10] = array[3]
            self[11] = array[4]
            self[12] = array[5]
            self[13] = array[6]
         case 8:
            self[8] = array[0]
            self[9] = array[1]
            self[10] = array[2]
            self[11] = array[3]
            self[12] = array[4]
            self[13] = array[5]
            self[14] = array[6]
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
         case 4:
            self[4] = array[0]
            self[5] = array[1]
            self[6] = array[2]
            self[7] = array[3]
            self[8] = array[4]
            self[9] = array[5]
            self[10] = array[6]
            self[11] = array[7]
         case 5:
            self[5] = array[0]
            self[6] = array[1]
            self[7] = array[2]
            self[8] = array[3]
            self[9] = array[4]
            self[10] = array[5]
            self[11] = array[6]
            self[12] = array[7]
         case 6:
            self[6] = array[0]
            self[7] = array[1]
            self[8] = array[2]
            self[9] = array[3]
            self[10] = array[4]
            self[11] = array[5]
            self[12] = array[6]
            self[13] = array[7]
         case 7:
            self[7] = array[0]
            self[8] = array[1]
            self[9] = array[2]
            self[10] = array[3]
            self[11] = array[4]
            self[12] = array[5]
            self[13] = array[6]
            self[14] = array[7]
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
         case 3:
            self[3] = array[0]
            self[4] = array[1]
            self[5] = array[2]
            self[6] = array[3]
            self[7] = array[4]
            self[8] = array[5]
            self[9] = array[6]
            self[10] = array[7]
            self[11] = array[8]
         case 4:
            self[4] = array[0]
            self[5] = array[1]
            self[6] = array[2]
            self[7] = array[3]
            self[8] = array[4]
            self[9] = array[5]
            self[10] = array[6]
            self[11] = array[7]
            self[12] = array[8]
         case 5:
            self[5] = array[0]
            self[6] = array[1]
            self[7] = array[2]
            self[8] = array[3]
            self[9] = array[4]
            self[10] = array[5]
            self[11] = array[6]
            self[12] = array[7]
            self[13] = array[8]
         case 6:
            self[6] = array[0]
            self[7] = array[1]
            self[8] = array[2]
            self[9] = array[3]
            self[10] = array[4]
            self[11] = array[5]
            self[12] = array[6]
            self[13] = array[7]
            self[14] = array[8]
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
            self[11] = array[9]
         case 3:
            self[3] = array[0]
            self[4] = array[1]
            self[5] = array[2]
            self[6] = array[3]
            self[7] = array[4]
            self[8] = array[5]
            self[9] = array[6]
            self[10] = array[7]
            self[11] = array[8]
            self[12] = array[9]
         case 4:
            self[4] = array[0]
            self[5] = array[1]
            self[6] = array[2]
            self[7] = array[3]
            self[8] = array[4]
            self[9] = array[5]
            self[10] = array[6]
            self[11] = array[7]
            self[12] = array[8]
            self[13] = array[9]
         case 5:
            self[5] = array[0]
            self[6] = array[1]
            self[7] = array[2]
            self[8] = array[3]
            self[9] = array[4]
            self[10] = array[5]
            self[11] = array[6]
            self[12] = array[7]
            self[13] = array[8]
            self[14] = array[9]
        default:
            fatalError("offset out of available range")
        }
    }

    @inlinable public mutating func set11(_ array: StaticArray11<T>, at offset: Int = 0) {
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
            self[10] = array[10]
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
            self[11] = array[10]
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
            self[11] = array[9]
            self[12] = array[10]
         case 3:
            self[3] = array[0]
            self[4] = array[1]
            self[5] = array[2]
            self[6] = array[3]
            self[7] = array[4]
            self[8] = array[5]
            self[9] = array[6]
            self[10] = array[7]
            self[11] = array[8]
            self[12] = array[9]
            self[13] = array[10]
         case 4:
            self[4] = array[0]
            self[5] = array[1]
            self[6] = array[2]
            self[7] = array[3]
            self[8] = array[4]
            self[9] = array[5]
            self[10] = array[6]
            self[11] = array[7]
            self[12] = array[8]
            self[13] = array[9]
            self[14] = array[10]
        default:
            fatalError("offset out of available range")
        }
    }

    @inlinable public mutating func set12(_ array: StaticArray12<T>, at offset: Int = 0) {
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
            self[10] = array[10]
            self[11] = array[11]
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
            self[11] = array[10]
            self[12] = array[11]
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
            self[11] = array[9]
            self[12] = array[10]
            self[13] = array[11]
         case 3:
            self[3] = array[0]
            self[4] = array[1]
            self[5] = array[2]
            self[6] = array[3]
            self[7] = array[4]
            self[8] = array[5]
            self[9] = array[6]
            self[10] = array[7]
            self[11] = array[8]
            self[12] = array[9]
            self[13] = array[10]
            self[14] = array[11]
        default:
            fatalError("offset out of available range")
        }
    }

    @inlinable public mutating func set13(_ array: StaticArray13<T>, at offset: Int = 0) {
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
            self[10] = array[10]
            self[11] = array[11]
            self[12] = array[12]
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
            self[11] = array[10]
            self[12] = array[11]
            self[13] = array[12]
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
            self[11] = array[9]
            self[12] = array[10]
            self[13] = array[11]
            self[14] = array[12]
        default:
            fatalError("offset out of available range")
        }
    }

    @inlinable public mutating func set14(_ array: StaticArray14<T>, at offset: Int = 0) {
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
            self[10] = array[10]
            self[11] = array[11]
            self[12] = array[12]
            self[13] = array[13]
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
            self[11] = array[10]
            self[12] = array[11]
            self[13] = array[12]
            self[14] = array[13]
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
            self[10],
            self[11],
            self[12],
            self[13],
            self[14]
        ]
    }

    @inlinable public func map<M>(_ transform: (T) throws -> M) rethrows -> StaticArray15<M> {
        try StaticArray15<M>(values: (
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
            transform(self[10]),
            transform(self[11]),
            transform(self[12]),
            transform(self[13]),
            transform(self[14])
        ))
    }
}

public func zip<L, R>(_ lhs: StaticArray15<L>, _ rhs: StaticArray15<R>) -> StaticArray15<(L, R)> {
    StaticArray15(values: (
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
        (lhs[10], rhs[10]),
        (lhs[11], rhs[11]),
        (lhs[12], rhs[12]),
        (lhs[13], rhs[13]),
        (lhs[14], rhs[14])
    ))
}

extension StaticArray15: Collection {
    public typealias Index = Int
    public var startIndex: Index { 0 }
    public var endIndex: Index { 15 }
    @inlinable public func index(after i: Index) -> Index { i + 1 }
}

extension StaticArray15: Sequence {
    public struct Iterator: IteratorProtocol {
        private var index = 0
        private let array: StaticArray15<T>

        init(_ array: StaticArray15<T>) {
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

extension StaticArray15: Equatable where T: Equatable {
    @inlinable public static func == (lhs: Self, rhs: Self) -> Bool {
        zip(lhs, rhs).allSatisfy { $0.0 == $0.1 }
    }
}

extension StaticArray15: Codable where T: Codable {
    public init(from decoder: Decoder) throws {
        try self.init(array: [T](from: decoder))
    }

    public func encode(to encoder: Encoder) throws {
        try self.toArray().encode(to: encoder)
    }
}

extension StaticArray15: AdditiveArithmetic where T: AdditiveArithmetic {
    @inlinable public static func - (lhs: Self, rhs: Self) -> Self {
        zip(lhs, rhs).map { $0.0 - $0.1 }
    }

    @inlinable public static func + (lhs: Self, rhs: Self) -> Self {
        zip(lhs, rhs).map { $0.0 + $0.1 }
    }

    @inlinable public static var zero: Self { Self(repeating: T.zero) }
}

@inlinable public func + <T>(lhs: StaticArray15<T>, rhs: T) -> StaticArray15<T> where T: AdditiveArithmetic {
    lhs.map { $0 + rhs }
}

@inlinable public func + <T>(lhs: T, rhs: StaticArray15<T>) -> StaticArray15<T> where T: AdditiveArithmetic {
    rhs.map { lhs + $0 }
}

@inlinable public func - <T>(lhs: StaticArray15<T>, rhs: T) -> StaticArray15<T> where T: AdditiveArithmetic {
    lhs.map { $0 - rhs }
}

@inlinable public func - <T>(lhs: T, rhs: StaticArray15<T>) -> StaticArray15<T> where T: AdditiveArithmetic {
    rhs.map { lhs - $0 }
}

extension StaticArray15: Divisible where T: Divisible {
    @inlinable public static func / (lhs: Self, rhs: Self) -> Self {
        zip(lhs, rhs).map { $0.0 / $0.1 }
    }
}

@inlinable public func / <T>(lhs: StaticArray15<T>, rhs: T) -> StaticArray15<T> where T: Divisible {
    lhs.map { $0 / rhs }
}

@inlinable public func / <T>(lhs: T, rhs: StaticArray15<T>) -> StaticArray15<T> where T: Divisible {
    rhs.map { lhs / $0 }
}

extension StaticArray15: Multipliable where T: Multipliable {
    @inlinable public static func * (lhs: Self, rhs: Self) -> Self {
        zip(lhs, rhs).map { $0.0 * $0.1 }
    }
}

@inlinable public func * <T>(lhs: StaticArray15<T>, rhs: T) -> StaticArray15<T> where T: Multipliable {
    lhs.map { $0 * rhs }
}

@inlinable public func * <T>(lhs: T, rhs: StaticArray15<T>) -> StaticArray15<T> where T: Multipliable {
    rhs.map { lhs * $0 }
}

extension StaticArray15: ABSComputable where T: ABSComputable {
    @inlinable public func abs() -> Self {
        self.map { $0.abs() }
    }
}

public struct StaticArray16<T> {
    public typealias Values = (T, T, T, T, T, T, T, T, T, T, T, T, T, T, T, T)

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
            value,
            value,
            value,
            value,
            value,
            value
        )
    }

    init(array: [T]) throws {
        guard array.count == 16 else { fatalError("array size mismatch") }
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
            array[10],
            array[11],
            array[12],
            array[13],
            array[14],
            array[15]
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
            case 11: return self.values.11
            case 12: return self.values.12
            case 13: return self.values.13
            case 14: return self.values.14
            case 15: return self.values.15
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
            case 11: self.values.11 = newValue
            case 12: self.values.12 = newValue
            case 13: self.values.13 = newValue
            case 14: self.values.14 = newValue
            case 15: self.values.15 = newValue
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
         case 10:
            return StaticArray2(values: (
                self[10],
                self[11]
            ))
         case 11:
            return StaticArray2(values: (
                self[11],
                self[12]
            ))
         case 12:
            return StaticArray2(values: (
                self[12],
                self[13]
            ))
         case 13:
            return StaticArray2(values: (
                self[13],
                self[14]
            ))
         case 14:
            return StaticArray2(values: (
                self[14],
                self[15]
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
         case 9:
            return StaticArray3(values: (
                self[9],
                self[10],
                self[11]
            ))
         case 10:
            return StaticArray3(values: (
                self[10],
                self[11],
                self[12]
            ))
         case 11:
            return StaticArray3(values: (
                self[11],
                self[12],
                self[13]
            ))
         case 12:
            return StaticArray3(values: (
                self[12],
                self[13],
                self[14]
            ))
         case 13:
            return StaticArray3(values: (
                self[13],
                self[14],
                self[15]
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
         case 8:
            return StaticArray4(values: (
                self[8],
                self[9],
                self[10],
                self[11]
            ))
         case 9:
            return StaticArray4(values: (
                self[9],
                self[10],
                self[11],
                self[12]
            ))
         case 10:
            return StaticArray4(values: (
                self[10],
                self[11],
                self[12],
                self[13]
            ))
         case 11:
            return StaticArray4(values: (
                self[11],
                self[12],
                self[13],
                self[14]
            ))
         case 12:
            return StaticArray4(values: (
                self[12],
                self[13],
                self[14],
                self[15]
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
         case 7:
            return StaticArray5(values: (
                self[7],
                self[8],
                self[9],
                self[10],
                self[11]
            ))
         case 8:
            return StaticArray5(values: (
                self[8],
                self[9],
                self[10],
                self[11],
                self[12]
            ))
         case 9:
            return StaticArray5(values: (
                self[9],
                self[10],
                self[11],
                self[12],
                self[13]
            ))
         case 10:
            return StaticArray5(values: (
                self[10],
                self[11],
                self[12],
                self[13],
                self[14]
            ))
         case 11:
            return StaticArray5(values: (
                self[11],
                self[12],
                self[13],
                self[14],
                self[15]
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
         case 6:
            return StaticArray6(values: (
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11]
            ))
         case 7:
            return StaticArray6(values: (
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12]
            ))
         case 8:
            return StaticArray6(values: (
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13]
            ))
         case 9:
            return StaticArray6(values: (
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14]
            ))
         case 10:
            return StaticArray6(values: (
                self[10],
                self[11],
                self[12],
                self[13],
                self[14],
                self[15]
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
         case 5:
            return StaticArray7(values: (
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11]
            ))
         case 6:
            return StaticArray7(values: (
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12]
            ))
         case 7:
            return StaticArray7(values: (
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13]
            ))
         case 8:
            return StaticArray7(values: (
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14]
            ))
         case 9:
            return StaticArray7(values: (
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14],
                self[15]
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
         case 4:
            return StaticArray8(values: (
                self[4],
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11]
            ))
         case 5:
            return StaticArray8(values: (
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12]
            ))
         case 6:
            return StaticArray8(values: (
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13]
            ))
         case 7:
            return StaticArray8(values: (
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14]
            ))
         case 8:
            return StaticArray8(values: (
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14],
                self[15]
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
         case 3:
            return StaticArray9(values: (
                self[3],
                self[4],
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11]
            ))
         case 4:
            return StaticArray9(values: (
                self[4],
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12]
            ))
         case 5:
            return StaticArray9(values: (
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13]
            ))
         case 6:
            return StaticArray9(values: (
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14]
            ))
         case 7:
            return StaticArray9(values: (
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14],
                self[15]
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
         case 2:
            return StaticArray10(values: (
                self[2],
                self[3],
                self[4],
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11]
            ))
         case 3:
            return StaticArray10(values: (
                self[3],
                self[4],
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12]
            ))
         case 4:
            return StaticArray10(values: (
                self[4],
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13]
            ))
         case 5:
            return StaticArray10(values: (
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14]
            ))
         case 6:
            return StaticArray10(values: (
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14],
                self[15]
            ))
        default:
            fatalError("offset out of available range")
        }
    }

    @inlinable public func get11(from offset: Int = 0) ->  StaticArray11<T> {
        switch offset {
         case 0:
            return StaticArray11(values: (
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
            ))
         case 1:
            return StaticArray11(values: (
                self[1],
                self[2],
                self[3],
                self[4],
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11]
            ))
         case 2:
            return StaticArray11(values: (
                self[2],
                self[3],
                self[4],
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12]
            ))
         case 3:
            return StaticArray11(values: (
                self[3],
                self[4],
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13]
            ))
         case 4:
            return StaticArray11(values: (
                self[4],
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14]
            ))
         case 5:
            return StaticArray11(values: (
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14],
                self[15]
            ))
        default:
            fatalError("offset out of available range")
        }
    }

    @inlinable public func get12(from offset: Int = 0) ->  StaticArray12<T> {
        switch offset {
         case 0:
            return StaticArray12(values: (
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
                self[10],
                self[11]
            ))
         case 1:
            return StaticArray12(values: (
                self[1],
                self[2],
                self[3],
                self[4],
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12]
            ))
         case 2:
            return StaticArray12(values: (
                self[2],
                self[3],
                self[4],
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13]
            ))
         case 3:
            return StaticArray12(values: (
                self[3],
                self[4],
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14]
            ))
         case 4:
            return StaticArray12(values: (
                self[4],
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14],
                self[15]
            ))
        default:
            fatalError("offset out of available range")
        }
    }

    @inlinable public func get13(from offset: Int = 0) ->  StaticArray13<T> {
        switch offset {
         case 0:
            return StaticArray13(values: (
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
                self[10],
                self[11],
                self[12]
            ))
         case 1:
            return StaticArray13(values: (
                self[1],
                self[2],
                self[3],
                self[4],
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13]
            ))
         case 2:
            return StaticArray13(values: (
                self[2],
                self[3],
                self[4],
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14]
            ))
         case 3:
            return StaticArray13(values: (
                self[3],
                self[4],
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14],
                self[15]
            ))
        default:
            fatalError("offset out of available range")
        }
    }

    @inlinable public func get14(from offset: Int = 0) ->  StaticArray14<T> {
        switch offset {
         case 0:
            return StaticArray14(values: (
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
                self[10],
                self[11],
                self[12],
                self[13]
            ))
         case 1:
            return StaticArray14(values: (
                self[1],
                self[2],
                self[3],
                self[4],
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14]
            ))
         case 2:
            return StaticArray14(values: (
                self[2],
                self[3],
                self[4],
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14],
                self[15]
            ))
        default:
            fatalError("offset out of available range")
        }
    }

    @inlinable public func get15(from offset: Int = 0) ->  StaticArray15<T> {
        switch offset {
         case 0:
            return StaticArray15(values: (
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
                self[10],
                self[11],
                self[12],
                self[13],
                self[14]
            ))
         case 1:
            return StaticArray15(values: (
                self[1],
                self[2],
                self[3],
                self[4],
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14],
                self[15]
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
         case 10:
            self[10] = array[0]
            self[11] = array[1]
         case 11:
            self[11] = array[0]
            self[12] = array[1]
         case 12:
            self[12] = array[0]
            self[13] = array[1]
         case 13:
            self[13] = array[0]
            self[14] = array[1]
         case 14:
            self[14] = array[0]
            self[15] = array[1]
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
         case 9:
            self[9] = array[0]
            self[10] = array[1]
            self[11] = array[2]
         case 10:
            self[10] = array[0]
            self[11] = array[1]
            self[12] = array[2]
         case 11:
            self[11] = array[0]
            self[12] = array[1]
            self[13] = array[2]
         case 12:
            self[12] = array[0]
            self[13] = array[1]
            self[14] = array[2]
         case 13:
            self[13] = array[0]
            self[14] = array[1]
            self[15] = array[2]
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
         case 8:
            self[8] = array[0]
            self[9] = array[1]
            self[10] = array[2]
            self[11] = array[3]
         case 9:
            self[9] = array[0]
            self[10] = array[1]
            self[11] = array[2]
            self[12] = array[3]
         case 10:
            self[10] = array[0]
            self[11] = array[1]
            self[12] = array[2]
            self[13] = array[3]
         case 11:
            self[11] = array[0]
            self[12] = array[1]
            self[13] = array[2]
            self[14] = array[3]
         case 12:
            self[12] = array[0]
            self[13] = array[1]
            self[14] = array[2]
            self[15] = array[3]
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
         case 7:
            self[7] = array[0]
            self[8] = array[1]
            self[9] = array[2]
            self[10] = array[3]
            self[11] = array[4]
         case 8:
            self[8] = array[0]
            self[9] = array[1]
            self[10] = array[2]
            self[11] = array[3]
            self[12] = array[4]
         case 9:
            self[9] = array[0]
            self[10] = array[1]
            self[11] = array[2]
            self[12] = array[3]
            self[13] = array[4]
         case 10:
            self[10] = array[0]
            self[11] = array[1]
            self[12] = array[2]
            self[13] = array[3]
            self[14] = array[4]
         case 11:
            self[11] = array[0]
            self[12] = array[1]
            self[13] = array[2]
            self[14] = array[3]
            self[15] = array[4]
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
         case 6:
            self[6] = array[0]
            self[7] = array[1]
            self[8] = array[2]
            self[9] = array[3]
            self[10] = array[4]
            self[11] = array[5]
         case 7:
            self[7] = array[0]
            self[8] = array[1]
            self[9] = array[2]
            self[10] = array[3]
            self[11] = array[4]
            self[12] = array[5]
         case 8:
            self[8] = array[0]
            self[9] = array[1]
            self[10] = array[2]
            self[11] = array[3]
            self[12] = array[4]
            self[13] = array[5]
         case 9:
            self[9] = array[0]
            self[10] = array[1]
            self[11] = array[2]
            self[12] = array[3]
            self[13] = array[4]
            self[14] = array[5]
         case 10:
            self[10] = array[0]
            self[11] = array[1]
            self[12] = array[2]
            self[13] = array[3]
            self[14] = array[4]
            self[15] = array[5]
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
         case 5:
            self[5] = array[0]
            self[6] = array[1]
            self[7] = array[2]
            self[8] = array[3]
            self[9] = array[4]
            self[10] = array[5]
            self[11] = array[6]
         case 6:
            self[6] = array[0]
            self[7] = array[1]
            self[8] = array[2]
            self[9] = array[3]
            self[10] = array[4]
            self[11] = array[5]
            self[12] = array[6]
         case 7:
            self[7] = array[0]
            self[8] = array[1]
            self[9] = array[2]
            self[10] = array[3]
            self[11] = array[4]
            self[12] = array[5]
            self[13] = array[6]
         case 8:
            self[8] = array[0]
            self[9] = array[1]
            self[10] = array[2]
            self[11] = array[3]
            self[12] = array[4]
            self[13] = array[5]
            self[14] = array[6]
         case 9:
            self[9] = array[0]
            self[10] = array[1]
            self[11] = array[2]
            self[12] = array[3]
            self[13] = array[4]
            self[14] = array[5]
            self[15] = array[6]
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
         case 4:
            self[4] = array[0]
            self[5] = array[1]
            self[6] = array[2]
            self[7] = array[3]
            self[8] = array[4]
            self[9] = array[5]
            self[10] = array[6]
            self[11] = array[7]
         case 5:
            self[5] = array[0]
            self[6] = array[1]
            self[7] = array[2]
            self[8] = array[3]
            self[9] = array[4]
            self[10] = array[5]
            self[11] = array[6]
            self[12] = array[7]
         case 6:
            self[6] = array[0]
            self[7] = array[1]
            self[8] = array[2]
            self[9] = array[3]
            self[10] = array[4]
            self[11] = array[5]
            self[12] = array[6]
            self[13] = array[7]
         case 7:
            self[7] = array[0]
            self[8] = array[1]
            self[9] = array[2]
            self[10] = array[3]
            self[11] = array[4]
            self[12] = array[5]
            self[13] = array[6]
            self[14] = array[7]
         case 8:
            self[8] = array[0]
            self[9] = array[1]
            self[10] = array[2]
            self[11] = array[3]
            self[12] = array[4]
            self[13] = array[5]
            self[14] = array[6]
            self[15] = array[7]
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
         case 3:
            self[3] = array[0]
            self[4] = array[1]
            self[5] = array[2]
            self[6] = array[3]
            self[7] = array[4]
            self[8] = array[5]
            self[9] = array[6]
            self[10] = array[7]
            self[11] = array[8]
         case 4:
            self[4] = array[0]
            self[5] = array[1]
            self[6] = array[2]
            self[7] = array[3]
            self[8] = array[4]
            self[9] = array[5]
            self[10] = array[6]
            self[11] = array[7]
            self[12] = array[8]
         case 5:
            self[5] = array[0]
            self[6] = array[1]
            self[7] = array[2]
            self[8] = array[3]
            self[9] = array[4]
            self[10] = array[5]
            self[11] = array[6]
            self[12] = array[7]
            self[13] = array[8]
         case 6:
            self[6] = array[0]
            self[7] = array[1]
            self[8] = array[2]
            self[9] = array[3]
            self[10] = array[4]
            self[11] = array[5]
            self[12] = array[6]
            self[13] = array[7]
            self[14] = array[8]
         case 7:
            self[7] = array[0]
            self[8] = array[1]
            self[9] = array[2]
            self[10] = array[3]
            self[11] = array[4]
            self[12] = array[5]
            self[13] = array[6]
            self[14] = array[7]
            self[15] = array[8]
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
            self[11] = array[9]
         case 3:
            self[3] = array[0]
            self[4] = array[1]
            self[5] = array[2]
            self[6] = array[3]
            self[7] = array[4]
            self[8] = array[5]
            self[9] = array[6]
            self[10] = array[7]
            self[11] = array[8]
            self[12] = array[9]
         case 4:
            self[4] = array[0]
            self[5] = array[1]
            self[6] = array[2]
            self[7] = array[3]
            self[8] = array[4]
            self[9] = array[5]
            self[10] = array[6]
            self[11] = array[7]
            self[12] = array[8]
            self[13] = array[9]
         case 5:
            self[5] = array[0]
            self[6] = array[1]
            self[7] = array[2]
            self[8] = array[3]
            self[9] = array[4]
            self[10] = array[5]
            self[11] = array[6]
            self[12] = array[7]
            self[13] = array[8]
            self[14] = array[9]
         case 6:
            self[6] = array[0]
            self[7] = array[1]
            self[8] = array[2]
            self[9] = array[3]
            self[10] = array[4]
            self[11] = array[5]
            self[12] = array[6]
            self[13] = array[7]
            self[14] = array[8]
            self[15] = array[9]
        default:
            fatalError("offset out of available range")
        }
    }

    @inlinable public mutating func set11(_ array: StaticArray11<T>, at offset: Int = 0) {
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
            self[10] = array[10]
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
            self[11] = array[10]
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
            self[11] = array[9]
            self[12] = array[10]
         case 3:
            self[3] = array[0]
            self[4] = array[1]
            self[5] = array[2]
            self[6] = array[3]
            self[7] = array[4]
            self[8] = array[5]
            self[9] = array[6]
            self[10] = array[7]
            self[11] = array[8]
            self[12] = array[9]
            self[13] = array[10]
         case 4:
            self[4] = array[0]
            self[5] = array[1]
            self[6] = array[2]
            self[7] = array[3]
            self[8] = array[4]
            self[9] = array[5]
            self[10] = array[6]
            self[11] = array[7]
            self[12] = array[8]
            self[13] = array[9]
            self[14] = array[10]
         case 5:
            self[5] = array[0]
            self[6] = array[1]
            self[7] = array[2]
            self[8] = array[3]
            self[9] = array[4]
            self[10] = array[5]
            self[11] = array[6]
            self[12] = array[7]
            self[13] = array[8]
            self[14] = array[9]
            self[15] = array[10]
        default:
            fatalError("offset out of available range")
        }
    }

    @inlinable public mutating func set12(_ array: StaticArray12<T>, at offset: Int = 0) {
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
            self[10] = array[10]
            self[11] = array[11]
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
            self[11] = array[10]
            self[12] = array[11]
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
            self[11] = array[9]
            self[12] = array[10]
            self[13] = array[11]
         case 3:
            self[3] = array[0]
            self[4] = array[1]
            self[5] = array[2]
            self[6] = array[3]
            self[7] = array[4]
            self[8] = array[5]
            self[9] = array[6]
            self[10] = array[7]
            self[11] = array[8]
            self[12] = array[9]
            self[13] = array[10]
            self[14] = array[11]
         case 4:
            self[4] = array[0]
            self[5] = array[1]
            self[6] = array[2]
            self[7] = array[3]
            self[8] = array[4]
            self[9] = array[5]
            self[10] = array[6]
            self[11] = array[7]
            self[12] = array[8]
            self[13] = array[9]
            self[14] = array[10]
            self[15] = array[11]
        default:
            fatalError("offset out of available range")
        }
    }

    @inlinable public mutating func set13(_ array: StaticArray13<T>, at offset: Int = 0) {
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
            self[10] = array[10]
            self[11] = array[11]
            self[12] = array[12]
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
            self[11] = array[10]
            self[12] = array[11]
            self[13] = array[12]
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
            self[11] = array[9]
            self[12] = array[10]
            self[13] = array[11]
            self[14] = array[12]
         case 3:
            self[3] = array[0]
            self[4] = array[1]
            self[5] = array[2]
            self[6] = array[3]
            self[7] = array[4]
            self[8] = array[5]
            self[9] = array[6]
            self[10] = array[7]
            self[11] = array[8]
            self[12] = array[9]
            self[13] = array[10]
            self[14] = array[11]
            self[15] = array[12]
        default:
            fatalError("offset out of available range")
        }
    }

    @inlinable public mutating func set14(_ array: StaticArray14<T>, at offset: Int = 0) {
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
            self[10] = array[10]
            self[11] = array[11]
            self[12] = array[12]
            self[13] = array[13]
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
            self[11] = array[10]
            self[12] = array[11]
            self[13] = array[12]
            self[14] = array[13]
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
            self[11] = array[9]
            self[12] = array[10]
            self[13] = array[11]
            self[14] = array[12]
            self[15] = array[13]
        default:
            fatalError("offset out of available range")
        }
    }

    @inlinable public mutating func set15(_ array: StaticArray15<T>, at offset: Int = 0) {
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
            self[10] = array[10]
            self[11] = array[11]
            self[12] = array[12]
            self[13] = array[13]
            self[14] = array[14]
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
            self[11] = array[10]
            self[12] = array[11]
            self[13] = array[12]
            self[14] = array[13]
            self[15] = array[14]
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
            self[10],
            self[11],
            self[12],
            self[13],
            self[14],
            self[15]
        ]
    }

    @inlinable public func map<M>(_ transform: (T) throws -> M) rethrows -> StaticArray16<M> {
        try StaticArray16<M>(values: (
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
            transform(self[10]),
            transform(self[11]),
            transform(self[12]),
            transform(self[13]),
            transform(self[14]),
            transform(self[15])
        ))
    }
}

public func zip<L, R>(_ lhs: StaticArray16<L>, _ rhs: StaticArray16<R>) -> StaticArray16<(L, R)> {
    StaticArray16(values: (
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
        (lhs[10], rhs[10]),
        (lhs[11], rhs[11]),
        (lhs[12], rhs[12]),
        (lhs[13], rhs[13]),
        (lhs[14], rhs[14]),
        (lhs[15], rhs[15])
    ))
}

extension StaticArray16: Collection {
    public typealias Index = Int
    public var startIndex: Index { 0 }
    public var endIndex: Index { 16 }
    @inlinable public func index(after i: Index) -> Index { i + 1 }
}

extension StaticArray16: Sequence {
    public struct Iterator: IteratorProtocol {
        private var index = 0
        private let array: StaticArray16<T>

        init(_ array: StaticArray16<T>) {
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

extension StaticArray16: Equatable where T: Equatable {
    @inlinable public static func == (lhs: Self, rhs: Self) -> Bool {
        zip(lhs, rhs).allSatisfy { $0.0 == $0.1 }
    }
}

extension StaticArray16: Codable where T: Codable {
    public init(from decoder: Decoder) throws {
        try self.init(array: [T](from: decoder))
    }

    public func encode(to encoder: Encoder) throws {
        try self.toArray().encode(to: encoder)
    }
}

extension StaticArray16: AdditiveArithmetic where T: AdditiveArithmetic {
    @inlinable public static func - (lhs: Self, rhs: Self) -> Self {
        zip(lhs, rhs).map { $0.0 - $0.1 }
    }

    @inlinable public static func + (lhs: Self, rhs: Self) -> Self {
        zip(lhs, rhs).map { $0.0 + $0.1 }
    }

    @inlinable public static var zero: Self { Self(repeating: T.zero) }
}

@inlinable public func + <T>(lhs: StaticArray16<T>, rhs: T) -> StaticArray16<T> where T: AdditiveArithmetic {
    lhs.map { $0 + rhs }
}

@inlinable public func + <T>(lhs: T, rhs: StaticArray16<T>) -> StaticArray16<T> where T: AdditiveArithmetic {
    rhs.map { lhs + $0 }
}

@inlinable public func - <T>(lhs: StaticArray16<T>, rhs: T) -> StaticArray16<T> where T: AdditiveArithmetic {
    lhs.map { $0 - rhs }
}

@inlinable public func - <T>(lhs: T, rhs: StaticArray16<T>) -> StaticArray16<T> where T: AdditiveArithmetic {
    rhs.map { lhs - $0 }
}

extension StaticArray16: Divisible where T: Divisible {
    @inlinable public static func / (lhs: Self, rhs: Self) -> Self {
        zip(lhs, rhs).map { $0.0 / $0.1 }
    }
}

@inlinable public func / <T>(lhs: StaticArray16<T>, rhs: T) -> StaticArray16<T> where T: Divisible {
    lhs.map { $0 / rhs }
}

@inlinable public func / <T>(lhs: T, rhs: StaticArray16<T>) -> StaticArray16<T> where T: Divisible {
    rhs.map { lhs / $0 }
}

extension StaticArray16: Multipliable where T: Multipliable {
    @inlinable public static func * (lhs: Self, rhs: Self) -> Self {
        zip(lhs, rhs).map { $0.0 * $0.1 }
    }
}

@inlinable public func * <T>(lhs: StaticArray16<T>, rhs: T) -> StaticArray16<T> where T: Multipliable {
    lhs.map { $0 * rhs }
}

@inlinable public func * <T>(lhs: T, rhs: StaticArray16<T>) -> StaticArray16<T> where T: Multipliable {
    rhs.map { lhs * $0 }
}

extension StaticArray16: ABSComputable where T: ABSComputable {
    @inlinable public func abs() -> Self {
        self.map { $0.abs() }
    }
}

public struct StaticArray17<T> {
    public typealias Values = (T, T, T, T, T, T, T, T, T, T, T, T, T, T, T, T, T)

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
            value,
            value,
            value,
            value,
            value,
            value,
            value
        )
    }

    init(array: [T]) throws {
        guard array.count == 17 else { fatalError("array size mismatch") }
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
            array[10],
            array[11],
            array[12],
            array[13],
            array[14],
            array[15],
            array[16]
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
            case 11: return self.values.11
            case 12: return self.values.12
            case 13: return self.values.13
            case 14: return self.values.14
            case 15: return self.values.15
            case 16: return self.values.16
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
            case 11: self.values.11 = newValue
            case 12: self.values.12 = newValue
            case 13: self.values.13 = newValue
            case 14: self.values.14 = newValue
            case 15: self.values.15 = newValue
            case 16: self.values.16 = newValue
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
         case 10:
            return StaticArray2(values: (
                self[10],
                self[11]
            ))
         case 11:
            return StaticArray2(values: (
                self[11],
                self[12]
            ))
         case 12:
            return StaticArray2(values: (
                self[12],
                self[13]
            ))
         case 13:
            return StaticArray2(values: (
                self[13],
                self[14]
            ))
         case 14:
            return StaticArray2(values: (
                self[14],
                self[15]
            ))
         case 15:
            return StaticArray2(values: (
                self[15],
                self[16]
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
         case 9:
            return StaticArray3(values: (
                self[9],
                self[10],
                self[11]
            ))
         case 10:
            return StaticArray3(values: (
                self[10],
                self[11],
                self[12]
            ))
         case 11:
            return StaticArray3(values: (
                self[11],
                self[12],
                self[13]
            ))
         case 12:
            return StaticArray3(values: (
                self[12],
                self[13],
                self[14]
            ))
         case 13:
            return StaticArray3(values: (
                self[13],
                self[14],
                self[15]
            ))
         case 14:
            return StaticArray3(values: (
                self[14],
                self[15],
                self[16]
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
         case 8:
            return StaticArray4(values: (
                self[8],
                self[9],
                self[10],
                self[11]
            ))
         case 9:
            return StaticArray4(values: (
                self[9],
                self[10],
                self[11],
                self[12]
            ))
         case 10:
            return StaticArray4(values: (
                self[10],
                self[11],
                self[12],
                self[13]
            ))
         case 11:
            return StaticArray4(values: (
                self[11],
                self[12],
                self[13],
                self[14]
            ))
         case 12:
            return StaticArray4(values: (
                self[12],
                self[13],
                self[14],
                self[15]
            ))
         case 13:
            return StaticArray4(values: (
                self[13],
                self[14],
                self[15],
                self[16]
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
         case 7:
            return StaticArray5(values: (
                self[7],
                self[8],
                self[9],
                self[10],
                self[11]
            ))
         case 8:
            return StaticArray5(values: (
                self[8],
                self[9],
                self[10],
                self[11],
                self[12]
            ))
         case 9:
            return StaticArray5(values: (
                self[9],
                self[10],
                self[11],
                self[12],
                self[13]
            ))
         case 10:
            return StaticArray5(values: (
                self[10],
                self[11],
                self[12],
                self[13],
                self[14]
            ))
         case 11:
            return StaticArray5(values: (
                self[11],
                self[12],
                self[13],
                self[14],
                self[15]
            ))
         case 12:
            return StaticArray5(values: (
                self[12],
                self[13],
                self[14],
                self[15],
                self[16]
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
         case 6:
            return StaticArray6(values: (
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11]
            ))
         case 7:
            return StaticArray6(values: (
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12]
            ))
         case 8:
            return StaticArray6(values: (
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13]
            ))
         case 9:
            return StaticArray6(values: (
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14]
            ))
         case 10:
            return StaticArray6(values: (
                self[10],
                self[11],
                self[12],
                self[13],
                self[14],
                self[15]
            ))
         case 11:
            return StaticArray6(values: (
                self[11],
                self[12],
                self[13],
                self[14],
                self[15],
                self[16]
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
         case 5:
            return StaticArray7(values: (
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11]
            ))
         case 6:
            return StaticArray7(values: (
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12]
            ))
         case 7:
            return StaticArray7(values: (
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13]
            ))
         case 8:
            return StaticArray7(values: (
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14]
            ))
         case 9:
            return StaticArray7(values: (
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14],
                self[15]
            ))
         case 10:
            return StaticArray7(values: (
                self[10],
                self[11],
                self[12],
                self[13],
                self[14],
                self[15],
                self[16]
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
         case 4:
            return StaticArray8(values: (
                self[4],
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11]
            ))
         case 5:
            return StaticArray8(values: (
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12]
            ))
         case 6:
            return StaticArray8(values: (
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13]
            ))
         case 7:
            return StaticArray8(values: (
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14]
            ))
         case 8:
            return StaticArray8(values: (
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14],
                self[15]
            ))
         case 9:
            return StaticArray8(values: (
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14],
                self[15],
                self[16]
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
         case 3:
            return StaticArray9(values: (
                self[3],
                self[4],
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11]
            ))
         case 4:
            return StaticArray9(values: (
                self[4],
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12]
            ))
         case 5:
            return StaticArray9(values: (
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13]
            ))
         case 6:
            return StaticArray9(values: (
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14]
            ))
         case 7:
            return StaticArray9(values: (
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14],
                self[15]
            ))
         case 8:
            return StaticArray9(values: (
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14],
                self[15],
                self[16]
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
         case 2:
            return StaticArray10(values: (
                self[2],
                self[3],
                self[4],
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11]
            ))
         case 3:
            return StaticArray10(values: (
                self[3],
                self[4],
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12]
            ))
         case 4:
            return StaticArray10(values: (
                self[4],
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13]
            ))
         case 5:
            return StaticArray10(values: (
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14]
            ))
         case 6:
            return StaticArray10(values: (
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14],
                self[15]
            ))
         case 7:
            return StaticArray10(values: (
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14],
                self[15],
                self[16]
            ))
        default:
            fatalError("offset out of available range")
        }
    }

    @inlinable public func get11(from offset: Int = 0) ->  StaticArray11<T> {
        switch offset {
         case 0:
            return StaticArray11(values: (
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
            ))
         case 1:
            return StaticArray11(values: (
                self[1],
                self[2],
                self[3],
                self[4],
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11]
            ))
         case 2:
            return StaticArray11(values: (
                self[2],
                self[3],
                self[4],
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12]
            ))
         case 3:
            return StaticArray11(values: (
                self[3],
                self[4],
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13]
            ))
         case 4:
            return StaticArray11(values: (
                self[4],
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14]
            ))
         case 5:
            return StaticArray11(values: (
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14],
                self[15]
            ))
         case 6:
            return StaticArray11(values: (
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14],
                self[15],
                self[16]
            ))
        default:
            fatalError("offset out of available range")
        }
    }

    @inlinable public func get12(from offset: Int = 0) ->  StaticArray12<T> {
        switch offset {
         case 0:
            return StaticArray12(values: (
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
                self[10],
                self[11]
            ))
         case 1:
            return StaticArray12(values: (
                self[1],
                self[2],
                self[3],
                self[4],
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12]
            ))
         case 2:
            return StaticArray12(values: (
                self[2],
                self[3],
                self[4],
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13]
            ))
         case 3:
            return StaticArray12(values: (
                self[3],
                self[4],
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14]
            ))
         case 4:
            return StaticArray12(values: (
                self[4],
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14],
                self[15]
            ))
         case 5:
            return StaticArray12(values: (
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14],
                self[15],
                self[16]
            ))
        default:
            fatalError("offset out of available range")
        }
    }

    @inlinable public func get13(from offset: Int = 0) ->  StaticArray13<T> {
        switch offset {
         case 0:
            return StaticArray13(values: (
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
                self[10],
                self[11],
                self[12]
            ))
         case 1:
            return StaticArray13(values: (
                self[1],
                self[2],
                self[3],
                self[4],
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13]
            ))
         case 2:
            return StaticArray13(values: (
                self[2],
                self[3],
                self[4],
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14]
            ))
         case 3:
            return StaticArray13(values: (
                self[3],
                self[4],
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14],
                self[15]
            ))
         case 4:
            return StaticArray13(values: (
                self[4],
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14],
                self[15],
                self[16]
            ))
        default:
            fatalError("offset out of available range")
        }
    }

    @inlinable public func get14(from offset: Int = 0) ->  StaticArray14<T> {
        switch offset {
         case 0:
            return StaticArray14(values: (
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
                self[10],
                self[11],
                self[12],
                self[13]
            ))
         case 1:
            return StaticArray14(values: (
                self[1],
                self[2],
                self[3],
                self[4],
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14]
            ))
         case 2:
            return StaticArray14(values: (
                self[2],
                self[3],
                self[4],
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14],
                self[15]
            ))
         case 3:
            return StaticArray14(values: (
                self[3],
                self[4],
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14],
                self[15],
                self[16]
            ))
        default:
            fatalError("offset out of available range")
        }
    }

    @inlinable public func get15(from offset: Int = 0) ->  StaticArray15<T> {
        switch offset {
         case 0:
            return StaticArray15(values: (
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
                self[10],
                self[11],
                self[12],
                self[13],
                self[14]
            ))
         case 1:
            return StaticArray15(values: (
                self[1],
                self[2],
                self[3],
                self[4],
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14],
                self[15]
            ))
         case 2:
            return StaticArray15(values: (
                self[2],
                self[3],
                self[4],
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14],
                self[15],
                self[16]
            ))
        default:
            fatalError("offset out of available range")
        }
    }

    @inlinable public func get16(from offset: Int = 0) ->  StaticArray16<T> {
        switch offset {
         case 0:
            return StaticArray16(values: (
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
                self[10],
                self[11],
                self[12],
                self[13],
                self[14],
                self[15]
            ))
         case 1:
            return StaticArray16(values: (
                self[1],
                self[2],
                self[3],
                self[4],
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14],
                self[15],
                self[16]
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
         case 10:
            self[10] = array[0]
            self[11] = array[1]
         case 11:
            self[11] = array[0]
            self[12] = array[1]
         case 12:
            self[12] = array[0]
            self[13] = array[1]
         case 13:
            self[13] = array[0]
            self[14] = array[1]
         case 14:
            self[14] = array[0]
            self[15] = array[1]
         case 15:
            self[15] = array[0]
            self[16] = array[1]
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
         case 9:
            self[9] = array[0]
            self[10] = array[1]
            self[11] = array[2]
         case 10:
            self[10] = array[0]
            self[11] = array[1]
            self[12] = array[2]
         case 11:
            self[11] = array[0]
            self[12] = array[1]
            self[13] = array[2]
         case 12:
            self[12] = array[0]
            self[13] = array[1]
            self[14] = array[2]
         case 13:
            self[13] = array[0]
            self[14] = array[1]
            self[15] = array[2]
         case 14:
            self[14] = array[0]
            self[15] = array[1]
            self[16] = array[2]
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
         case 8:
            self[8] = array[0]
            self[9] = array[1]
            self[10] = array[2]
            self[11] = array[3]
         case 9:
            self[9] = array[0]
            self[10] = array[1]
            self[11] = array[2]
            self[12] = array[3]
         case 10:
            self[10] = array[0]
            self[11] = array[1]
            self[12] = array[2]
            self[13] = array[3]
         case 11:
            self[11] = array[0]
            self[12] = array[1]
            self[13] = array[2]
            self[14] = array[3]
         case 12:
            self[12] = array[0]
            self[13] = array[1]
            self[14] = array[2]
            self[15] = array[3]
         case 13:
            self[13] = array[0]
            self[14] = array[1]
            self[15] = array[2]
            self[16] = array[3]
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
         case 7:
            self[7] = array[0]
            self[8] = array[1]
            self[9] = array[2]
            self[10] = array[3]
            self[11] = array[4]
         case 8:
            self[8] = array[0]
            self[9] = array[1]
            self[10] = array[2]
            self[11] = array[3]
            self[12] = array[4]
         case 9:
            self[9] = array[0]
            self[10] = array[1]
            self[11] = array[2]
            self[12] = array[3]
            self[13] = array[4]
         case 10:
            self[10] = array[0]
            self[11] = array[1]
            self[12] = array[2]
            self[13] = array[3]
            self[14] = array[4]
         case 11:
            self[11] = array[0]
            self[12] = array[1]
            self[13] = array[2]
            self[14] = array[3]
            self[15] = array[4]
         case 12:
            self[12] = array[0]
            self[13] = array[1]
            self[14] = array[2]
            self[15] = array[3]
            self[16] = array[4]
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
         case 6:
            self[6] = array[0]
            self[7] = array[1]
            self[8] = array[2]
            self[9] = array[3]
            self[10] = array[4]
            self[11] = array[5]
         case 7:
            self[7] = array[0]
            self[8] = array[1]
            self[9] = array[2]
            self[10] = array[3]
            self[11] = array[4]
            self[12] = array[5]
         case 8:
            self[8] = array[0]
            self[9] = array[1]
            self[10] = array[2]
            self[11] = array[3]
            self[12] = array[4]
            self[13] = array[5]
         case 9:
            self[9] = array[0]
            self[10] = array[1]
            self[11] = array[2]
            self[12] = array[3]
            self[13] = array[4]
            self[14] = array[5]
         case 10:
            self[10] = array[0]
            self[11] = array[1]
            self[12] = array[2]
            self[13] = array[3]
            self[14] = array[4]
            self[15] = array[5]
         case 11:
            self[11] = array[0]
            self[12] = array[1]
            self[13] = array[2]
            self[14] = array[3]
            self[15] = array[4]
            self[16] = array[5]
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
         case 5:
            self[5] = array[0]
            self[6] = array[1]
            self[7] = array[2]
            self[8] = array[3]
            self[9] = array[4]
            self[10] = array[5]
            self[11] = array[6]
         case 6:
            self[6] = array[0]
            self[7] = array[1]
            self[8] = array[2]
            self[9] = array[3]
            self[10] = array[4]
            self[11] = array[5]
            self[12] = array[6]
         case 7:
            self[7] = array[0]
            self[8] = array[1]
            self[9] = array[2]
            self[10] = array[3]
            self[11] = array[4]
            self[12] = array[5]
            self[13] = array[6]
         case 8:
            self[8] = array[0]
            self[9] = array[1]
            self[10] = array[2]
            self[11] = array[3]
            self[12] = array[4]
            self[13] = array[5]
            self[14] = array[6]
         case 9:
            self[9] = array[0]
            self[10] = array[1]
            self[11] = array[2]
            self[12] = array[3]
            self[13] = array[4]
            self[14] = array[5]
            self[15] = array[6]
         case 10:
            self[10] = array[0]
            self[11] = array[1]
            self[12] = array[2]
            self[13] = array[3]
            self[14] = array[4]
            self[15] = array[5]
            self[16] = array[6]
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
         case 4:
            self[4] = array[0]
            self[5] = array[1]
            self[6] = array[2]
            self[7] = array[3]
            self[8] = array[4]
            self[9] = array[5]
            self[10] = array[6]
            self[11] = array[7]
         case 5:
            self[5] = array[0]
            self[6] = array[1]
            self[7] = array[2]
            self[8] = array[3]
            self[9] = array[4]
            self[10] = array[5]
            self[11] = array[6]
            self[12] = array[7]
         case 6:
            self[6] = array[0]
            self[7] = array[1]
            self[8] = array[2]
            self[9] = array[3]
            self[10] = array[4]
            self[11] = array[5]
            self[12] = array[6]
            self[13] = array[7]
         case 7:
            self[7] = array[0]
            self[8] = array[1]
            self[9] = array[2]
            self[10] = array[3]
            self[11] = array[4]
            self[12] = array[5]
            self[13] = array[6]
            self[14] = array[7]
         case 8:
            self[8] = array[0]
            self[9] = array[1]
            self[10] = array[2]
            self[11] = array[3]
            self[12] = array[4]
            self[13] = array[5]
            self[14] = array[6]
            self[15] = array[7]
         case 9:
            self[9] = array[0]
            self[10] = array[1]
            self[11] = array[2]
            self[12] = array[3]
            self[13] = array[4]
            self[14] = array[5]
            self[15] = array[6]
            self[16] = array[7]
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
         case 3:
            self[3] = array[0]
            self[4] = array[1]
            self[5] = array[2]
            self[6] = array[3]
            self[7] = array[4]
            self[8] = array[5]
            self[9] = array[6]
            self[10] = array[7]
            self[11] = array[8]
         case 4:
            self[4] = array[0]
            self[5] = array[1]
            self[6] = array[2]
            self[7] = array[3]
            self[8] = array[4]
            self[9] = array[5]
            self[10] = array[6]
            self[11] = array[7]
            self[12] = array[8]
         case 5:
            self[5] = array[0]
            self[6] = array[1]
            self[7] = array[2]
            self[8] = array[3]
            self[9] = array[4]
            self[10] = array[5]
            self[11] = array[6]
            self[12] = array[7]
            self[13] = array[8]
         case 6:
            self[6] = array[0]
            self[7] = array[1]
            self[8] = array[2]
            self[9] = array[3]
            self[10] = array[4]
            self[11] = array[5]
            self[12] = array[6]
            self[13] = array[7]
            self[14] = array[8]
         case 7:
            self[7] = array[0]
            self[8] = array[1]
            self[9] = array[2]
            self[10] = array[3]
            self[11] = array[4]
            self[12] = array[5]
            self[13] = array[6]
            self[14] = array[7]
            self[15] = array[8]
         case 8:
            self[8] = array[0]
            self[9] = array[1]
            self[10] = array[2]
            self[11] = array[3]
            self[12] = array[4]
            self[13] = array[5]
            self[14] = array[6]
            self[15] = array[7]
            self[16] = array[8]
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
            self[11] = array[9]
         case 3:
            self[3] = array[0]
            self[4] = array[1]
            self[5] = array[2]
            self[6] = array[3]
            self[7] = array[4]
            self[8] = array[5]
            self[9] = array[6]
            self[10] = array[7]
            self[11] = array[8]
            self[12] = array[9]
         case 4:
            self[4] = array[0]
            self[5] = array[1]
            self[6] = array[2]
            self[7] = array[3]
            self[8] = array[4]
            self[9] = array[5]
            self[10] = array[6]
            self[11] = array[7]
            self[12] = array[8]
            self[13] = array[9]
         case 5:
            self[5] = array[0]
            self[6] = array[1]
            self[7] = array[2]
            self[8] = array[3]
            self[9] = array[4]
            self[10] = array[5]
            self[11] = array[6]
            self[12] = array[7]
            self[13] = array[8]
            self[14] = array[9]
         case 6:
            self[6] = array[0]
            self[7] = array[1]
            self[8] = array[2]
            self[9] = array[3]
            self[10] = array[4]
            self[11] = array[5]
            self[12] = array[6]
            self[13] = array[7]
            self[14] = array[8]
            self[15] = array[9]
         case 7:
            self[7] = array[0]
            self[8] = array[1]
            self[9] = array[2]
            self[10] = array[3]
            self[11] = array[4]
            self[12] = array[5]
            self[13] = array[6]
            self[14] = array[7]
            self[15] = array[8]
            self[16] = array[9]
        default:
            fatalError("offset out of available range")
        }
    }

    @inlinable public mutating func set11(_ array: StaticArray11<T>, at offset: Int = 0) {
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
            self[10] = array[10]
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
            self[11] = array[10]
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
            self[11] = array[9]
            self[12] = array[10]
         case 3:
            self[3] = array[0]
            self[4] = array[1]
            self[5] = array[2]
            self[6] = array[3]
            self[7] = array[4]
            self[8] = array[5]
            self[9] = array[6]
            self[10] = array[7]
            self[11] = array[8]
            self[12] = array[9]
            self[13] = array[10]
         case 4:
            self[4] = array[0]
            self[5] = array[1]
            self[6] = array[2]
            self[7] = array[3]
            self[8] = array[4]
            self[9] = array[5]
            self[10] = array[6]
            self[11] = array[7]
            self[12] = array[8]
            self[13] = array[9]
            self[14] = array[10]
         case 5:
            self[5] = array[0]
            self[6] = array[1]
            self[7] = array[2]
            self[8] = array[3]
            self[9] = array[4]
            self[10] = array[5]
            self[11] = array[6]
            self[12] = array[7]
            self[13] = array[8]
            self[14] = array[9]
            self[15] = array[10]
         case 6:
            self[6] = array[0]
            self[7] = array[1]
            self[8] = array[2]
            self[9] = array[3]
            self[10] = array[4]
            self[11] = array[5]
            self[12] = array[6]
            self[13] = array[7]
            self[14] = array[8]
            self[15] = array[9]
            self[16] = array[10]
        default:
            fatalError("offset out of available range")
        }
    }

    @inlinable public mutating func set12(_ array: StaticArray12<T>, at offset: Int = 0) {
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
            self[10] = array[10]
            self[11] = array[11]
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
            self[11] = array[10]
            self[12] = array[11]
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
            self[11] = array[9]
            self[12] = array[10]
            self[13] = array[11]
         case 3:
            self[3] = array[0]
            self[4] = array[1]
            self[5] = array[2]
            self[6] = array[3]
            self[7] = array[4]
            self[8] = array[5]
            self[9] = array[6]
            self[10] = array[7]
            self[11] = array[8]
            self[12] = array[9]
            self[13] = array[10]
            self[14] = array[11]
         case 4:
            self[4] = array[0]
            self[5] = array[1]
            self[6] = array[2]
            self[7] = array[3]
            self[8] = array[4]
            self[9] = array[5]
            self[10] = array[6]
            self[11] = array[7]
            self[12] = array[8]
            self[13] = array[9]
            self[14] = array[10]
            self[15] = array[11]
         case 5:
            self[5] = array[0]
            self[6] = array[1]
            self[7] = array[2]
            self[8] = array[3]
            self[9] = array[4]
            self[10] = array[5]
            self[11] = array[6]
            self[12] = array[7]
            self[13] = array[8]
            self[14] = array[9]
            self[15] = array[10]
            self[16] = array[11]
        default:
            fatalError("offset out of available range")
        }
    }

    @inlinable public mutating func set13(_ array: StaticArray13<T>, at offset: Int = 0) {
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
            self[10] = array[10]
            self[11] = array[11]
            self[12] = array[12]
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
            self[11] = array[10]
            self[12] = array[11]
            self[13] = array[12]
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
            self[11] = array[9]
            self[12] = array[10]
            self[13] = array[11]
            self[14] = array[12]
         case 3:
            self[3] = array[0]
            self[4] = array[1]
            self[5] = array[2]
            self[6] = array[3]
            self[7] = array[4]
            self[8] = array[5]
            self[9] = array[6]
            self[10] = array[7]
            self[11] = array[8]
            self[12] = array[9]
            self[13] = array[10]
            self[14] = array[11]
            self[15] = array[12]
         case 4:
            self[4] = array[0]
            self[5] = array[1]
            self[6] = array[2]
            self[7] = array[3]
            self[8] = array[4]
            self[9] = array[5]
            self[10] = array[6]
            self[11] = array[7]
            self[12] = array[8]
            self[13] = array[9]
            self[14] = array[10]
            self[15] = array[11]
            self[16] = array[12]
        default:
            fatalError("offset out of available range")
        }
    }

    @inlinable public mutating func set14(_ array: StaticArray14<T>, at offset: Int = 0) {
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
            self[10] = array[10]
            self[11] = array[11]
            self[12] = array[12]
            self[13] = array[13]
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
            self[11] = array[10]
            self[12] = array[11]
            self[13] = array[12]
            self[14] = array[13]
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
            self[11] = array[9]
            self[12] = array[10]
            self[13] = array[11]
            self[14] = array[12]
            self[15] = array[13]
         case 3:
            self[3] = array[0]
            self[4] = array[1]
            self[5] = array[2]
            self[6] = array[3]
            self[7] = array[4]
            self[8] = array[5]
            self[9] = array[6]
            self[10] = array[7]
            self[11] = array[8]
            self[12] = array[9]
            self[13] = array[10]
            self[14] = array[11]
            self[15] = array[12]
            self[16] = array[13]
        default:
            fatalError("offset out of available range")
        }
    }

    @inlinable public mutating func set15(_ array: StaticArray15<T>, at offset: Int = 0) {
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
            self[10] = array[10]
            self[11] = array[11]
            self[12] = array[12]
            self[13] = array[13]
            self[14] = array[14]
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
            self[11] = array[10]
            self[12] = array[11]
            self[13] = array[12]
            self[14] = array[13]
            self[15] = array[14]
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
            self[11] = array[9]
            self[12] = array[10]
            self[13] = array[11]
            self[14] = array[12]
            self[15] = array[13]
            self[16] = array[14]
        default:
            fatalError("offset out of available range")
        }
    }

    @inlinable public mutating func set16(_ array: StaticArray16<T>, at offset: Int = 0) {
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
            self[10] = array[10]
            self[11] = array[11]
            self[12] = array[12]
            self[13] = array[13]
            self[14] = array[14]
            self[15] = array[15]
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
            self[11] = array[10]
            self[12] = array[11]
            self[13] = array[12]
            self[14] = array[13]
            self[15] = array[14]
            self[16] = array[15]
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
            self[10],
            self[11],
            self[12],
            self[13],
            self[14],
            self[15],
            self[16]
        ]
    }

    @inlinable public func map<M>(_ transform: (T) throws -> M) rethrows -> StaticArray17<M> {
        try StaticArray17<M>(values: (
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
            transform(self[10]),
            transform(self[11]),
            transform(self[12]),
            transform(self[13]),
            transform(self[14]),
            transform(self[15]),
            transform(self[16])
        ))
    }
}

public func zip<L, R>(_ lhs: StaticArray17<L>, _ rhs: StaticArray17<R>) -> StaticArray17<(L, R)> {
    StaticArray17(values: (
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
        (lhs[10], rhs[10]),
        (lhs[11], rhs[11]),
        (lhs[12], rhs[12]),
        (lhs[13], rhs[13]),
        (lhs[14], rhs[14]),
        (lhs[15], rhs[15]),
        (lhs[16], rhs[16])
    ))
}

extension StaticArray17: Collection {
    public typealias Index = Int
    public var startIndex: Index { 0 }
    public var endIndex: Index { 17 }
    @inlinable public func index(after i: Index) -> Index { i + 1 }
}

extension StaticArray17: Sequence {
    public struct Iterator: IteratorProtocol {
        private var index = 0
        private let array: StaticArray17<T>

        init(_ array: StaticArray17<T>) {
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

extension StaticArray17: Equatable where T: Equatable {
    @inlinable public static func == (lhs: Self, rhs: Self) -> Bool {
        zip(lhs, rhs).allSatisfy { $0.0 == $0.1 }
    }
}

extension StaticArray17: Codable where T: Codable {
    public init(from decoder: Decoder) throws {
        try self.init(array: [T](from: decoder))
    }

    public func encode(to encoder: Encoder) throws {
        try self.toArray().encode(to: encoder)
    }
}

extension StaticArray17: AdditiveArithmetic where T: AdditiveArithmetic {
    @inlinable public static func - (lhs: Self, rhs: Self) -> Self {
        zip(lhs, rhs).map { $0.0 - $0.1 }
    }

    @inlinable public static func + (lhs: Self, rhs: Self) -> Self {
        zip(lhs, rhs).map { $0.0 + $0.1 }
    }

    @inlinable public static var zero: Self { Self(repeating: T.zero) }
}

@inlinable public func + <T>(lhs: StaticArray17<T>, rhs: T) -> StaticArray17<T> where T: AdditiveArithmetic {
    lhs.map { $0 + rhs }
}

@inlinable public func + <T>(lhs: T, rhs: StaticArray17<T>) -> StaticArray17<T> where T: AdditiveArithmetic {
    rhs.map { lhs + $0 }
}

@inlinable public func - <T>(lhs: StaticArray17<T>, rhs: T) -> StaticArray17<T> where T: AdditiveArithmetic {
    lhs.map { $0 - rhs }
}

@inlinable public func - <T>(lhs: T, rhs: StaticArray17<T>) -> StaticArray17<T> where T: AdditiveArithmetic {
    rhs.map { lhs - $0 }
}

extension StaticArray17: Divisible where T: Divisible {
    @inlinable public static func / (lhs: Self, rhs: Self) -> Self {
        zip(lhs, rhs).map { $0.0 / $0.1 }
    }
}

@inlinable public func / <T>(lhs: StaticArray17<T>, rhs: T) -> StaticArray17<T> where T: Divisible {
    lhs.map { $0 / rhs }
}

@inlinable public func / <T>(lhs: T, rhs: StaticArray17<T>) -> StaticArray17<T> where T: Divisible {
    rhs.map { lhs / $0 }
}

extension StaticArray17: Multipliable where T: Multipliable {
    @inlinable public static func * (lhs: Self, rhs: Self) -> Self {
        zip(lhs, rhs).map { $0.0 * $0.1 }
    }
}

@inlinable public func * <T>(lhs: StaticArray17<T>, rhs: T) -> StaticArray17<T> where T: Multipliable {
    lhs.map { $0 * rhs }
}

@inlinable public func * <T>(lhs: T, rhs: StaticArray17<T>) -> StaticArray17<T> where T: Multipliable {
    rhs.map { lhs * $0 }
}

extension StaticArray17: ABSComputable where T: ABSComputable {
    @inlinable public func abs() -> Self {
        self.map { $0.abs() }
    }
}

public struct StaticArray18<T> {
    public typealias Values = (T, T, T, T, T, T, T, T, T, T, T, T, T, T, T, T, T, T)

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

    init(array: [T]) throws {
        guard array.count == 18 else { fatalError("array size mismatch") }
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
            array[10],
            array[11],
            array[12],
            array[13],
            array[14],
            array[15],
            array[16],
            array[17]
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
            case 11: return self.values.11
            case 12: return self.values.12
            case 13: return self.values.13
            case 14: return self.values.14
            case 15: return self.values.15
            case 16: return self.values.16
            case 17: return self.values.17
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
            case 11: self.values.11 = newValue
            case 12: self.values.12 = newValue
            case 13: self.values.13 = newValue
            case 14: self.values.14 = newValue
            case 15: self.values.15 = newValue
            case 16: self.values.16 = newValue
            case 17: self.values.17 = newValue
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
         case 10:
            return StaticArray2(values: (
                self[10],
                self[11]
            ))
         case 11:
            return StaticArray2(values: (
                self[11],
                self[12]
            ))
         case 12:
            return StaticArray2(values: (
                self[12],
                self[13]
            ))
         case 13:
            return StaticArray2(values: (
                self[13],
                self[14]
            ))
         case 14:
            return StaticArray2(values: (
                self[14],
                self[15]
            ))
         case 15:
            return StaticArray2(values: (
                self[15],
                self[16]
            ))
         case 16:
            return StaticArray2(values: (
                self[16],
                self[17]
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
         case 9:
            return StaticArray3(values: (
                self[9],
                self[10],
                self[11]
            ))
         case 10:
            return StaticArray3(values: (
                self[10],
                self[11],
                self[12]
            ))
         case 11:
            return StaticArray3(values: (
                self[11],
                self[12],
                self[13]
            ))
         case 12:
            return StaticArray3(values: (
                self[12],
                self[13],
                self[14]
            ))
         case 13:
            return StaticArray3(values: (
                self[13],
                self[14],
                self[15]
            ))
         case 14:
            return StaticArray3(values: (
                self[14],
                self[15],
                self[16]
            ))
         case 15:
            return StaticArray3(values: (
                self[15],
                self[16],
                self[17]
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
         case 8:
            return StaticArray4(values: (
                self[8],
                self[9],
                self[10],
                self[11]
            ))
         case 9:
            return StaticArray4(values: (
                self[9],
                self[10],
                self[11],
                self[12]
            ))
         case 10:
            return StaticArray4(values: (
                self[10],
                self[11],
                self[12],
                self[13]
            ))
         case 11:
            return StaticArray4(values: (
                self[11],
                self[12],
                self[13],
                self[14]
            ))
         case 12:
            return StaticArray4(values: (
                self[12],
                self[13],
                self[14],
                self[15]
            ))
         case 13:
            return StaticArray4(values: (
                self[13],
                self[14],
                self[15],
                self[16]
            ))
         case 14:
            return StaticArray4(values: (
                self[14],
                self[15],
                self[16],
                self[17]
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
         case 7:
            return StaticArray5(values: (
                self[7],
                self[8],
                self[9],
                self[10],
                self[11]
            ))
         case 8:
            return StaticArray5(values: (
                self[8],
                self[9],
                self[10],
                self[11],
                self[12]
            ))
         case 9:
            return StaticArray5(values: (
                self[9],
                self[10],
                self[11],
                self[12],
                self[13]
            ))
         case 10:
            return StaticArray5(values: (
                self[10],
                self[11],
                self[12],
                self[13],
                self[14]
            ))
         case 11:
            return StaticArray5(values: (
                self[11],
                self[12],
                self[13],
                self[14],
                self[15]
            ))
         case 12:
            return StaticArray5(values: (
                self[12],
                self[13],
                self[14],
                self[15],
                self[16]
            ))
         case 13:
            return StaticArray5(values: (
                self[13],
                self[14],
                self[15],
                self[16],
                self[17]
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
         case 6:
            return StaticArray6(values: (
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11]
            ))
         case 7:
            return StaticArray6(values: (
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12]
            ))
         case 8:
            return StaticArray6(values: (
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13]
            ))
         case 9:
            return StaticArray6(values: (
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14]
            ))
         case 10:
            return StaticArray6(values: (
                self[10],
                self[11],
                self[12],
                self[13],
                self[14],
                self[15]
            ))
         case 11:
            return StaticArray6(values: (
                self[11],
                self[12],
                self[13],
                self[14],
                self[15],
                self[16]
            ))
         case 12:
            return StaticArray6(values: (
                self[12],
                self[13],
                self[14],
                self[15],
                self[16],
                self[17]
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
         case 5:
            return StaticArray7(values: (
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11]
            ))
         case 6:
            return StaticArray7(values: (
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12]
            ))
         case 7:
            return StaticArray7(values: (
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13]
            ))
         case 8:
            return StaticArray7(values: (
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14]
            ))
         case 9:
            return StaticArray7(values: (
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14],
                self[15]
            ))
         case 10:
            return StaticArray7(values: (
                self[10],
                self[11],
                self[12],
                self[13],
                self[14],
                self[15],
                self[16]
            ))
         case 11:
            return StaticArray7(values: (
                self[11],
                self[12],
                self[13],
                self[14],
                self[15],
                self[16],
                self[17]
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
         case 4:
            return StaticArray8(values: (
                self[4],
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11]
            ))
         case 5:
            return StaticArray8(values: (
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12]
            ))
         case 6:
            return StaticArray8(values: (
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13]
            ))
         case 7:
            return StaticArray8(values: (
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14]
            ))
         case 8:
            return StaticArray8(values: (
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14],
                self[15]
            ))
         case 9:
            return StaticArray8(values: (
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14],
                self[15],
                self[16]
            ))
         case 10:
            return StaticArray8(values: (
                self[10],
                self[11],
                self[12],
                self[13],
                self[14],
                self[15],
                self[16],
                self[17]
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
         case 3:
            return StaticArray9(values: (
                self[3],
                self[4],
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11]
            ))
         case 4:
            return StaticArray9(values: (
                self[4],
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12]
            ))
         case 5:
            return StaticArray9(values: (
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13]
            ))
         case 6:
            return StaticArray9(values: (
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14]
            ))
         case 7:
            return StaticArray9(values: (
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14],
                self[15]
            ))
         case 8:
            return StaticArray9(values: (
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14],
                self[15],
                self[16]
            ))
         case 9:
            return StaticArray9(values: (
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14],
                self[15],
                self[16],
                self[17]
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
         case 2:
            return StaticArray10(values: (
                self[2],
                self[3],
                self[4],
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11]
            ))
         case 3:
            return StaticArray10(values: (
                self[3],
                self[4],
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12]
            ))
         case 4:
            return StaticArray10(values: (
                self[4],
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13]
            ))
         case 5:
            return StaticArray10(values: (
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14]
            ))
         case 6:
            return StaticArray10(values: (
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14],
                self[15]
            ))
         case 7:
            return StaticArray10(values: (
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14],
                self[15],
                self[16]
            ))
         case 8:
            return StaticArray10(values: (
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14],
                self[15],
                self[16],
                self[17]
            ))
        default:
            fatalError("offset out of available range")
        }
    }

    @inlinable public func get11(from offset: Int = 0) ->  StaticArray11<T> {
        switch offset {
         case 0:
            return StaticArray11(values: (
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
            ))
         case 1:
            return StaticArray11(values: (
                self[1],
                self[2],
                self[3],
                self[4],
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11]
            ))
         case 2:
            return StaticArray11(values: (
                self[2],
                self[3],
                self[4],
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12]
            ))
         case 3:
            return StaticArray11(values: (
                self[3],
                self[4],
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13]
            ))
         case 4:
            return StaticArray11(values: (
                self[4],
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14]
            ))
         case 5:
            return StaticArray11(values: (
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14],
                self[15]
            ))
         case 6:
            return StaticArray11(values: (
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14],
                self[15],
                self[16]
            ))
         case 7:
            return StaticArray11(values: (
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14],
                self[15],
                self[16],
                self[17]
            ))
        default:
            fatalError("offset out of available range")
        }
    }

    @inlinable public func get12(from offset: Int = 0) ->  StaticArray12<T> {
        switch offset {
         case 0:
            return StaticArray12(values: (
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
                self[10],
                self[11]
            ))
         case 1:
            return StaticArray12(values: (
                self[1],
                self[2],
                self[3],
                self[4],
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12]
            ))
         case 2:
            return StaticArray12(values: (
                self[2],
                self[3],
                self[4],
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13]
            ))
         case 3:
            return StaticArray12(values: (
                self[3],
                self[4],
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14]
            ))
         case 4:
            return StaticArray12(values: (
                self[4],
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14],
                self[15]
            ))
         case 5:
            return StaticArray12(values: (
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14],
                self[15],
                self[16]
            ))
         case 6:
            return StaticArray12(values: (
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14],
                self[15],
                self[16],
                self[17]
            ))
        default:
            fatalError("offset out of available range")
        }
    }

    @inlinable public func get13(from offset: Int = 0) ->  StaticArray13<T> {
        switch offset {
         case 0:
            return StaticArray13(values: (
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
                self[10],
                self[11],
                self[12]
            ))
         case 1:
            return StaticArray13(values: (
                self[1],
                self[2],
                self[3],
                self[4],
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13]
            ))
         case 2:
            return StaticArray13(values: (
                self[2],
                self[3],
                self[4],
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14]
            ))
         case 3:
            return StaticArray13(values: (
                self[3],
                self[4],
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14],
                self[15]
            ))
         case 4:
            return StaticArray13(values: (
                self[4],
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14],
                self[15],
                self[16]
            ))
         case 5:
            return StaticArray13(values: (
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14],
                self[15],
                self[16],
                self[17]
            ))
        default:
            fatalError("offset out of available range")
        }
    }

    @inlinable public func get14(from offset: Int = 0) ->  StaticArray14<T> {
        switch offset {
         case 0:
            return StaticArray14(values: (
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
                self[10],
                self[11],
                self[12],
                self[13]
            ))
         case 1:
            return StaticArray14(values: (
                self[1],
                self[2],
                self[3],
                self[4],
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14]
            ))
         case 2:
            return StaticArray14(values: (
                self[2],
                self[3],
                self[4],
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14],
                self[15]
            ))
         case 3:
            return StaticArray14(values: (
                self[3],
                self[4],
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14],
                self[15],
                self[16]
            ))
         case 4:
            return StaticArray14(values: (
                self[4],
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14],
                self[15],
                self[16],
                self[17]
            ))
        default:
            fatalError("offset out of available range")
        }
    }

    @inlinable public func get15(from offset: Int = 0) ->  StaticArray15<T> {
        switch offset {
         case 0:
            return StaticArray15(values: (
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
                self[10],
                self[11],
                self[12],
                self[13],
                self[14]
            ))
         case 1:
            return StaticArray15(values: (
                self[1],
                self[2],
                self[3],
                self[4],
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14],
                self[15]
            ))
         case 2:
            return StaticArray15(values: (
                self[2],
                self[3],
                self[4],
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14],
                self[15],
                self[16]
            ))
         case 3:
            return StaticArray15(values: (
                self[3],
                self[4],
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14],
                self[15],
                self[16],
                self[17]
            ))
        default:
            fatalError("offset out of available range")
        }
    }

    @inlinable public func get16(from offset: Int = 0) ->  StaticArray16<T> {
        switch offset {
         case 0:
            return StaticArray16(values: (
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
                self[10],
                self[11],
                self[12],
                self[13],
                self[14],
                self[15]
            ))
         case 1:
            return StaticArray16(values: (
                self[1],
                self[2],
                self[3],
                self[4],
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14],
                self[15],
                self[16]
            ))
         case 2:
            return StaticArray16(values: (
                self[2],
                self[3],
                self[4],
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14],
                self[15],
                self[16],
                self[17]
            ))
        default:
            fatalError("offset out of available range")
        }
    }

    @inlinable public func get17(from offset: Int = 0) ->  StaticArray17<T> {
        switch offset {
         case 0:
            return StaticArray17(values: (
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
                self[10],
                self[11],
                self[12],
                self[13],
                self[14],
                self[15],
                self[16]
            ))
         case 1:
            return StaticArray17(values: (
                self[1],
                self[2],
                self[3],
                self[4],
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14],
                self[15],
                self[16],
                self[17]
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
         case 10:
            self[10] = array[0]
            self[11] = array[1]
         case 11:
            self[11] = array[0]
            self[12] = array[1]
         case 12:
            self[12] = array[0]
            self[13] = array[1]
         case 13:
            self[13] = array[0]
            self[14] = array[1]
         case 14:
            self[14] = array[0]
            self[15] = array[1]
         case 15:
            self[15] = array[0]
            self[16] = array[1]
         case 16:
            self[16] = array[0]
            self[17] = array[1]
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
         case 9:
            self[9] = array[0]
            self[10] = array[1]
            self[11] = array[2]
         case 10:
            self[10] = array[0]
            self[11] = array[1]
            self[12] = array[2]
         case 11:
            self[11] = array[0]
            self[12] = array[1]
            self[13] = array[2]
         case 12:
            self[12] = array[0]
            self[13] = array[1]
            self[14] = array[2]
         case 13:
            self[13] = array[0]
            self[14] = array[1]
            self[15] = array[2]
         case 14:
            self[14] = array[0]
            self[15] = array[1]
            self[16] = array[2]
         case 15:
            self[15] = array[0]
            self[16] = array[1]
            self[17] = array[2]
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
         case 8:
            self[8] = array[0]
            self[9] = array[1]
            self[10] = array[2]
            self[11] = array[3]
         case 9:
            self[9] = array[0]
            self[10] = array[1]
            self[11] = array[2]
            self[12] = array[3]
         case 10:
            self[10] = array[0]
            self[11] = array[1]
            self[12] = array[2]
            self[13] = array[3]
         case 11:
            self[11] = array[0]
            self[12] = array[1]
            self[13] = array[2]
            self[14] = array[3]
         case 12:
            self[12] = array[0]
            self[13] = array[1]
            self[14] = array[2]
            self[15] = array[3]
         case 13:
            self[13] = array[0]
            self[14] = array[1]
            self[15] = array[2]
            self[16] = array[3]
         case 14:
            self[14] = array[0]
            self[15] = array[1]
            self[16] = array[2]
            self[17] = array[3]
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
         case 7:
            self[7] = array[0]
            self[8] = array[1]
            self[9] = array[2]
            self[10] = array[3]
            self[11] = array[4]
         case 8:
            self[8] = array[0]
            self[9] = array[1]
            self[10] = array[2]
            self[11] = array[3]
            self[12] = array[4]
         case 9:
            self[9] = array[0]
            self[10] = array[1]
            self[11] = array[2]
            self[12] = array[3]
            self[13] = array[4]
         case 10:
            self[10] = array[0]
            self[11] = array[1]
            self[12] = array[2]
            self[13] = array[3]
            self[14] = array[4]
         case 11:
            self[11] = array[0]
            self[12] = array[1]
            self[13] = array[2]
            self[14] = array[3]
            self[15] = array[4]
         case 12:
            self[12] = array[0]
            self[13] = array[1]
            self[14] = array[2]
            self[15] = array[3]
            self[16] = array[4]
         case 13:
            self[13] = array[0]
            self[14] = array[1]
            self[15] = array[2]
            self[16] = array[3]
            self[17] = array[4]
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
         case 6:
            self[6] = array[0]
            self[7] = array[1]
            self[8] = array[2]
            self[9] = array[3]
            self[10] = array[4]
            self[11] = array[5]
         case 7:
            self[7] = array[0]
            self[8] = array[1]
            self[9] = array[2]
            self[10] = array[3]
            self[11] = array[4]
            self[12] = array[5]
         case 8:
            self[8] = array[0]
            self[9] = array[1]
            self[10] = array[2]
            self[11] = array[3]
            self[12] = array[4]
            self[13] = array[5]
         case 9:
            self[9] = array[0]
            self[10] = array[1]
            self[11] = array[2]
            self[12] = array[3]
            self[13] = array[4]
            self[14] = array[5]
         case 10:
            self[10] = array[0]
            self[11] = array[1]
            self[12] = array[2]
            self[13] = array[3]
            self[14] = array[4]
            self[15] = array[5]
         case 11:
            self[11] = array[0]
            self[12] = array[1]
            self[13] = array[2]
            self[14] = array[3]
            self[15] = array[4]
            self[16] = array[5]
         case 12:
            self[12] = array[0]
            self[13] = array[1]
            self[14] = array[2]
            self[15] = array[3]
            self[16] = array[4]
            self[17] = array[5]
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
         case 5:
            self[5] = array[0]
            self[6] = array[1]
            self[7] = array[2]
            self[8] = array[3]
            self[9] = array[4]
            self[10] = array[5]
            self[11] = array[6]
         case 6:
            self[6] = array[0]
            self[7] = array[1]
            self[8] = array[2]
            self[9] = array[3]
            self[10] = array[4]
            self[11] = array[5]
            self[12] = array[6]
         case 7:
            self[7] = array[0]
            self[8] = array[1]
            self[9] = array[2]
            self[10] = array[3]
            self[11] = array[4]
            self[12] = array[5]
            self[13] = array[6]
         case 8:
            self[8] = array[0]
            self[9] = array[1]
            self[10] = array[2]
            self[11] = array[3]
            self[12] = array[4]
            self[13] = array[5]
            self[14] = array[6]
         case 9:
            self[9] = array[0]
            self[10] = array[1]
            self[11] = array[2]
            self[12] = array[3]
            self[13] = array[4]
            self[14] = array[5]
            self[15] = array[6]
         case 10:
            self[10] = array[0]
            self[11] = array[1]
            self[12] = array[2]
            self[13] = array[3]
            self[14] = array[4]
            self[15] = array[5]
            self[16] = array[6]
         case 11:
            self[11] = array[0]
            self[12] = array[1]
            self[13] = array[2]
            self[14] = array[3]
            self[15] = array[4]
            self[16] = array[5]
            self[17] = array[6]
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
         case 4:
            self[4] = array[0]
            self[5] = array[1]
            self[6] = array[2]
            self[7] = array[3]
            self[8] = array[4]
            self[9] = array[5]
            self[10] = array[6]
            self[11] = array[7]
         case 5:
            self[5] = array[0]
            self[6] = array[1]
            self[7] = array[2]
            self[8] = array[3]
            self[9] = array[4]
            self[10] = array[5]
            self[11] = array[6]
            self[12] = array[7]
         case 6:
            self[6] = array[0]
            self[7] = array[1]
            self[8] = array[2]
            self[9] = array[3]
            self[10] = array[4]
            self[11] = array[5]
            self[12] = array[6]
            self[13] = array[7]
         case 7:
            self[7] = array[0]
            self[8] = array[1]
            self[9] = array[2]
            self[10] = array[3]
            self[11] = array[4]
            self[12] = array[5]
            self[13] = array[6]
            self[14] = array[7]
         case 8:
            self[8] = array[0]
            self[9] = array[1]
            self[10] = array[2]
            self[11] = array[3]
            self[12] = array[4]
            self[13] = array[5]
            self[14] = array[6]
            self[15] = array[7]
         case 9:
            self[9] = array[0]
            self[10] = array[1]
            self[11] = array[2]
            self[12] = array[3]
            self[13] = array[4]
            self[14] = array[5]
            self[15] = array[6]
            self[16] = array[7]
         case 10:
            self[10] = array[0]
            self[11] = array[1]
            self[12] = array[2]
            self[13] = array[3]
            self[14] = array[4]
            self[15] = array[5]
            self[16] = array[6]
            self[17] = array[7]
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
         case 3:
            self[3] = array[0]
            self[4] = array[1]
            self[5] = array[2]
            self[6] = array[3]
            self[7] = array[4]
            self[8] = array[5]
            self[9] = array[6]
            self[10] = array[7]
            self[11] = array[8]
         case 4:
            self[4] = array[0]
            self[5] = array[1]
            self[6] = array[2]
            self[7] = array[3]
            self[8] = array[4]
            self[9] = array[5]
            self[10] = array[6]
            self[11] = array[7]
            self[12] = array[8]
         case 5:
            self[5] = array[0]
            self[6] = array[1]
            self[7] = array[2]
            self[8] = array[3]
            self[9] = array[4]
            self[10] = array[5]
            self[11] = array[6]
            self[12] = array[7]
            self[13] = array[8]
         case 6:
            self[6] = array[0]
            self[7] = array[1]
            self[8] = array[2]
            self[9] = array[3]
            self[10] = array[4]
            self[11] = array[5]
            self[12] = array[6]
            self[13] = array[7]
            self[14] = array[8]
         case 7:
            self[7] = array[0]
            self[8] = array[1]
            self[9] = array[2]
            self[10] = array[3]
            self[11] = array[4]
            self[12] = array[5]
            self[13] = array[6]
            self[14] = array[7]
            self[15] = array[8]
         case 8:
            self[8] = array[0]
            self[9] = array[1]
            self[10] = array[2]
            self[11] = array[3]
            self[12] = array[4]
            self[13] = array[5]
            self[14] = array[6]
            self[15] = array[7]
            self[16] = array[8]
         case 9:
            self[9] = array[0]
            self[10] = array[1]
            self[11] = array[2]
            self[12] = array[3]
            self[13] = array[4]
            self[14] = array[5]
            self[15] = array[6]
            self[16] = array[7]
            self[17] = array[8]
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
            self[11] = array[9]
         case 3:
            self[3] = array[0]
            self[4] = array[1]
            self[5] = array[2]
            self[6] = array[3]
            self[7] = array[4]
            self[8] = array[5]
            self[9] = array[6]
            self[10] = array[7]
            self[11] = array[8]
            self[12] = array[9]
         case 4:
            self[4] = array[0]
            self[5] = array[1]
            self[6] = array[2]
            self[7] = array[3]
            self[8] = array[4]
            self[9] = array[5]
            self[10] = array[6]
            self[11] = array[7]
            self[12] = array[8]
            self[13] = array[9]
         case 5:
            self[5] = array[0]
            self[6] = array[1]
            self[7] = array[2]
            self[8] = array[3]
            self[9] = array[4]
            self[10] = array[5]
            self[11] = array[6]
            self[12] = array[7]
            self[13] = array[8]
            self[14] = array[9]
         case 6:
            self[6] = array[0]
            self[7] = array[1]
            self[8] = array[2]
            self[9] = array[3]
            self[10] = array[4]
            self[11] = array[5]
            self[12] = array[6]
            self[13] = array[7]
            self[14] = array[8]
            self[15] = array[9]
         case 7:
            self[7] = array[0]
            self[8] = array[1]
            self[9] = array[2]
            self[10] = array[3]
            self[11] = array[4]
            self[12] = array[5]
            self[13] = array[6]
            self[14] = array[7]
            self[15] = array[8]
            self[16] = array[9]
         case 8:
            self[8] = array[0]
            self[9] = array[1]
            self[10] = array[2]
            self[11] = array[3]
            self[12] = array[4]
            self[13] = array[5]
            self[14] = array[6]
            self[15] = array[7]
            self[16] = array[8]
            self[17] = array[9]
        default:
            fatalError("offset out of available range")
        }
    }

    @inlinable public mutating func set11(_ array: StaticArray11<T>, at offset: Int = 0) {
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
            self[10] = array[10]
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
            self[11] = array[10]
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
            self[11] = array[9]
            self[12] = array[10]
         case 3:
            self[3] = array[0]
            self[4] = array[1]
            self[5] = array[2]
            self[6] = array[3]
            self[7] = array[4]
            self[8] = array[5]
            self[9] = array[6]
            self[10] = array[7]
            self[11] = array[8]
            self[12] = array[9]
            self[13] = array[10]
         case 4:
            self[4] = array[0]
            self[5] = array[1]
            self[6] = array[2]
            self[7] = array[3]
            self[8] = array[4]
            self[9] = array[5]
            self[10] = array[6]
            self[11] = array[7]
            self[12] = array[8]
            self[13] = array[9]
            self[14] = array[10]
         case 5:
            self[5] = array[0]
            self[6] = array[1]
            self[7] = array[2]
            self[8] = array[3]
            self[9] = array[4]
            self[10] = array[5]
            self[11] = array[6]
            self[12] = array[7]
            self[13] = array[8]
            self[14] = array[9]
            self[15] = array[10]
         case 6:
            self[6] = array[0]
            self[7] = array[1]
            self[8] = array[2]
            self[9] = array[3]
            self[10] = array[4]
            self[11] = array[5]
            self[12] = array[6]
            self[13] = array[7]
            self[14] = array[8]
            self[15] = array[9]
            self[16] = array[10]
         case 7:
            self[7] = array[0]
            self[8] = array[1]
            self[9] = array[2]
            self[10] = array[3]
            self[11] = array[4]
            self[12] = array[5]
            self[13] = array[6]
            self[14] = array[7]
            self[15] = array[8]
            self[16] = array[9]
            self[17] = array[10]
        default:
            fatalError("offset out of available range")
        }
    }

    @inlinable public mutating func set12(_ array: StaticArray12<T>, at offset: Int = 0) {
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
            self[10] = array[10]
            self[11] = array[11]
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
            self[11] = array[10]
            self[12] = array[11]
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
            self[11] = array[9]
            self[12] = array[10]
            self[13] = array[11]
         case 3:
            self[3] = array[0]
            self[4] = array[1]
            self[5] = array[2]
            self[6] = array[3]
            self[7] = array[4]
            self[8] = array[5]
            self[9] = array[6]
            self[10] = array[7]
            self[11] = array[8]
            self[12] = array[9]
            self[13] = array[10]
            self[14] = array[11]
         case 4:
            self[4] = array[0]
            self[5] = array[1]
            self[6] = array[2]
            self[7] = array[3]
            self[8] = array[4]
            self[9] = array[5]
            self[10] = array[6]
            self[11] = array[7]
            self[12] = array[8]
            self[13] = array[9]
            self[14] = array[10]
            self[15] = array[11]
         case 5:
            self[5] = array[0]
            self[6] = array[1]
            self[7] = array[2]
            self[8] = array[3]
            self[9] = array[4]
            self[10] = array[5]
            self[11] = array[6]
            self[12] = array[7]
            self[13] = array[8]
            self[14] = array[9]
            self[15] = array[10]
            self[16] = array[11]
         case 6:
            self[6] = array[0]
            self[7] = array[1]
            self[8] = array[2]
            self[9] = array[3]
            self[10] = array[4]
            self[11] = array[5]
            self[12] = array[6]
            self[13] = array[7]
            self[14] = array[8]
            self[15] = array[9]
            self[16] = array[10]
            self[17] = array[11]
        default:
            fatalError("offset out of available range")
        }
    }

    @inlinable public mutating func set13(_ array: StaticArray13<T>, at offset: Int = 0) {
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
            self[10] = array[10]
            self[11] = array[11]
            self[12] = array[12]
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
            self[11] = array[10]
            self[12] = array[11]
            self[13] = array[12]
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
            self[11] = array[9]
            self[12] = array[10]
            self[13] = array[11]
            self[14] = array[12]
         case 3:
            self[3] = array[0]
            self[4] = array[1]
            self[5] = array[2]
            self[6] = array[3]
            self[7] = array[4]
            self[8] = array[5]
            self[9] = array[6]
            self[10] = array[7]
            self[11] = array[8]
            self[12] = array[9]
            self[13] = array[10]
            self[14] = array[11]
            self[15] = array[12]
         case 4:
            self[4] = array[0]
            self[5] = array[1]
            self[6] = array[2]
            self[7] = array[3]
            self[8] = array[4]
            self[9] = array[5]
            self[10] = array[6]
            self[11] = array[7]
            self[12] = array[8]
            self[13] = array[9]
            self[14] = array[10]
            self[15] = array[11]
            self[16] = array[12]
         case 5:
            self[5] = array[0]
            self[6] = array[1]
            self[7] = array[2]
            self[8] = array[3]
            self[9] = array[4]
            self[10] = array[5]
            self[11] = array[6]
            self[12] = array[7]
            self[13] = array[8]
            self[14] = array[9]
            self[15] = array[10]
            self[16] = array[11]
            self[17] = array[12]
        default:
            fatalError("offset out of available range")
        }
    }

    @inlinable public mutating func set14(_ array: StaticArray14<T>, at offset: Int = 0) {
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
            self[10] = array[10]
            self[11] = array[11]
            self[12] = array[12]
            self[13] = array[13]
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
            self[11] = array[10]
            self[12] = array[11]
            self[13] = array[12]
            self[14] = array[13]
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
            self[11] = array[9]
            self[12] = array[10]
            self[13] = array[11]
            self[14] = array[12]
            self[15] = array[13]
         case 3:
            self[3] = array[0]
            self[4] = array[1]
            self[5] = array[2]
            self[6] = array[3]
            self[7] = array[4]
            self[8] = array[5]
            self[9] = array[6]
            self[10] = array[7]
            self[11] = array[8]
            self[12] = array[9]
            self[13] = array[10]
            self[14] = array[11]
            self[15] = array[12]
            self[16] = array[13]
         case 4:
            self[4] = array[0]
            self[5] = array[1]
            self[6] = array[2]
            self[7] = array[3]
            self[8] = array[4]
            self[9] = array[5]
            self[10] = array[6]
            self[11] = array[7]
            self[12] = array[8]
            self[13] = array[9]
            self[14] = array[10]
            self[15] = array[11]
            self[16] = array[12]
            self[17] = array[13]
        default:
            fatalError("offset out of available range")
        }
    }

    @inlinable public mutating func set15(_ array: StaticArray15<T>, at offset: Int = 0) {
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
            self[10] = array[10]
            self[11] = array[11]
            self[12] = array[12]
            self[13] = array[13]
            self[14] = array[14]
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
            self[11] = array[10]
            self[12] = array[11]
            self[13] = array[12]
            self[14] = array[13]
            self[15] = array[14]
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
            self[11] = array[9]
            self[12] = array[10]
            self[13] = array[11]
            self[14] = array[12]
            self[15] = array[13]
            self[16] = array[14]
         case 3:
            self[3] = array[0]
            self[4] = array[1]
            self[5] = array[2]
            self[6] = array[3]
            self[7] = array[4]
            self[8] = array[5]
            self[9] = array[6]
            self[10] = array[7]
            self[11] = array[8]
            self[12] = array[9]
            self[13] = array[10]
            self[14] = array[11]
            self[15] = array[12]
            self[16] = array[13]
            self[17] = array[14]
        default:
            fatalError("offset out of available range")
        }
    }

    @inlinable public mutating func set16(_ array: StaticArray16<T>, at offset: Int = 0) {
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
            self[10] = array[10]
            self[11] = array[11]
            self[12] = array[12]
            self[13] = array[13]
            self[14] = array[14]
            self[15] = array[15]
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
            self[11] = array[10]
            self[12] = array[11]
            self[13] = array[12]
            self[14] = array[13]
            self[15] = array[14]
            self[16] = array[15]
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
            self[11] = array[9]
            self[12] = array[10]
            self[13] = array[11]
            self[14] = array[12]
            self[15] = array[13]
            self[16] = array[14]
            self[17] = array[15]
        default:
            fatalError("offset out of available range")
        }
    }

    @inlinable public mutating func set17(_ array: StaticArray17<T>, at offset: Int = 0) {
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
            self[10] = array[10]
            self[11] = array[11]
            self[12] = array[12]
            self[13] = array[13]
            self[14] = array[14]
            self[15] = array[15]
            self[16] = array[16]
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
            self[11] = array[10]
            self[12] = array[11]
            self[13] = array[12]
            self[14] = array[13]
            self[15] = array[14]
            self[16] = array[15]
            self[17] = array[16]
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
            self[10],
            self[11],
            self[12],
            self[13],
            self[14],
            self[15],
            self[16],
            self[17]
        ]
    }

    @inlinable public func map<M>(_ transform: (T) throws -> M) rethrows -> StaticArray18<M> {
        try StaticArray18<M>(values: (
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
            transform(self[10]),
            transform(self[11]),
            transform(self[12]),
            transform(self[13]),
            transform(self[14]),
            transform(self[15]),
            transform(self[16]),
            transform(self[17])
        ))
    }
}

public func zip<L, R>(_ lhs: StaticArray18<L>, _ rhs: StaticArray18<R>) -> StaticArray18<(L, R)> {
    StaticArray18(values: (
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
        (lhs[10], rhs[10]),
        (lhs[11], rhs[11]),
        (lhs[12], rhs[12]),
        (lhs[13], rhs[13]),
        (lhs[14], rhs[14]),
        (lhs[15], rhs[15]),
        (lhs[16], rhs[16]),
        (lhs[17], rhs[17])
    ))
}

extension StaticArray18: Collection {
    public typealias Index = Int
    public var startIndex: Index { 0 }
    public var endIndex: Index { 18 }
    @inlinable public func index(after i: Index) -> Index { i + 1 }
}

extension StaticArray18: Sequence {
    public struct Iterator: IteratorProtocol {
        private var index = 0
        private let array: StaticArray18<T>

        init(_ array: StaticArray18<T>) {
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

extension StaticArray18: Equatable where T: Equatable {
    @inlinable public static func == (lhs: Self, rhs: Self) -> Bool {
        zip(lhs, rhs).allSatisfy { $0.0 == $0.1 }
    }
}

extension StaticArray18: Codable where T: Codable {
    public init(from decoder: Decoder) throws {
        try self.init(array: [T](from: decoder))
    }

    public func encode(to encoder: Encoder) throws {
        try self.toArray().encode(to: encoder)
    }
}

extension StaticArray18: AdditiveArithmetic where T: AdditiveArithmetic {
    @inlinable public static func - (lhs: Self, rhs: Self) -> Self {
        zip(lhs, rhs).map { $0.0 - $0.1 }
    }

    @inlinable public static func + (lhs: Self, rhs: Self) -> Self {
        zip(lhs, rhs).map { $0.0 + $0.1 }
    }

    @inlinable public static var zero: Self { Self(repeating: T.zero) }
}

@inlinable public func + <T>(lhs: StaticArray18<T>, rhs: T) -> StaticArray18<T> where T: AdditiveArithmetic {
    lhs.map { $0 + rhs }
}

@inlinable public func + <T>(lhs: T, rhs: StaticArray18<T>) -> StaticArray18<T> where T: AdditiveArithmetic {
    rhs.map { lhs + $0 }
}

@inlinable public func - <T>(lhs: StaticArray18<T>, rhs: T) -> StaticArray18<T> where T: AdditiveArithmetic {
    lhs.map { $0 - rhs }
}

@inlinable public func - <T>(lhs: T, rhs: StaticArray18<T>) -> StaticArray18<T> where T: AdditiveArithmetic {
    rhs.map { lhs - $0 }
}

extension StaticArray18: Divisible where T: Divisible {
    @inlinable public static func / (lhs: Self, rhs: Self) -> Self {
        zip(lhs, rhs).map { $0.0 / $0.1 }
    }
}

@inlinable public func / <T>(lhs: StaticArray18<T>, rhs: T) -> StaticArray18<T> where T: Divisible {
    lhs.map { $0 / rhs }
}

@inlinable public func / <T>(lhs: T, rhs: StaticArray18<T>) -> StaticArray18<T> where T: Divisible {
    rhs.map { lhs / $0 }
}

extension StaticArray18: Multipliable where T: Multipliable {
    @inlinable public static func * (lhs: Self, rhs: Self) -> Self {
        zip(lhs, rhs).map { $0.0 * $0.1 }
    }
}

@inlinable public func * <T>(lhs: StaticArray18<T>, rhs: T) -> StaticArray18<T> where T: Multipliable {
    lhs.map { $0 * rhs }
}

@inlinable public func * <T>(lhs: T, rhs: StaticArray18<T>) -> StaticArray18<T> where T: Multipliable {
    rhs.map { lhs * $0 }
}

extension StaticArray18: ABSComputable where T: ABSComputable {
    @inlinable public func abs() -> Self {
        self.map { $0.abs() }
    }
}

public struct StaticArray19<T> {
    public typealias Values = (T, T, T, T, T, T, T, T, T, T, T, T, T, T, T, T, T, T, T)

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

    init(array: [T]) throws {
        guard array.count == 19 else { fatalError("array size mismatch") }
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
            array[10],
            array[11],
            array[12],
            array[13],
            array[14],
            array[15],
            array[16],
            array[17],
            array[18]
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
            case 11: return self.values.11
            case 12: return self.values.12
            case 13: return self.values.13
            case 14: return self.values.14
            case 15: return self.values.15
            case 16: return self.values.16
            case 17: return self.values.17
            case 18: return self.values.18
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
            case 11: self.values.11 = newValue
            case 12: self.values.12 = newValue
            case 13: self.values.13 = newValue
            case 14: self.values.14 = newValue
            case 15: self.values.15 = newValue
            case 16: self.values.16 = newValue
            case 17: self.values.17 = newValue
            case 18: self.values.18 = newValue
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
         case 10:
            return StaticArray2(values: (
                self[10],
                self[11]
            ))
         case 11:
            return StaticArray2(values: (
                self[11],
                self[12]
            ))
         case 12:
            return StaticArray2(values: (
                self[12],
                self[13]
            ))
         case 13:
            return StaticArray2(values: (
                self[13],
                self[14]
            ))
         case 14:
            return StaticArray2(values: (
                self[14],
                self[15]
            ))
         case 15:
            return StaticArray2(values: (
                self[15],
                self[16]
            ))
         case 16:
            return StaticArray2(values: (
                self[16],
                self[17]
            ))
         case 17:
            return StaticArray2(values: (
                self[17],
                self[18]
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
         case 9:
            return StaticArray3(values: (
                self[9],
                self[10],
                self[11]
            ))
         case 10:
            return StaticArray3(values: (
                self[10],
                self[11],
                self[12]
            ))
         case 11:
            return StaticArray3(values: (
                self[11],
                self[12],
                self[13]
            ))
         case 12:
            return StaticArray3(values: (
                self[12],
                self[13],
                self[14]
            ))
         case 13:
            return StaticArray3(values: (
                self[13],
                self[14],
                self[15]
            ))
         case 14:
            return StaticArray3(values: (
                self[14],
                self[15],
                self[16]
            ))
         case 15:
            return StaticArray3(values: (
                self[15],
                self[16],
                self[17]
            ))
         case 16:
            return StaticArray3(values: (
                self[16],
                self[17],
                self[18]
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
         case 8:
            return StaticArray4(values: (
                self[8],
                self[9],
                self[10],
                self[11]
            ))
         case 9:
            return StaticArray4(values: (
                self[9],
                self[10],
                self[11],
                self[12]
            ))
         case 10:
            return StaticArray4(values: (
                self[10],
                self[11],
                self[12],
                self[13]
            ))
         case 11:
            return StaticArray4(values: (
                self[11],
                self[12],
                self[13],
                self[14]
            ))
         case 12:
            return StaticArray4(values: (
                self[12],
                self[13],
                self[14],
                self[15]
            ))
         case 13:
            return StaticArray4(values: (
                self[13],
                self[14],
                self[15],
                self[16]
            ))
         case 14:
            return StaticArray4(values: (
                self[14],
                self[15],
                self[16],
                self[17]
            ))
         case 15:
            return StaticArray4(values: (
                self[15],
                self[16],
                self[17],
                self[18]
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
         case 7:
            return StaticArray5(values: (
                self[7],
                self[8],
                self[9],
                self[10],
                self[11]
            ))
         case 8:
            return StaticArray5(values: (
                self[8],
                self[9],
                self[10],
                self[11],
                self[12]
            ))
         case 9:
            return StaticArray5(values: (
                self[9],
                self[10],
                self[11],
                self[12],
                self[13]
            ))
         case 10:
            return StaticArray5(values: (
                self[10],
                self[11],
                self[12],
                self[13],
                self[14]
            ))
         case 11:
            return StaticArray5(values: (
                self[11],
                self[12],
                self[13],
                self[14],
                self[15]
            ))
         case 12:
            return StaticArray5(values: (
                self[12],
                self[13],
                self[14],
                self[15],
                self[16]
            ))
         case 13:
            return StaticArray5(values: (
                self[13],
                self[14],
                self[15],
                self[16],
                self[17]
            ))
         case 14:
            return StaticArray5(values: (
                self[14],
                self[15],
                self[16],
                self[17],
                self[18]
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
         case 6:
            return StaticArray6(values: (
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11]
            ))
         case 7:
            return StaticArray6(values: (
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12]
            ))
         case 8:
            return StaticArray6(values: (
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13]
            ))
         case 9:
            return StaticArray6(values: (
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14]
            ))
         case 10:
            return StaticArray6(values: (
                self[10],
                self[11],
                self[12],
                self[13],
                self[14],
                self[15]
            ))
         case 11:
            return StaticArray6(values: (
                self[11],
                self[12],
                self[13],
                self[14],
                self[15],
                self[16]
            ))
         case 12:
            return StaticArray6(values: (
                self[12],
                self[13],
                self[14],
                self[15],
                self[16],
                self[17]
            ))
         case 13:
            return StaticArray6(values: (
                self[13],
                self[14],
                self[15],
                self[16],
                self[17],
                self[18]
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
         case 5:
            return StaticArray7(values: (
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11]
            ))
         case 6:
            return StaticArray7(values: (
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12]
            ))
         case 7:
            return StaticArray7(values: (
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13]
            ))
         case 8:
            return StaticArray7(values: (
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14]
            ))
         case 9:
            return StaticArray7(values: (
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14],
                self[15]
            ))
         case 10:
            return StaticArray7(values: (
                self[10],
                self[11],
                self[12],
                self[13],
                self[14],
                self[15],
                self[16]
            ))
         case 11:
            return StaticArray7(values: (
                self[11],
                self[12],
                self[13],
                self[14],
                self[15],
                self[16],
                self[17]
            ))
         case 12:
            return StaticArray7(values: (
                self[12],
                self[13],
                self[14],
                self[15],
                self[16],
                self[17],
                self[18]
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
         case 4:
            return StaticArray8(values: (
                self[4],
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11]
            ))
         case 5:
            return StaticArray8(values: (
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12]
            ))
         case 6:
            return StaticArray8(values: (
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13]
            ))
         case 7:
            return StaticArray8(values: (
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14]
            ))
         case 8:
            return StaticArray8(values: (
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14],
                self[15]
            ))
         case 9:
            return StaticArray8(values: (
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14],
                self[15],
                self[16]
            ))
         case 10:
            return StaticArray8(values: (
                self[10],
                self[11],
                self[12],
                self[13],
                self[14],
                self[15],
                self[16],
                self[17]
            ))
         case 11:
            return StaticArray8(values: (
                self[11],
                self[12],
                self[13],
                self[14],
                self[15],
                self[16],
                self[17],
                self[18]
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
         case 3:
            return StaticArray9(values: (
                self[3],
                self[4],
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11]
            ))
         case 4:
            return StaticArray9(values: (
                self[4],
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12]
            ))
         case 5:
            return StaticArray9(values: (
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13]
            ))
         case 6:
            return StaticArray9(values: (
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14]
            ))
         case 7:
            return StaticArray9(values: (
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14],
                self[15]
            ))
         case 8:
            return StaticArray9(values: (
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14],
                self[15],
                self[16]
            ))
         case 9:
            return StaticArray9(values: (
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14],
                self[15],
                self[16],
                self[17]
            ))
         case 10:
            return StaticArray9(values: (
                self[10],
                self[11],
                self[12],
                self[13],
                self[14],
                self[15],
                self[16],
                self[17],
                self[18]
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
         case 2:
            return StaticArray10(values: (
                self[2],
                self[3],
                self[4],
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11]
            ))
         case 3:
            return StaticArray10(values: (
                self[3],
                self[4],
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12]
            ))
         case 4:
            return StaticArray10(values: (
                self[4],
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13]
            ))
         case 5:
            return StaticArray10(values: (
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14]
            ))
         case 6:
            return StaticArray10(values: (
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14],
                self[15]
            ))
         case 7:
            return StaticArray10(values: (
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14],
                self[15],
                self[16]
            ))
         case 8:
            return StaticArray10(values: (
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14],
                self[15],
                self[16],
                self[17]
            ))
         case 9:
            return StaticArray10(values: (
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14],
                self[15],
                self[16],
                self[17],
                self[18]
            ))
        default:
            fatalError("offset out of available range")
        }
    }

    @inlinable public func get11(from offset: Int = 0) ->  StaticArray11<T> {
        switch offset {
         case 0:
            return StaticArray11(values: (
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
            ))
         case 1:
            return StaticArray11(values: (
                self[1],
                self[2],
                self[3],
                self[4],
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11]
            ))
         case 2:
            return StaticArray11(values: (
                self[2],
                self[3],
                self[4],
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12]
            ))
         case 3:
            return StaticArray11(values: (
                self[3],
                self[4],
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13]
            ))
         case 4:
            return StaticArray11(values: (
                self[4],
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14]
            ))
         case 5:
            return StaticArray11(values: (
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14],
                self[15]
            ))
         case 6:
            return StaticArray11(values: (
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14],
                self[15],
                self[16]
            ))
         case 7:
            return StaticArray11(values: (
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14],
                self[15],
                self[16],
                self[17]
            ))
         case 8:
            return StaticArray11(values: (
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14],
                self[15],
                self[16],
                self[17],
                self[18]
            ))
        default:
            fatalError("offset out of available range")
        }
    }

    @inlinable public func get12(from offset: Int = 0) ->  StaticArray12<T> {
        switch offset {
         case 0:
            return StaticArray12(values: (
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
                self[10],
                self[11]
            ))
         case 1:
            return StaticArray12(values: (
                self[1],
                self[2],
                self[3],
                self[4],
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12]
            ))
         case 2:
            return StaticArray12(values: (
                self[2],
                self[3],
                self[4],
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13]
            ))
         case 3:
            return StaticArray12(values: (
                self[3],
                self[4],
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14]
            ))
         case 4:
            return StaticArray12(values: (
                self[4],
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14],
                self[15]
            ))
         case 5:
            return StaticArray12(values: (
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14],
                self[15],
                self[16]
            ))
         case 6:
            return StaticArray12(values: (
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14],
                self[15],
                self[16],
                self[17]
            ))
         case 7:
            return StaticArray12(values: (
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14],
                self[15],
                self[16],
                self[17],
                self[18]
            ))
        default:
            fatalError("offset out of available range")
        }
    }

    @inlinable public func get13(from offset: Int = 0) ->  StaticArray13<T> {
        switch offset {
         case 0:
            return StaticArray13(values: (
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
                self[10],
                self[11],
                self[12]
            ))
         case 1:
            return StaticArray13(values: (
                self[1],
                self[2],
                self[3],
                self[4],
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13]
            ))
         case 2:
            return StaticArray13(values: (
                self[2],
                self[3],
                self[4],
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14]
            ))
         case 3:
            return StaticArray13(values: (
                self[3],
                self[4],
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14],
                self[15]
            ))
         case 4:
            return StaticArray13(values: (
                self[4],
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14],
                self[15],
                self[16]
            ))
         case 5:
            return StaticArray13(values: (
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14],
                self[15],
                self[16],
                self[17]
            ))
         case 6:
            return StaticArray13(values: (
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14],
                self[15],
                self[16],
                self[17],
                self[18]
            ))
        default:
            fatalError("offset out of available range")
        }
    }

    @inlinable public func get14(from offset: Int = 0) ->  StaticArray14<T> {
        switch offset {
         case 0:
            return StaticArray14(values: (
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
                self[10],
                self[11],
                self[12],
                self[13]
            ))
         case 1:
            return StaticArray14(values: (
                self[1],
                self[2],
                self[3],
                self[4],
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14]
            ))
         case 2:
            return StaticArray14(values: (
                self[2],
                self[3],
                self[4],
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14],
                self[15]
            ))
         case 3:
            return StaticArray14(values: (
                self[3],
                self[4],
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14],
                self[15],
                self[16]
            ))
         case 4:
            return StaticArray14(values: (
                self[4],
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14],
                self[15],
                self[16],
                self[17]
            ))
         case 5:
            return StaticArray14(values: (
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14],
                self[15],
                self[16],
                self[17],
                self[18]
            ))
        default:
            fatalError("offset out of available range")
        }
    }

    @inlinable public func get15(from offset: Int = 0) ->  StaticArray15<T> {
        switch offset {
         case 0:
            return StaticArray15(values: (
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
                self[10],
                self[11],
                self[12],
                self[13],
                self[14]
            ))
         case 1:
            return StaticArray15(values: (
                self[1],
                self[2],
                self[3],
                self[4],
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14],
                self[15]
            ))
         case 2:
            return StaticArray15(values: (
                self[2],
                self[3],
                self[4],
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14],
                self[15],
                self[16]
            ))
         case 3:
            return StaticArray15(values: (
                self[3],
                self[4],
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14],
                self[15],
                self[16],
                self[17]
            ))
         case 4:
            return StaticArray15(values: (
                self[4],
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14],
                self[15],
                self[16],
                self[17],
                self[18]
            ))
        default:
            fatalError("offset out of available range")
        }
    }

    @inlinable public func get16(from offset: Int = 0) ->  StaticArray16<T> {
        switch offset {
         case 0:
            return StaticArray16(values: (
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
                self[10],
                self[11],
                self[12],
                self[13],
                self[14],
                self[15]
            ))
         case 1:
            return StaticArray16(values: (
                self[1],
                self[2],
                self[3],
                self[4],
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14],
                self[15],
                self[16]
            ))
         case 2:
            return StaticArray16(values: (
                self[2],
                self[3],
                self[4],
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14],
                self[15],
                self[16],
                self[17]
            ))
         case 3:
            return StaticArray16(values: (
                self[3],
                self[4],
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14],
                self[15],
                self[16],
                self[17],
                self[18]
            ))
        default:
            fatalError("offset out of available range")
        }
    }

    @inlinable public func get17(from offset: Int = 0) ->  StaticArray17<T> {
        switch offset {
         case 0:
            return StaticArray17(values: (
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
                self[10],
                self[11],
                self[12],
                self[13],
                self[14],
                self[15],
                self[16]
            ))
         case 1:
            return StaticArray17(values: (
                self[1],
                self[2],
                self[3],
                self[4],
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14],
                self[15],
                self[16],
                self[17]
            ))
         case 2:
            return StaticArray17(values: (
                self[2],
                self[3],
                self[4],
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14],
                self[15],
                self[16],
                self[17],
                self[18]
            ))
        default:
            fatalError("offset out of available range")
        }
    }

    @inlinable public func get18(from offset: Int = 0) ->  StaticArray18<T> {
        switch offset {
         case 0:
            return StaticArray18(values: (
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
                self[10],
                self[11],
                self[12],
                self[13],
                self[14],
                self[15],
                self[16],
                self[17]
            ))
         case 1:
            return StaticArray18(values: (
                self[1],
                self[2],
                self[3],
                self[4],
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14],
                self[15],
                self[16],
                self[17],
                self[18]
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
         case 10:
            self[10] = array[0]
            self[11] = array[1]
         case 11:
            self[11] = array[0]
            self[12] = array[1]
         case 12:
            self[12] = array[0]
            self[13] = array[1]
         case 13:
            self[13] = array[0]
            self[14] = array[1]
         case 14:
            self[14] = array[0]
            self[15] = array[1]
         case 15:
            self[15] = array[0]
            self[16] = array[1]
         case 16:
            self[16] = array[0]
            self[17] = array[1]
         case 17:
            self[17] = array[0]
            self[18] = array[1]
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
         case 9:
            self[9] = array[0]
            self[10] = array[1]
            self[11] = array[2]
         case 10:
            self[10] = array[0]
            self[11] = array[1]
            self[12] = array[2]
         case 11:
            self[11] = array[0]
            self[12] = array[1]
            self[13] = array[2]
         case 12:
            self[12] = array[0]
            self[13] = array[1]
            self[14] = array[2]
         case 13:
            self[13] = array[0]
            self[14] = array[1]
            self[15] = array[2]
         case 14:
            self[14] = array[0]
            self[15] = array[1]
            self[16] = array[2]
         case 15:
            self[15] = array[0]
            self[16] = array[1]
            self[17] = array[2]
         case 16:
            self[16] = array[0]
            self[17] = array[1]
            self[18] = array[2]
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
         case 8:
            self[8] = array[0]
            self[9] = array[1]
            self[10] = array[2]
            self[11] = array[3]
         case 9:
            self[9] = array[0]
            self[10] = array[1]
            self[11] = array[2]
            self[12] = array[3]
         case 10:
            self[10] = array[0]
            self[11] = array[1]
            self[12] = array[2]
            self[13] = array[3]
         case 11:
            self[11] = array[0]
            self[12] = array[1]
            self[13] = array[2]
            self[14] = array[3]
         case 12:
            self[12] = array[0]
            self[13] = array[1]
            self[14] = array[2]
            self[15] = array[3]
         case 13:
            self[13] = array[0]
            self[14] = array[1]
            self[15] = array[2]
            self[16] = array[3]
         case 14:
            self[14] = array[0]
            self[15] = array[1]
            self[16] = array[2]
            self[17] = array[3]
         case 15:
            self[15] = array[0]
            self[16] = array[1]
            self[17] = array[2]
            self[18] = array[3]
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
         case 7:
            self[7] = array[0]
            self[8] = array[1]
            self[9] = array[2]
            self[10] = array[3]
            self[11] = array[4]
         case 8:
            self[8] = array[0]
            self[9] = array[1]
            self[10] = array[2]
            self[11] = array[3]
            self[12] = array[4]
         case 9:
            self[9] = array[0]
            self[10] = array[1]
            self[11] = array[2]
            self[12] = array[3]
            self[13] = array[4]
         case 10:
            self[10] = array[0]
            self[11] = array[1]
            self[12] = array[2]
            self[13] = array[3]
            self[14] = array[4]
         case 11:
            self[11] = array[0]
            self[12] = array[1]
            self[13] = array[2]
            self[14] = array[3]
            self[15] = array[4]
         case 12:
            self[12] = array[0]
            self[13] = array[1]
            self[14] = array[2]
            self[15] = array[3]
            self[16] = array[4]
         case 13:
            self[13] = array[0]
            self[14] = array[1]
            self[15] = array[2]
            self[16] = array[3]
            self[17] = array[4]
         case 14:
            self[14] = array[0]
            self[15] = array[1]
            self[16] = array[2]
            self[17] = array[3]
            self[18] = array[4]
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
         case 6:
            self[6] = array[0]
            self[7] = array[1]
            self[8] = array[2]
            self[9] = array[3]
            self[10] = array[4]
            self[11] = array[5]
         case 7:
            self[7] = array[0]
            self[8] = array[1]
            self[9] = array[2]
            self[10] = array[3]
            self[11] = array[4]
            self[12] = array[5]
         case 8:
            self[8] = array[0]
            self[9] = array[1]
            self[10] = array[2]
            self[11] = array[3]
            self[12] = array[4]
            self[13] = array[5]
         case 9:
            self[9] = array[0]
            self[10] = array[1]
            self[11] = array[2]
            self[12] = array[3]
            self[13] = array[4]
            self[14] = array[5]
         case 10:
            self[10] = array[0]
            self[11] = array[1]
            self[12] = array[2]
            self[13] = array[3]
            self[14] = array[4]
            self[15] = array[5]
         case 11:
            self[11] = array[0]
            self[12] = array[1]
            self[13] = array[2]
            self[14] = array[3]
            self[15] = array[4]
            self[16] = array[5]
         case 12:
            self[12] = array[0]
            self[13] = array[1]
            self[14] = array[2]
            self[15] = array[3]
            self[16] = array[4]
            self[17] = array[5]
         case 13:
            self[13] = array[0]
            self[14] = array[1]
            self[15] = array[2]
            self[16] = array[3]
            self[17] = array[4]
            self[18] = array[5]
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
         case 5:
            self[5] = array[0]
            self[6] = array[1]
            self[7] = array[2]
            self[8] = array[3]
            self[9] = array[4]
            self[10] = array[5]
            self[11] = array[6]
         case 6:
            self[6] = array[0]
            self[7] = array[1]
            self[8] = array[2]
            self[9] = array[3]
            self[10] = array[4]
            self[11] = array[5]
            self[12] = array[6]
         case 7:
            self[7] = array[0]
            self[8] = array[1]
            self[9] = array[2]
            self[10] = array[3]
            self[11] = array[4]
            self[12] = array[5]
            self[13] = array[6]
         case 8:
            self[8] = array[0]
            self[9] = array[1]
            self[10] = array[2]
            self[11] = array[3]
            self[12] = array[4]
            self[13] = array[5]
            self[14] = array[6]
         case 9:
            self[9] = array[0]
            self[10] = array[1]
            self[11] = array[2]
            self[12] = array[3]
            self[13] = array[4]
            self[14] = array[5]
            self[15] = array[6]
         case 10:
            self[10] = array[0]
            self[11] = array[1]
            self[12] = array[2]
            self[13] = array[3]
            self[14] = array[4]
            self[15] = array[5]
            self[16] = array[6]
         case 11:
            self[11] = array[0]
            self[12] = array[1]
            self[13] = array[2]
            self[14] = array[3]
            self[15] = array[4]
            self[16] = array[5]
            self[17] = array[6]
         case 12:
            self[12] = array[0]
            self[13] = array[1]
            self[14] = array[2]
            self[15] = array[3]
            self[16] = array[4]
            self[17] = array[5]
            self[18] = array[6]
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
         case 4:
            self[4] = array[0]
            self[5] = array[1]
            self[6] = array[2]
            self[7] = array[3]
            self[8] = array[4]
            self[9] = array[5]
            self[10] = array[6]
            self[11] = array[7]
         case 5:
            self[5] = array[0]
            self[6] = array[1]
            self[7] = array[2]
            self[8] = array[3]
            self[9] = array[4]
            self[10] = array[5]
            self[11] = array[6]
            self[12] = array[7]
         case 6:
            self[6] = array[0]
            self[7] = array[1]
            self[8] = array[2]
            self[9] = array[3]
            self[10] = array[4]
            self[11] = array[5]
            self[12] = array[6]
            self[13] = array[7]
         case 7:
            self[7] = array[0]
            self[8] = array[1]
            self[9] = array[2]
            self[10] = array[3]
            self[11] = array[4]
            self[12] = array[5]
            self[13] = array[6]
            self[14] = array[7]
         case 8:
            self[8] = array[0]
            self[9] = array[1]
            self[10] = array[2]
            self[11] = array[3]
            self[12] = array[4]
            self[13] = array[5]
            self[14] = array[6]
            self[15] = array[7]
         case 9:
            self[9] = array[0]
            self[10] = array[1]
            self[11] = array[2]
            self[12] = array[3]
            self[13] = array[4]
            self[14] = array[5]
            self[15] = array[6]
            self[16] = array[7]
         case 10:
            self[10] = array[0]
            self[11] = array[1]
            self[12] = array[2]
            self[13] = array[3]
            self[14] = array[4]
            self[15] = array[5]
            self[16] = array[6]
            self[17] = array[7]
         case 11:
            self[11] = array[0]
            self[12] = array[1]
            self[13] = array[2]
            self[14] = array[3]
            self[15] = array[4]
            self[16] = array[5]
            self[17] = array[6]
            self[18] = array[7]
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
         case 3:
            self[3] = array[0]
            self[4] = array[1]
            self[5] = array[2]
            self[6] = array[3]
            self[7] = array[4]
            self[8] = array[5]
            self[9] = array[6]
            self[10] = array[7]
            self[11] = array[8]
         case 4:
            self[4] = array[0]
            self[5] = array[1]
            self[6] = array[2]
            self[7] = array[3]
            self[8] = array[4]
            self[9] = array[5]
            self[10] = array[6]
            self[11] = array[7]
            self[12] = array[8]
         case 5:
            self[5] = array[0]
            self[6] = array[1]
            self[7] = array[2]
            self[8] = array[3]
            self[9] = array[4]
            self[10] = array[5]
            self[11] = array[6]
            self[12] = array[7]
            self[13] = array[8]
         case 6:
            self[6] = array[0]
            self[7] = array[1]
            self[8] = array[2]
            self[9] = array[3]
            self[10] = array[4]
            self[11] = array[5]
            self[12] = array[6]
            self[13] = array[7]
            self[14] = array[8]
         case 7:
            self[7] = array[0]
            self[8] = array[1]
            self[9] = array[2]
            self[10] = array[3]
            self[11] = array[4]
            self[12] = array[5]
            self[13] = array[6]
            self[14] = array[7]
            self[15] = array[8]
         case 8:
            self[8] = array[0]
            self[9] = array[1]
            self[10] = array[2]
            self[11] = array[3]
            self[12] = array[4]
            self[13] = array[5]
            self[14] = array[6]
            self[15] = array[7]
            self[16] = array[8]
         case 9:
            self[9] = array[0]
            self[10] = array[1]
            self[11] = array[2]
            self[12] = array[3]
            self[13] = array[4]
            self[14] = array[5]
            self[15] = array[6]
            self[16] = array[7]
            self[17] = array[8]
         case 10:
            self[10] = array[0]
            self[11] = array[1]
            self[12] = array[2]
            self[13] = array[3]
            self[14] = array[4]
            self[15] = array[5]
            self[16] = array[6]
            self[17] = array[7]
            self[18] = array[8]
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
            self[11] = array[9]
         case 3:
            self[3] = array[0]
            self[4] = array[1]
            self[5] = array[2]
            self[6] = array[3]
            self[7] = array[4]
            self[8] = array[5]
            self[9] = array[6]
            self[10] = array[7]
            self[11] = array[8]
            self[12] = array[9]
         case 4:
            self[4] = array[0]
            self[5] = array[1]
            self[6] = array[2]
            self[7] = array[3]
            self[8] = array[4]
            self[9] = array[5]
            self[10] = array[6]
            self[11] = array[7]
            self[12] = array[8]
            self[13] = array[9]
         case 5:
            self[5] = array[0]
            self[6] = array[1]
            self[7] = array[2]
            self[8] = array[3]
            self[9] = array[4]
            self[10] = array[5]
            self[11] = array[6]
            self[12] = array[7]
            self[13] = array[8]
            self[14] = array[9]
         case 6:
            self[6] = array[0]
            self[7] = array[1]
            self[8] = array[2]
            self[9] = array[3]
            self[10] = array[4]
            self[11] = array[5]
            self[12] = array[6]
            self[13] = array[7]
            self[14] = array[8]
            self[15] = array[9]
         case 7:
            self[7] = array[0]
            self[8] = array[1]
            self[9] = array[2]
            self[10] = array[3]
            self[11] = array[4]
            self[12] = array[5]
            self[13] = array[6]
            self[14] = array[7]
            self[15] = array[8]
            self[16] = array[9]
         case 8:
            self[8] = array[0]
            self[9] = array[1]
            self[10] = array[2]
            self[11] = array[3]
            self[12] = array[4]
            self[13] = array[5]
            self[14] = array[6]
            self[15] = array[7]
            self[16] = array[8]
            self[17] = array[9]
         case 9:
            self[9] = array[0]
            self[10] = array[1]
            self[11] = array[2]
            self[12] = array[3]
            self[13] = array[4]
            self[14] = array[5]
            self[15] = array[6]
            self[16] = array[7]
            self[17] = array[8]
            self[18] = array[9]
        default:
            fatalError("offset out of available range")
        }
    }

    @inlinable public mutating func set11(_ array: StaticArray11<T>, at offset: Int = 0) {
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
            self[10] = array[10]
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
            self[11] = array[10]
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
            self[11] = array[9]
            self[12] = array[10]
         case 3:
            self[3] = array[0]
            self[4] = array[1]
            self[5] = array[2]
            self[6] = array[3]
            self[7] = array[4]
            self[8] = array[5]
            self[9] = array[6]
            self[10] = array[7]
            self[11] = array[8]
            self[12] = array[9]
            self[13] = array[10]
         case 4:
            self[4] = array[0]
            self[5] = array[1]
            self[6] = array[2]
            self[7] = array[3]
            self[8] = array[4]
            self[9] = array[5]
            self[10] = array[6]
            self[11] = array[7]
            self[12] = array[8]
            self[13] = array[9]
            self[14] = array[10]
         case 5:
            self[5] = array[0]
            self[6] = array[1]
            self[7] = array[2]
            self[8] = array[3]
            self[9] = array[4]
            self[10] = array[5]
            self[11] = array[6]
            self[12] = array[7]
            self[13] = array[8]
            self[14] = array[9]
            self[15] = array[10]
         case 6:
            self[6] = array[0]
            self[7] = array[1]
            self[8] = array[2]
            self[9] = array[3]
            self[10] = array[4]
            self[11] = array[5]
            self[12] = array[6]
            self[13] = array[7]
            self[14] = array[8]
            self[15] = array[9]
            self[16] = array[10]
         case 7:
            self[7] = array[0]
            self[8] = array[1]
            self[9] = array[2]
            self[10] = array[3]
            self[11] = array[4]
            self[12] = array[5]
            self[13] = array[6]
            self[14] = array[7]
            self[15] = array[8]
            self[16] = array[9]
            self[17] = array[10]
         case 8:
            self[8] = array[0]
            self[9] = array[1]
            self[10] = array[2]
            self[11] = array[3]
            self[12] = array[4]
            self[13] = array[5]
            self[14] = array[6]
            self[15] = array[7]
            self[16] = array[8]
            self[17] = array[9]
            self[18] = array[10]
        default:
            fatalError("offset out of available range")
        }
    }

    @inlinable public mutating func set12(_ array: StaticArray12<T>, at offset: Int = 0) {
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
            self[10] = array[10]
            self[11] = array[11]
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
            self[11] = array[10]
            self[12] = array[11]
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
            self[11] = array[9]
            self[12] = array[10]
            self[13] = array[11]
         case 3:
            self[3] = array[0]
            self[4] = array[1]
            self[5] = array[2]
            self[6] = array[3]
            self[7] = array[4]
            self[8] = array[5]
            self[9] = array[6]
            self[10] = array[7]
            self[11] = array[8]
            self[12] = array[9]
            self[13] = array[10]
            self[14] = array[11]
         case 4:
            self[4] = array[0]
            self[5] = array[1]
            self[6] = array[2]
            self[7] = array[3]
            self[8] = array[4]
            self[9] = array[5]
            self[10] = array[6]
            self[11] = array[7]
            self[12] = array[8]
            self[13] = array[9]
            self[14] = array[10]
            self[15] = array[11]
         case 5:
            self[5] = array[0]
            self[6] = array[1]
            self[7] = array[2]
            self[8] = array[3]
            self[9] = array[4]
            self[10] = array[5]
            self[11] = array[6]
            self[12] = array[7]
            self[13] = array[8]
            self[14] = array[9]
            self[15] = array[10]
            self[16] = array[11]
         case 6:
            self[6] = array[0]
            self[7] = array[1]
            self[8] = array[2]
            self[9] = array[3]
            self[10] = array[4]
            self[11] = array[5]
            self[12] = array[6]
            self[13] = array[7]
            self[14] = array[8]
            self[15] = array[9]
            self[16] = array[10]
            self[17] = array[11]
         case 7:
            self[7] = array[0]
            self[8] = array[1]
            self[9] = array[2]
            self[10] = array[3]
            self[11] = array[4]
            self[12] = array[5]
            self[13] = array[6]
            self[14] = array[7]
            self[15] = array[8]
            self[16] = array[9]
            self[17] = array[10]
            self[18] = array[11]
        default:
            fatalError("offset out of available range")
        }
    }

    @inlinable public mutating func set13(_ array: StaticArray13<T>, at offset: Int = 0) {
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
            self[10] = array[10]
            self[11] = array[11]
            self[12] = array[12]
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
            self[11] = array[10]
            self[12] = array[11]
            self[13] = array[12]
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
            self[11] = array[9]
            self[12] = array[10]
            self[13] = array[11]
            self[14] = array[12]
         case 3:
            self[3] = array[0]
            self[4] = array[1]
            self[5] = array[2]
            self[6] = array[3]
            self[7] = array[4]
            self[8] = array[5]
            self[9] = array[6]
            self[10] = array[7]
            self[11] = array[8]
            self[12] = array[9]
            self[13] = array[10]
            self[14] = array[11]
            self[15] = array[12]
         case 4:
            self[4] = array[0]
            self[5] = array[1]
            self[6] = array[2]
            self[7] = array[3]
            self[8] = array[4]
            self[9] = array[5]
            self[10] = array[6]
            self[11] = array[7]
            self[12] = array[8]
            self[13] = array[9]
            self[14] = array[10]
            self[15] = array[11]
            self[16] = array[12]
         case 5:
            self[5] = array[0]
            self[6] = array[1]
            self[7] = array[2]
            self[8] = array[3]
            self[9] = array[4]
            self[10] = array[5]
            self[11] = array[6]
            self[12] = array[7]
            self[13] = array[8]
            self[14] = array[9]
            self[15] = array[10]
            self[16] = array[11]
            self[17] = array[12]
         case 6:
            self[6] = array[0]
            self[7] = array[1]
            self[8] = array[2]
            self[9] = array[3]
            self[10] = array[4]
            self[11] = array[5]
            self[12] = array[6]
            self[13] = array[7]
            self[14] = array[8]
            self[15] = array[9]
            self[16] = array[10]
            self[17] = array[11]
            self[18] = array[12]
        default:
            fatalError("offset out of available range")
        }
    }

    @inlinable public mutating func set14(_ array: StaticArray14<T>, at offset: Int = 0) {
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
            self[10] = array[10]
            self[11] = array[11]
            self[12] = array[12]
            self[13] = array[13]
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
            self[11] = array[10]
            self[12] = array[11]
            self[13] = array[12]
            self[14] = array[13]
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
            self[11] = array[9]
            self[12] = array[10]
            self[13] = array[11]
            self[14] = array[12]
            self[15] = array[13]
         case 3:
            self[3] = array[0]
            self[4] = array[1]
            self[5] = array[2]
            self[6] = array[3]
            self[7] = array[4]
            self[8] = array[5]
            self[9] = array[6]
            self[10] = array[7]
            self[11] = array[8]
            self[12] = array[9]
            self[13] = array[10]
            self[14] = array[11]
            self[15] = array[12]
            self[16] = array[13]
         case 4:
            self[4] = array[0]
            self[5] = array[1]
            self[6] = array[2]
            self[7] = array[3]
            self[8] = array[4]
            self[9] = array[5]
            self[10] = array[6]
            self[11] = array[7]
            self[12] = array[8]
            self[13] = array[9]
            self[14] = array[10]
            self[15] = array[11]
            self[16] = array[12]
            self[17] = array[13]
         case 5:
            self[5] = array[0]
            self[6] = array[1]
            self[7] = array[2]
            self[8] = array[3]
            self[9] = array[4]
            self[10] = array[5]
            self[11] = array[6]
            self[12] = array[7]
            self[13] = array[8]
            self[14] = array[9]
            self[15] = array[10]
            self[16] = array[11]
            self[17] = array[12]
            self[18] = array[13]
        default:
            fatalError("offset out of available range")
        }
    }

    @inlinable public mutating func set15(_ array: StaticArray15<T>, at offset: Int = 0) {
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
            self[10] = array[10]
            self[11] = array[11]
            self[12] = array[12]
            self[13] = array[13]
            self[14] = array[14]
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
            self[11] = array[10]
            self[12] = array[11]
            self[13] = array[12]
            self[14] = array[13]
            self[15] = array[14]
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
            self[11] = array[9]
            self[12] = array[10]
            self[13] = array[11]
            self[14] = array[12]
            self[15] = array[13]
            self[16] = array[14]
         case 3:
            self[3] = array[0]
            self[4] = array[1]
            self[5] = array[2]
            self[6] = array[3]
            self[7] = array[4]
            self[8] = array[5]
            self[9] = array[6]
            self[10] = array[7]
            self[11] = array[8]
            self[12] = array[9]
            self[13] = array[10]
            self[14] = array[11]
            self[15] = array[12]
            self[16] = array[13]
            self[17] = array[14]
         case 4:
            self[4] = array[0]
            self[5] = array[1]
            self[6] = array[2]
            self[7] = array[3]
            self[8] = array[4]
            self[9] = array[5]
            self[10] = array[6]
            self[11] = array[7]
            self[12] = array[8]
            self[13] = array[9]
            self[14] = array[10]
            self[15] = array[11]
            self[16] = array[12]
            self[17] = array[13]
            self[18] = array[14]
        default:
            fatalError("offset out of available range")
        }
    }

    @inlinable public mutating func set16(_ array: StaticArray16<T>, at offset: Int = 0) {
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
            self[10] = array[10]
            self[11] = array[11]
            self[12] = array[12]
            self[13] = array[13]
            self[14] = array[14]
            self[15] = array[15]
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
            self[11] = array[10]
            self[12] = array[11]
            self[13] = array[12]
            self[14] = array[13]
            self[15] = array[14]
            self[16] = array[15]
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
            self[11] = array[9]
            self[12] = array[10]
            self[13] = array[11]
            self[14] = array[12]
            self[15] = array[13]
            self[16] = array[14]
            self[17] = array[15]
         case 3:
            self[3] = array[0]
            self[4] = array[1]
            self[5] = array[2]
            self[6] = array[3]
            self[7] = array[4]
            self[8] = array[5]
            self[9] = array[6]
            self[10] = array[7]
            self[11] = array[8]
            self[12] = array[9]
            self[13] = array[10]
            self[14] = array[11]
            self[15] = array[12]
            self[16] = array[13]
            self[17] = array[14]
            self[18] = array[15]
        default:
            fatalError("offset out of available range")
        }
    }

    @inlinable public mutating func set17(_ array: StaticArray17<T>, at offset: Int = 0) {
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
            self[10] = array[10]
            self[11] = array[11]
            self[12] = array[12]
            self[13] = array[13]
            self[14] = array[14]
            self[15] = array[15]
            self[16] = array[16]
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
            self[11] = array[10]
            self[12] = array[11]
            self[13] = array[12]
            self[14] = array[13]
            self[15] = array[14]
            self[16] = array[15]
            self[17] = array[16]
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
            self[11] = array[9]
            self[12] = array[10]
            self[13] = array[11]
            self[14] = array[12]
            self[15] = array[13]
            self[16] = array[14]
            self[17] = array[15]
            self[18] = array[16]
        default:
            fatalError("offset out of available range")
        }
    }

    @inlinable public mutating func set18(_ array: StaticArray18<T>, at offset: Int = 0) {
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
            self[10] = array[10]
            self[11] = array[11]
            self[12] = array[12]
            self[13] = array[13]
            self[14] = array[14]
            self[15] = array[15]
            self[16] = array[16]
            self[17] = array[17]
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
            self[11] = array[10]
            self[12] = array[11]
            self[13] = array[12]
            self[14] = array[13]
            self[15] = array[14]
            self[16] = array[15]
            self[17] = array[16]
            self[18] = array[17]
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
            self[10],
            self[11],
            self[12],
            self[13],
            self[14],
            self[15],
            self[16],
            self[17],
            self[18]
        ]
    }

    @inlinable public func map<M>(_ transform: (T) throws -> M) rethrows -> StaticArray19<M> {
        try StaticArray19<M>(values: (
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
            transform(self[10]),
            transform(self[11]),
            transform(self[12]),
            transform(self[13]),
            transform(self[14]),
            transform(self[15]),
            transform(self[16]),
            transform(self[17]),
            transform(self[18])
        ))
    }
}

public func zip<L, R>(_ lhs: StaticArray19<L>, _ rhs: StaticArray19<R>) -> StaticArray19<(L, R)> {
    StaticArray19(values: (
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
        (lhs[10], rhs[10]),
        (lhs[11], rhs[11]),
        (lhs[12], rhs[12]),
        (lhs[13], rhs[13]),
        (lhs[14], rhs[14]),
        (lhs[15], rhs[15]),
        (lhs[16], rhs[16]),
        (lhs[17], rhs[17]),
        (lhs[18], rhs[18])
    ))
}

extension StaticArray19: Collection {
    public typealias Index = Int
    public var startIndex: Index { 0 }
    public var endIndex: Index { 19 }
    @inlinable public func index(after i: Index) -> Index { i + 1 }
}

extension StaticArray19: Sequence {
    public struct Iterator: IteratorProtocol {
        private var index = 0
        private let array: StaticArray19<T>

        init(_ array: StaticArray19<T>) {
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

extension StaticArray19: Equatable where T: Equatable {
    @inlinable public static func == (lhs: Self, rhs: Self) -> Bool {
        zip(lhs, rhs).allSatisfy { $0.0 == $0.1 }
    }
}

extension StaticArray19: Codable where T: Codable {
    public init(from decoder: Decoder) throws {
        try self.init(array: [T](from: decoder))
    }

    public func encode(to encoder: Encoder) throws {
        try self.toArray().encode(to: encoder)
    }
}

extension StaticArray19: AdditiveArithmetic where T: AdditiveArithmetic {
    @inlinable public static func - (lhs: Self, rhs: Self) -> Self {
        zip(lhs, rhs).map { $0.0 - $0.1 }
    }

    @inlinable public static func + (lhs: Self, rhs: Self) -> Self {
        zip(lhs, rhs).map { $0.0 + $0.1 }
    }

    @inlinable public static var zero: Self { Self(repeating: T.zero) }
}

@inlinable public func + <T>(lhs: StaticArray19<T>, rhs: T) -> StaticArray19<T> where T: AdditiveArithmetic {
    lhs.map { $0 + rhs }
}

@inlinable public func + <T>(lhs: T, rhs: StaticArray19<T>) -> StaticArray19<T> where T: AdditiveArithmetic {
    rhs.map { lhs + $0 }
}

@inlinable public func - <T>(lhs: StaticArray19<T>, rhs: T) -> StaticArray19<T> where T: AdditiveArithmetic {
    lhs.map { $0 - rhs }
}

@inlinable public func - <T>(lhs: T, rhs: StaticArray19<T>) -> StaticArray19<T> where T: AdditiveArithmetic {
    rhs.map { lhs - $0 }
}

extension StaticArray19: Divisible where T: Divisible {
    @inlinable public static func / (lhs: Self, rhs: Self) -> Self {
        zip(lhs, rhs).map { $0.0 / $0.1 }
    }
}

@inlinable public func / <T>(lhs: StaticArray19<T>, rhs: T) -> StaticArray19<T> where T: Divisible {
    lhs.map { $0 / rhs }
}

@inlinable public func / <T>(lhs: T, rhs: StaticArray19<T>) -> StaticArray19<T> where T: Divisible {
    rhs.map { lhs / $0 }
}

extension StaticArray19: Multipliable where T: Multipliable {
    @inlinable public static func * (lhs: Self, rhs: Self) -> Self {
        zip(lhs, rhs).map { $0.0 * $0.1 }
    }
}

@inlinable public func * <T>(lhs: StaticArray19<T>, rhs: T) -> StaticArray19<T> where T: Multipliable {
    lhs.map { $0 * rhs }
}

@inlinable public func * <T>(lhs: T, rhs: StaticArray19<T>) -> StaticArray19<T> where T: Multipliable {
    rhs.map { lhs * $0 }
}

extension StaticArray19: ABSComputable where T: ABSComputable {
    @inlinable public func abs() -> Self {
        self.map { $0.abs() }
    }
}

public struct StaticArray20<T> {
    public typealias Values = (T, T, T, T, T, T, T, T, T, T, T, T, T, T, T, T, T, T, T, T)

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

    init(array: [T]) throws {
        guard array.count == 20 else { fatalError("array size mismatch") }
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
            array[10],
            array[11],
            array[12],
            array[13],
            array[14],
            array[15],
            array[16],
            array[17],
            array[18],
            array[19]
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
            case 11: return self.values.11
            case 12: return self.values.12
            case 13: return self.values.13
            case 14: return self.values.14
            case 15: return self.values.15
            case 16: return self.values.16
            case 17: return self.values.17
            case 18: return self.values.18
            case 19: return self.values.19
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
            case 11: self.values.11 = newValue
            case 12: self.values.12 = newValue
            case 13: self.values.13 = newValue
            case 14: self.values.14 = newValue
            case 15: self.values.15 = newValue
            case 16: self.values.16 = newValue
            case 17: self.values.17 = newValue
            case 18: self.values.18 = newValue
            case 19: self.values.19 = newValue
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
         case 10:
            return StaticArray2(values: (
                self[10],
                self[11]
            ))
         case 11:
            return StaticArray2(values: (
                self[11],
                self[12]
            ))
         case 12:
            return StaticArray2(values: (
                self[12],
                self[13]
            ))
         case 13:
            return StaticArray2(values: (
                self[13],
                self[14]
            ))
         case 14:
            return StaticArray2(values: (
                self[14],
                self[15]
            ))
         case 15:
            return StaticArray2(values: (
                self[15],
                self[16]
            ))
         case 16:
            return StaticArray2(values: (
                self[16],
                self[17]
            ))
         case 17:
            return StaticArray2(values: (
                self[17],
                self[18]
            ))
         case 18:
            return StaticArray2(values: (
                self[18],
                self[19]
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
         case 9:
            return StaticArray3(values: (
                self[9],
                self[10],
                self[11]
            ))
         case 10:
            return StaticArray3(values: (
                self[10],
                self[11],
                self[12]
            ))
         case 11:
            return StaticArray3(values: (
                self[11],
                self[12],
                self[13]
            ))
         case 12:
            return StaticArray3(values: (
                self[12],
                self[13],
                self[14]
            ))
         case 13:
            return StaticArray3(values: (
                self[13],
                self[14],
                self[15]
            ))
         case 14:
            return StaticArray3(values: (
                self[14],
                self[15],
                self[16]
            ))
         case 15:
            return StaticArray3(values: (
                self[15],
                self[16],
                self[17]
            ))
         case 16:
            return StaticArray3(values: (
                self[16],
                self[17],
                self[18]
            ))
         case 17:
            return StaticArray3(values: (
                self[17],
                self[18],
                self[19]
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
         case 8:
            return StaticArray4(values: (
                self[8],
                self[9],
                self[10],
                self[11]
            ))
         case 9:
            return StaticArray4(values: (
                self[9],
                self[10],
                self[11],
                self[12]
            ))
         case 10:
            return StaticArray4(values: (
                self[10],
                self[11],
                self[12],
                self[13]
            ))
         case 11:
            return StaticArray4(values: (
                self[11],
                self[12],
                self[13],
                self[14]
            ))
         case 12:
            return StaticArray4(values: (
                self[12],
                self[13],
                self[14],
                self[15]
            ))
         case 13:
            return StaticArray4(values: (
                self[13],
                self[14],
                self[15],
                self[16]
            ))
         case 14:
            return StaticArray4(values: (
                self[14],
                self[15],
                self[16],
                self[17]
            ))
         case 15:
            return StaticArray4(values: (
                self[15],
                self[16],
                self[17],
                self[18]
            ))
         case 16:
            return StaticArray4(values: (
                self[16],
                self[17],
                self[18],
                self[19]
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
         case 7:
            return StaticArray5(values: (
                self[7],
                self[8],
                self[9],
                self[10],
                self[11]
            ))
         case 8:
            return StaticArray5(values: (
                self[8],
                self[9],
                self[10],
                self[11],
                self[12]
            ))
         case 9:
            return StaticArray5(values: (
                self[9],
                self[10],
                self[11],
                self[12],
                self[13]
            ))
         case 10:
            return StaticArray5(values: (
                self[10],
                self[11],
                self[12],
                self[13],
                self[14]
            ))
         case 11:
            return StaticArray5(values: (
                self[11],
                self[12],
                self[13],
                self[14],
                self[15]
            ))
         case 12:
            return StaticArray5(values: (
                self[12],
                self[13],
                self[14],
                self[15],
                self[16]
            ))
         case 13:
            return StaticArray5(values: (
                self[13],
                self[14],
                self[15],
                self[16],
                self[17]
            ))
         case 14:
            return StaticArray5(values: (
                self[14],
                self[15],
                self[16],
                self[17],
                self[18]
            ))
         case 15:
            return StaticArray5(values: (
                self[15],
                self[16],
                self[17],
                self[18],
                self[19]
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
         case 6:
            return StaticArray6(values: (
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11]
            ))
         case 7:
            return StaticArray6(values: (
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12]
            ))
         case 8:
            return StaticArray6(values: (
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13]
            ))
         case 9:
            return StaticArray6(values: (
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14]
            ))
         case 10:
            return StaticArray6(values: (
                self[10],
                self[11],
                self[12],
                self[13],
                self[14],
                self[15]
            ))
         case 11:
            return StaticArray6(values: (
                self[11],
                self[12],
                self[13],
                self[14],
                self[15],
                self[16]
            ))
         case 12:
            return StaticArray6(values: (
                self[12],
                self[13],
                self[14],
                self[15],
                self[16],
                self[17]
            ))
         case 13:
            return StaticArray6(values: (
                self[13],
                self[14],
                self[15],
                self[16],
                self[17],
                self[18]
            ))
         case 14:
            return StaticArray6(values: (
                self[14],
                self[15],
                self[16],
                self[17],
                self[18],
                self[19]
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
         case 5:
            return StaticArray7(values: (
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11]
            ))
         case 6:
            return StaticArray7(values: (
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12]
            ))
         case 7:
            return StaticArray7(values: (
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13]
            ))
         case 8:
            return StaticArray7(values: (
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14]
            ))
         case 9:
            return StaticArray7(values: (
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14],
                self[15]
            ))
         case 10:
            return StaticArray7(values: (
                self[10],
                self[11],
                self[12],
                self[13],
                self[14],
                self[15],
                self[16]
            ))
         case 11:
            return StaticArray7(values: (
                self[11],
                self[12],
                self[13],
                self[14],
                self[15],
                self[16],
                self[17]
            ))
         case 12:
            return StaticArray7(values: (
                self[12],
                self[13],
                self[14],
                self[15],
                self[16],
                self[17],
                self[18]
            ))
         case 13:
            return StaticArray7(values: (
                self[13],
                self[14],
                self[15],
                self[16],
                self[17],
                self[18],
                self[19]
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
         case 4:
            return StaticArray8(values: (
                self[4],
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11]
            ))
         case 5:
            return StaticArray8(values: (
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12]
            ))
         case 6:
            return StaticArray8(values: (
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13]
            ))
         case 7:
            return StaticArray8(values: (
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14]
            ))
         case 8:
            return StaticArray8(values: (
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14],
                self[15]
            ))
         case 9:
            return StaticArray8(values: (
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14],
                self[15],
                self[16]
            ))
         case 10:
            return StaticArray8(values: (
                self[10],
                self[11],
                self[12],
                self[13],
                self[14],
                self[15],
                self[16],
                self[17]
            ))
         case 11:
            return StaticArray8(values: (
                self[11],
                self[12],
                self[13],
                self[14],
                self[15],
                self[16],
                self[17],
                self[18]
            ))
         case 12:
            return StaticArray8(values: (
                self[12],
                self[13],
                self[14],
                self[15],
                self[16],
                self[17],
                self[18],
                self[19]
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
         case 3:
            return StaticArray9(values: (
                self[3],
                self[4],
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11]
            ))
         case 4:
            return StaticArray9(values: (
                self[4],
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12]
            ))
         case 5:
            return StaticArray9(values: (
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13]
            ))
         case 6:
            return StaticArray9(values: (
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14]
            ))
         case 7:
            return StaticArray9(values: (
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14],
                self[15]
            ))
         case 8:
            return StaticArray9(values: (
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14],
                self[15],
                self[16]
            ))
         case 9:
            return StaticArray9(values: (
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14],
                self[15],
                self[16],
                self[17]
            ))
         case 10:
            return StaticArray9(values: (
                self[10],
                self[11],
                self[12],
                self[13],
                self[14],
                self[15],
                self[16],
                self[17],
                self[18]
            ))
         case 11:
            return StaticArray9(values: (
                self[11],
                self[12],
                self[13],
                self[14],
                self[15],
                self[16],
                self[17],
                self[18],
                self[19]
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
         case 2:
            return StaticArray10(values: (
                self[2],
                self[3],
                self[4],
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11]
            ))
         case 3:
            return StaticArray10(values: (
                self[3],
                self[4],
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12]
            ))
         case 4:
            return StaticArray10(values: (
                self[4],
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13]
            ))
         case 5:
            return StaticArray10(values: (
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14]
            ))
         case 6:
            return StaticArray10(values: (
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14],
                self[15]
            ))
         case 7:
            return StaticArray10(values: (
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14],
                self[15],
                self[16]
            ))
         case 8:
            return StaticArray10(values: (
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14],
                self[15],
                self[16],
                self[17]
            ))
         case 9:
            return StaticArray10(values: (
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14],
                self[15],
                self[16],
                self[17],
                self[18]
            ))
         case 10:
            return StaticArray10(values: (
                self[10],
                self[11],
                self[12],
                self[13],
                self[14],
                self[15],
                self[16],
                self[17],
                self[18],
                self[19]
            ))
        default:
            fatalError("offset out of available range")
        }
    }

    @inlinable public func get11(from offset: Int = 0) ->  StaticArray11<T> {
        switch offset {
         case 0:
            return StaticArray11(values: (
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
            ))
         case 1:
            return StaticArray11(values: (
                self[1],
                self[2],
                self[3],
                self[4],
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11]
            ))
         case 2:
            return StaticArray11(values: (
                self[2],
                self[3],
                self[4],
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12]
            ))
         case 3:
            return StaticArray11(values: (
                self[3],
                self[4],
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13]
            ))
         case 4:
            return StaticArray11(values: (
                self[4],
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14]
            ))
         case 5:
            return StaticArray11(values: (
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14],
                self[15]
            ))
         case 6:
            return StaticArray11(values: (
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14],
                self[15],
                self[16]
            ))
         case 7:
            return StaticArray11(values: (
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14],
                self[15],
                self[16],
                self[17]
            ))
         case 8:
            return StaticArray11(values: (
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14],
                self[15],
                self[16],
                self[17],
                self[18]
            ))
         case 9:
            return StaticArray11(values: (
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14],
                self[15],
                self[16],
                self[17],
                self[18],
                self[19]
            ))
        default:
            fatalError("offset out of available range")
        }
    }

    @inlinable public func get12(from offset: Int = 0) ->  StaticArray12<T> {
        switch offset {
         case 0:
            return StaticArray12(values: (
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
                self[10],
                self[11]
            ))
         case 1:
            return StaticArray12(values: (
                self[1],
                self[2],
                self[3],
                self[4],
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12]
            ))
         case 2:
            return StaticArray12(values: (
                self[2],
                self[3],
                self[4],
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13]
            ))
         case 3:
            return StaticArray12(values: (
                self[3],
                self[4],
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14]
            ))
         case 4:
            return StaticArray12(values: (
                self[4],
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14],
                self[15]
            ))
         case 5:
            return StaticArray12(values: (
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14],
                self[15],
                self[16]
            ))
         case 6:
            return StaticArray12(values: (
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14],
                self[15],
                self[16],
                self[17]
            ))
         case 7:
            return StaticArray12(values: (
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14],
                self[15],
                self[16],
                self[17],
                self[18]
            ))
         case 8:
            return StaticArray12(values: (
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14],
                self[15],
                self[16],
                self[17],
                self[18],
                self[19]
            ))
        default:
            fatalError("offset out of available range")
        }
    }

    @inlinable public func get13(from offset: Int = 0) ->  StaticArray13<T> {
        switch offset {
         case 0:
            return StaticArray13(values: (
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
                self[10],
                self[11],
                self[12]
            ))
         case 1:
            return StaticArray13(values: (
                self[1],
                self[2],
                self[3],
                self[4],
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13]
            ))
         case 2:
            return StaticArray13(values: (
                self[2],
                self[3],
                self[4],
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14]
            ))
         case 3:
            return StaticArray13(values: (
                self[3],
                self[4],
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14],
                self[15]
            ))
         case 4:
            return StaticArray13(values: (
                self[4],
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14],
                self[15],
                self[16]
            ))
         case 5:
            return StaticArray13(values: (
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14],
                self[15],
                self[16],
                self[17]
            ))
         case 6:
            return StaticArray13(values: (
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14],
                self[15],
                self[16],
                self[17],
                self[18]
            ))
         case 7:
            return StaticArray13(values: (
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14],
                self[15],
                self[16],
                self[17],
                self[18],
                self[19]
            ))
        default:
            fatalError("offset out of available range")
        }
    }

    @inlinable public func get14(from offset: Int = 0) ->  StaticArray14<T> {
        switch offset {
         case 0:
            return StaticArray14(values: (
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
                self[10],
                self[11],
                self[12],
                self[13]
            ))
         case 1:
            return StaticArray14(values: (
                self[1],
                self[2],
                self[3],
                self[4],
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14]
            ))
         case 2:
            return StaticArray14(values: (
                self[2],
                self[3],
                self[4],
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14],
                self[15]
            ))
         case 3:
            return StaticArray14(values: (
                self[3],
                self[4],
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14],
                self[15],
                self[16]
            ))
         case 4:
            return StaticArray14(values: (
                self[4],
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14],
                self[15],
                self[16],
                self[17]
            ))
         case 5:
            return StaticArray14(values: (
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14],
                self[15],
                self[16],
                self[17],
                self[18]
            ))
         case 6:
            return StaticArray14(values: (
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14],
                self[15],
                self[16],
                self[17],
                self[18],
                self[19]
            ))
        default:
            fatalError("offset out of available range")
        }
    }

    @inlinable public func get15(from offset: Int = 0) ->  StaticArray15<T> {
        switch offset {
         case 0:
            return StaticArray15(values: (
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
                self[10],
                self[11],
                self[12],
                self[13],
                self[14]
            ))
         case 1:
            return StaticArray15(values: (
                self[1],
                self[2],
                self[3],
                self[4],
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14],
                self[15]
            ))
         case 2:
            return StaticArray15(values: (
                self[2],
                self[3],
                self[4],
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14],
                self[15],
                self[16]
            ))
         case 3:
            return StaticArray15(values: (
                self[3],
                self[4],
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14],
                self[15],
                self[16],
                self[17]
            ))
         case 4:
            return StaticArray15(values: (
                self[4],
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14],
                self[15],
                self[16],
                self[17],
                self[18]
            ))
         case 5:
            return StaticArray15(values: (
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14],
                self[15],
                self[16],
                self[17],
                self[18],
                self[19]
            ))
        default:
            fatalError("offset out of available range")
        }
    }

    @inlinable public func get16(from offset: Int = 0) ->  StaticArray16<T> {
        switch offset {
         case 0:
            return StaticArray16(values: (
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
                self[10],
                self[11],
                self[12],
                self[13],
                self[14],
                self[15]
            ))
         case 1:
            return StaticArray16(values: (
                self[1],
                self[2],
                self[3],
                self[4],
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14],
                self[15],
                self[16]
            ))
         case 2:
            return StaticArray16(values: (
                self[2],
                self[3],
                self[4],
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14],
                self[15],
                self[16],
                self[17]
            ))
         case 3:
            return StaticArray16(values: (
                self[3],
                self[4],
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14],
                self[15],
                self[16],
                self[17],
                self[18]
            ))
         case 4:
            return StaticArray16(values: (
                self[4],
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14],
                self[15],
                self[16],
                self[17],
                self[18],
                self[19]
            ))
        default:
            fatalError("offset out of available range")
        }
    }

    @inlinable public func get17(from offset: Int = 0) ->  StaticArray17<T> {
        switch offset {
         case 0:
            return StaticArray17(values: (
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
                self[10],
                self[11],
                self[12],
                self[13],
                self[14],
                self[15],
                self[16]
            ))
         case 1:
            return StaticArray17(values: (
                self[1],
                self[2],
                self[3],
                self[4],
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14],
                self[15],
                self[16],
                self[17]
            ))
         case 2:
            return StaticArray17(values: (
                self[2],
                self[3],
                self[4],
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14],
                self[15],
                self[16],
                self[17],
                self[18]
            ))
         case 3:
            return StaticArray17(values: (
                self[3],
                self[4],
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14],
                self[15],
                self[16],
                self[17],
                self[18],
                self[19]
            ))
        default:
            fatalError("offset out of available range")
        }
    }

    @inlinable public func get18(from offset: Int = 0) ->  StaticArray18<T> {
        switch offset {
         case 0:
            return StaticArray18(values: (
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
                self[10],
                self[11],
                self[12],
                self[13],
                self[14],
                self[15],
                self[16],
                self[17]
            ))
         case 1:
            return StaticArray18(values: (
                self[1],
                self[2],
                self[3],
                self[4],
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14],
                self[15],
                self[16],
                self[17],
                self[18]
            ))
         case 2:
            return StaticArray18(values: (
                self[2],
                self[3],
                self[4],
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14],
                self[15],
                self[16],
                self[17],
                self[18],
                self[19]
            ))
        default:
            fatalError("offset out of available range")
        }
    }

    @inlinable public func get19(from offset: Int = 0) ->  StaticArray19<T> {
        switch offset {
         case 0:
            return StaticArray19(values: (
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
                self[10],
                self[11],
                self[12],
                self[13],
                self[14],
                self[15],
                self[16],
                self[17],
                self[18]
            ))
         case 1:
            return StaticArray19(values: (
                self[1],
                self[2],
                self[3],
                self[4],
                self[5],
                self[6],
                self[7],
                self[8],
                self[9],
                self[10],
                self[11],
                self[12],
                self[13],
                self[14],
                self[15],
                self[16],
                self[17],
                self[18],
                self[19]
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
         case 10:
            self[10] = array[0]
            self[11] = array[1]
         case 11:
            self[11] = array[0]
            self[12] = array[1]
         case 12:
            self[12] = array[0]
            self[13] = array[1]
         case 13:
            self[13] = array[0]
            self[14] = array[1]
         case 14:
            self[14] = array[0]
            self[15] = array[1]
         case 15:
            self[15] = array[0]
            self[16] = array[1]
         case 16:
            self[16] = array[0]
            self[17] = array[1]
         case 17:
            self[17] = array[0]
            self[18] = array[1]
         case 18:
            self[18] = array[0]
            self[19] = array[1]
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
         case 9:
            self[9] = array[0]
            self[10] = array[1]
            self[11] = array[2]
         case 10:
            self[10] = array[0]
            self[11] = array[1]
            self[12] = array[2]
         case 11:
            self[11] = array[0]
            self[12] = array[1]
            self[13] = array[2]
         case 12:
            self[12] = array[0]
            self[13] = array[1]
            self[14] = array[2]
         case 13:
            self[13] = array[0]
            self[14] = array[1]
            self[15] = array[2]
         case 14:
            self[14] = array[0]
            self[15] = array[1]
            self[16] = array[2]
         case 15:
            self[15] = array[0]
            self[16] = array[1]
            self[17] = array[2]
         case 16:
            self[16] = array[0]
            self[17] = array[1]
            self[18] = array[2]
         case 17:
            self[17] = array[0]
            self[18] = array[1]
            self[19] = array[2]
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
         case 8:
            self[8] = array[0]
            self[9] = array[1]
            self[10] = array[2]
            self[11] = array[3]
         case 9:
            self[9] = array[0]
            self[10] = array[1]
            self[11] = array[2]
            self[12] = array[3]
         case 10:
            self[10] = array[0]
            self[11] = array[1]
            self[12] = array[2]
            self[13] = array[3]
         case 11:
            self[11] = array[0]
            self[12] = array[1]
            self[13] = array[2]
            self[14] = array[3]
         case 12:
            self[12] = array[0]
            self[13] = array[1]
            self[14] = array[2]
            self[15] = array[3]
         case 13:
            self[13] = array[0]
            self[14] = array[1]
            self[15] = array[2]
            self[16] = array[3]
         case 14:
            self[14] = array[0]
            self[15] = array[1]
            self[16] = array[2]
            self[17] = array[3]
         case 15:
            self[15] = array[0]
            self[16] = array[1]
            self[17] = array[2]
            self[18] = array[3]
         case 16:
            self[16] = array[0]
            self[17] = array[1]
            self[18] = array[2]
            self[19] = array[3]
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
         case 7:
            self[7] = array[0]
            self[8] = array[1]
            self[9] = array[2]
            self[10] = array[3]
            self[11] = array[4]
         case 8:
            self[8] = array[0]
            self[9] = array[1]
            self[10] = array[2]
            self[11] = array[3]
            self[12] = array[4]
         case 9:
            self[9] = array[0]
            self[10] = array[1]
            self[11] = array[2]
            self[12] = array[3]
            self[13] = array[4]
         case 10:
            self[10] = array[0]
            self[11] = array[1]
            self[12] = array[2]
            self[13] = array[3]
            self[14] = array[4]
         case 11:
            self[11] = array[0]
            self[12] = array[1]
            self[13] = array[2]
            self[14] = array[3]
            self[15] = array[4]
         case 12:
            self[12] = array[0]
            self[13] = array[1]
            self[14] = array[2]
            self[15] = array[3]
            self[16] = array[4]
         case 13:
            self[13] = array[0]
            self[14] = array[1]
            self[15] = array[2]
            self[16] = array[3]
            self[17] = array[4]
         case 14:
            self[14] = array[0]
            self[15] = array[1]
            self[16] = array[2]
            self[17] = array[3]
            self[18] = array[4]
         case 15:
            self[15] = array[0]
            self[16] = array[1]
            self[17] = array[2]
            self[18] = array[3]
            self[19] = array[4]
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
         case 6:
            self[6] = array[0]
            self[7] = array[1]
            self[8] = array[2]
            self[9] = array[3]
            self[10] = array[4]
            self[11] = array[5]
         case 7:
            self[7] = array[0]
            self[8] = array[1]
            self[9] = array[2]
            self[10] = array[3]
            self[11] = array[4]
            self[12] = array[5]
         case 8:
            self[8] = array[0]
            self[9] = array[1]
            self[10] = array[2]
            self[11] = array[3]
            self[12] = array[4]
            self[13] = array[5]
         case 9:
            self[9] = array[0]
            self[10] = array[1]
            self[11] = array[2]
            self[12] = array[3]
            self[13] = array[4]
            self[14] = array[5]
         case 10:
            self[10] = array[0]
            self[11] = array[1]
            self[12] = array[2]
            self[13] = array[3]
            self[14] = array[4]
            self[15] = array[5]
         case 11:
            self[11] = array[0]
            self[12] = array[1]
            self[13] = array[2]
            self[14] = array[3]
            self[15] = array[4]
            self[16] = array[5]
         case 12:
            self[12] = array[0]
            self[13] = array[1]
            self[14] = array[2]
            self[15] = array[3]
            self[16] = array[4]
            self[17] = array[5]
         case 13:
            self[13] = array[0]
            self[14] = array[1]
            self[15] = array[2]
            self[16] = array[3]
            self[17] = array[4]
            self[18] = array[5]
         case 14:
            self[14] = array[0]
            self[15] = array[1]
            self[16] = array[2]
            self[17] = array[3]
            self[18] = array[4]
            self[19] = array[5]
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
         case 5:
            self[5] = array[0]
            self[6] = array[1]
            self[7] = array[2]
            self[8] = array[3]
            self[9] = array[4]
            self[10] = array[5]
            self[11] = array[6]
         case 6:
            self[6] = array[0]
            self[7] = array[1]
            self[8] = array[2]
            self[9] = array[3]
            self[10] = array[4]
            self[11] = array[5]
            self[12] = array[6]
         case 7:
            self[7] = array[0]
            self[8] = array[1]
            self[9] = array[2]
            self[10] = array[3]
            self[11] = array[4]
            self[12] = array[5]
            self[13] = array[6]
         case 8:
            self[8] = array[0]
            self[9] = array[1]
            self[10] = array[2]
            self[11] = array[3]
            self[12] = array[4]
            self[13] = array[5]
            self[14] = array[6]
         case 9:
            self[9] = array[0]
            self[10] = array[1]
            self[11] = array[2]
            self[12] = array[3]
            self[13] = array[4]
            self[14] = array[5]
            self[15] = array[6]
         case 10:
            self[10] = array[0]
            self[11] = array[1]
            self[12] = array[2]
            self[13] = array[3]
            self[14] = array[4]
            self[15] = array[5]
            self[16] = array[6]
         case 11:
            self[11] = array[0]
            self[12] = array[1]
            self[13] = array[2]
            self[14] = array[3]
            self[15] = array[4]
            self[16] = array[5]
            self[17] = array[6]
         case 12:
            self[12] = array[0]
            self[13] = array[1]
            self[14] = array[2]
            self[15] = array[3]
            self[16] = array[4]
            self[17] = array[5]
            self[18] = array[6]
         case 13:
            self[13] = array[0]
            self[14] = array[1]
            self[15] = array[2]
            self[16] = array[3]
            self[17] = array[4]
            self[18] = array[5]
            self[19] = array[6]
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
         case 4:
            self[4] = array[0]
            self[5] = array[1]
            self[6] = array[2]
            self[7] = array[3]
            self[8] = array[4]
            self[9] = array[5]
            self[10] = array[6]
            self[11] = array[7]
         case 5:
            self[5] = array[0]
            self[6] = array[1]
            self[7] = array[2]
            self[8] = array[3]
            self[9] = array[4]
            self[10] = array[5]
            self[11] = array[6]
            self[12] = array[7]
         case 6:
            self[6] = array[0]
            self[7] = array[1]
            self[8] = array[2]
            self[9] = array[3]
            self[10] = array[4]
            self[11] = array[5]
            self[12] = array[6]
            self[13] = array[7]
         case 7:
            self[7] = array[0]
            self[8] = array[1]
            self[9] = array[2]
            self[10] = array[3]
            self[11] = array[4]
            self[12] = array[5]
            self[13] = array[6]
            self[14] = array[7]
         case 8:
            self[8] = array[0]
            self[9] = array[1]
            self[10] = array[2]
            self[11] = array[3]
            self[12] = array[4]
            self[13] = array[5]
            self[14] = array[6]
            self[15] = array[7]
         case 9:
            self[9] = array[0]
            self[10] = array[1]
            self[11] = array[2]
            self[12] = array[3]
            self[13] = array[4]
            self[14] = array[5]
            self[15] = array[6]
            self[16] = array[7]
         case 10:
            self[10] = array[0]
            self[11] = array[1]
            self[12] = array[2]
            self[13] = array[3]
            self[14] = array[4]
            self[15] = array[5]
            self[16] = array[6]
            self[17] = array[7]
         case 11:
            self[11] = array[0]
            self[12] = array[1]
            self[13] = array[2]
            self[14] = array[3]
            self[15] = array[4]
            self[16] = array[5]
            self[17] = array[6]
            self[18] = array[7]
         case 12:
            self[12] = array[0]
            self[13] = array[1]
            self[14] = array[2]
            self[15] = array[3]
            self[16] = array[4]
            self[17] = array[5]
            self[18] = array[6]
            self[19] = array[7]
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
         case 3:
            self[3] = array[0]
            self[4] = array[1]
            self[5] = array[2]
            self[6] = array[3]
            self[7] = array[4]
            self[8] = array[5]
            self[9] = array[6]
            self[10] = array[7]
            self[11] = array[8]
         case 4:
            self[4] = array[0]
            self[5] = array[1]
            self[6] = array[2]
            self[7] = array[3]
            self[8] = array[4]
            self[9] = array[5]
            self[10] = array[6]
            self[11] = array[7]
            self[12] = array[8]
         case 5:
            self[5] = array[0]
            self[6] = array[1]
            self[7] = array[2]
            self[8] = array[3]
            self[9] = array[4]
            self[10] = array[5]
            self[11] = array[6]
            self[12] = array[7]
            self[13] = array[8]
         case 6:
            self[6] = array[0]
            self[7] = array[1]
            self[8] = array[2]
            self[9] = array[3]
            self[10] = array[4]
            self[11] = array[5]
            self[12] = array[6]
            self[13] = array[7]
            self[14] = array[8]
         case 7:
            self[7] = array[0]
            self[8] = array[1]
            self[9] = array[2]
            self[10] = array[3]
            self[11] = array[4]
            self[12] = array[5]
            self[13] = array[6]
            self[14] = array[7]
            self[15] = array[8]
         case 8:
            self[8] = array[0]
            self[9] = array[1]
            self[10] = array[2]
            self[11] = array[3]
            self[12] = array[4]
            self[13] = array[5]
            self[14] = array[6]
            self[15] = array[7]
            self[16] = array[8]
         case 9:
            self[9] = array[0]
            self[10] = array[1]
            self[11] = array[2]
            self[12] = array[3]
            self[13] = array[4]
            self[14] = array[5]
            self[15] = array[6]
            self[16] = array[7]
            self[17] = array[8]
         case 10:
            self[10] = array[0]
            self[11] = array[1]
            self[12] = array[2]
            self[13] = array[3]
            self[14] = array[4]
            self[15] = array[5]
            self[16] = array[6]
            self[17] = array[7]
            self[18] = array[8]
         case 11:
            self[11] = array[0]
            self[12] = array[1]
            self[13] = array[2]
            self[14] = array[3]
            self[15] = array[4]
            self[16] = array[5]
            self[17] = array[6]
            self[18] = array[7]
            self[19] = array[8]
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
            self[11] = array[9]
         case 3:
            self[3] = array[0]
            self[4] = array[1]
            self[5] = array[2]
            self[6] = array[3]
            self[7] = array[4]
            self[8] = array[5]
            self[9] = array[6]
            self[10] = array[7]
            self[11] = array[8]
            self[12] = array[9]
         case 4:
            self[4] = array[0]
            self[5] = array[1]
            self[6] = array[2]
            self[7] = array[3]
            self[8] = array[4]
            self[9] = array[5]
            self[10] = array[6]
            self[11] = array[7]
            self[12] = array[8]
            self[13] = array[9]
         case 5:
            self[5] = array[0]
            self[6] = array[1]
            self[7] = array[2]
            self[8] = array[3]
            self[9] = array[4]
            self[10] = array[5]
            self[11] = array[6]
            self[12] = array[7]
            self[13] = array[8]
            self[14] = array[9]
         case 6:
            self[6] = array[0]
            self[7] = array[1]
            self[8] = array[2]
            self[9] = array[3]
            self[10] = array[4]
            self[11] = array[5]
            self[12] = array[6]
            self[13] = array[7]
            self[14] = array[8]
            self[15] = array[9]
         case 7:
            self[7] = array[0]
            self[8] = array[1]
            self[9] = array[2]
            self[10] = array[3]
            self[11] = array[4]
            self[12] = array[5]
            self[13] = array[6]
            self[14] = array[7]
            self[15] = array[8]
            self[16] = array[9]
         case 8:
            self[8] = array[0]
            self[9] = array[1]
            self[10] = array[2]
            self[11] = array[3]
            self[12] = array[4]
            self[13] = array[5]
            self[14] = array[6]
            self[15] = array[7]
            self[16] = array[8]
            self[17] = array[9]
         case 9:
            self[9] = array[0]
            self[10] = array[1]
            self[11] = array[2]
            self[12] = array[3]
            self[13] = array[4]
            self[14] = array[5]
            self[15] = array[6]
            self[16] = array[7]
            self[17] = array[8]
            self[18] = array[9]
         case 10:
            self[10] = array[0]
            self[11] = array[1]
            self[12] = array[2]
            self[13] = array[3]
            self[14] = array[4]
            self[15] = array[5]
            self[16] = array[6]
            self[17] = array[7]
            self[18] = array[8]
            self[19] = array[9]
        default:
            fatalError("offset out of available range")
        }
    }

    @inlinable public mutating func set11(_ array: StaticArray11<T>, at offset: Int = 0) {
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
            self[10] = array[10]
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
            self[11] = array[10]
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
            self[11] = array[9]
            self[12] = array[10]
         case 3:
            self[3] = array[0]
            self[4] = array[1]
            self[5] = array[2]
            self[6] = array[3]
            self[7] = array[4]
            self[8] = array[5]
            self[9] = array[6]
            self[10] = array[7]
            self[11] = array[8]
            self[12] = array[9]
            self[13] = array[10]
         case 4:
            self[4] = array[0]
            self[5] = array[1]
            self[6] = array[2]
            self[7] = array[3]
            self[8] = array[4]
            self[9] = array[5]
            self[10] = array[6]
            self[11] = array[7]
            self[12] = array[8]
            self[13] = array[9]
            self[14] = array[10]
         case 5:
            self[5] = array[0]
            self[6] = array[1]
            self[7] = array[2]
            self[8] = array[3]
            self[9] = array[4]
            self[10] = array[5]
            self[11] = array[6]
            self[12] = array[7]
            self[13] = array[8]
            self[14] = array[9]
            self[15] = array[10]
         case 6:
            self[6] = array[0]
            self[7] = array[1]
            self[8] = array[2]
            self[9] = array[3]
            self[10] = array[4]
            self[11] = array[5]
            self[12] = array[6]
            self[13] = array[7]
            self[14] = array[8]
            self[15] = array[9]
            self[16] = array[10]
         case 7:
            self[7] = array[0]
            self[8] = array[1]
            self[9] = array[2]
            self[10] = array[3]
            self[11] = array[4]
            self[12] = array[5]
            self[13] = array[6]
            self[14] = array[7]
            self[15] = array[8]
            self[16] = array[9]
            self[17] = array[10]
         case 8:
            self[8] = array[0]
            self[9] = array[1]
            self[10] = array[2]
            self[11] = array[3]
            self[12] = array[4]
            self[13] = array[5]
            self[14] = array[6]
            self[15] = array[7]
            self[16] = array[8]
            self[17] = array[9]
            self[18] = array[10]
         case 9:
            self[9] = array[0]
            self[10] = array[1]
            self[11] = array[2]
            self[12] = array[3]
            self[13] = array[4]
            self[14] = array[5]
            self[15] = array[6]
            self[16] = array[7]
            self[17] = array[8]
            self[18] = array[9]
            self[19] = array[10]
        default:
            fatalError("offset out of available range")
        }
    }

    @inlinable public mutating func set12(_ array: StaticArray12<T>, at offset: Int = 0) {
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
            self[10] = array[10]
            self[11] = array[11]
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
            self[11] = array[10]
            self[12] = array[11]
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
            self[11] = array[9]
            self[12] = array[10]
            self[13] = array[11]
         case 3:
            self[3] = array[0]
            self[4] = array[1]
            self[5] = array[2]
            self[6] = array[3]
            self[7] = array[4]
            self[8] = array[5]
            self[9] = array[6]
            self[10] = array[7]
            self[11] = array[8]
            self[12] = array[9]
            self[13] = array[10]
            self[14] = array[11]
         case 4:
            self[4] = array[0]
            self[5] = array[1]
            self[6] = array[2]
            self[7] = array[3]
            self[8] = array[4]
            self[9] = array[5]
            self[10] = array[6]
            self[11] = array[7]
            self[12] = array[8]
            self[13] = array[9]
            self[14] = array[10]
            self[15] = array[11]
         case 5:
            self[5] = array[0]
            self[6] = array[1]
            self[7] = array[2]
            self[8] = array[3]
            self[9] = array[4]
            self[10] = array[5]
            self[11] = array[6]
            self[12] = array[7]
            self[13] = array[8]
            self[14] = array[9]
            self[15] = array[10]
            self[16] = array[11]
         case 6:
            self[6] = array[0]
            self[7] = array[1]
            self[8] = array[2]
            self[9] = array[3]
            self[10] = array[4]
            self[11] = array[5]
            self[12] = array[6]
            self[13] = array[7]
            self[14] = array[8]
            self[15] = array[9]
            self[16] = array[10]
            self[17] = array[11]
         case 7:
            self[7] = array[0]
            self[8] = array[1]
            self[9] = array[2]
            self[10] = array[3]
            self[11] = array[4]
            self[12] = array[5]
            self[13] = array[6]
            self[14] = array[7]
            self[15] = array[8]
            self[16] = array[9]
            self[17] = array[10]
            self[18] = array[11]
         case 8:
            self[8] = array[0]
            self[9] = array[1]
            self[10] = array[2]
            self[11] = array[3]
            self[12] = array[4]
            self[13] = array[5]
            self[14] = array[6]
            self[15] = array[7]
            self[16] = array[8]
            self[17] = array[9]
            self[18] = array[10]
            self[19] = array[11]
        default:
            fatalError("offset out of available range")
        }
    }

    @inlinable public mutating func set13(_ array: StaticArray13<T>, at offset: Int = 0) {
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
            self[10] = array[10]
            self[11] = array[11]
            self[12] = array[12]
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
            self[11] = array[10]
            self[12] = array[11]
            self[13] = array[12]
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
            self[11] = array[9]
            self[12] = array[10]
            self[13] = array[11]
            self[14] = array[12]
         case 3:
            self[3] = array[0]
            self[4] = array[1]
            self[5] = array[2]
            self[6] = array[3]
            self[7] = array[4]
            self[8] = array[5]
            self[9] = array[6]
            self[10] = array[7]
            self[11] = array[8]
            self[12] = array[9]
            self[13] = array[10]
            self[14] = array[11]
            self[15] = array[12]
         case 4:
            self[4] = array[0]
            self[5] = array[1]
            self[6] = array[2]
            self[7] = array[3]
            self[8] = array[4]
            self[9] = array[5]
            self[10] = array[6]
            self[11] = array[7]
            self[12] = array[8]
            self[13] = array[9]
            self[14] = array[10]
            self[15] = array[11]
            self[16] = array[12]
         case 5:
            self[5] = array[0]
            self[6] = array[1]
            self[7] = array[2]
            self[8] = array[3]
            self[9] = array[4]
            self[10] = array[5]
            self[11] = array[6]
            self[12] = array[7]
            self[13] = array[8]
            self[14] = array[9]
            self[15] = array[10]
            self[16] = array[11]
            self[17] = array[12]
         case 6:
            self[6] = array[0]
            self[7] = array[1]
            self[8] = array[2]
            self[9] = array[3]
            self[10] = array[4]
            self[11] = array[5]
            self[12] = array[6]
            self[13] = array[7]
            self[14] = array[8]
            self[15] = array[9]
            self[16] = array[10]
            self[17] = array[11]
            self[18] = array[12]
         case 7:
            self[7] = array[0]
            self[8] = array[1]
            self[9] = array[2]
            self[10] = array[3]
            self[11] = array[4]
            self[12] = array[5]
            self[13] = array[6]
            self[14] = array[7]
            self[15] = array[8]
            self[16] = array[9]
            self[17] = array[10]
            self[18] = array[11]
            self[19] = array[12]
        default:
            fatalError("offset out of available range")
        }
    }

    @inlinable public mutating func set14(_ array: StaticArray14<T>, at offset: Int = 0) {
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
            self[10] = array[10]
            self[11] = array[11]
            self[12] = array[12]
            self[13] = array[13]
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
            self[11] = array[10]
            self[12] = array[11]
            self[13] = array[12]
            self[14] = array[13]
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
            self[11] = array[9]
            self[12] = array[10]
            self[13] = array[11]
            self[14] = array[12]
            self[15] = array[13]
         case 3:
            self[3] = array[0]
            self[4] = array[1]
            self[5] = array[2]
            self[6] = array[3]
            self[7] = array[4]
            self[8] = array[5]
            self[9] = array[6]
            self[10] = array[7]
            self[11] = array[8]
            self[12] = array[9]
            self[13] = array[10]
            self[14] = array[11]
            self[15] = array[12]
            self[16] = array[13]
         case 4:
            self[4] = array[0]
            self[5] = array[1]
            self[6] = array[2]
            self[7] = array[3]
            self[8] = array[4]
            self[9] = array[5]
            self[10] = array[6]
            self[11] = array[7]
            self[12] = array[8]
            self[13] = array[9]
            self[14] = array[10]
            self[15] = array[11]
            self[16] = array[12]
            self[17] = array[13]
         case 5:
            self[5] = array[0]
            self[6] = array[1]
            self[7] = array[2]
            self[8] = array[3]
            self[9] = array[4]
            self[10] = array[5]
            self[11] = array[6]
            self[12] = array[7]
            self[13] = array[8]
            self[14] = array[9]
            self[15] = array[10]
            self[16] = array[11]
            self[17] = array[12]
            self[18] = array[13]
         case 6:
            self[6] = array[0]
            self[7] = array[1]
            self[8] = array[2]
            self[9] = array[3]
            self[10] = array[4]
            self[11] = array[5]
            self[12] = array[6]
            self[13] = array[7]
            self[14] = array[8]
            self[15] = array[9]
            self[16] = array[10]
            self[17] = array[11]
            self[18] = array[12]
            self[19] = array[13]
        default:
            fatalError("offset out of available range")
        }
    }

    @inlinable public mutating func set15(_ array: StaticArray15<T>, at offset: Int = 0) {
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
            self[10] = array[10]
            self[11] = array[11]
            self[12] = array[12]
            self[13] = array[13]
            self[14] = array[14]
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
            self[11] = array[10]
            self[12] = array[11]
            self[13] = array[12]
            self[14] = array[13]
            self[15] = array[14]
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
            self[11] = array[9]
            self[12] = array[10]
            self[13] = array[11]
            self[14] = array[12]
            self[15] = array[13]
            self[16] = array[14]
         case 3:
            self[3] = array[0]
            self[4] = array[1]
            self[5] = array[2]
            self[6] = array[3]
            self[7] = array[4]
            self[8] = array[5]
            self[9] = array[6]
            self[10] = array[7]
            self[11] = array[8]
            self[12] = array[9]
            self[13] = array[10]
            self[14] = array[11]
            self[15] = array[12]
            self[16] = array[13]
            self[17] = array[14]
         case 4:
            self[4] = array[0]
            self[5] = array[1]
            self[6] = array[2]
            self[7] = array[3]
            self[8] = array[4]
            self[9] = array[5]
            self[10] = array[6]
            self[11] = array[7]
            self[12] = array[8]
            self[13] = array[9]
            self[14] = array[10]
            self[15] = array[11]
            self[16] = array[12]
            self[17] = array[13]
            self[18] = array[14]
         case 5:
            self[5] = array[0]
            self[6] = array[1]
            self[7] = array[2]
            self[8] = array[3]
            self[9] = array[4]
            self[10] = array[5]
            self[11] = array[6]
            self[12] = array[7]
            self[13] = array[8]
            self[14] = array[9]
            self[15] = array[10]
            self[16] = array[11]
            self[17] = array[12]
            self[18] = array[13]
            self[19] = array[14]
        default:
            fatalError("offset out of available range")
        }
    }

    @inlinable public mutating func set16(_ array: StaticArray16<T>, at offset: Int = 0) {
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
            self[10] = array[10]
            self[11] = array[11]
            self[12] = array[12]
            self[13] = array[13]
            self[14] = array[14]
            self[15] = array[15]
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
            self[11] = array[10]
            self[12] = array[11]
            self[13] = array[12]
            self[14] = array[13]
            self[15] = array[14]
            self[16] = array[15]
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
            self[11] = array[9]
            self[12] = array[10]
            self[13] = array[11]
            self[14] = array[12]
            self[15] = array[13]
            self[16] = array[14]
            self[17] = array[15]
         case 3:
            self[3] = array[0]
            self[4] = array[1]
            self[5] = array[2]
            self[6] = array[3]
            self[7] = array[4]
            self[8] = array[5]
            self[9] = array[6]
            self[10] = array[7]
            self[11] = array[8]
            self[12] = array[9]
            self[13] = array[10]
            self[14] = array[11]
            self[15] = array[12]
            self[16] = array[13]
            self[17] = array[14]
            self[18] = array[15]
         case 4:
            self[4] = array[0]
            self[5] = array[1]
            self[6] = array[2]
            self[7] = array[3]
            self[8] = array[4]
            self[9] = array[5]
            self[10] = array[6]
            self[11] = array[7]
            self[12] = array[8]
            self[13] = array[9]
            self[14] = array[10]
            self[15] = array[11]
            self[16] = array[12]
            self[17] = array[13]
            self[18] = array[14]
            self[19] = array[15]
        default:
            fatalError("offset out of available range")
        }
    }

    @inlinable public mutating func set17(_ array: StaticArray17<T>, at offset: Int = 0) {
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
            self[10] = array[10]
            self[11] = array[11]
            self[12] = array[12]
            self[13] = array[13]
            self[14] = array[14]
            self[15] = array[15]
            self[16] = array[16]
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
            self[11] = array[10]
            self[12] = array[11]
            self[13] = array[12]
            self[14] = array[13]
            self[15] = array[14]
            self[16] = array[15]
            self[17] = array[16]
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
            self[11] = array[9]
            self[12] = array[10]
            self[13] = array[11]
            self[14] = array[12]
            self[15] = array[13]
            self[16] = array[14]
            self[17] = array[15]
            self[18] = array[16]
         case 3:
            self[3] = array[0]
            self[4] = array[1]
            self[5] = array[2]
            self[6] = array[3]
            self[7] = array[4]
            self[8] = array[5]
            self[9] = array[6]
            self[10] = array[7]
            self[11] = array[8]
            self[12] = array[9]
            self[13] = array[10]
            self[14] = array[11]
            self[15] = array[12]
            self[16] = array[13]
            self[17] = array[14]
            self[18] = array[15]
            self[19] = array[16]
        default:
            fatalError("offset out of available range")
        }
    }

    @inlinable public mutating func set18(_ array: StaticArray18<T>, at offset: Int = 0) {
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
            self[10] = array[10]
            self[11] = array[11]
            self[12] = array[12]
            self[13] = array[13]
            self[14] = array[14]
            self[15] = array[15]
            self[16] = array[16]
            self[17] = array[17]
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
            self[11] = array[10]
            self[12] = array[11]
            self[13] = array[12]
            self[14] = array[13]
            self[15] = array[14]
            self[16] = array[15]
            self[17] = array[16]
            self[18] = array[17]
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
            self[11] = array[9]
            self[12] = array[10]
            self[13] = array[11]
            self[14] = array[12]
            self[15] = array[13]
            self[16] = array[14]
            self[17] = array[15]
            self[18] = array[16]
            self[19] = array[17]
        default:
            fatalError("offset out of available range")
        }
    }

    @inlinable public mutating func set19(_ array: StaticArray19<T>, at offset: Int = 0) {
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
            self[10] = array[10]
            self[11] = array[11]
            self[12] = array[12]
            self[13] = array[13]
            self[14] = array[14]
            self[15] = array[15]
            self[16] = array[16]
            self[17] = array[17]
            self[18] = array[18]
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
            self[11] = array[10]
            self[12] = array[11]
            self[13] = array[12]
            self[14] = array[13]
            self[15] = array[14]
            self[16] = array[15]
            self[17] = array[16]
            self[18] = array[17]
            self[19] = array[18]
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
            self[10],
            self[11],
            self[12],
            self[13],
            self[14],
            self[15],
            self[16],
            self[17],
            self[18],
            self[19]
        ]
    }

    @inlinable public func map<M>(_ transform: (T) throws -> M) rethrows -> StaticArray20<M> {
        try StaticArray20<M>(values: (
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
            transform(self[10]),
            transform(self[11]),
            transform(self[12]),
            transform(self[13]),
            transform(self[14]),
            transform(self[15]),
            transform(self[16]),
            transform(self[17]),
            transform(self[18]),
            transform(self[19])
        ))
    }
}

public func zip<L, R>(_ lhs: StaticArray20<L>, _ rhs: StaticArray20<R>) -> StaticArray20<(L, R)> {
    StaticArray20(values: (
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
        (lhs[10], rhs[10]),
        (lhs[11], rhs[11]),
        (lhs[12], rhs[12]),
        (lhs[13], rhs[13]),
        (lhs[14], rhs[14]),
        (lhs[15], rhs[15]),
        (lhs[16], rhs[16]),
        (lhs[17], rhs[17]),
        (lhs[18], rhs[18]),
        (lhs[19], rhs[19])
    ))
}

extension StaticArray20: Collection {
    public typealias Index = Int
    public var startIndex: Index { 0 }
    public var endIndex: Index { 20 }
    @inlinable public func index(after i: Index) -> Index { i + 1 }
}

extension StaticArray20: Sequence {
    public struct Iterator: IteratorProtocol {
        private var index = 0
        private let array: StaticArray20<T>

        init(_ array: StaticArray20<T>) {
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

extension StaticArray20: Equatable where T: Equatable {
    @inlinable public static func == (lhs: Self, rhs: Self) -> Bool {
        zip(lhs, rhs).allSatisfy { $0.0 == $0.1 }
    }
}

extension StaticArray20: Codable where T: Codable {
    public init(from decoder: Decoder) throws {
        try self.init(array: [T](from: decoder))
    }

    public func encode(to encoder: Encoder) throws {
        try self.toArray().encode(to: encoder)
    }
}

extension StaticArray20: AdditiveArithmetic where T: AdditiveArithmetic {
    @inlinable public static func - (lhs: Self, rhs: Self) -> Self {
        zip(lhs, rhs).map { $0.0 - $0.1 }
    }

    @inlinable public static func + (lhs: Self, rhs: Self) -> Self {
        zip(lhs, rhs).map { $0.0 + $0.1 }
    }

    @inlinable public static var zero: Self { Self(repeating: T.zero) }
}

@inlinable public func + <T>(lhs: StaticArray20<T>, rhs: T) -> StaticArray20<T> where T: AdditiveArithmetic {
    lhs.map { $0 + rhs }
}

@inlinable public func + <T>(lhs: T, rhs: StaticArray20<T>) -> StaticArray20<T> where T: AdditiveArithmetic {
    rhs.map { lhs + $0 }
}

@inlinable public func - <T>(lhs: StaticArray20<T>, rhs: T) -> StaticArray20<T> where T: AdditiveArithmetic {
    lhs.map { $0 - rhs }
}

@inlinable public func - <T>(lhs: T, rhs: StaticArray20<T>) -> StaticArray20<T> where T: AdditiveArithmetic {
    rhs.map { lhs - $0 }
}

extension StaticArray20: Divisible where T: Divisible {
    @inlinable public static func / (lhs: Self, rhs: Self) -> Self {
        zip(lhs, rhs).map { $0.0 / $0.1 }
    }
}

@inlinable public func / <T>(lhs: StaticArray20<T>, rhs: T) -> StaticArray20<T> where T: Divisible {
    lhs.map { $0 / rhs }
}

@inlinable public func / <T>(lhs: T, rhs: StaticArray20<T>) -> StaticArray20<T> where T: Divisible {
    rhs.map { lhs / $0 }
}

extension StaticArray20: Multipliable where T: Multipliable {
    @inlinable public static func * (lhs: Self, rhs: Self) -> Self {
        zip(lhs, rhs).map { $0.0 * $0.1 }
    }
}

@inlinable public func * <T>(lhs: StaticArray20<T>, rhs: T) -> StaticArray20<T> where T: Multipliable {
    lhs.map { $0 * rhs }
}

@inlinable public func * <T>(lhs: T, rhs: StaticArray20<T>) -> StaticArray20<T> where T: Multipliable {
    rhs.map { lhs * $0 }
}

extension StaticArray20: ABSComputable where T: ABSComputable {
    @inlinable public func abs() -> Self {
        self.map { $0.abs() }
    }
}

