// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "FeatureLoading",
    platforms: [.iOS(.v13)],
    products: [
        .library(
            name: "FeatureLoading",
            targets: ["FeatureLoading"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "FeatureLoading",
            dependencies: [],
            path: "Sources",
            resources: [
                .process("Resources")
            ]
        ),
        .testTarget(
            name: "FeatureLoadingTests",
            dependencies: ["FeatureLoading"]),
    ]
)
