// Copyright 2024 CCT Plus LLC
// Licensed under the Apache License, Version 2.0 (the "License");
// you may obtain a copy of the License at
//     http://www.apache.org/licenses/LICENSE-2.0
// -----------------------------------------------------------
// Project: Exercises
// Created on 9/13/24 by @HeyJayWilson
// -----------------------------------------------------------

import DataStorage
import SwiftUI

struct NewExerciseListModel {
	var name: String = ""
	var description: String = ""
	var icon: String = "dumbbell"
}

struct NewExerciseList: View {
	@Environment(\.dismiss) var dismiss
	@Environment(\.modelContext) private var modelContext

	@State private var newExerciseList = NewExerciseListModel()

	var body: some View {
		NavigationStack {
			Form {
				HStack {
					Image(systemName: newExerciseList.icon)
						.resizable()
						.aspectRatio(contentMode: .fit)
						.frame(height: 50)
				}
				.padding(.bottom)
				.frame(maxWidth: .infinity)
				.listRowBackground(Color.clear)
				Section {
					TextField(
						"Name",
						text: $newExerciseList.name,
						prompt: Text("Upper body, Push day, Monday, etc.")
					)
				} header: {
					Text("Name")
				}

				Section {
					SFSymbolPicker(selectedSymbol: $newExerciseList.icon)
				} header: {
					Text("Icon")
				}
			}
			.toolbar {
				ToolbarItem(placement: .cancellationAction) {
					Button("Cancel") {
						cancel()
					}
					.tint(.red)
				}

				ToolbarItem(placement: .confirmationAction) {
					Button("Save") {
						save()
					}
				}
			}
		}
	}

	// Create a new exercise list and then close the sheet or whatever view is open
	func save() {
		let newList = ExerciseList(
			name: newExerciseList.name,
			summary: newExerciseList.description,
			icon: newExerciseList.icon
		)
		modelContext.insert(newList)
		dismiss()
	}

	func cancel() {
		// TODO: Double check if the user really wants to cancel if the user has changed anything
		dismiss()
	}
}

#Preview {
	NewExerciseList()
		.modelContainer(ExerciseList.previewModel)
}
