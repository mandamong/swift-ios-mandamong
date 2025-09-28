import ProjectDescription

let project = Project(
    name: "MandaratData",
    targets: [
        .target(
            name: "MandaratData",
            destinations: .iOS,
            product: .framework,
            bundleId: "com.mandamong.mandaratdata",
            deploymentTargets: .iOS("17.0"),
            sources: ["Sources/**"],
            dependencies: [
                .project(target: "Network", path: "../../Network"),
                .project(target: "LocalDB", path: "../../LocalDB"),
            ]
        )
    ]
)
