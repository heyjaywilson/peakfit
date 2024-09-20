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
import SwiftUI

struct NewExerciseView: View {
	@Environment(\.dismiss) var dismiss
	@Environment(\.modelContext) private var modelContext

	@State private var name: String = ""

	var body: some View {
		Form {
			TextField("Exercise name", text: $name)
		}
		.navigationTitle("New Exercise")
		.toolbar {
			ToolbarItem(placement: .cancellationAction) {
				Button("Cancel") {
					dismiss()
				}
				.tint(.red)
			}
			ToolbarItem(placement: .confirmationAction) {
				Button("Add Exercise") {
					saveExercise()
				}
			}
		}
	}
}

#Preview {
	NavigationStack {
		NewExerciseView()
	}
}

extension NewExerciseView {
	func saveExercise() {
		let container = modelContext.container
		let newName = name
		Task {
			let actor = Exercise.Service(modelContainer: container)
			do {
				try await actor.addExercise(name: newName)
			}
			catch {
				print("🚨 \(#file) \(#function) \(error)")
			}
		}
		dismiss()
	}
}
