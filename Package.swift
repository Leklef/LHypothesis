// swift-tools-version:5.7

import PackageDescription

let package = Package(
  name: "LHypothesis",
  platforms: [
    .macOS(.v10_15), .iOS(.v13), .tvOS(.v13)
  ],
  products: [
    .library(
      name: "LHypothesis",
      targets: ["LHypothesis"]
    ),
    .library(
      name: "LHypothesisAppsFlyer",
      targets: ["LHypothesisAppsFlyer"]
    ),
    .library(
      name: "LHypothesisFirebase",
      targets: ["LHypothesisFirebase"]
    )
  ],
  dependencies: [
    .package(url: "https://github.com/AppsFlyerSDK/AppsFlyerFramework", from: "6.10.0"),
    .package(url: "https://github.com/firebase/firebase-ios-sdk", from: "10.7.0")
  ],
  targets: [
    .target(
      name: "LHypothesis",
      path: "./Sources/Core"
    ),
    .target(
      name: "LHypothesisAppsFlyer",
      dependencies: [
        .target(name: "LHypothesis"),
        .product(name: "AppsFlyerLib", package: "AppsFlyerFramework")
      ],
      path: "./Sources/Providers",
      exclude: ["FirebaseProvider.swift"]
    ),
    .target(
      name: "LHypothesisFirebase",
      dependencies: [
        .target(name: "LHypothesis"),
        .product(name: "FirebaseAnalytics", package: "firebase-ios-sdk")
      ],
      path: "./Sources/Providers",
      exclude: ["AppsFlyerProvider.swift"]
    ),
    .testTarget(
        name: "LHypothesisTests",
        dependencies: ["LHypothesis"],
        path: "./Tests"
    )
  ],
  swiftLanguageVersions: [.v5]
)
