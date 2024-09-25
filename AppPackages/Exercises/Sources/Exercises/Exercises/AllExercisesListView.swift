// Copyright 2024 CCT Plus LLC
// Licensed under the Apache License, Version 2.0 (the "License");
// you may obtain a copy of the License at
//     http://www.apache.org/licenses/LICENSE-2.0
// -----------------------------------------------------------
// Project: Exercises
// Created on 9/13/24 by @HeyJayWilson
// -----------------------------------------------------------

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
