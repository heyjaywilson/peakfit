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
	dependencies: [
		.package(name: "Exercises", path: "./../Exercises"),
		.package(name: "Days", path: "./../Days"),
		.package(name: "Settings", path: "./../Settings"),
	],
	targets: [
		// Targets are the basic building blocks of a package, defining a module or a test suite.
		// Targets can depend on other targets in this package and products from dependencies.
		.target(
			name: "AppEntry",
			dependencies: [
				.byName(
					name: "Exercises"
				),
				.byName(
					name: "Days"
				),
				.byName(
					name: "Settings"
				),
			]
		),
		.testTarget(
			name: "AppEntryTests",
			dependencies: ["AppEntry"]
		),
	]
)
