// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "LHypothesis",
  platforms: [
    .macOS(.v10_15), .iOS(.v11), .tvOS(.v12)
  ],
  products: [
    .library(
      name: "LHypothesis",
      targets: ["LHypothesis"])
  ],
  dependencies: [],
  targets: [
    .target(
      name: "LHypothesis",
      path: "./LHypothesis/Classes/Core"
    ),
    .target(
      name: "LHypothesisAppsFlyer",
      dependencies: ["LHypothesis"],
      path: "./LHypothesis/Classes/Providers",
      exclude: ["FirebaseProvider.swift"]
    ),
    .target(
      name: "LHypothesisFirebase",
      dependencies: ["LHypothesis"],
      path: "./LHypothesis/Classes/Providers",
      exclude: ["AppsFlyerProvider.swift"]
    )
  ],
  swiftLanguageVersions: [.v5]
)
