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
// Copyright© 2024 CCT Plus LLC. All rights reserved.
//

import Foundation
import SwiftData

extension ModelContext {
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
