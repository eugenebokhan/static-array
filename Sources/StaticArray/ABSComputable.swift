import Foundation
import Foundation

public protocol ABSComputable {
    func abs() -> Self
}

extension Int8: ABSComputable { public func abs() -> Self { Swift.abs(self) } }
extension Int16: ABSComputable { public func abs() -> Self { Swift.abs(self) } }
extension Int32: ABSComputable { public func abs() -> Self { Swift.abs(self) } }
extension Int64: ABSComputable { public func abs() -> Self { Swift.abs(self) } }

@available(iOS 14.0, macOS 11.0, macCatalyst 14.0, *)
extension Float16: ABSComputable { public func abs() -> Self { Swift.abs(self) } }
extension Float32: ABSComputable { public func abs() -> Self { Swift.abs(self) } }
extension Float64: ABSComputable { public func abs() -> Self { Swift.abs(self) } }
