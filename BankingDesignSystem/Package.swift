// swift-tools-version: 6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "BankingDesignSystem",
    platforms: [
        .iOS(.v18)
    ],
    products: [
        .library(
            name: "BankingDesignSystem",
            targets: ["BankingDesignSystem"]
        ),
    ],
    targets: [
        .target(
            name: "BankingDesignSystem"
        ),
    ]
)
