// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "TabBarWithMenuController",
    platforms: [.iOS(.v13)],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "TabBarWithMenuController",
            targets: ["TabBarWithMenuController"]),
    ],
    dependencies: [
        .package(name: "UIComponents", path: "../../Foundation/UIComponents"),
        .package(name: "Networking", path: "../../Foundation/Networking")
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "TabBarWithMenuController",
            dependencies: ["UIComponents", "Networking"],
            path: "Sources"),
        .testTarget(
            name: "TabBarWithMenuControllerTests",
            dependencies: ["TabBarWithMenuController", "UIComponents", "Networking"]),
    ]
)
