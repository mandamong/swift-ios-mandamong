import ProjectDescription

let project = Project(
    name: "LoginData",
    targets: [
        .target(
            name: "LoginData",
            destinations: .iOS,
            product: .framework,
            bundleId: "com.mandamong.logindata",
            deploymentTargets: .iOS("17.0"),
            sources: ["Sources/**"],
            dependencies: [
                .project(target: "Network", path: "../../Network"),
                .project(target: "LocalDB", path: "../../LocalDB"),
            ]
        )
    ]
)
