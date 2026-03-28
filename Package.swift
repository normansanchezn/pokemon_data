// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "pokemon_data",
    platforms: [
        .iOS(.v26),
        .macOS(.v15),
        .tvOS(.v18),
        .watchOS(.v11),
        .visionOS(.v2)
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "pokemon_data",
            targets: ["pokemon_data"]
        ),
    ],
    dependencies: [
        // If pokemon_shared is a local package in your workspace, adjust the path accordingly.
        .package(name: "pokemon_shared", path: "../pokemon_shared"),
        .package(name: "pokemon_domain", path: "../pokemon_domain"),
        .package(url: "https://github.com/supabase/supabase-swift", from: "2.0.0")
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "pokemon_data",
            dependencies: [
                .product(name: "pokemon_shared", package: "pokemon_shared"),
                .product(name: "pokemon_domain", package: "pokemon_domain"),
                .product(name: "Supabase", package: "supabase-swift")
            ]
        ),
        .testTarget(
            name: "pokemon_dataTests",
            dependencies: ["pokemon_data"]
        ),
    ]
)
