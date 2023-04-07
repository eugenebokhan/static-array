// swift-tools-version: 5.8

import PackageDescription

let package = Package(
    name: "StaticArray",
    platforms: [ .macOS(.v10_13)],
    products: [
        .library(
            name: "StaticArray",
            targets: ["StaticArray"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-argument-parser", exact: "1.2.2"),
        .package(url: "https://github.com/JohnSundell/Files", exact: "4.2.0")
    ],
    targets: [
        .executableTarget(
            name: "StaticArrayGenerator",
            dependencies: [
                .product(name: "Files", package: "Files"),
                .product(name: "ArgumentParser", package: "swift-argument-parser")
            ]
        ),
        .target(name: "StaticArray")
    ]
)
