// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

// MARK: Зависимости этого Package
private let packageDependencies: [Package.Dependency] = [
    .package(name: "Coordinating", path: "../../Foundation/Coordinating"),
    .package(name: "FeatureLoading", path: "../FeatureLoading"),
    .package(name: "Authorization", path: "../Authorization"),
    .package(name: "TabBarController", path: "../TabBarController"),
    .package(name: "TabBarWithMenuController", path: "../TabBarWithMenuController"),
    .package(name: "Home", path: "../Home")
]

// MARK: Зависимости таргета Features
private let targetFeaturesDependencies: [Target.Dependency] = [
    "Coordinating",
    "FeatureLoading",
    "Authorization",
    "TabBarController",
    "TabBarWithMenuController",
    "Home"
]

// MARK: - Package Features

let package = Package(
    name: "Features",
    platforms: [.iOS(.v13)],
    products: [
        .library(
            name: "Features",
            targets: ["Features"]),
    ],
    dependencies: packageDependencies,
    targets: [
        .target(
            name: "Features",
            dependencies: targetFeaturesDependencies,
            path: "Sources",
            resources: [
                .process("Resources")
            ]),
    ]
)
