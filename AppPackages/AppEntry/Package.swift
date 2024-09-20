// Copyright 2024 CCT Plus LLC
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
	name: "AppEntry",
	platforms: [.iOS(.v18)],
	products: [
		// Products define the executables and libraries a package produces, making them visible to other packages.
		.library(
			name: "AppEntry",
			targets: ["AppEntry"]
		)
	],
	dependencies: [.package(name: "Exercises", path: "./../Exercises")],
	targets: [
		// Targets are the basic building blocks of a package, defining a module or a test suite.
		// Targets can depend on other targets in this package and products from dependencies.
		.target(
			name: "AppEntry",
			dependencies: [.byName(name: "Exercises")]
		),
		.testTarget(
			name: "AppEntryTests",
			dependencies: ["AppEntry"]
		),
	]
)
