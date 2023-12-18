// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "JData",
  platforms: [.iOS(.v15)],
  products: [
    .library(
      name: "JData",
      targets: ["JData"]),
  ],
  dependencies: [
    .package(url: "https://github.com/Quick/Nimble.git", from: "12.0.0"),
    .package(url: "https://github.com/pointfreeco/swift-composable-architecture.git", from: "1.5.5"),
    .package(name: "JFoundation", path: "../JFoundation"),
  ],
  targets: [
    .target(
      name: "JData",
      dependencies: ["JFoundation", .product(name: "ComposableArchitecture", package: "swift-composable-architecture")]),
    .testTarget(
      name: "JDataTests",
      dependencies: ["JData", "Nimble"],
      resources: [.process("JSONs")]
    ),
  ]
)
