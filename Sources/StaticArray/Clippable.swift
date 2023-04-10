import Foundation
import Foundation

public protocol Clippable {
    func clip(min: Self?, max: Self?) -> Self
}

extension Clippable where Self: Comparable {
    public func clip(min: Self? = nil, max: Self? = nil) -> Self {
        var result = self
        if let min = min, result < min { result = min }
        if let max = max, result > max { result = max }
        return result
    }
}

extension Int8: Clippable {}
extension Int16: Clippable {}
extension Int32: Clippable {}
extension Int64: Clippable {}

@available(iOS 14.0, macOS 11.0, macCatalyst 14.0, *)
extension Float16: Clippable {}
extension Float32: Clippable {}
extension Float64: Clippable {}
