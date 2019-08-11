// swift-tools-version:5.0

import PackageDescription

let package = Package(
    name: "ElementaryCycles",
    products: [
        .library(
            name: "ElementaryCycles",
            targets: ["ElementaryCycles"]),
        .library(
            name: "ElementaryCyclesSearch",
            targets: ["ElementaryCyclesSearch"]),
        .executable(
            name: "ElementaryCyclesSearchExample",
            targets: ["ElementaryCyclesSearchExample"]),
    ],
    dependencies: [
        .package(url: "https://github.com/hectr/swift-idioms.git", from: "1.4.0"),
    ],
    targets: [
        .target(
            name: "ElementaryCyclesSearchExample",
            dependencies: ["ElementaryCyclesSearch"]),
        .target(
            name: "ElementaryCyclesSearch",
            dependencies: ["Idioms"]),
        .target(
            name: "ElementaryCycles",
            dependencies: ["ElementaryCyclesSearch"]),
        .testTarget(
            name: "ElementaryCyclesSearchTests",
            dependencies: ["ElementaryCyclesSearch"]),
        .testTarget(
            name: "ElementaryCyclesTests",
            dependencies: ["ElementaryCycles"]),
    ]
)
