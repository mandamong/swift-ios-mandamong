import ProjectDescription

let project = Project(
    name: "MandaratFeature",
    targets: [
        .target(
            name: "MandaratFeature",
            destinations: .iOS,
            product: .framework,
            bundleId: "com.mandamong.mandaratfeature",
            sources: ["Sources/**"],
            dependencies: [
                .project(target: "MandaratDomain", path: "../MandaratDomain"),
                .external(name: "ComposableArchitecture")
            ]
        )
    ]
)
