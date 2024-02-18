// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "Core",
  platforms: [
    .iOS(.v17),
  ],
  products: [
    .singleTargetLibrary("CoreUtils"),
    .singleTargetLibrary("CoreModels"),
  ],
  dependencies: [
  ],
  targets: [
    .target(name: "CoreUtils"),
    .target(name: "CoreModels"),
  ]
)

// Single target library
extension Product {
  static func singleTargetLibrary(_ name: String) -> Product {
    .library(name: name, targets: [name])
  }
}
