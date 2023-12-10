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
    .package(name: "JFoundation", path: "../JFoundation"),
  ],
  targets: [
    .target(
      name: "JData",
      dependencies: ["JFoundation"]),
    .testTarget(
      name: "JDataTests",
      dependencies: ["JData", "Nimble"],
      resources: [.process("JSONs")]
    ),
  ]
)
