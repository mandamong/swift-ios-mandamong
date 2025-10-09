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
            entitlements: .file(path: .relativeToRoot("Projects/App/App.entitlements")),
            dependencies: [
                .project(target: "LoginFeature", path: "../Login/LoginFeature"),
                .project(target: "MandaratFeature", path: "../Mandarat/MandaratFeature"),
            ],
            settings: .settings(
                base: [
                    "CODE_SIGN_STYLE": "Manual",
                    "DEVELOPMENT_TEAM": "P85DW78LYM",
                ],
                configurations: [
                    .debug(name: .debug, settings: [
                        "CODE_SIGN_IDENTITY": "Apple Development",
                        "PROVISIONING_PROFILE_SPECIFIER": "debug-mandamong",
                    ])
                ]
            )
        )
    ]
)
