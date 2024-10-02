// Copyright 2024 CCT Plus LLC
// Licensed under the Apache License, Version 2.0 (the "License");
// you may obtain a copy of the License at
//     http://www.apache.org/licenses/LICENSE-2.0
// -----------------------------------------------------------
// Project: DataStorage
// Created on 9/10/24 by @HeyJayWilson
// -----------------------------------------------------------

import SwiftData

public struct DataStorage {
	/// Model container to use when in production
	public static let productionModelContainer = {
		let schema = Schema(
			[
				Exercise.self,
				ExerciseSet.self,
				ExerciseList.self,
			]
		)
		let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

		do {
			return try ModelContainer(
				for: schema,
				configurations: [modelConfiguration]
			)
		} catch {
			fatalError("Could not create ModelContainer: \(error)")
		}
	}()
}
