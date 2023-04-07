import Foundation

public protocol Divisible {
    static func / (lhs: Self, rhs: Self) -> Self
}

extension Int8: Divisible {}
extension Int16: Divisible {}
extension Int32: Divisible {}
extension Int64: Divisible {}

@available(macOS 11.0, macCatalyst 14.0, *)
extension Float16: Divisible {}
extension Float32: Divisible {}
extension Float64: Divisible {}

extension SIMD2: Divisible where Scalar: FloatingPoint {}
extension SIMD3: Divisible where Scalar: FloatingPoint {}
extension SIMD4: Divisible where Scalar: FloatingPoint {}
