//
// -----------------------------------------------------------
// Project: Utilities
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

import Foundation

extension Date {
	public static let firstDayOfWeek = Calendar.current.firstWeekday
	public static let capitalizedFirstLettersOfWeekdays: [String] = {
		let calendar = Calendar.current

		var weekdays = calendar.shortWeekdaySymbols
		if firstDayOfWeek > 1 {
			for _ in 1..<firstDayOfWeek {
				if let first = weekdays.first {
					weekdays.append(first)
					weekdays.removeFirst()
				}
			}
		}
		return weekdays.map { $0.capitalized }
	}()
}
