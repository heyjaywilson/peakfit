// Copyright 2024 CCT Plus LLC
// Licensed under the Apache License, Version 2.0 (the "License");
// you may obtain a copy of the License at
//     http://www.apache.org/licenses/LICENSE-2.0
// -----------------------------------------------------------
// Project: Days
// Created on 9/21/24 by @HeyJayWilson
// -----------------------------------------------------------

import DataStorage
import SwiftUI

struct DayExerciseRow: View {
	var set: ExerciseSet

	let gridItems: [GridItem] = [
		.init(.flexible(minimum: 0, maximum: 200), alignment: .leading),
		.init(.flexible(minimum: 0, maximum: 200), alignment: .trailing),
	]

	var body: some View {
		LazyVGrid(columns: gridItems) {
			Text("\(set.reps.formatted()) reps")
			if set.weight != 0.0 {
				Text("\(set.weight.formatted()) lbs")
			}
		}
	}
}

#Preview {
	ScrollView {
		VStack(alignment: .leading) {
			Section {
				DayExerciseRow(set: .init(reps: 8, weight: 0, dateCompleted: .now))
				DayExerciseRow(set: .init(reps: 8, weight: 0, dateCompleted: .now))
			} header: {
				HStack {
					Text("Push up")
						.title2()
					Spacer()
				}
			}
		}
		.padding(16)
		.frame(maxWidth: .infinity, alignment: .leading)
		.background {
			RoundedRectangle(cornerRadius: 10, style: .continuous)
				.fill(Material.regular)
		}

		VStack(alignment: .leading) {
			Section {
				DayExerciseRow(set: .init(reps: 10, weight: 20, dateCompleted: .now))
				DayExerciseRow(set: .init(reps: 10, weight: 20, dateCompleted: .now))
				DayExerciseRow(set: .init(reps: 10, weight: 20, dateCompleted: .now))
			} header: {
				HStack {
					Text("Bicep Curl")
						.title2()
					Spacer()
				}
			}
		}
		.padding(16)
		.frame(maxWidth: .infinity, alignment: .leading)
		.background {
			RoundedRectangle(cornerRadius: 10, style: .continuous)
				.fill(Material.regular)
		}
	}
	.contentMargins(16)
}
