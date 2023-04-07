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

