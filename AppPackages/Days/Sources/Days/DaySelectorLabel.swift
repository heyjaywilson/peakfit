// Copyright 2024 CCT Plus LLC
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
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

struct DaySelectorLabel: View {
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
				.fontDesign(.rounded)
			Text(dayOfMonth.formatted())
				.fontDesign(.rounded)
				.fontWeight(.bold)
		}
		.foregroundStyle(
			isSelected ? .white : .secondary
		)
		.frame(maxWidth: .infinity, maxHeight: .infinity)
		.aspectRatio(0.75, contentMode: .fit)
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
				.stroke(isSelected ? Color.accentColor : Color.secondary, lineWidth: 2)
		}
	}
}

#Preview("Only day") {
	DaySelectorLabel(date: .now)
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
					DaySelectorLabel(
						isSelected: index == 2, date: .now
					)
					.containerRelativeFrame(
						.horizontal,
						count: 7,
						spacing: 8
					)
				}
			}
			HStack {
				ForEach(0..<7) { index in
					DaySelectorLabel(
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
		.scrollTargetLayout()
	}
	.scrollTargetBehavior(.viewAligned)
	.contentMargins(
		16,
		for: .scrollContent
	)
}