// Copyright 2024 CCT Plus LLC
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// -----------------------------------------------------------
// Project: DataStorage
// Created on 9/18/24 by @HeyJayWilson
// -----------------------------------------------------------
// Find HeyJayWilson on the web:
// 🕸️ Website             https://heyjaywilson.com
// 💻 Follow on GitHub:   https://github.com/heyjaywilson
// 🧵 Follow on Threads:  https://threads.net/@heyjaywilson
// 💭 Follow on Mastodon: https://iosdev.space/@heyjaywilson
// ☕ Buy me a ko-fi:     https://ko-fi.com/heyjaywilson
// -----------------------------------------------------------
//

import Foundation
import SwiftData
import Testing

@testable import DataStorage

struct ExerciseTests {

	enum ExerciseName: String, CaseIterable {
		case pushUps = "push ups"
		case bicepCurls = "bicep curls"
		case tricepExtensions = "tricep extensions"
	}

	@MainActor
	@Test("All exercises available", arguments: ExerciseName.allCases)
	func insertingNewExercise(exerciseName: ExerciseName) async throws {
		// Write your test here and use APIs like `#expect(...)` to check expected conditions.
		let config = ModelConfiguration(isStoredInMemoryOnly: true)
		let container = try ModelContainer(for: Exercise.self, configurations: config)

		// Create a background actor
		let actor = Exercise.Service(modelContainer: container)

		// use actor to add a new exercise
		try await actor.addExercise(name: exerciseName.rawValue)

		// Get exercises to check
		let exerciseIDs = Task.detached {
			return try await Exercise.Service(modelContainer: container).getAllIDs()
		}

		let exercises: [Exercise] = try! await exerciseIDs.value.compactMap { id in
			return try container.mainContext.getModel(for: id)
		}

		try #require(exercises.count == 1)
		#expect(exercises[0].name == exerciseName.rawValue)
	}

}
