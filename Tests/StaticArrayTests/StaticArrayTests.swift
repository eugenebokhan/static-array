import Foundation
import XCTest
@testable import StaticArray

final class StaticArrayTests: XCTestCase {

    func testSum() throws {
        XCTAssertEqual(
            StaticArray2(values: (1, 2)) + StaticArray2(values: (3, 4)),
            StaticArray2(values: (4, 6))
        )
        XCTAssertEqual(
            StaticArray2(values: (1, 2)) + 3,
            StaticArray2(values: (4, 5))
        )
        XCTAssertEqual(
            StaticArray2(values: (StaticArray3(repeating: 1), StaticArray3(repeating: 2))) +
            StaticArray2(values: (StaticArray3(repeating: 3), StaticArray3(repeating: 4))),
            StaticArray2(values: (StaticArray3(repeating: 4), StaticArray3(repeating: 6)))
        )
    }

    func testMultiply() throws {
        XCTAssertEqual(
            StaticArray2(values: (1, 2)) * StaticArray2(values: (3, 4)),
            StaticArray2(values: (3, 8))
        )
        XCTAssertEqual(
            StaticArray2(values: (1, 2)) * 3,
            StaticArray2(values: (3, 6))
        )
        XCTAssertEqual(
            StaticArray2(values: (StaticArray3(repeating: 1), StaticArray3(repeating: 2))) *
            StaticArray2(values: (StaticArray3(repeating: 3), StaticArray3(repeating: 4))),
            StaticArray2(values: (StaticArray3(repeating: 3), StaticArray3(repeating: 8)))
        )
    }

    func testMap() throws {
        XCTAssertEqual(
            StaticArray2(values: (1, 2)).map { $0 * 4 },
            StaticArray2(values: (4, 8))
        )
    }

    func testZip() throws {
        let a = StaticArray2(values: (1, 2))
        let b = a
        let c = zip(a, b).map { $0.1 - $0.1 }
        XCTAssertEqual(c, StaticArray2(repeating: 0))
    }

    func testSet() throws {
        var a = StaticArray4(values: (1, 2, 3, 4))
        let b = StaticArray2(repeating: 9)
        a.set2(b, at: 1)
        XCTAssertEqual(
            a,
            StaticArray4(values: (1, 9, 9, 4))
        )
    }

    func testGet() throws {
        let a = StaticArray4(values: (1, 2, 3, 4))
        let b = a.get2(from: 2)
        XCTAssertEqual(b, StaticArray2(values: (3, 4)))
    }

}
