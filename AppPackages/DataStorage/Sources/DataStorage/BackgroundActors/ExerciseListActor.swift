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

extension ExerciseList {
	@ModelActor
	public actor Service {
		/// Delete lists for given persistent identifiers
		public func deleteList(for ids: [PersistentIdentifier]) throws {
			for id in ids {
				guard let list = self[id, as: ExerciseList.self] else {
					print("\(#file) \(#function) \(id) not found")
					return
				}
				modelContext.delete(list)
				try save()
			}
		}

		/// Save the modelContext as it is right now
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
