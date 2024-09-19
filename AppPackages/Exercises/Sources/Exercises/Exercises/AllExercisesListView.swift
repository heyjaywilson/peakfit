//
// -----------------------------------------------------------
// Project: Exercises
// Created on 9/13/24 by @HeyJayWilson
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

struct AllExercisesListView: View {
	@Query(sort: \Exercise.name) var exercises: [Exercise]

	@State private var showNewExercise: Bool = false

	var body: some View {
		List(exercises) { exercise in
			Text(exercise.name)
		}
		.navigationTitle("All Exercises")
		.toolbar {
			ToolbarItem(id: "newExercise", placement: .primaryAction) {
				Button("New exercise", systemImage: "plus.circle") {
					showNewExercise = true
				}
			}
		}
		.sheet(isPresented: $showNewExercise) {
			NavigationStack {
				NewExerciseView()
			}
			.presentationDetents([.medium])
		}
	}
}

#Preview(traits: .modifier(ExerciseListModelPreviewModifier())) {
	@Previewable @Query var exerciseLists: [ExerciseList]

	NavigationStack {
		AllExercisesListView()
			.modelContainer(Exercise.previewModel)
	}
}
