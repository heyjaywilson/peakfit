// Copyright 2024 CCT Plus LLC
// Licensed under the Apache License, Version 2.0 (the "License");
// you may obtain a copy of the License at
//     http://www.apache.org/licenses/LICENSE-2.0
// -----------------------------------------------------------
// Project: Days
// Created on 9/20/24
// -----------------------------------------------------------

import DataStorage
import Design
import SwiftData
import SwiftUI

struct DayDetailView: View {
	@Environment(\.modelContext) private var modelContext

	@Query private var exerciseSets: [ExerciseSet]

	@State private var daySummaryViewSize = CGSize.zero

	var exercises: [Exercise] {
		Array(Set(exerciseSets.compactMap { $0.exercise }))
	}

	var exerciseSetsGroupedByExercise: [Exercise: [ExerciseSet]] {
		Dictionary(grouping: exerciseSets) { $0.exercise! }
	}

	var totalReps: Int {
		exerciseSets.reduce(0) { $0 + $1.reps }
	}

	init(day: Date) {
		let calendar = Calendar.current
		let startOfDay = calendar.startOfDay(for: day)
		let endOfDay = calendar.date(byAdding: .day, value: 1, to: startOfDay)!
		let setFilter = #Predicate<ExerciseSet> { set in
			set.completedDate >= startOfDay && set.completedDate < endOfDay
		}
		_exerciseSets = Query(filter: setFilter)
	}

	var body: some View {
		ZStack(alignment: .top) {
			VStack {
				ScrollView {
					Color.clear
						.frame(height: daySummaryViewSize.height)
					LazyVStack(spacing: .spacingLarge) {
						ForEach(exercises) { exercise in
							section(for: exercise)
							// TODO: Figure out how to only animate when the view is exiting at the top
							//								.scrollTransition { content, phase in
							//									content
							//										.scaleEffect(1 - abs(phase.value) * 0.1)
							//								}
						}
					}

				}
				.contentMargins(.contentMarginsBase, for: .scrollContent)
			}
			daySummary
				.padding(.bottom)
				.padding(.horizontal, .paddingLarge)
				.overlay {
					GeometryReader { proxy in
						Color.clear
							.task {
								daySummaryViewSize.height = proxy.size.height - 20
							}
					}
				}
		}
	}
}

#Preview {
	DayDetailView(day: .now)
		.modelContainer(Exercise.previewModel)
}

extension DayDetailView {
	@ViewBuilder var daySummary: some View {
		VStack(alignment: .leading, spacing: .spacingLarge) {
			HStack {
				VStack(alignment: .leading, spacing: .spacingSmall) {
					Text("Sets")
						.headline()
					Text(exerciseSets.count.formatted())
						.title()
						.foregroundStyle(exerciseSets.isEmpty ? .secondary : Color.red)
						.contentTransition(.numericText())
				}
				Spacer()
				VStack(alignment: .leading, spacing: .spacingSmall) {
					Text("Repetitions")
						.headline()
					Text(totalReps.formatted())
						.title()
						.foregroundStyle(totalReps <= 0 ? .secondary : Color.blue)
						.contentTransition(.numericText())
				}
			}
			HStack {
				VStack(alignment: .leading, spacing: .spacingSmall) {
					Text("Exercises")
						.headline()
					Text(exercises.count.formatted())
						.title()
						.foregroundStyle(exercises.isEmpty ? .secondary : Color.orange)
						.contentTransition(.numericText())
				}
			}
		}
		.frame(maxWidth: .infinity, alignment: .leading)
		.padding(.paddingLarge)
		.background {
			RoundedRectangle(cornerRadius: .radiusBase)
				.fill(Material.ultraThin)
				.shadow(radius: .radiusSmall)
		}
	}

	@ViewBuilder func section(for exercise: Exercise) -> some View {
		VStack(alignment: .leading) {
			Section {
				if let exerciseSets = exerciseSetsGroupedByExercise[exercise] {
					ForEach(exerciseSets) { exerciseSet in
						DayExerciseRow(set: exerciseSet)
					}
				}
			} header: {
				HStack {
					Text(exercise.name)
						.title2()
					Spacer()
					HStack {
						Text(totalReps(for: exercise).formatted())
							.foregroundStyle(.blue)
							.bold()
							+ Text(" Reps")
					}
					.padding(.trailing, .paddingBase)
					HStack {
						Text(totalWeight(for: exercise).formatted())
							.foregroundStyle(.green)
							.bold()
							+ Text(" lbs")
					}
				}
			}
		}
		.padding(16)
		.frame(maxWidth: .infinity, alignment: .leading)
		.background {
			RoundedRectangle(cornerRadius: .radiusBase, style: .continuous)
				.fill(Material.ultraThin)
		}
	}

	func totalReps(for exercise: Exercise) -> Int {
		exerciseSetsGroupedByExercise[exercise]?.reduce(0) { $0 + $1.reps } ?? 0
	}

	func totalWeight(for exercise: Exercise) -> Double {
		exerciseSetsGroupedByExercise[exercise]?.reduce(0) { $0 + $1.weight } ?? 0
	}
}
