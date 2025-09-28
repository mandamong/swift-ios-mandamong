import ProjectDescription

let project = Project(
    name: "App",
    targets: [
        .target(
            name: "App",
            destinations: .iOS,
            product: .app,
            bundleId: "com.mandamong.app",
            deploymentTargets: .iOS("17.0"),
            infoPlist: .default,
            sources: ["Sources/**"],
            dependencies: [
                .project(target: "LoginFeature", path: "../Login/LoginFeature"),

                .project(target: "MandaratFeature", path: "../Mandarat/MandaratFeature"),

                .project(target: "DesignSystem", path: "../Shared"),
                .project(target: "Utils", path: "../Shared"),

                .project(target: "Network", path: "../Network"),
                .project(target: "LocalDB", path: "../LocalDB"),

                .external(name: "ComposableArchitecture")
            ]
        )
    ]
)
