import ArgumentParser
import Foundation

@available(macOS 13.0, *)
struct GenerateCommand: ParsableCommand {

    enum Error: Swift.Error {
        case unsupportedDestinationFileURL
        case unsupportedMaxDimension
    }

    // MARK: Options

    @Option(
        help: "Path to swift file where the generated code will be written",
        completion: CompletionKind.file(extensions: ["swift"])
    )
    private var destination: String

    @Option(help: "Maximum dimension of generated Static Array")
    private var maxDimension: Int = 27

    // MARK: - Functions

    func run() throws {
        try self.writeCode()
    }

    private func writeCode() throws {
        let url = URL(filePath: self.destination, directoryHint: .isDirectory)

        guard self.maxDimension > 2
        else { throw Error.unsupportedMaxDimension }

        try FileManager.default.contentsOfDirectory(atPath: self.destination)
            .filter { $0.contains("StaticArray") }
            .forEach { try FileManager.default.removeItem(at: url.appending(path: $0)) }

        for d in 2 ... self.maxDimension {
            let fileURL = url.appending(component: "StaticArray\(d).swift")
            try self.generateCode(currentD: d).write(
                to: fileURL,
                atomically: true,
                encoding: .utf8
            )
        }
    }

    private func generateCode(currentD: Int) -> String {
        var result = """
        import Foundation

        public struct StaticArray\(currentD)<T> {
            public typealias Values = (
        """

        (0 ..< currentD - 1).forEach { _ in result += "T, " }
        result += "T)\n\n"

        // MARK: - Properties

        result += "    private var values: Values\n\n"

        // MARK: - Init

        result += """
                public init(values: Values) {
                    self.values = values
                }\n\n
            """

        result += """
                public init(repeating value: T) {
                    self.values = (\n
            """
        (0 ..< currentD - 1).forEach { i in
            result += "            value,\n"
        }
        result += """
                        value
                    )
                }\n\n
            """

        result += """
                init(array: [T]) throws {
                    guard array.count == \(currentD) else { fatalError("array size mismatch") }
                    self.values = (\n
            """
        (0 ..< currentD - 1).forEach { i in
            result += "            array[\(i)],\n"
        }
        result += """
                        array[\(currentD - 1)]
                    )
                }\n\n
            """

        // MARK: - Subscript

        result += """
                public subscript(_ index: Int) -> T {
                    get {
                        switch index {\n
            """
        (0 ..< currentD).forEach { i in
            result += "            case \(i): return self.values.\(i)\n"
        }
        result += """
                        default: fatalError("index out of range")
                        }
                    }
                    set {
                        switch index {\n
            """
        (0 ..< currentD).forEach { i in
            result += "            case \(i): self.values.\(i) = newValue\n"
        }
        result += """
                        default: fatalError("index out of range")
                        }
                    }
                }\n\n
            """

        // MARK: - Getters and Setters

        if currentD >= 3 {
            (2 ..< currentD).forEach { returnD in
                let maxOffset = currentD - returnD
                result += """
                        @inlinable public func get\(returnD)(from offset: Int = 0) ->  StaticArray\(returnD)<T> {
                            switch offset {\n
                    """
                (0 ... maxOffset).forEach { offset in
                    result += """
                                 case \(offset):
                                    return StaticArray\(returnD)(values: (\n
                        """
                    (offset ..< offset + returnD - 1).forEach { i in
                        result += "                self[\(i)],\n"
                    }
                    result += """
                                        self[\(offset + returnD - 1)]
                                    ))\n
                        """
                }
                result += """
                            default:
                                fatalError("offset out of available range")
                            }
                        }\n\n
                    """
            }

            (2 ..< currentD).forEach { returnD in
                let maxOffset = currentD - returnD
                result += """
                        @inlinable public mutating func set\(returnD)(_ array: StaticArray\(returnD)<T>, at offset: Int = 0) {
                            switch offset {\n
                    """
                (0 ... maxOffset).forEach { offset in
                    result += """
                                 case \(offset):\n
                        """
                    (offset ..< offset + returnD).forEach { i in
                        result += "            self[\(i)] = array[\(i - offset)]\n"
                    }
                }
                result += """
                            default:
                                fatalError("offset out of available range")
                            }
                        }\n\n
                    """
            }
        }

        // MARK: - To Array

        result += """
                @inlinable public  func toArray() -> [T] {
                    [\n
            """
        (0 ..< currentD - 1).forEach { i in
            result += "            self[\(i)],\n"
        }
        result += """
                        self[\(currentD - 1)]
                    ]
                }\n\n
            """

        // MARK: - Map

        result += """
                @inlinable public func map<M>(_ transform: (T) throws -> M) rethrows -> StaticArray\(currentD)<M> {
                    try StaticArray\(currentD)<M>(values: (\n
            """
        (0 ..< currentD - 1).forEach { i in
            result += "            transform(self[\(i)]),\n"
        }
        result += """
                        transform(self[\(currentD - 1)])
                    ))
                }
            }\n\n
            """

        // MARK: - Zip

        result += """
            public func zip<L, R>(_ lhs: StaticArray\(currentD)<L>, _ rhs: StaticArray\(currentD)<R>) -> StaticArray\(currentD)<(L, R)> {
                StaticArray\(currentD)(values: (\n
            """
        (0 ..< currentD - 1).forEach { i in
            result += "        (lhs[\(i)], rhs[\(i)]),\n"
        }
        result += """
                    (lhs[\(currentD - 1)], rhs[\(currentD - 1)])
                ))
            }\n\n
            """

        // MARK: - Collection

        result += """
            extension StaticArray\(currentD): Collection {
                public typealias Index = Int
                public var startIndex: Index { 0 }
                public var endIndex: Index { \(currentD) }
                @inlinable public func index(after i: Index) -> Index { i + 1 }
            }\n\n
            """

        // MARK: - Sequence

        result += """
            extension StaticArray\(currentD): Sequence {
                public struct Iterator: IteratorProtocol {
                    private var index = 0
                    private let array: StaticArray\(currentD)<T>

                    init(_ array: StaticArray\(currentD)<T>) {
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
            }\n\n
            """

        // MARK: - Equitable

        result += """
            extension StaticArray\(currentD): Equatable where T: Equatable {
                @inlinable public static func == (lhs: Self, rhs: Self) -> Bool {
                    zip(lhs, rhs).allSatisfy { $0.0 == $0.1 }
                }
            }\n\n
            """

        // MARK: - Codable

        result += """
            extension StaticArray\(currentD): Codable where T: Codable {
                public init(from decoder: Decoder) throws {
                    try self.init(array: [T](from: decoder))
                }

                public func encode(to encoder: Encoder) throws {
                    try self.toArray().encode(to: encoder)
                }
            }\n\n
            """

        // MARK: - Additive Arithmetic

        result += """
            extension StaticArray\(currentD): AdditiveArithmetic where T: AdditiveArithmetic {
                @inlinable public static func - (lhs: Self, rhs: Self) -> Self {
                    zip(lhs, rhs).map { $0.0 - $0.1 }
                }

                @inlinable public static func + (lhs: Self, rhs: Self) -> Self {
                    zip(lhs, rhs).map { $0.0 + $0.1 }
                }

                @inlinable public static var zero: Self { Self(repeating: T.zero) }
            }

            @inlinable public func + <T>(lhs: StaticArray\(currentD)<T>, rhs: T) -> StaticArray\(currentD)<T> where T: AdditiveArithmetic {
                lhs.map { $0 + rhs }
            }

            @inlinable public func + <T>(lhs: T, rhs: StaticArray\(currentD)<T>) -> StaticArray\(currentD)<T> where T: AdditiveArithmetic {
                rhs.map { lhs + $0 }
            }

            @inlinable public func - <T>(lhs: StaticArray\(currentD)<T>, rhs: T) -> StaticArray\(currentD)<T> where T: AdditiveArithmetic {
                lhs.map { $0 - rhs }
            }

            @inlinable public func - <T>(lhs: T, rhs: StaticArray\(currentD)<T>) -> StaticArray\(currentD)<T> where T: AdditiveArithmetic {
                rhs.map { lhs - $0 }
            }\n\n
            """

        // MARK: - Divisible

        result += """
            extension StaticArray\(currentD): Divisible where T: Divisible {
                @inlinable public static func / (lhs: Self, rhs: Self) -> Self {
                    zip(lhs, rhs).map { $0.0 / $0.1 }
                }
            }

            @inlinable public func / <T>(lhs: StaticArray\(currentD)<T>, rhs: T) -> StaticArray\(currentD)<T> where T: Divisible {
                lhs.map { $0 / rhs }
            }

            @inlinable public func / <T>(lhs: T, rhs: StaticArray\(currentD)<T>) -> StaticArray\(currentD)<T> where T: Divisible {
                rhs.map { lhs / $0 }
            }\n\n
            """

        // MARK: - Multipliable

        result += """
            extension StaticArray\(currentD): Multipliable where T: Multipliable {
                @inlinable public static func * (lhs: Self, rhs: Self) -> Self {
                    zip(lhs, rhs).map { $0.0 * $0.1 }
                }
            }

            @inlinable public func * <T>(lhs: StaticArray\(currentD)<T>, rhs: T) -> StaticArray\(currentD)<T> where T: Multipliable {
                lhs.map { $0 * rhs }
            }

            @inlinable public func * <T>(lhs: T, rhs: StaticArray\(currentD)<T>) -> StaticArray\(currentD)<T> where T: Multipliable {
                rhs.map { lhs * $0 }
            }\n\n
            """

        // MARK: - ABSComputable

        result += """
            extension StaticArray\(currentD): ABSComputable where T: ABSComputable {
                @inlinable public func abs() -> Self {
                    self.map { $0.abs() }
                }
            }\n\n
            """

        return result
    }

    static let configuration = CommandConfiguration(abstract: "Static Array Code Generation Tool")
}
