//
// -----------------------------------------------------------
// Copyright 2024 CCT Plus LLC
// Licensed under the Apache License, Version 2.0 (the "License");
// you may obtain a copy of the License at
//     http://www.apache.org/licenses/LICENSE-2.0
// -----------------------------------------------------------
// Project: Days
// Created on 9/27/24
// -----------------------------------------------------------
//

import DataStorage
import SwiftUI
import Utilities

struct CalendarDayView: View {
	@Environment(\.modelContext) var modelContext
	@State var hasExercises: Bool = false

	var date: Date

	var body: some View {
		ZStack {
			RoundedRectangle(cornerRadius: .radiusSmall, style: .circular)
				.fill(hasExercises ? Color.accentColor : .clear)
				.overlay {
					RoundedRectangle(cornerRadius: .radiusSmall, style: .circular)
						.fill(Material.ultraThin)
				}
			Text(date.dayOfMonth.formatted())
				.padding(.vertical, .paddingBase)
				.foregroundStyle(hasExercises ? .white : .primary)
		}
		.task {
			await determineIfDateHasExercises()
		}
	}
}

#Preview {
	CalendarDayView(date: .now)
		.modelContainer(Exercise.previewModel)
}

extension CalendarDayView {
	func determineIfDateHasExercises() async {
		let container = modelContext.container
		let service = ExerciseSet.Service(modelContainer: container)
		do {
			let hasExercise = try await service.hasSet(for: date)
			await MainActor.run {
				self.hasExercises = hasExercise
			}
		} catch {
			print("Error determining if date has exercises: \(error)")
		}
	}
}
