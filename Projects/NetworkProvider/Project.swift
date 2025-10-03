import ProjectDescription

let project = Project(
    name: "NetworkProvider",
    targets: [
        .target(
            name: "NetworkProvider",
            destinations: .iOS,
            product: .framework,
            bundleId: "com.mandamong.networkprovider",
            deploymentTargets: .iOS("17.0"),
            sources: ["Sources/**"],
            dependencies: [
                .external(name: "Alamofire")
            ]
        )
    ]
)
