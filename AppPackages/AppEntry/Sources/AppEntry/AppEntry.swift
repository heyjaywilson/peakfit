// Copyright 2024 CCT Plus LLC
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// -----------------------------------------------------------
// Project: AppEntry
// Created on 9/11/24 by @HeyJayWilson
// -----------------------------------------------------------
// Find HeyJayWilson on the web:
// 🕸️ Website             https://heyjaywilson.com
// 💻 Follow on GitHub:   https://github.com/heyjaywilson
// 🧵 Follow on Threads:  https://threads.net/@heyjaywilson
// 💭 Follow on Mastodon: https://iosdev.space/@heyjaywilson
// ☕ Buy me a ko-fi:     https://ko-fi.com/heyjaywilson
// -----------------------------------------------------------
//

import Exercises
import SwiftUI

public struct AppEntry: View {
	public init() {}

	public var body: some View {
		TabView {
			Tab("Sets", systemImage: "dumbbell") {
				ExerciseListView()
			}
			Tab("Days", systemImage: "calendar") {
				Text("Days")
			}
		}
	}
}

#Preview {
	AppEntry()
}
