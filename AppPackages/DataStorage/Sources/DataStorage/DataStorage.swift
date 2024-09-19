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
// Copyright© 2024 CCT Plus LLC. All rights reserved.
//

import SwiftData

public struct DataStorage {
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
		}
		catch {
			fatalError("Could not create ModelContainer: \(error)")
		}
	}()
}
