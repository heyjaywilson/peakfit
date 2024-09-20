// Copyright 2024 CCT Plus LLC
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// -----------------------------------------------------------
// Project: DataStorage
// Created on 9/19/24 by @HeyJayWilson
// -----------------------------------------------------------
// Find HeyJayWilson on the web:
// 🕸️ Website             https://heyjaywilson.com
// 💻 Follow on GitHub:   https://github.com/heyjaywilson
// 🧵 Follow on Threads:  https://threads.net/@heyjaywilson
// 💭 Follow on Mastodon: https://iosdev.space/@heyjaywilson
// ☕ Buy me a ko-fi:     https://ko-fi.com/heyjaywilson
// -----------------------------------------------------------
//

import Foundation
import SwiftData

extension ExerciseList {
	@ModelActor
	public actor Service {
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

		private func save() throws {
			do {
				try modelContext.save()
			}
			catch {
				print("🚨 \(#file) \(#function) \(error)")
				throw error
			}
		}
	}
}
