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
