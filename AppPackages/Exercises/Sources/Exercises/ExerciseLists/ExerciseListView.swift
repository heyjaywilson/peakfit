// Copyright 2024 CCT Plus LLC
// Licensed under the Apache License, Version 2.0 (the "License");
// you may obtain a copy of the License at
//     http://www.apache.org/licenses/LICENSE-2.0
// -----------------------------------------------------------
// Project: Exercises
// Created on 2024-10-10 by @HeyJayWilson
// -----------------------------------------------------------

import DataStorage
import SwiftData
import SwiftUI

struct ExerciseListView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var lists: [ExerciseList]

    init(sortOrder: SortDescriptor<ExerciseList>) {
        _lists = Query(sort: [sortOrder])
    }

    var body: some View {
        List {
            ForEach(lists) { exerciseList in
                NavigationLink(destination: ExerciseListDetailView(exerciseList: exerciseList))
                {
                    listRow(for: exerciseList)
                }
            }
            .onDelete(perform: deleteList)

            Section {
                NavigationLink("All Exercises") {
                    AllExercisesListView()
                }
            }
        }
    }
}

extension ExerciseListView {
	@ViewBuilder func listRow(for exerciseList: ExerciseList) -> some View {
		HStack {
			Image(systemName: exerciseList.icon)
				.frame(maxWidth: 24)
			Text(exerciseList.name)
			Spacer()
			if let lastCompletedDate = exerciseList.lastCompletedDate {
				Text(
					lastCompletedDate,
					format: .relative(presentation: .named)
				)
			}
		}
	}
}

extension ExerciseListView {
	private func deleteList(at offsets: IndexSet) {
		var ids: [PersistentIdentifier] = []

		for index in offsets {
			let listToDelete = lists[index]
			ids.append(listToDelete.persistentModelID)
		}

		let container = modelContext.container
		let finalIDs = ids

		ids = []

		Task.detached(priority: .userInitiated) {
			let service = ExerciseList.Service(modelContainer: container)
			do {
				try await service.deleteList(for: finalIDs)
			} catch {
				print("🚨 \(#file) \(#function) \(error)")
			}
		}
	}
}

#Preview {
    ExerciseListView(sortOrder: SortDescriptor(\ExerciseList.name, order: .reverse))
}
