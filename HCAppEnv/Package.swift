// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "HCAppEnv",
    defaultLocalization: "en",
    platforms: [
        .iOS(.v16),
        .macOS(.v13)
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "HCAppEnv",
            targets: ["HCAppEnv"]),
    ],
    dependencies: [
        .package(name: "HCUtilKit", path: "../HCUtilKit"),
        .package(name: "HCModels", path: "../HCModels"),
        .package(name: "HCNetworkKit", path: "../HCNetworkKit"),
        .package(url: "https://github.com/evgenyneu/keychain-swift", branch: "master"),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "HCAppEnv",
            dependencies: [
                .product(name: "HCUtilKit", package: "HCUtilKit"),
                .product(name: "HCModels", package: "HCModels"),
                .product(name: "HCUtilKit", package: "HCUtilKit"),
                .product(name: "KeychainSwift", package: "keychain-swift"),
            ],
            swiftSettings: [
                .enableExperimentalFeature("StrictConcurrency"),
            ]
        ),
        .testTarget(
            name: "HCAppEnvTests",
            dependencies: ["HCAppEnv"]),
    ]
)
