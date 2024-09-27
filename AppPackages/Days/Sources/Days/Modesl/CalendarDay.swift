//
// -----------------------------------------------------------
// Copyright 2024 CCT Plus LLC
// Licensed under the Apache License, Version 2.0 (the "License");
// you may obtain a copy of the License at
//     http://www.apache.org/licenses/LICENSE-2.0
// -----------------------------------------------------------
// Project: Days
// Created on 9/25/24
// -----------------------------------------------------------
//

import Foundation

struct CalendarDay: Identifiable {
	var id: Double {
		date.timeIntervalSince1970
	}

	var date: Date
	var hasExercises: Bool
}
