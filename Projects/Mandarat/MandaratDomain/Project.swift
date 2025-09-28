import ProjectDescription

let project = Project(
    name: "MandaratDomain",
    targets: [
        .target(
            name: "MandaratDomain",
            destinations: .iOS,
            product: .framework,
            bundleId: "com.mandamong.mandaratdomain",
            deploymentTargets: .iOS("17.0"),
            sources: ["Sources/**"],
            dependencies: [
                .project(target: "MandaratData", path: "../MandaratData"),
            ]
        )
    ]
)
