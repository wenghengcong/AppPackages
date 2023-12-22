// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "HCNetworkKit",
    defaultLocalization: "en",
    platforms: [
        .iOS(.v16),
        .macOS(.v13)
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "HCNetworkKit",
            targets: ["HCNetworkKit"]),
    ],
    dependencies: [
        .package(name: "HCUtilKit", path: "../HCUtilKit")
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "HCNetworkKit",
            dependencies: [
                .product(name: "HCUtilKit", package: "HCUtilKit")
            ],
            swiftSettings: [
                .enableExperimentalFeature("StrictConcurrency"),
            ])
    ]
)
