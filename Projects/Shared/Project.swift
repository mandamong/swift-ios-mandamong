import ProjectDescription

let project = Project(
    name: "Shared",
    targets: [
        .target(
            name: "DesignSystem",
            destinations: .iOS,
            product: .framework,
            bundleId: "com.mandamong.designsystem",
            sources: ["DesignSystem/Sources/**"],
            resources: ["DesignSystem/Resources/**"],
            dependencies: []
        )
    ]
)
