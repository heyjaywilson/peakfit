//
// -----------------------------------------------------------
// Project: PeakFit
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

import AppEntry
import DataStorage
import SwiftData
import SwiftUI

@main
struct PeakFitApp: App {
	var body: some Scene {
		WindowGroup {
			AppEntry()
		}
		.modelContainer(DataStorage.productionModelContainer)
	}
}
