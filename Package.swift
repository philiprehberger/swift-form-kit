// swift-tools-version: 6.0
import PackageDescription

let package = Package(
    name: "swift-form-kit",
    platforms: [
        .macOS(.v13),
        .iOS(.v16),
        .tvOS(.v16),
        .watchOS(.v9)
    ],
    products: [
        .library(name: "FormKit", targets: ["FormKit"])
    ],
    targets: [
        .target(
            name: "FormKit",
            path: "Sources/FormKit"
        ),
        .testTarget(
            name: "FormKitTests",
            dependencies: ["FormKit"],
            path: "Tests/FormKitTests"
        )
    ]
)
