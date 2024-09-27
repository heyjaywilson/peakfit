//
// -----------------------------------------------------------
// Project: Days
// Created on 9/22/24 by @HeyJayWilson
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
import SwiftUI
import Utilities

struct CalendarMonthView: View {
	@Environment(\.dismiss) var dismiss

	@Binding var selectedDate: Date?
	var date: Date

	let daysOfWeeks = Date.capitalizedFirstLettersOfWeekdays

	/// Columns in grid
	let columns: [GridItem] = [
		.init(.flexible()),
		.init(.flexible()),
		.init(.flexible()),
		.init(.flexible()),
		.init(.flexible()),
		.init(.flexible()),
		.init(.flexible()),
	]

	/// The processed calendar days in the month.
	var daysInMonth: [Date] {
		var returnValue = [Date]()
		for day in 1...Date.daysInMonth(for: date) {
			returnValue.append(
				Calendar.current.date(
					from: DateComponents(
						year: Calendar.current.component(.year, from: date),
						month: Calendar.current.component(.month, from: date), day: day))!)
		}
		return returnValue
	}

	/// How many views to skip before 1
	var daysBeforeStartOfMonth: Int {
		let startOfMonth = Date.startOfMonth(for: date)
		return startOfMonth.weekdayInt - 1
	}

	var body: some View {
		VStack {
			Text(DateFormatters.monthString.string(from: date))
				.font(.headline)
			LazyVGrid(columns: columns) {
				ForEach(daysOfWeeks, id: \.self) { day in
					Text(day)
						.bold()
						.fontDesign(.rounded)
				}
				ForEach(0..<daysBeforeStartOfMonth, id: \.self) { _ in
					Color.clear
				}
				ForEach(daysInMonth, id: \.self) { date in
					Button {
						selectedDate = date
						dismiss()
					} label: {
						CalendarDayView(date: date)
					}

				}
			}
		}
	}
}

#Preview {
	CalendarMonthView(selectedDate: .constant(.now), date: .now)
		.padding()
		.modelContainer(Exercise.previewModel)
	CalendarMonthView(selectedDate: .constant(.now), date: .Constants.monday)
		.padding()
		.modelContainer(Exercise.previewModel)
}
