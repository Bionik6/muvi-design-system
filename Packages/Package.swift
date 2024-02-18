// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "Packages",
  platforms: [
    .iOS(.v17),
  ],
  products: [
    .singleTargetLibrary("CoreUI"),
    .singleTargetLibrary("CoreModels"),
    .singleTargetLibrary("Networking"),
  ],
  dependencies: [
  ],
  targets: [
    .target(name: "CoreUI"),
    .target(name: "CoreModels"),
    .target(name: "Networking", dependencies: [.target(name: "CoreModels")]),
  ]
)

// Single target library
extension Product {
  static func singleTargetLibrary(_ name: String) -> Product {
    .library(name: name, targets: [name])
  }
}