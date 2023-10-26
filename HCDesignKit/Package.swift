// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "HCDesignKit",
    defaultLocalization: "en",
    platforms: [
        .iOS(.v16),
        .macOS(.v13)
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "HCDesignKit",
            targets: ["HCDesignKit"]),
    ],
    dependencies: [
        .package(name: "HCUtilKit", path: "../HCUtilKit"),
        .package(name: "HCModels", path: "../HCModels"),
        .package(name: "HCAppEnv", path: "../HCAppEnv"),
        .package(url: "https://github.com/markiv/SwiftUI-Shimmer", exact: "1.1.0"),
        .package(url: "https://github.com/kean/Nuke", from: "12.0.0"),
        .package(url: "https://github.com/divadretlaw/EmojiText", from: "2.6.0"),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "HCDesignKit",
            dependencies: [
                .product(name: "HCUtilKit", package: "HCUtilKit"),
                .product(name: "HCModels", package: "HCModels"),
                .product(name: "HCAppEnv", package: "HCAppEnv"),
                .product(name: "Shimmer", package: "SwiftUI-Shimmer"),
                .product(name: "NukeUI", package: "Nuke"),
                .product(name: "Nuke", package: "Nuke"),
                .product(name: "EmojiText", package: "EmojiText"),
            ],
            swiftSettings: [
                .enableExperimentalFeature("StrictConcurrency"),
            ]
        )
    ]
)
