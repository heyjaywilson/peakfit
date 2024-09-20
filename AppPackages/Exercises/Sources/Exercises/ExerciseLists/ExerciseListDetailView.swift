// Copyright 2024 CCT Plus LLC
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// -----------------------------------------------------------
// Project: Exercises
// Created on 9/11/24 by @HeyJayWilson
// -----------------------------------------------------------
// Find HeyJayWilson on the web:
// 🕸️ Website             https://heyjaywilson.com
// 💻 Follow on GitHub:   https://github.com/heyjaywilson
// 🧵 Follow on Threads:  https://threads.net/@heyjaywilson
// 💭 Follow on Mastodon: https://iosdev.space/@heyjaywilson
// ☕ Buy me a ko-fi:     https://ko-fi.com/heyjaywilson
// -----------------------------------------------------------
//

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
						.onDisappear {
							do {
								try modelContext.save()
							}
							catch {
								print(#file, #function, "Error saving model: \(error)")
							}
						}
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
			}
			catch {
				print(#file, #function, "Error deleting exercise: \(error)")
			}
		}
	}
}
