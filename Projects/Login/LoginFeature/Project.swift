import ProjectDescription

let project = Project(
    name: "LoginFeature",
    targets: [
        .target(
            name: "LoginFeature",
            destinations: .iOS,
            product: .framework,
            bundleId: "com.mandamong.loginfeature",
            sources: ["Sources/**"],
            dependencies: [
                .project(target: "LoginDomain", path: "../LoginDomain"),
                .project(target: "Shared", path: "../../Shared"),
                .external(name: "ComposableArchitecture")
            ]
        )
    ]
)
