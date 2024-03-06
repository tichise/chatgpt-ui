// swift-tools-version:5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ChatGPTUI",
    platforms: [
        .iOS(.v16),
    ],
    products: [
        .library(
            name: "ChatGPTUI",
            targets: ["ChatGPTUI"]),
    ],
    dependencies: [
        .package(url: "https://github.com/tichise/TILogger.git", from: "1.3.1"),
        .package(url: "https://github.com/MacPaw/OpenAI.git", from: "0.2.6"),
    ],
    targets: [
        .target(
            name: "ChatGPTUI",
            dependencies: ["TILogger", "OpenAI"]
        ),
        .testTarget(
            name: "ChatGPTUITests",
            dependencies: ["ChatGPTUI"]),
    ]
)
