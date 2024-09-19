//
// -----------------------------------------------------------
// Project: DataStorage
// Created on 9/10/24 by @HeyJayWilson
// -----------------------------------------------------------
// Find HeyJayWilson on the web:
// 🕸️ Website             https://heyjaywilson.com
// 💻 Follow on GitHub:   https://github.com/heyjaywilson
// 🧵 Follow on Threads:  https://threads.net/@heyjaywilson
// 💭 Follow on Mastodon: https://iosdev.space/@heyjaywilson
// ☕ Buy me a ko-fi:     https://ko-fi.com/heyjaywilson
// -----------------------------------------------------------
// Copyright© 2024 CCT Plus LLC. All rights reserved.
//

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

		let exercise = Exercise(
			name: "Chest Press",
			sets: [
				.init(reps: 8, weight: 10, dateCompleted: .now),
				.init(reps: 8, weight: 5, dateCompleted: .distantPast),
			]
		)
		let exercise1 = Exercise(name: "Bicep Curl")

		container.mainContext.insert(exercise)
		container.mainContext.insert(exercise1)

		return container
	}
}
