// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "Shared",
  platforms: [
    .iOS(.v17),
  ],
  products: [
    .singleTargetLibrary("CoreUI"),
  ],
  dependencies: [],
  targets: [
    .target(
      name: "CoreUI",
      resources: [
        .process("Resources/Assets.xcassets"),
        .process("Resources/Fonts/Inter-Bold.ttf"),
        .process("Resources/Fonts/Inter-Medium.ttf"),
        .process("Resources/Fonts/Inter-Regular.ttf"),
        .process("Resources/Fonts/Inter-SemiBold.ttf"),
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
