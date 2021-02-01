// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "bus-stops",
    dependencies: [
        .package(name: "WMATA", url: "https://github.com/emma-k-alexandra/WMATA.swift", from: "8.4.2"),
        .package(url: "https://github.com/apple/swift-argument-parser", from: "0.3.2")
    ],
    targets: [
        .target(
            name: "bus-stops",
            dependencies: [
                "WMATA",
                .product(name: "ArgumentParser", package: "swift-argument-parser")
            ]),
        .testTarget(
            name: "bus-stopsTests",
            dependencies: ["bus-stops"]),
    ]
)
