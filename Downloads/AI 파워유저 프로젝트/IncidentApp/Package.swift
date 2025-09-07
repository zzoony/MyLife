// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "IncidentApp",
    platforms: [
        .macOS(.v12)
    ],
    products: [
        .executable(
            name: "IncidentApp",
            targets: ["IncidentApp"]
        )
    ],
    dependencies: [],
    targets: [
        .executableTarget(
            name: "IncidentApp",
            dependencies: [],
            path: "Sources"
        )
    ]
)