// Copyright 2024 CCT Plus LLC
// Licensed under the Apache License, Version 2.0 (the "License");
// you may obtain a copy of the License at
//     http://www.apache.org/licenses/LICENSE-2.0
// -----------------------------------------------------------
// Project: DataStorage
// Created on 9/10/24 by @HeyJayWilson
// -----------------------------------------------------------

import SwiftData

extension Exercise {
	/// This service is responsible for managing exercises in the database. It is used to do any writing to the database.
	@ModelActor
	public actor Service {
		/// Add an Exercise to the database
		/// - Parameter name: The name of the Exercise
		/// - Throws: Any errors that occur during the save operation
		public func addExercise(name: String) throws {
			let newExercise = Exercise(name: name)
			modelContext.insert(newExercise)
			try save()
		}

		/// Save the current modelContext
		/// - Throws: Any errors that occur during the save operation
		///
		/// This needs to be called after any mutations to the modelContext in a background actor so that the changes are persisted.
		private func save() throws {
			do {
				try modelContext.save()
			} catch {
				print("🚨 \(#file) \(#function) \(error)")
				throw error
			}
		}

		/// Delete an Exercise from the database
		/// - Parameter ids: The IDs of the Exercises to delete
		/// - Throws: Any errors that occur during the save operation
		public func delete(for ids: [PersistentIdentifier]) throws {
			for id in ids {
				guard
					let exercise = self[
						id,
						as: Exercise.self
					]
				else {
					print("\(#file) \(#function) Could not find Exercise with ID: \(id)")
					return
				}
				modelContext.delete(exercise)
				try save()
			}
		}

		/// Returns the PersistentIdentifier for each exercise the user has added
		func getAllIDs() throws -> [PersistentIdentifier] {
			let descriptor = FetchDescriptor<Exercise>()
			let exercises = try modelContext.fetch(descriptor)
			return exercises.map { $0.persistentModelID }
		}
	}
}
