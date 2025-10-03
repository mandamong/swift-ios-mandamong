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
            infoPlist: .extendingDefault(with: [
                "UILaunchScreen": .dictionary([
                    "UILaunchScreenIsTranslucent": .boolean(false)
                ])
            ]),
            sources: ["Sources/**"],
            dependencies: [
                .project(target: "LoginFeature", path: "../Login/LoginFeature"),
                .project(target: "MandaratFeature", path: "../Mandarat/MandaratFeature"),
            ]
        )
    ]
)
