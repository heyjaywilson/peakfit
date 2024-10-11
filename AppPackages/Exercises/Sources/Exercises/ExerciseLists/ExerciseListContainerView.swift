// Copyright 2024 CCT Plus LLC
// Licensed under the Apache License, Version 2.0 (the "License");
// you may obtain a copy of the License at
//     http://www.apache.org/licenses/LICENSE-2.0
// -----------------------------------------------------------
// Project: Exercises
// Created on 9/11/24 by @HeyJayWilson
// -----------------------------------------------------------

import DataStorage
import SwiftData
import SwiftUI

public struct ExerciseListContainerView: View {
    @Environment(\.modelContext) private var modelContext
    
    // Sorting by name here because I don't have an order field
    @State private var sortOrder = SortDescriptor(\ExerciseList.name)
    
    @State private var showNewListView: Bool = false
    
    public init() {}
    
    public var body: some View {
        NavigationStack {
            ExerciseListView(sortOrder: sortOrder)
                .navigationTitle("My Lists")
                .toolbar {
                    ToolbarItem {
                        Button("Add list", systemImage: "plus.circle") {
                            showNewListView = true
                        }
                    }
                    
                    ToolbarItem {
                        Menu("Sort", systemImage: "arrow.up.arrow.down") {
                            Picker("Sort", selection: $sortOrder) {
                                Text("Alphabetical")
                                    .tag(SortDescriptor(\ExerciseList.name))
                            }
                        }
                    }
                }
                .sheet(isPresented: $showNewListView) {
                    NewExerciseList()
                }
        }
    }
}

#Preview {
    ExerciseListContainerView()
        .modelContainer(ExerciseList.previewModel)
}
