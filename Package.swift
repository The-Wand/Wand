// swift-tools-version: 5.6
///
/// Copyright 2020 Alexander Kozin
///
/// Licensed under the Apache License, Version 2.0 (the "License");
/// you may not use this file except in compliance with the License.
/// You may obtain a copy of the License at
///
///     http://www.apache.org/licenses/LICENSE-2.0
///
/// Unless required by applicable law or agreed to in writing, software
/// distributed under the License is distributed on an "AS IS" BASIS,
/// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
/// See the License for the specific language governing permissions and
/// limitations under the License.
///
/// Created by Alex Kozin
/// El Machine 🤖

import PackageDescription

let package = Package(
    name: "Wand",

    platforms: [
        .iOS(.v14),
        .macOS(.v12),
        .tvOS(.v14),
        .watchOS(.v7),
    ],

    products: [
        .library(name: "Wand", targets: ["Wand"])
    ],

    dependencies: [
        .package(url: "https://github.com/The-Wand/Any.git", .upToNextMajor(from: "1.0.1") ),
        .package(url: "https://github.com/swiftlang/swift-docc-plugin", .upToNextMajor(from: "1.1.0") ),
    ],
    targets: [
        .target(name: "Wand"),
        .testTarget(name: "WandTests", dependencies:
                        [
                            "Wand",
                            .product(name: "Any_", package: "Any")
                        ]
                   )
    ]
)

