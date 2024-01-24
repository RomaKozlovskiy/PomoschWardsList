// swift-tools-version:5.7

import PackageDescription

let package = Package(
  name: "WardsAPI",
  platforms: [
    .iOS(.v12),
    .macOS(.v10_14),
    .tvOS(.v12),
    .watchOS(.v5),
  ],
  products: [
    .library(name: "WardsAPI", targets: ["WardsAPI"]),
  ],
  dependencies: [
    .package(url: "https://github.com/apollographql/apollo-ios.git", from: "1.0.0"),
  ],
  targets: [
    .target(
      name: "WardsAPI",
      dependencies: [
        .product(name: "ApolloAPI", package: "apollo-ios"),
      ],
      path: "./Sources"
    ),
  ]
)
