// Copyright 2024 CCT Plus LLC
// Licensed under the Apache License, Version 2.0 (the "License");
// you may obtain a copy of the License at
//     http://www.apache.org/licenses/LICENSE-2.0
// -----------------------------------------------------------
// Project: Exercises
// Created on 9/11/24 by @HeyJayWilson
// -----------------------------------------------------------

import DataStorage
import SwiftUI

struct ExerciseListDetailView: View {
	@Environment(\.modelContext) var modelContext

	var exerciseList: ExerciseList

	var body: some View {
		List {
			if exerciseList.exercises.isEmpty {
				NavigationLink("No exercises yet! Add one!") {
					SelectExerciseView(nameOfList: exerciseList.name)
				}
			}
			ForEach(exerciseList.exercises) { exercise in
				NavigationLink {
					// Allow the view to fetch it's own exercise instead of being dependent on it being passed in
					ExerciseDetailView(for: exercise.name)
				} label: {
					HStack {
						Text(exercise.name)
						Spacer()
						if let lastCompletedDate = exercise.lastCompletedDate {
							Text(lastCompletedDate.formatted(.relative(presentation: .numeric)))
						}
					}
				}
				.swipeActions(edge: .trailing) {
					Button(
						role: .destructive
					) {
						deleteExercise(exercise)
					} label: {
						Label(
							"Delete",
							systemImage: "trash"
						)
					}
				}
			}
		}
		.toolbar {
			ToolbarItem(placement: .primaryAction) {
				Menu("Menu", systemImage: "note.text") {
					Button {
						exerciseList.sort(by: .alphabetical)
					} label: {
						Text("Alphabetical")
					}

					Button {} label: {
						Text("Last Completed")
					}
				}
			}
		}
		.navigationTitle(Text(exerciseList.name))
	}
}

#Preview {
	NavigationStack {
		ExerciseListDetailView(
			exerciseList: ExerciseList(name: "Push Day", exercises: [])
		)
	}
	.modelContainer(ExerciseList.previewModel)
}

extension ExerciseListDetailView {
	func deleteExercise(_ exercise: Exercise) {
		let exerciseID = exercise.persistentModelID
		let container = modelContext.container
		Task.detached(priority: .userInitiated) {
			let service = Exercise.Service(modelContainer: container)
			do {
				try await service.delete(for: [exerciseID])
			} catch {
				print(#file, #function, "Error deleting exercise: \(error)")
			}
		}
	}
}
