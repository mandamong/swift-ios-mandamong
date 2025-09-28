import ProjectDescription

let project = Project(
    name: "LoginFeature",
    targets: [
        .target(
            name: "LoginFeature",
            destinations: .iOS,
            product: .framework,
            bundleId: "com.mandamong.loginfeature",
            deploymentTargets: .iOS("17.0"),
            sources: ["Sources/**"],
            dependencies: [
                .project(target: "LoginDomain", path: "../LoginDomain"),
                .external(name: "ComposableArchitecture")
            ]
        )
    ]
)
