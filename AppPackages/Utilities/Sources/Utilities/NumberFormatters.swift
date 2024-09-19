//
// -----------------------------------------------------------
// Project: Utilities
// Created on 9/14/24 by @HeyJayWilson
// -----------------------------------------------------------
// Find HeyJayWilson on the web:
// 🕸️ Website             https://heyjaywilson.com
// 💻 Follow on GitHub:   https://github.com/heyjaywilson
// 🧵 Follow on Threads:  https://threads.net/@heyjaywilson
// 💭 Follow on Mastodon: https://iosdev.space/@heyjaywilson
// ☕ Buy me a ko-fi:     https://ko-fi.com/heyjaywilson
// -----------------------------------------------------------
// Copyright© 2024 CCT Plus LLC. All rights reserved.
//

import Foundation

public struct PFNumberFormatter {
	public static let decimal: NumberFormatter = {
		var nf = NumberFormatter()
		nf.numberStyle = .decimal
		return nf
	}()

	public static let int: NumberFormatter = {
		var nf = NumberFormatter()
		nf.numberStyle = .none
		return nf
	}()
}
