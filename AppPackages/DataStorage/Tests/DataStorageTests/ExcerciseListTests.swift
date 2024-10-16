//
// -----------------------------------------------------------
// Copyright 2024 CCT Plus LLC
// Licensed under the Apache License, Version 2.0 (the "License");
// you may obtain a copy of the License at
//     http://www.apache.org/licenses/LICENSE-2.0
// -----------------------------------------------------------
// Project: DataStorage
// Created on 16.10.24
// -----------------------------------------------------------
//

import Testing
import SwiftData
@testable import DataStorage

struct ExcerciseListTests {
    @Test("Sort all exercises in list alphabetically")
	func sortingExercisesAlphabetically() async throws {
		let config = ModelConfiguration(isStoredInMemoryOnly: true)
		let container = try ModelContainer(for: Exercise.self, configurations: config)

		let actor = ExerciseList.Service(modelContainer: container)

		let exercise1 = Exercise(name: "abc")
		let exercise2 = Exercise(name: "bcd")
		let exercise3 = Exercise(name: "XYZ")
		let exercise4 = Exercise(name: "XZY")

		let expectedList: [Exercise] = [
			exercise1,
			exercise2,
			exercise3,
			exercise4
		]

		let sut = ExerciseList(name: "Test", exercises: [
			exercise3,
			exercise1,
			exercise4,
			exercise2
		])

		sut.sortExercises(by: .alphabetical)

		#expect(sut.exercises == expectedList)
    }
}
