//
// -----------------------------------------------------------
// Project: DataStorage
// Created on 9/13/24 by @HeyJayWilson
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
import SwiftUI

public struct ExerciseModelPreviewModifier: PreviewModifier {
	public init() {}

	public static func makeSharedContext() async throws -> ModelContainer {
		return Exercise.previewModel
	}

	public func body(content: Content, context: ModelContainer) -> some View {
		content
			.modelContainer(context)
	}
}
