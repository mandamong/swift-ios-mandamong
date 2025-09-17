import ProjectDescription

let project = Project(
    name: "LoginDomain",
    targets: [
        .target(
            name: "LoginDomain",
            destinations: .iOS,
            product: .framework,
            bundleId: "com.mandamong.logindomain",
            sources: ["Sources/**"],
            dependencies: [
                .project(target: "LoginData", path: "../LoginData"),
                .project(target: "Shared", path: "../../Shared")
            ]
        )
    ]
)
