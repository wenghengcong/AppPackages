// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "HCAccountKit",
    defaultLocalization: "en",
    platforms: [
        .iOS(.v16),
        .macOS(.v13)
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "HCAccountKit",
            targets: ["HCAccountKit"]),
    ],
    dependencies: [
        .package(name: "HCUtilKit", path: "../HCUtilKit"),
        .package(name: "HCModels", path: "../HCModels"),
        .package(name: "HCNetworkKit", path: "../HCNetworkKit"),
        .package(name: "HCDesignKit", path: "../HCDesignKit"),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "HCAccountKit",
            dependencies: [
                .product(name: "HCUtilKit", package: "HCUtilKit"),
                .product(name: "HCModels", package: "HCModels"),
                .product(name: "HCNetworkKit", package: "HCNetworkKit"),
                .product(name: "HCDesignKit", package: "HCDesignKit"),
            ],
            swiftSettings: [
                .enableExperimentalFeature("StrictConcurrency"),
            ]
        )
    ]
)
