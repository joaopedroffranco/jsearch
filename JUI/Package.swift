// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "JUI",
  platforms: [.iOS(.v15)],
  products: [
    .library(
      name: "JUI",
      targets: ["JUI"]),
  ],
  dependencies: [
    .package(url: "https://github.com/onevcat/Kingfisher.git", from: "7.0.0"),
  ],
  targets: [
    .target(
      name: "JUI",
      dependencies: ["Kingfisher"])
  ]
)
