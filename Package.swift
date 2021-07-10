// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "Bifrost",
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
