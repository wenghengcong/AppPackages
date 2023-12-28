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
        .library(name: "HCDesignKit", targets: ["HCDesignKit"]),
    ],
    dependencies: [
        .package(name: "HCUtilKit", path: "../HCUtilKit"),
        .package(name: "HCAppEnv", path: "../HCAppEnv"),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "HCDesignKit",
            dependencies: [
                .product(name: "HCUtilKit", package: "HCUtilKit"),
                .product(name: "HCAppEnv", package: "HCAppEnv"),
            ],
            // 如果是process，那么会将对应目录下的都拷贝到HCDesignKit_HCDesignKit.bundle根目录下
            // 如果是变为其他路径: [.process("DesignResources")], 也是可以的
            // 只是说Resource是Package默认的路径而已
            // 如果是copy，如.copy("ABC")，那么会存在HCDesignKit_HCDesignKit.bundle的ABC目录下
            resources: [.process("Resources")],
            swiftSettings: [
                .enableExperimentalFeature("StrictConcurrency"),
            ]
        ),
    ]
)
