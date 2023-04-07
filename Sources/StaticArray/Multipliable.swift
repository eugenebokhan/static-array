import Foundation

public protocol Multipliable {
    static func * (lhs: Self, rhs: Self) -> Self
}

extension Int8: Multipliable {}
extension Int16: Multipliable {}
extension Int32: Multipliable {}
extension Int64: Multipliable {}

@available(macOS 11.0, macCatalyst 14.0, *)
extension Float16: Multipliable {}
extension Float32: Multipliable {}
extension Float64: Multipliable {}

extension SIMD2: Multipliable where Scalar: FloatingPoint {}
extension SIMD3: Multipliable where Scalar: FloatingPoint {}
extension SIMD4: Multipliable where Scalar: FloatingPoint {}
