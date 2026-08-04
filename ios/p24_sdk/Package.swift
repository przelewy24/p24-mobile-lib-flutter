// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "p24_sdk",
    platforms: [
        .iOS("13.0")
    ],
    products: [
        .library(name: "p24-sdk", targets: ["p24_sdk"])
    ],
    dependencies: [
        .package(name: "FlutterFramework", path: "../FlutterFramework")
    ],
    targets: [
        .binaryTarget(
            name: "P24",
            path: "Lib/P24.xcframework"
        ),
        .target(
            name: "p24_sdk",
            dependencies: [
                .product(name: "FlutterFramework", package: "FlutterFramework"),
                "P24"
            ]
        )
    ]
)
