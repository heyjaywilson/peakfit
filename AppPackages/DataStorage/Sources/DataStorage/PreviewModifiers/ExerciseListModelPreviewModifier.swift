//
// -----------------------------------------------------------
// Project: DataStorage
// Created on 9/14/24 by @HeyJayWilson
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
import SwiftUI

public struct ExerciseListModelPreviewModifier: PreviewModifier {
	public init() {}

	public static func makeSharedContext() async throws -> ModelContainer {
		return ExerciseList.previewModel
	}

	public func body(content: Content, context: ModelContainer) -> some View {
		content
			.modelContainer(context)
	}
}
