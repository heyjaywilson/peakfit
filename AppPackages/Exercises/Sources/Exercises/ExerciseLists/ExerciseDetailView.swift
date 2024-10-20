// Copyright 2024 CCT Plus LLC
// Licensed under the Apache License, Version 2.0 (the "License");
// you may obtain a copy of the License at
//     http://www.apache.org/licenses/LICENSE-2.0
// -----------------------------------------------------------
// Project: Exercises
// Created on 9/13/24 by @HeyJayWilson
// -----------------------------------------------------------

import DataStorage
import Design
import SwiftData
import SwiftUI
import Utilities

struct ExerciseDetailView: View {
	@Environment(\.modelContext) private var modelContext
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
			} else {
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

#Preview("Exercise with entries", traits: .modifier(ExerciseModelPreviewModifier())) {
	@Previewable @Query var exercises: [Exercise]

	NavigationStack {
		ExerciseDetailView(for: exercises.first(where: { !$0.sets.isEmpty })!.name)
	}
	.modelContainer(Exercise.previewModel)
}

#Preview("Exercise without entries", traits: .modifier(ExerciseModelPreviewModifier())) {
	@Previewable @Query var exercises: [Exercise]

	NavigationStack {
		ExerciseDetailView(for: exercises.first(where: { $0.sets.isEmpty })!.name)
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
					.swipeActions(edge: .trailing) {
						Button(role: .destructive) {
							deleteSet(set)
						} label: {
							Label("Delete", systemImage: "trash")
						}
					}
					.swipeActions(edge: .leading) {
						Button {
							repeatSet(set)
						} label: {
							Label(
								"Repeat",
								systemImage: "repeat"
							)
						}
						.tint(.orange)
					}
				}
			} header: {
				Text(
					setsByDate.date.relativeString(todayString: "Today")
				)
				.caption()
				.bold()
			}
		}
	}

	func deleteSet(_ set: ExerciseSet) {
		let id = set.persistentModelID
		let container = modelContext.container

		Task.detached(priority: .userInitiated) {
			let service = ExerciseSet.Service(modelContainer: container)
			do {
				try await service.deleteSet(for: [id])
			} catch {
				print("🚨 \(#file) \(#function) \(error)")
			}
		}
	}

	func repeatSet(_ set: ExerciseSet) {
		let exerciseID = exercise.persistentModelID
		let weight = set.weight
		let reps = set.reps
		let container = modelContext.container

		Task.detached(priority: .userInitiated) {
			let service = ExerciseSet.Service(modelContainer: container)
			do {
				try await service.addSet(
					for: exerciseID,
					weight: weight,
					reps: reps
				)
			} catch {
				print("🚨 \(#file) \(#function) \(error)")
			}
		}
	}
}
