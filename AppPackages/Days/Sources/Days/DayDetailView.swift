//
// -----------------------------------------------------------
// Project: Days
// Created on 9/20/24 by @HeyJayWilson
// -----------------------------------------------------------
// Find HeyJayWilson on the web:
// 🕸️ Website             https://heyjaywilson.com
// 💻 Follow on GitHub:   https://github.com/heyjaywilson
// 🧵 Follow on Threads:  https://threads.net/@heyjaywilson
// 💭 Follow on Mastodon: https://iosdev.space/@heyjaywilson
// ☕ Buy me a ko-fi:     https://ko-fi.com/heyjaywilson
// -----------------------------------------------------------
//

import DataStorage
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
					LazyVStack(spacing: 16) {
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
				.contentMargins(16.0, for: .scrollContent)
			}
			daySummary
				.padding(.bottom)
				.padding(.horizontal, 16)
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
		VStack(alignment: .leading, spacing: 16) {
			HStack {
				VStack(alignment: .leading, spacing: 4) {
					Text("Sets")
						.font(.headline)
						.fontDesign(.rounded)
					Text(exerciseSets.count.formatted())
						.font(.title)
						.fontWeight(.bold)
						.fontDesign(.rounded)
						.foregroundStyle(exerciseSets.isEmpty ? .secondary : Color.red)
						.contentTransition(.numericText())
				}
				Spacer()
				VStack(alignment: .leading, spacing: 4) {
					Text("Repetitions")
						.font(.headline)
						.fontDesign(.rounded)
					Text(totalReps.formatted())
						.font(.title)
						.fontWeight(.bold)
						.fontDesign(.rounded)
						.foregroundStyle(totalReps <= 0 ? .secondary : Color.blue)
						.contentTransition(.numericText())
				}
			}
			HStack {
				VStack(alignment: .leading, spacing: 4) {
					Text("Exercises")
						.font(.headline)
						.fontDesign(.rounded)
					Text(exercises.count.formatted())
						.font(.title)
						.fontWeight(.bold)
						.fontDesign(.rounded)
						.foregroundStyle(exercises.isEmpty ? .secondary : Color.orange)
						.contentTransition(.numericText())
				}
			}
		}
		.frame(maxWidth: .infinity, alignment: .leading)
		.padding(16)
		.background {
			RoundedRectangle(cornerRadius: 10)
				.fill(Material.ultraThin)
				.shadow(radius: 8)
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
						.font(.title2)
						.fontWeight(.bold)
						.fontDesign(.rounded)
					Spacer()
					HStack {
						Text(totalReps(for: exercise).formatted())
							.foregroundStyle(.blue)
							.bold()
							+ Text(" Reps")
					}
					.padding(.trailing, 8)
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
			RoundedRectangle(cornerRadius: 10, style: .continuous)
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
