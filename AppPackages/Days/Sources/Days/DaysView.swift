// Copyright 2024 CCT Plus LLC
// Licensed under the Apache License, Version 2.0 (the "License");
// you may obtain a copy of the License at
//     http://www.apache.org/licenses/LICENSE-2.0
// -----------------------------------------------------------
// Project: Days
// Created on 9/20/24 by @HeyJayWilson
// -----------------------------------------------------------

import DataStorage
import Design
import SwiftData
import SwiftUI
import Utilities

public struct DaysView: View {
	@Environment(\.modelContext) private var modelContext

	@State private var weeks: [Week] = []
	@State private var selectedDate: Date? = .now
	@State private var weekPosition: Week.ID?
	@State private var openCalendar: Bool = false

	var monthShown: String {
		guard let currentWeek = weeks.first(where: { $0.id == weekPosition }) else {
			return ""
		}

		return DateFormatters.abbreviatedMonthString.string(from: currentWeek.startDate)
	}

	public init() {}

	public var body: some View {
		NavigationStack {
			VStack(alignment: .leading, spacing: .zero) {
				Text(monthShown + "\(weekPosition ?? 0)")
					.title2()
					.foregroundStyle(.secondary)
					.padding(.leading, .paddingXLarge)
					.task {
						await addWeek(for: .now)
						weekPosition = weeks.first?.id
					}
				ScrollView(.horizontal) {
					LazyHStack {
						ForEach(weeks) { week in
							WeekView(selectedDate: $selectedDate, week: week)
								.id(week.id)
								.containerRelativeFrame(
									.horizontal, count: 1, spacing: .spacingLarge,
									alignment: .center
								)
								.task {
									let previousWeekDate = getDateForPreviousWeek(
										from: week.startDate)
									Task {
										await addWeek(for: previousWeekDate)
									}
								}
						}
					}
					.scrollTargetLayout()
				}
				.scrollTargetBehavior(.viewAligned)
				.scrollPosition(id: $weekPosition)
				.scrollIndicators(.hidden)
				.frame(height: 100)
			}
			DayDetailView(day: selectedDate ?? .now)
				.toolbar {
					ToolbarItem {
						Button("Calendar", systemImage: "calendar") {
							openCalendar.toggle()
						}
					}
				}
				.sheet(isPresented: $openCalendar) {
					// Open the calendar view to the month that was scrolled
					CalendarMonthView(
						selectedDate: $selectedDate,
						date: weeks.first(where: { $0.id == weekPosition })?.startDate ?? .now
					)
					.presentationDetents([.medium])
					.presentationDragIndicator(.visible)
				}
		}
		// Change the scrollview position when the selected date changes
		.onChange(of: selectedDate ?? .now) { oldValue, newValue in
			Task {
				await addWeek(for: newValue)
				await MainActor.run {
					weekPosition =
						weeks.first(where: { $0.startDate == getBeginningOfWeek(for: newValue) })?
						.id
				}
			}
		}
	}
}

#Preview {
	DaysView()
}

extension DaysView {
	func addWeek(for date: Date) async {
		let beginningOfWeek = getBeginningOfWeek(for: date)
		let week = await makeWeek(for: beginningOfWeek)
		// check if week already exists in weeks
		if !weeks.contains(where: { $0.id == week.id }) {
			print("🟢 Week does not exist. Adding to Weeks")
			await MainActor.run {
				weeks.insert(week, at: 0)
			}
		} else {
			print("⚠️ Week already exists so not adding to weeks")
		}
	}

	func getBeginningOfWeek(for date: Date) -> Date {
		let calendar = Calendar.current
		let beginningOfWeek = calendar.date(
			from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: date))!
		return beginningOfWeek
	}

	func getEndOfWeek(for date: Date) -> Date {
		let calendar = Calendar.current
		let endOfWeek = calendar.date(byAdding: .day, value: 6, to: getBeginningOfWeek(for: date))!
		return endOfWeek
	}

	func makeWeek(for beginningOfWeek: Date) async -> Week {
		let calendar = Calendar.current
		let container = modelContext.container
		let service = ExerciseSet.Service(modelContainer: container)

		let days = await withTaskGroup(of: CalendarDay.self) { group in
			for dayOffset in 0..<7 {
				group.addTask {
					let date = calendar.date(byAdding: .day, value: dayOffset, to: beginningOfWeek)!
					let hasExercise = (try? await service.hasSet(for: date)) ?? false
					return CalendarDay(date: date, hasExercises: hasExercise)
				}
			}

			var results: [CalendarDay] = []
			for await day in group {
				results.append(day)
			}
			return results.sorted { $0.date < $1.date }
		}

		return Week(startDate: beginningOfWeek, endDate: days.last!.date, days: days)
	}

	func getDateForPreviousWeek(from date: Date) -> Date {
		let calendar = Calendar.current
		let newDate = calendar.date(byAdding: .day, value: -1, to: date)!
		return newDate
	}
}
