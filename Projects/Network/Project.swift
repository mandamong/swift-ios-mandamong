import ProjectDescription

let project = Project(
    name: "Network",
    targets: [
        .target(
            name: "Network",
            destinations: .iOS,
            product: .framework,
            bundleId: "com.mandamong.network",
            sources: ["Sources/**"],
            dependencies: [
                .external(name: "Moya")
            ]
        )
    ]
)
