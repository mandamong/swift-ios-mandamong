import ProjectDescription

let project = Project(
    name: "Mandamong",
    organizationName: "Mandamong-iOS",
    packages: [
        .remote(url: "https://github.com/pointfreeco/swift-composable-architecture", requirement: .upToNextMajor(from: "1.22.2")),
        .remote(url: "https://github.com/Moya/Moya", requirement: .upToNextMajor(from: "15.0.3"))
    ],
    targets: [
        // MARK: - Application
        .target(
            name: "Mandamong",
            destinations: .iOS,
            product: .app,
            bundleId: "com.SwainYun.Mandamong",
            infoPlist: .extendingDefault(with: [
                "UIAppFonts": [
                    "SpoqaHanSansNeo-Bold.otf",
                    "SpoqaHanSansNeo-Medium.otf",
                    "SpoqaHanSansNeo-Regular.otf"
                ],
            ]),
            sources: ["Mandamong/Sources/Application/**"],
            resources: ["Mandamong/Resources/**"],
            dependencies: [
                .target(name: "Presentation"),
                .target(name: "Repository")
            ]
        ),
        // MARK: - Presentation
        .target(
            name: "Presentation",
            destinations: .iOS,
            product: .framework,
            bundleId: "com.SwainYun.Mandamong.presentation",
            sources: ["Mandamong/Sources/Presentation/**"],
            dependencies: [
                .target(name: "Domain"),
                .package(product: "ComposableArchitecture")
            ]
        ),
        // MARK: - Domain
        .target(
            name: "Domain",
            destinations: .iOS,
            product: .framework,
            bundleId: "com.SwainYun.Mandamong.domain",
            sources: ["Mandamong/Sources/Domain/**"],
            dependencies: []
        ),
        // MARK: - Repository
        .target(
            name: "Repository",
            destinations: .iOS,
            product: .framework,
            bundleId: "com.SwainYun.Mandamong.repository",
            sources: ["Mandamong/Sources/Repository/**"],
            dependencies: [
                .target(name: "Domain"),
                .target(name: "Infrastructure")
            ]
        ),
        // MARK: - Infrastructure
        .target(
            name: "Infrastructure",
            destinations: .iOS,
            product: .framework,
            bundleId: "com.SwainYun.Mandamong.infrastructure",
            sources: ["Mandamong/Sources/Infrastructure/**"],
            dependencies: [
                .package(product: "Moya")
            ]
        ),
        .target(
            name: "MandamongTests",
            destinations: .iOS,
            product: .unitTests,
            bundleId: "com.SwainYun.Mandamong.Tests",
            infoPlist: .default,
            sources: ["Mandamong/Tests/**"],
            resources: [],
            dependencies: [.target(name: "Mandamong")]
        ),
    ]
)
