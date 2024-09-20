// Copyright 2024 CCT Plus LLC
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// -----------------------------------------------------------
// Project: DataStorage
// Created on 9/10/24 by @HeyJayWilson
// -----------------------------------------------------------
// Find HeyJayWilson on the web:
// 🕸️ Website             https://heyjaywilson.com
// 💻 Follow on GitHub:   https://github.com/heyjaywilson
// 🧵 Follow on Threads:  https://threads.net/@heyjaywilson
// 💭 Follow on Mastodon: https://iosdev.space/@heyjaywilson
// ☕ Buy me a ko-fi:     https://ko-fi.com/heyjaywilson
// -----------------------------------------------------------
//

import SwiftData

extension Exercise {
	@ModelActor
	public actor Service {
		public func addExercise(name: String) throws {
			let newExercise = Exercise(name: name)
			modelContext.insert(newExercise)
			try save()
		}

		/// Saves to the model context
		private func save() throws {
			do {
				try modelContext.save()
			}
			catch {
				print("🚨 \(#file) \(#function) \(error)")
				throw error
			}
		}

		/// Returns PersistentIdentifier for each exercise
		func getAllIDs() throws -> [PersistentIdentifier] {
			let descriptor = FetchDescriptor<Exercise>()
			let exercises = try modelContext.fetch(descriptor)
			return exercises.map { $0.persistentModelID }
		}
	}
}
