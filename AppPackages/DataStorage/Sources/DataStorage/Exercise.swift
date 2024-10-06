// Copyright 2024 CCT Plus LLC
// Licensed under the Apache License, Version 2.0 (the "License");
// you may obtain a copy of the License at
//     http://www.apache.org/licenses/LICENSE-2.0
// -----------------------------------------------------------
// Project: DataStorage
// Created on 9/10/24 by @HeyJayWilson
// -----------------------------------------------------------

import Foundation
import SwiftData

@Model
final public class Exercise {
	public var name: String

	@Relationship(inverse: \ExerciseSet.exercise)
	public var sets: [ExerciseSet] = []

	public var lists: [ExerciseList] = []

	public init(name: String, sets: [ExerciseSet] = [], lists: [ExerciseList] = []) {
		self.name = name
		self.sets = sets
	}
}

extension Exercise {
	/// Get the last completed date of the exercise
	public var lastCompletedDate: Date? {
		sets.sorted(by: { $0.completedDate < $1.completedDate }).first?.completedDate
	}

	/// Groups sets by the day completed
	///
	/// The time is ignored since we are doing start of day
	public var setsByDate: [SetsByDate] {
		var returnValue: [SetsByDate] = []

		let groupedData = Dictionary(grouping: sets) { set in
			Calendar.current.startOfDay(for: set.completedDate)
		}

		for (date, sets) in groupedData {
			returnValue.append(.init(date: date, sets: sets))
		}

		returnValue.sort(by: { $0.date > $1.date })

		return returnValue
	}
}

extension Exercise {
	/// Model container that has an exercise
	@MainActor
	public static var previewModel: ModelContainer {
		let container = try! ModelContainer(
			for: Exercise.self,
			configurations: ModelConfiguration(isStoredInMemoryOnly: true)
		)
		
		let exercise = Exercise( // Should contain sets in the future and past
			name: "Chest Press",
			sets: [
				// Future
				.init(reps: 20, weight: 20, dateCompleted: inDays(2)),
				.init(reps: 20, weight: 20, dateCompleted: inDays(2)),
				.init(reps: 20, weight: 20, dateCompleted: inDays(2)),
				// Today
				.init(reps: 0, weight: 0, dateCompleted: .now),
				// Past
				.init(reps: 1, weight: 1, dateCompleted: inDays(-1)),
				.init(reps: 1, weight: 1, dateCompleted: inDays(-1)),
				.init(reps: 12, weight: 12, dateCompleted: inDays(-12)),
				.init(reps: 12, weight: 12, dateCompleted: inDays(-12)),
				.init(reps: 60, weight: 60, dateCompleted: inDays(-60)),
				.init(reps: 60, weight: 60, dateCompleted: inDays(-60)),
				.init(reps: 61, weight: 60, dateCompleted: inDays(-61)),
				.init(reps: 61, weight: 60, dateCompleted: inDays(-360)),
				.init(reps: 1000, weight: 1000, dateCompleted: .distantPast),
			]
		)
		let exercise1 = Exercise(name: "Bicep Curl") // Leave empty
		
		container.mainContext.insert(exercise)
		container.mainContext.insert(exercise1)
		
		return container
	}
	
	/// Very rough and inaccurate way of getting easy access to days relative to today
	private static func inDays(_ days: Int) -> Date {
		Calendar.current.date(byAdding: .day, value: days, to: .now) ?? .now
	}
}
