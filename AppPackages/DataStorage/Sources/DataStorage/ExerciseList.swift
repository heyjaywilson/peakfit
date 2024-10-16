// Copyright 2024 CCT Plus LLC
// Licensed under the Apache License, Version 2.0 (the "License");
// you may obtain a copy of the License at
//     http://www.apache.org/licenses/LICENSE-2.0
// -----------------------------------------------------------
// Project: DataStorage
// Created on 9/11/24 by @HeyJayWilson
// -----------------------------------------------------------

import Foundation
import SwiftData

///Holds a group of exercises
///
///Is a SwiftData model
@Model
final public class ExerciseList {
	public var name: String
	public var summary: String
	public var icon: String
	/// Last date a set was completed
	public var lastCompletedDate: Date?

	@Relationship(inverse: \Exercise.lists)
	public var exercises: [Exercise] = []

	public init(
		name: String,
		summary: String = "",
		icon: String = "dumbbell",
		lastCompletedDate: Date? = nil,
		exercises: [Exercise] = []
	) {
		self.name = name
		self.summary = summary
		self.icon = icon
		self.lastCompletedDate = lastCompletedDate
		self.exercises = exercises
	}

	public func addExercise(_ exercise: Exercise) {
		// only add an exercise if it does not exist in the exercises for this list
		if !exercises.contains(where: { $0.name == exercise.name }) {
			exercises.append(exercise)
		}
	}
}

public extension ExerciseList {
	enum SortOption {
		case alphabetical
	}

	func sort(by option: SortOption) {
		switch option {
		case .alphabetical:
			exercises.sort { $0.name.localizedCaseInsensitiveCompare($1.name) == .orderedAscending }
		}
	}
}

extension ExerciseList {
	@MainActor
	public static var previewModel: ModelContainer {
		let container = try! ModelContainer(
			for: ExerciseList.self,
			configurations: ModelConfiguration(isStoredInMemoryOnly: true)
		)

		let pushUp = Exercise(name: "Push up")
		let pullUp = Exercise(name: "Pull up")
		let bentOverRows = Exercise(name: "Bent over rows")
		let bicepCurls = Exercise(name: "Bicep Curls")
		let chestPress = Exercise(name: "Chest Press")

		let pushDays = ExerciseList(name: "Push Days", lastCompletedDate: .now)
		let pullDays = ExerciseList(name: "Pull Days", lastCompletedDate: .distantPast)

		container.mainContext.insert(pushDays)
		pushDays.exercises = [pushUp, chestPress]

		container.mainContext.insert(pullDays)
		pullDays.exercises = [pullUp, bentOverRows, bicepCurls]

		return container
	}

	@MainActor
	public static let preview: ExerciseList = {
		return ExerciseList(
			name: "Push Day",
			lastCompletedDate: .now,
			exercises: [.init(name: "Push up"), .init(name: "Chest Press")]
		)
	}()
}
