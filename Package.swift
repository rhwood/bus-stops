// swift-tools-version:5.6

import PackageDescription

let package = Package(
    name: "bus-stops",
    platforms: [
        .macOS(.v10_15)
    ],
    dependencies: [
        .package(url: "https://github.com/emma-k-alexandra/WMATA.swift", from: "14.0.0"),
        .package(url: "https://github.com/apple/swift-argument-parser", from: "1.1.3")
    ],
    targets: [
        .executableTarget(
            name: "bus-stops",
            dependencies: [
                .product(name: "WMATA", package: "WMATA.swift"),
                .product(name: "ArgumentParser", package: "swift-argument-parser")
            ]),
        .testTarget(
            name: "bus-stopsTests",
            dependencies: ["bus-stops"]),
    ]
)
