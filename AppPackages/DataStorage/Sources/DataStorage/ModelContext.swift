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

extension ModelContext {
	/// Returns a specific model for an ID
	public func getModel<T>(for id: PersistentIdentifier) throws -> T? where T: PersistentModel {
		// If the model is already in the context, let's grab it
		if let model: T = registeredModel(for: id) {
			return model
		}
		// Else let's fetch it
		let predicate = #Predicate<T> { $0.persistentModelID == id }

		return try fetch(FetchDescriptor(predicate: predicate)).first
	}
}
