// Copyright 2024 CCT Plus LLC
// Licensed under the Apache License, Version 2.0 (the "License");
// you may obtain a copy of the License at
//     http://www.apache.org/licenses/LICENSE-2.0
// -----------------------------------------------------------
// Project: DataStorage
// Created on 9/13/24 by @HeyJayWilson
// -----------------------------------------------------------

import Foundation
import SwiftData

public class SetsByDate: Identifiable, Hashable, Equatable {
	public static func == (lhs: SetsByDate, rhs: SetsByDate) -> Bool {
		lhs.date == rhs.date
	}

	public var date: Date
	public var sets: [ExerciseSet]

	public init(date: Date, sets: [ExerciseSet]) {
		self.date = date
		self.sets = sets.sorted(by: { $0.completedDate < $1.completedDate })
	}

	public func hash(into hasher: inout Hasher) {
		hasher.combine(date)
		hasher.combine(sets)
	}
}
