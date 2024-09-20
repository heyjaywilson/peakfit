// Copyright 2024 CCT Plus LLC
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
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

struct ExerciseDetailView: View {
	@Query private var foundExercises: [Exercise]

	@State private var showAddSet: Bool = false

	init(for name: String) {
		let filter = #Predicate<Exercise> { exercise in
			exercise.name == name
		}

		_foundExercises = Query(filter: filter)
	}

	var exercise: Exercise {
		foundExercises.first!
	}

	var body: some View {
		Group {
			if exercise.sets.isEmpty {
				noSetsView
			}
			else {
				setListView
			}
		}
		.navigationTitle(exercise.name)
		.toolbar {
			ToolbarItem(placement: .primaryAction) {
				Button("Add set", systemImage: "plus.circle") {
					showAddSet = true
				}
			}
		}
		.sheet(isPresented: $showAddSet) {
			NavigationStack {
				NewSetView(exerciseName: exercise.name)
			}
			.presentationDetents([.medium])
		}
	}
}

#Preview(traits: .modifier(ExerciseModelPreviewModifier())) {
	@Previewable @Query var exercises: [Exercise]

	NavigationStack {
		if let exercise = exercises.first {
			ExerciseDetailView(for: exercise.name)
		}
		else {
			Text("No exercise found")
		}
	}
	.modelContainer(Exercise.previewModel)
}

extension ExerciseDetailView {
	@ViewBuilder var noSetsView: some View {
		Text("No sets view")
	}

	@ViewBuilder var setListView: some View {
		List(exercise.setsByDate, id: \.self) { setsByDate in
			Section {
				// TODO: Make Grid so it's easy to read and all columns are aligned
				ForEach(setsByDate.sets, id: \.self) { set in
					HStack {
						Text(set.completedDate.formatted(date: .omitted, time: .shortened))
						Spacer()
						Text("\(set.reps.formatted()) reps")
						// TODO: Make lbs adjustable
						Text("\(set.weight.formatted()) lbs")
					}
				}
			} header: {
				Text(
					setsByDate.date.formatted(
						.reference(to: .now, allowedFields: [.year, .month, .day])
					)
				)
			}
		}
	}
}
