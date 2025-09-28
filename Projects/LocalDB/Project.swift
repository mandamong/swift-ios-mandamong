import ProjectDescription

let project = Project(
    name: "LocalDB",
    targets: [
        .target(
            name: "LocalDB",
            destinations: .iOS,
            product: .framework,
            bundleId: "com.mandamong.localdb",
            deploymentTargets: .iOS("17.0"),
            sources: ["Sources/**"],
            dependencies: [
                
            ]
        )
    ]
)
