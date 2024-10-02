// Copyright 2024 CCT Plus LLC
// Licensed under the Apache License, Version 2.0 (the "License");
// you may obtain a copy of the License at
//     http://www.apache.org/licenses/LICENSE-2.0
// -----------------------------------------------------------
// Project: DataStorage
// Created on 9/10/24 by @HeyJayWilson
// -----------------------------------------------------------

import Foundation
import SwiftData

@Model
final public class ExerciseSet {
	public var reps: Int = 0
	public var weight: Double = 0.0
	public var completedDate: Date = Date.now

	public var exercise: Exercise?

	public init(reps: Int, weight: Double, dateCompleted: Date) {
		self.reps = reps
		self.weight = weight
		self.completedDate = dateCompleted
	}
}
