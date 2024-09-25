// Copyright 2024 CCT Plus LLC
// Licensed under the Apache License, Version 2.0 (the "License");
// you may obtain a copy of the License at
//     http://www.apache.org/licenses/LICENSE-2.0
// -----------------------------------------------------------
// Project: DataStorage
// Created on 9/14/24 by @HeyJayWilson
// -----------------------------------------------------------

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
