import ProjectDescription

let iosTarget = Target(
    name: "LHypothesis-iOS",
    platform: .iOS,
    product: .staticFramework,
    bundleId: "com.lgilyazov.LHypothesis-iOS",
    deploymentTarget: .iOS(targetVersion: "12.0", devices: [.iphone, .ipad]),
    infoPlist: .default,
    sources: ["Sources/**"]
)

let macTarget = Target(
    name: "LHypothesis-Mac",
    platform: .macOS,
    product: .staticFramework,
    bundleId: "com.lgilyazov.LHypothesis-Mac",
    deploymentTarget: .macOS(targetVersion: "10.15"),
    infoPlist: .default,
    sources: ["Sources/**"]
)

let tvTarget = Target(
    name: "LHypothesis-tvOS",
    platform: .tvOS,
    product: .staticFramework,
    bundleId: "com.lgilyazov.LHypothesis-tvOS",
    deploymentTarget: .tvOS(targetVersion: "12.0"),
    infoPlist: .default,
    sources: ["Sources/**"]
)

let testsTarget = Target(
    name: "LHypothesisTests",
    platform: .iOS,
    product: .unitTests,
    bundleId: "com.lgilyazov.LHypothesis.Tests",
    deploymentTarget: .iOS(targetVersion: "12.0", devices: [.iphone, .ipad]),
    infoPlist: .default,
    sources: ["Tests/**"],
    dependencies: [
        .target(name: iosTarget.name),
    ]
)

let project = Project(
    name: "LHypothesis",
    targets: [
        iosTarget,
        macTarget,
        tvTarget,
        testsTarget
    ],
    schemes: [
        .init(
            name: "LHypothesis",
            buildAction: BuildAction(targets: [
                TargetReference(stringLiteral: iosTarget.name),
                TargetReference(stringLiteral: macTarget.name),
                TargetReference(stringLiteral: tvTarget.name)
            ]),
            testAction: .testPlans(["LHypothesis.xctestplan"])
        ),
        .init(
            name: "LHypothesisTests-iOS",
            buildAction: BuildAction(targets: [
                TargetReference(stringLiteral: testsTarget.name)
            ]),
            testAction: .testPlans(["LHypothesis.xctestplan"])
        )
    ]
)
