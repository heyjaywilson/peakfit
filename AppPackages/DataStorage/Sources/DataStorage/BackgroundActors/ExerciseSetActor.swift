// Copyright 2024 CCT Plus LLC
// Licensed under the Apache License, Version 2.0 (the "License");
// you may obtain a copy of the License at
//     http://www.apache.org/licenses/LICENSE-2.0
// -----------------------------------------------------------
// Project: DataStorage
// Created on 9/19/24 by @HeyJayWilson
// -----------------------------------------------------------

import Foundation
import SwiftData

extension ExerciseSet {
	@ModelActor
	public actor Service {
		public func deleteSet(for ids: [PersistentIdentifier]) throws {
			for id in ids {
				guard let set = self[id, as: ExerciseSet.self] else {
					print("\(#file) \(#function) \(id) not found")
					return
				}
				modelContext.delete(set)
				try save()
			}
		}

		public func addSet(for exerciseID: PersistentIdentifier, weight: Double, reps: Int) throws {
			guard let exercise = self[exerciseID, as: Exercise.self] else {
				print("\(#file) \(#function) \(exerciseID) not found")
				return
			}
			let newSet = ExerciseSet(
				reps: reps,
				weight: weight,
				dateCompleted: .now
			)
			modelContext.insert(newSet)
			exercise.sets.append(newSet)
			try save()
		}

		public func hasSet(for date: Date) throws -> Bool {
			let calendar = Calendar.current
			let startOfDay = calendar.startOfDay(for: date)
			let endOfDay = calendar.date(byAdding: .day, value: 1, to: startOfDay)!

			let predicate = #Predicate<ExerciseSet> { exerciseSet in
				exerciseSet.completedDate >= startOfDay && exerciseSet.completedDate < endOfDay
			}

			var descriptor = FetchDescriptor<ExerciseSet>(predicate: predicate)
			descriptor.fetchLimit = 1  // We only need to know if at least one exists

			do {
				let sets = try modelContext.fetch(descriptor)
				return !sets.isEmpty
			} catch {
				print("🚨 \(#file) \(#function) Error fetching sets: \(error)")
				throw error
			}
		}

		private func save() throws {
			do {
				try modelContext.save()
			} catch {
				print("🚨 \(#file) \(#function) \(error)")
				throw error
			}
		}
	}
}
