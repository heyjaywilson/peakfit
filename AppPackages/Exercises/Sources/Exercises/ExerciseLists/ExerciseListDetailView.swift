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
// Copyright© 2024 CCT Plus LLC. All rights reserved.
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
