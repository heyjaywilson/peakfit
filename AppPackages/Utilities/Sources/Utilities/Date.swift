// Copyright 2024 CCT Plus LLC
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
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

	public static func startOfMonth(for date: Date = .now) -> Date {
		let calendar = Calendar.current
		return calendar.date(from: calendar.dateComponents([.year, .month], from: date))!
	}

	public static func endOfMonth(for date: Date = .now) -> Date {
		let calendar = Calendar.current
		return calendar.date(byAdding: .month, value: 1, to: startOfMonth(for: date))!
	}

	public static func daysInMonth(for date: Date = .now) -> Int {
		let calendar = Calendar.current
		return calendar.range(of: .day, in: .month, for: date)!.count
	}

	public var weekdayInt: Int {
		let calendar = Calendar.current
		return calendar.component(.weekday, from: self)
	}

	public var dayOfMonth: Int {
		let calendar = Calendar.current
		return calendar.component(.day, from: self)
	}
}

extension Date {
	
	/// Returns a localized string representing the date relative to a reference date.
	/// Different formatters are used depending on the actual difference.
	/// - Parameters:
	/// 	- todayString: The string to return if the reference is the same as the date.
	///   - reference: The reference date to compare against. Defaults to `.now`
	///   - calendar: The calendar to use for relative calculations. Defaults to `.current`
	/// - Returns: A localized string representing the date
	public func relativeString(todayString: LocalizedStringResource, from ref: Date = .now, calendar: Calendar = .current) -> String {
		// We only care about comparisons for the date
		let current = calendar.startOfDay(for: self)
		let reference = calendar.startOfDay(for: ref)
		
		let standardFormat = current.formatted(date: .long, time: .omitted)
		let referenceYear = Calendar.current.dateComponents([.year], from: reference)
		let currentYear = Calendar.current.dateComponents([.year], from: current)
		
		guard let daysDifference = Calendar.current.dateComponents([.day], from: current, to: reference).day else {
			return standardFormat
		}
		
		if daysDifference == 0 {
			// If the date is the same as the reference, we return the today string.
			return String(localized: todayString)
			
		} else if abs(daysDifference) <= 3 {
			// After an arbitrary three days difference, we choose not to trust the relative formatter anymore.
			return formatted(.relative(presentation: .named))
			
		} else if referenceYear == currentYear {
			// If we're still in the same year, showing the year label isn't as helpful.
			let noYearFormat = Date.FormatStyle()
				.day(.twoDigits)
				.month(.wide)
				.year(.omitted)
				.hour(.omitted)
				.minute(.omitted)
				.second(.omitted)
			
			return formatted(noYearFormat)

		} else {
			// We use the standard representation when we're in a different calendar year.
			return standardFormat
			
		}
	}
}

extension Date {
	/// Use these as dates in SwiftUI previews
	public struct Constants {
		/// April 21 2024
		public static let sunday = {
			DateFormatters.standard.date(from: "2024-04-21")!
		}()
		/// April 22 2024
		public static let monday = {
			DateFormatters.standard.date(from: "2024-04-22")!
		}()
		/// April 23 2024
		public static let tuesday = {
			DateFormatters.standard.date(from: "2024-04-23")!
		}()
		/// April 24 2024
		public static let wednesday = {
			DateFormatters.standard.date(from: "2024-04-24")!
		}()
		/// April 25 2024
		public static let thursday = {
			DateFormatters.standard.date(from: "2024-04-25")!
		}()
		/// April 26 2024
		public static let friday = {
			DateFormatters.standard.date(from: "2024-04-26")!
		}()
		/// April 27 2024
		public static let saturday = {
			DateFormatters.standard.date(from: "2024-04-27")!
		}()

		public static let april21Thru27 = {
			[sunday, monday, tuesday, wednesday, thursday, friday, saturday]
		}()
	}
}
