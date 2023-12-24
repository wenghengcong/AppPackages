// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "HCUtilKit",
    defaultLocalization: "en",
    platforms: [
        .iOS(.v16),
        .macOS(.v13)
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "HCUtilKit",
            targets: ["HCUtilKit"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/onevcat/Kingfisher", branch: "master"),
        .package(url: "https://github.com/evgenyneu/keychain-swift", branch: "master"),
        .package(url: "https://github.com/malcommac/SwiftDate", branch: "master"),
        .package(url: "https://github.com/scinfu/SwiftSoup", branch: "master"),
        .package(url: "https://github.com/SwiftyBeaver/SwiftyBeaver", branch: "master"),
        .package(url: "https://github.com/siteline/swiftui-introspect", branch: "main")
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(name: "HCUtilKit",
                dependencies: [
                    .product(name: "Kingfisher", package: "Kingfisher"),
                    .product(name: "KeychainSwift", package: "keychain-swift"),
                    .product(name: "SwiftDate", package: "SwiftDate"),
                    .product(name: "SwiftSoup", package: "SwiftSoup"),
                    .product(name: "SwiftyBeaver", package: "SwiftyBeaver"),
                    .product(name: "SwiftUIIntrospect", package: "swiftui-introspect"),
                ]
               )
    ]
)
