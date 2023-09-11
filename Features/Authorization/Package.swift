// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Authorization",
    platforms: [.iOS(.v13)],
    products: [
        .library(
            name: "Authorization",
            targets: ["Authorization"]),
    ],
    dependencies: [
        .package(name: "UIComponents", path: "../../Foundation/UIComponents"),
        .package(name: "Networking", path: "../../Foundation/Networking")
    ],
    targets: [
        .target(
            name: "Authorization",
            dependencies: ["UIComponents", "Networking"],
            path: "Sources",
            resources: [
                .process("Resources")
            ]
        ),
        .testTarget(
            name: "AuthorizationTests",
            dependencies: ["Authorization", "Networking"]),
    ]
)
