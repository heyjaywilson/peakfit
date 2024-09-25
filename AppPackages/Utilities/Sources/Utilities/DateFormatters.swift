// Copyright 2024 CCT Plus LLC
// Licensed under the Apache License, Version 2.0 (the "License");
// you may obtain a copy of the License at
//     http://www.apache.org/licenses/LICENSE-2.0
// -----------------------------------------------------------
// Project: Utilities
// Created on 9/20/24 by @HeyJayWilson
// -----------------------------------------------------------

import Foundation

public struct DateFormatters {
	/// Formatter that can return an abbreviated day string
	///
	/// Ex: mon for Monday or fri for Friday
	public static let abbreviatedDayString: DateFormatter = {
		let formatter = DateFormatter()
		formatter.dateFormat = "EEE"
		return formatter
	}()

	/// Formatter that can return a Month abbreviation
	///
	/// Ex: mon for Monday or fri for Friday
	public static let abbreviatedMonthString: DateFormatter = {
		let formatter = DateFormatter()
		formatter.dateFormat = "MMM"
		return formatter
	}()

	/// Formatter that can return a month
	///
	/// Ex: September
	public static let monthString: DateFormatter = {
		let formatter = DateFormatter()
		formatter.dateFormat = "MMMM"
		return formatter
	}()

	/// Formatter that can return or make a date using year - month - date
	///
	/// Ex: 2024-09-24
	public static let standard: DateFormatter = {
		let formatter = DateFormatter()
		formatter.dateFormat = "yyyy-MM-dd"
		return formatter
	}()

	/// Single letter for the day of the week
	///
	/// ex: M for Monday
	public let singleLetterDay: DateFormatter = {
		let formatter: DateFormatter = DateFormatter()
		formatter.dateFormat = "EEEEE"
		return formatter
	}()
}

extension Date {
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
