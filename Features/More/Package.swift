// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "More",
    platforms: [.iOS(.v13)],
    products: [
        .library(
            name: "More",
            targets: ["More"]),
    ],
    dependencies: [
        .package(name: "UIComponents", path: "../../Foundation/UIComponents"),
        .package(name: "Networking", path: "../../Foundation/Networking")
    ],
    targets: [
        .target(
            name: "More",
            dependencies: ["UIComponents", "Networking"],
            path: "Sources"),
        .testTarget(
            name: "MoreTests",
            dependencies: ["More"]),
    ]
)
