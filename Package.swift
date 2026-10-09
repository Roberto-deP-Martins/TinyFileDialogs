// swift-tools-version: 6.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "TinyFileDialogs",
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "TinyFileDialogs",
            targets: ["TinyFileDialogs"]
        )
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "TinyFileDialogs",
            dependencies: ["CTinyFileDialogs"]
        ),
        .target(
            name: "CTinyFileDialogs",
            publicHeadersPath: "include"
        ),
        .executableTarget(
            name: "TinyFileDialogsDemo",
            dependencies: ["TinyFileDialogs"]),
        .testTarget(
            name: "TinyFileDialogsTests",
            dependencies: ["TinyFileDialogs"]
        ),
    ],
    swiftLanguageModes: [.v6]
)
