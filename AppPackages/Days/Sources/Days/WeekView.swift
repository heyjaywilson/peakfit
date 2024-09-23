//
// -----------------------------------------------------------
// Project: Days
// Created on 9/21/24 by @HeyJayWilson
// -----------------------------------------------------------
// Find HeyJayWilson on the web:
// 🕸️ Website             https://heyjaywilson.com
// 💻 Follow on GitHub:   https://github.com/heyjaywilson
// 🧵 Follow on Threads:  https://threads.net/@heyjaywilson
// 💭 Follow on Mastodon: https://iosdev.space/@heyjaywilson
// ☕ Buy me a ko-fi:     https://ko-fi.com/heyjaywilson
// -----------------------------------------------------------
//

import SwiftUI
import Utilities

struct WeekView: View {
	@Binding var selectedDate: Date?

	var week: Week

	var body: some View {
		HStack(spacing: 4) {
			ForEach(week.days) { calendarDay in
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
}

#Preview {
	WeekView(
		selectedDate: .constant(.Constants.sunday),
		week: .init(
			startDate: .Constants.sunday,
			endDate: .Constants.saturday,
			days: [
				.init(date: .Constants.sunday, hasExercises: true),
				.init(date: .Constants.monday, hasExercises: false),
				.init(date: .Constants.tuesday, hasExercises: false),
				.init(date: .Constants.wednesday, hasExercises: false),
				.init(date: .Constants.thursday, hasExercises: true),
				.init(date: .Constants.friday, hasExercises: false),
				.init(date: .Constants.saturday, hasExercises: true),
			]
		)
	)
}
