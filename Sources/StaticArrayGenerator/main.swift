#if os(macOS)

import Foundation

let destinationFilePath = #file.deletingLastPathComponent
    .deletingLastPathComponent
    .appendingPathComponent("StaticArray")

if #available(macOS 13.0, *) {
    GenerateCommand.main([
        "--destination",
        destinationFilePath
    ])
}

extension String {
    var deletingLastPathComponent: Self {
        NSString(string: self).deletingLastPathComponent
    }
    func appendingPathComponent(_ component: Self) -> Self {
        NSString(string: self).appendingPathComponent(component)
    }
}

#endif
