//
// -----------------------------------------------------------
// Project: Exercises
// Created on 9/14/24 by @HeyJayWilson
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

import DataStorage
import SwiftData
import SwiftUI

/// A list of all exercises that allows an exercise to be selected and added to an ExerciseList
struct SelectExerciseView: View {
	@Environment(\.modelContext) var modelContext
	@Query(sort: \Exercise.name) private var exercises: [Exercise]
	@Query private var exerciseLists: [ExerciseList]

	@State private var selectedExercises: [Exercise] = []
	@State private var showAddExerciseSheet = false

	init(nameOfList: String) {
		let filter = #Predicate<ExerciseList> { $0.name == nameOfList }
		_exerciseLists = Query(filter: filter)
	}

	var body: some View {
		List {
			ForEach(exercises) { exercise in
				Button {
					select(exercise: exercise)
				} label: {
					HStack {
						Image(
							systemName: selectedExercises.contains(where: { $0 == exercise })
								? "checkmark.circle.fill" : "circle"
						)
						.tint(.secondary)
						Text(exercise.name)
					}
				}
				.tint(.primary)
			}
		}
		.navigationTitle("Add exercises")
		.toolbar {
			ToolbarItem(placement: .primaryAction) {
				Button("Add Exercise", systemImage: "plus.circle") {
					showAddExerciseSheet = true
				}
			}
		}
		.task {
			setSelectedExercises()
		}
		.sheet(isPresented: $showAddExerciseSheet) {
			NavigationStack {
				NewExerciseView()
			}
			.presentationDetents([.fraction(0.3), .medium])
		}
	}

	func setSelectedExercises() {
		selectedExercises = exerciseLists.first?.exercises ?? []
	}

	func select(exercise: Exercise) {
		if selectedExercises.contains(where: { $0 == exercise }) {
			selectedExercises.removeAll(where: { $0 == exercise })
		}
		else {
			selectedExercises.append(exercise)
		}
		// Auto update exerciseList
		exerciseLists.first?.exercises = selectedExercises
	}
}

#Preview(traits: .modifier(ExerciseListModelPreviewModifier())) {
	@Previewable @Query var exerciseLists: [ExerciseList]
	NavigationStack {
		SelectExerciseView(nameOfList: "Push Days")
	}
	.modelContainer(ExerciseList.previewModel)
}
