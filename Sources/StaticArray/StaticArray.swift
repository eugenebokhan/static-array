import Foundation

public enum StaticArrayError: Swift.Error {
    case arraySizeMismatch
}

public struct StaticArray2<T> {
    public typealias Values = (T, T)

    private var values: Values

    public var _0: T {
        get { self.values.0 }
        set { self.values.0 = newValue }
    }

    public var _1: T {
        get { self.values.1 }
        set { self.values.1 = newValue }
    }

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
        guard array.count == 2 else { throw StaticArrayError.arraySizeMismatch }
        self.values = (
            array[0],
            array[1]
        )
    }

    public func toArray() -> [T] {
        [
            self._0,
            self._1
        ]
    }

    public func map<M>(_ transform: (T) throws -> M) rethrows -> StaticArray2<M> {
        try StaticArray2<M>(values: (
            transform(self._0),
            transform(self._1)
        ))
    }

}

public func zip<L, R>(_ lhs: StaticArray2<L>, _ rhs: StaticArray2<R>) -> StaticArray2<(L, R)> {
    StaticArray2(values: (
        (lhs._0, rhs._0),
        (lhs._1, rhs._1)
    ))
}

public struct StaticArray3<T> {
    public typealias Values = (T, T, T)

    private var values: Values

    public var _0: T {
        get { self.values.0 }
        set { self.values.0 = newValue }
    }

    public var _1: T {
        get { self.values.1 }
        set { self.values.1 = newValue }
    }

    public var _2: T {
        get { self.values.2 }
        set { self.values.2 = newValue }
    }

    public var array2: StaticArray2<T> {
        get {
            StaticArray2(values: (
                self._0,
                self._2
            ))
        }
        set {
            self._0 = newValue._0
            self._1 = newValue._1
         }
    }

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
        guard array.count == 3 else { throw StaticArrayError.arraySizeMismatch }
        self.values = (
            array[0],
            array[1],
            array[2]
        )
    }

    public func toArray() -> [T] {
        [
            self._0,
            self._1,
            self._2
        ]
    }

    public func map<M>(_ transform: (T) throws -> M) rethrows -> StaticArray3<M> {
        try StaticArray3<M>(values: (
            transform(self._0),
            transform(self._1),
            transform(self._2)
        ))
    }

}

public func zip<L, R>(_ lhs: StaticArray3<L>, _ rhs: StaticArray3<R>) -> StaticArray3<(L, R)> {
    StaticArray3(values: (
        (lhs._0, rhs._0),
        (lhs._1, rhs._1),
        (lhs._2, rhs._2)
    ))
}

