// swift-tools-version: 5.7

import PackageDescription

let package = Package(
    name: "StaticArray",
    platforms: [
        .macOS(.v10_13),
        .iOS(.v11)
    ],
    products: [
        .library(
            name: "StaticArray",
            targets: ["StaticArray"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-argument-parser", exact: "1.2.2")
    ],
    targets: [
        .executableTarget(
            name: "StaticArrayGenerator",
            dependencies: [
                .product(name: "ArgumentParser", package: "swift-argument-parser")
            ]
        ),
        .target(name: "StaticArray"),
        .testTarget(name: "StaticArrayTests", dependencies: ["StaticArray"])
    ]
)
