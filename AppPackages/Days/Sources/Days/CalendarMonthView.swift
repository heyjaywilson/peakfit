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

import SwiftUI
import Utilities

struct CalendarMonthView: View {
	var date: Date

	let daysOfWeeks = Date.capitalizedFirstLettersOfWeekdays

	let columns: [GridItem] = [
		.init(.flexible()),
		.init(.flexible()),
		.init(.flexible()),
		.init(.flexible()),
		.init(.flexible()),
		.init(.flexible()),
		.init(.flexible()),
	]

	var body: some View {
		VStack {
			Text(DateFormatters.monthString.string(from: date))
			LazyVGrid(columns: columns) {
				ForEach(daysOfWeeks, id: \.self) { day in
					Text(day)
				}
			}
		}
	}
}

#Preview {
	CalendarMonthView(date: .now)
}
