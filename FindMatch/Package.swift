// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "FindMatch",
  platforms: [.iOS(.v15)],
  products: [
    .library(
      name: "FindMatch",
      targets: ["FindMatch"]),
  ],
  dependencies: [
    .package(name: "JUI", path: "../JUI"),
    .package(name: "JData", path: "../JData"),
    .package(name: "JFoundation", path: "../JFoundation"),
    .package(url: "https://github.com/Quick/Nimble.git", from: "12.0.0"),
  ],
  targets: [
    .target(
      name: "FindMatch",
      dependencies: ["JUI", "JData", "JFoundation"]),
    .testTarget(
      name: "FindMatchTests",
      dependencies: ["FindMatch", "Nimble", "JData"]),
  ]
)
