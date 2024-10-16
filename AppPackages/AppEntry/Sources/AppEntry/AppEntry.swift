// Copyright 2024 CCT Plus LLC
// Licensed under the Apache License, Version 2.0 (the "License");
// you may obtain a copy of the License at
//     http://www.apache.org/licenses/LICENSE-2.0
// -----------------------------------------------------------
// Project: AppEntry
// Created on 9/11/24
// -----------------------------------------------------------

import Days
import Exercises
import Settings
import SwiftUI

public struct AppEntry: View {
	public init() {}

	public var body: some View {
		TabView {
			Tab("Sets", systemImage: "dumbbell") {
				ExerciseListContainerView()
			}
			Tab("Days", systemImage: "calendar") {
				DaysView()
			}
			Tab("Settings", systemImage: "gear") {
				SettingsView()
			}
		}
	}
}

#Preview {
	AppEntry()
}
