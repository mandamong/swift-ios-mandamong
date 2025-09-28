import ProjectDescription

let project = Project(
    name: "LoginDomain",
    targets: [
        .target(
            name: "LoginDomain",
            destinations: .iOS,
            product: .framework,
            bundleId: "com.mandamong.logindomain",
            deploymentTargets: .iOS("17.0"),
            sources: ["Sources/**"],
            dependencies: [
                .project(target: "LoginData", path: "../LoginData"),
            ]
        )
    ]
)
