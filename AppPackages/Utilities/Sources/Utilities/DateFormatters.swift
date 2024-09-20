//
// -----------------------------------------------------------
// Project: Utilities
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

import Foundation

public struct DateFormatters {
	/// Returns an abbreviated day string
	///
	/// Ex: mon for Monday or fri for Friday
	public static let abbreviatedDayString: DateFormatter = {
		let formatter = DateFormatter()
		formatter.dateFormat = "EEE"
		return formatter
	}()
}
