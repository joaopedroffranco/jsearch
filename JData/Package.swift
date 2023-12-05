// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "JData",
    platforms: [.iOS(.v15)],
    products: [
      // Products define the executables and libraries a package produces, and make them visible to other packages.
      .library(
        name: "JData",
        targets: ["JData"]),
    ],
    dependencies: [
      .package(url: "https://github.com/Quick/Nimble.git", from: "12.0.0"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "JData",
            dependencies: []),
        .testTarget(
            name: "JDataTests",
            dependencies: ["JData", "Nimble"],
            resources: [.process("JSONs")]
        ),
    ]
)
