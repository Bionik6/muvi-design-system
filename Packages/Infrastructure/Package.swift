// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "Infrastructure",
  platforms: [
    .iOS(.v17),
  ],
  products: [
    .singleTargetLibrary("Networking"),
  ],
  dependencies: [
    .package(path: "Core"),
  ],
  targets: [
    .target(
      name: "Networking",
      dependencies: [
        .product(name: "CoreUtils", package: "Core"),
        .product(name: "CoreModels", package: "Core"),
      ]
    ),
  ]
)

// Single target library
extension Product {
  static func singleTargetLibrary(_ name: String) -> Product {
    .library(name: name, targets: [name])
  }
}
