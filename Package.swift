// swift-tools-version:5.9

import PackageDescription

let package = Package(
    name: "CardKit",
    platforms: [
        .iOS(.v12)
    ],
    products: [
        .library(
            name: "CardKit",
            targets: ["CardKit"]),
    ],
    targets: [
        .target(
            name: "CardKit",
            dependencies: []),
        .testTarget(
            name: "CardKitTests",
            dependencies: ["CardKit"]),
    ]
)
