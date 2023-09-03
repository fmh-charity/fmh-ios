// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Authorization",
    platforms: [.iOS(.v13)],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "Authorization",
            targets: ["Authorization"]),
    ],
    dependencies: [
        .package(name: "UIComponents", path: "../../Foundation/UIComponents")
    ],
    targets: [
        .target(
            name: "Authorization",
            dependencies: ["UIComponents"],
            path: "Sources",
            resources: [
                .process("Resources")
            ]
        ),
        .testTarget(
            name: "AuthorizationTests",
            dependencies: ["Authorization"]),
    ]
)
