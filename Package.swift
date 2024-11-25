// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "TMDBApi",
    platforms: [.macOS(.v13)],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "TMDBApi",
            targets: ["TMDBApi"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/WillsonSmith/swift-misc-utils", branch: "main"),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "TMDBApi",
            dependencies: [.product(name: "MiscUtils", package: "swift-misc-utils")]
        ),
        .testTarget(
            name: "TMDBApiTests",
            dependencies: ["TMDBApi"]
        ),
    ]
)
