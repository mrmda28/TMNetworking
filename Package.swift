// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "TMNetworking",
    platforms: [
        .macOS(.v10_15)
    ],
    products: [
        .library(
            name: "TMNetworking",
            targets: ["TMNetworking"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/Alamofire/Alamofire", exact: "5.8.0"),
        .package(url: "https://github.com/mrmda28/TMEndpoints", exact: "0.0.2")
    ],
    targets: [
        .target(
            name: "TMNetworking",
            dependencies: [
                "Alamofire",
                "TMEndpoints"
            ]
        ),
        .testTarget(
            name: "TMNetworkingTests",
            dependencies: ["TMNetworking"]
        )
    ]
)
