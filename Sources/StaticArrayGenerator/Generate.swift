import ArgumentParser
import Files
import Foundation

@available(macOS 13.0, *)
struct GenerateCommand: ParsableCommand {
    // MARK: Options

    @Option(
        help: "Path to swift file where the generated code will be written",
        completion: CompletionKind.file(extensions: ["swift"])
    )
    private var destination: String

    // MARK: - Functions

    func run() throws {
        try self.generateCode()
    }

    private func generateCode(maxDimension: Int = 3) throws {
        let url = URL(filePath: self.destination)

        if FileManager.default.fileExists(atPath: self.destination) {
            try FileManager.default.removeItem(at: url)
        }

        var result = """
        import Foundation

        public enum StaticArrayError: Swift.Error {
            case arraySizeMismatch
        }\n\n
        """

        let dimensionRange = 2 ... maxDimension

        for d in dimensionRange {
            result += """
            public struct StaticArray\(d)<T> {
                public typealias Values = (
            """

            (0 ..< d - 1).forEach { _ in result += "T, " }
            result += "T)\n\n"

            result += "    private var values: Values\n\n"

            (0 ..< d).forEach { i in
                result += """
                    public var _\(i): T {
                        get { self.values.\(i) }
                        set { self.values.\(i) = newValue }
                    }\n\n
                """
            }

            if d >= 3 {
                (3 ... d).forEach { d in
                    result += """
                    public var array\(d - 1): StaticArray\(d - 1)<T> {
                        get {
                            StaticArray\(d - 1)(values: (\n
                """
                    (0 ..< d - 2).forEach { i in
                        result += "                self._\(i),\n"
                    }
                    result += """
                                    self._\(d - 1)
                                ))
                            }
                            set {\n
                    """
                    (0 ..< d - 1).forEach { i in
                        result += "            self._\(i) = newValue._\(i)\n"
                    }
                    result += """
                             }
                        }\n\n
                    """
                }
            }

            result += """
                public init(values: Values) {
                    self.values = values
                }\n\n
            """

            result += """
                public init(repeating value: T) {
                    self.values = (\n
            """
            (0 ..< d - 1).forEach { i in
                result += "            value,\n"
            }
            result += """
                        value
                    )
                }\n\n
            """

            result += """
                init(array: [T]) throws {
                    guard array.count == \(d) else { throw StaticArrayError.arraySizeMismatch }
                    self.values = (\n
            """
            (0 ..< d - 1).forEach { i in
                result += "            array[\(i)],\n"
            }
            result += """
                        array[\(d - 1)]
                    )
                }\n\n
            """

            result += """
                public func toArray() -> [T] {
                    [\n
            """
            (0 ..< d - 1).forEach { i in
                result += "            self._\(i),\n"
            }
            result += """
                        self._\(d - 1)
                    ]
                }\n\n
            """

            result += """
                public func map<M>(_ transform: (T) throws -> M) rethrows -> StaticArray\(d)<M> {
                    try StaticArray\(d)<M>(values: (\n
            """
            (0 ..< d - 1).forEach { i in
                result += "            transform(self._\(i)),\n"
            }
            result += """
                        transform(self._\(d - 1))
                    ))
                }\n
            }\n\n
            """

            result += """
            public func zip<L, R>(_ lhs: StaticArray\(d)<L>, _ rhs: StaticArray\(d)<R>) -> StaticArray\(d)<(L, R)> {
                StaticArray\(d)(values: (\n
            """
            (0 ..< d - 1).forEach { i in
                result += "        (lhs._\(i), rhs._\(i)),\n"
            }
            result += """
                    (lhs._\(d - 1), rhs._\(d - 1))
                ))
            }\n\n
            """

        }
        try! result.write(
            to: url,
            atomically: true,
            encoding: .utf8
        )
    }

    static let configuration = CommandConfiguration(abstract: "Static Array Code Generation Tool")
}
