import ProjectDescription

let project = Project(
    name: "MandaratDomain",
    targets: [
        .target(
            name: "MandaratDomain",
            destinations: .iOS,
            product: .framework,
            bundleId: "com.mandamong.mandaratdomain",
            sources: ["Sources/**"],
            dependencies: [
                .project(target: "MandaratData", path: "../MandaratData"),
                .project(target: "Shared", path: "../../Shared")
            ]
        )
    ]
)
