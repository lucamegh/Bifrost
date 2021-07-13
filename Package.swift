// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "Bifrost",
    platforms: [
        .iOS(.v13), .macOS(.v10_15), .tvOS(.v13), .watchOS(.v6)
    ],
    products: [
        .library(
            name: "Bifrost",
            targets: ["Bifrost"]
        ),
    ],
    targets: [
        .target(
            name: "Bifrost",
            dependencies: []
        ),
        .testTarget(
            name: "BifrostTests",
            dependencies: ["Bifrost"]
        ),
    ]
)
