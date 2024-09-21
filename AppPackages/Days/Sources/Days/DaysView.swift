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

struct CalendarDay: Identifiable {
	var id: Double {
		date.timeIntervalSince1970
	}

	var date: Date
	var hasExercises: Bool
}

public struct DaysView: View {
	@Environment(\.modelContext) private var modelContext

	@State private var calendarDays: [CalendarDay] = []
	@State private var selectedDate: Date?

	public init() {}

	public var body: some View {
		VStack {
			ScrollView(.horizontal) {
				LazyHStack {
					ForEach(calendarDays) { calendarDay in
						Button {
							selectedDate = calendarDay.date
						} label: {
							DaySelectorLabel(
								isSelected: Calendar.current.isDate(
									selectedDate ?? .now, inSameDayAs: calendarDay.date),
								date: calendarDay.date)
						}
						.containerRelativeFrame(
							.horizontal,
							count: 7,
							spacing: 8
						)
					}
				}
			}
			.contentMargins(16, for: .scrollContent)
			.frame(height: 100)
			DayDetailView(day: selectedDate ?? .now)
		}
		.task {
			await getCurrentWeekDays()
		}
	}
}

#Preview {
	DaysView()
}

extension DaysView {
	func getCurrentWeekDays() async {
		let calendar = Calendar.current
		let today = Date()
		let container = modelContext.container

		// Find the start of the week (assuming Sunday is the first day of the week)
		guard
			let startOfWeek = calendar.date(
				from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: today))
		else {
			return
		}

		// Generate 7 days starting from the start of the week
		let generatedCalendarDays = await withTaskGroup(of: CalendarDay?.self) { group in
			for dayOffset in 0..<7 {
				group.addTask {
					guard
						let date = calendar.date(byAdding: .day, value: dayOffset, to: startOfWeek)
					else {
						return nil
					}
					let service = ExerciseSet.Service(modelContainer: container)
					let hasExercise = (try? await service.hasSet(for: date)) ?? false
					return CalendarDay(date: date, hasExercises: hasExercise)
				}
			}

			var results: [CalendarDay] = []
			for await result in group {
				if let result = result {
					results.append(result)
				}
			}
			return results.sorted { $0.date < $1.date }
		}
		await MainActor.run {
			// Set the selected date to today
			selectedDate = today
			calendarDays = generatedCalendarDays
		}
	}
}
