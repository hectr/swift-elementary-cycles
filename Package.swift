// swift-tools-version:4.2

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
    ],
    targets: [
        .target(
            name: "ElementaryCyclesSearchExample",
            dependencies: ["ElementaryCyclesSearch"]),
        .target(
            name: "ElementaryCyclesSearch",
            dependencies: []),
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
