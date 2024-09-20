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

import SwiftUI
import Utilities

struct Day: View {
	var isSelected: Bool = false

	var date: Date

	var dayOfWeek: String {
		let formatter = DateFormatters.abbreviatedDayString
		return formatter.string(from: date)
	}

	var dayOfMonth: Int {
		let calendar = Calendar.current
		return calendar.component(.day, from: date)
	}

	var body: some View {
		VStack {
			Text(dayOfWeek)
				.font(.caption)
				.textCase(.uppercase)
				.fontDesign(.monospaced)
			Text(dayOfMonth.formatted())
				.fontDesign(.monospaced)
				.fontWeight(.bold)
		}
		.foregroundStyle(
			isSelected ? .white : .primary
		)
		.frame(maxWidth: .infinity, maxHeight: 100)
		.aspectRatio(3 / 4, contentMode: .fit)
		.background {
			RoundedRectangle(cornerRadius: 10, style: .continuous)
				.fill(
					isSelected ? Color.accentColor : Color.clear
				)
				.padding(
					isSelected ? 0 : 4
				)
		}
		.overlay {
			RoundedRectangle(cornerRadius: 10, style: .continuous)
				.stroke(Color.accentColor, lineWidth: 2)
		}
	}
}

#Preview("Only day") {
	Day(date: .now)
		.frame(
			width: 100,
			height: 100
		)
}

#Preview("In scrollview") {
	ScrollView(.horizontal) {
		LazyHStack {
			HStack {
				ForEach(0..<7) { index in
					Day(
						isSelected: index == 2, date: .now
					)
					.containerRelativeFrame(
						.horizontal,
						count: 7,
						spacing: 8
					)
				}
			}
		}
	}
	.contentMargins(
		16,
		for: .scrollContent
	)
}
