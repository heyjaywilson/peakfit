// Copyright 2024 CCT Plus LLC
// Licensed under the Apache License, Version 2.0 (the "License");
// you may obtain a copy of the License at
//     http://www.apache.org/licenses/LICENSE-2.0
// -----------------------------------------------------------
// Project: PeakFit
// Created on 9/10/24 by @HeyJayWilson
// -----------------------------------------------------------

import AppEntry
import DataStorage
import SwiftData
import SwiftUI

@main
struct PeakFitApp: App {
	init() {
		let appearance = UINavigationBarAppearance()

		var titleFont = UIFont.preferredFont(forTextStyle: .largeTitle)
		/// the default large title font
		titleFont = UIFont(
			descriptor:
				titleFont.fontDescriptor
				.withDesign(.rounded)?
				/// make rounded
				.withSymbolicTraits(.traitBold) /// make bold
				?? titleFont.fontDescriptor,
			/// return the normal title if customization failed
			size: titleFont.pointSize
		)

		var backButtonFont = UIFont.preferredFont(forTextStyle: .body)
		backButtonFont = UIFont(
			descriptor: titleFont.fontDescriptor
				.withDesign(.rounded) ?? backButtonFont.fontDescriptor,
			size: backButtonFont.pointSize
		)

		// set the rounded font
		appearance.largeTitleTextAttributes = [.font: titleFont]
		appearance.titleTextAttributes = [.font: backButtonFont]
		UINavigationBar.appearance().standardAppearance = appearance
	}
	var body: some Scene {
		WindowGroup {
			AppEntry()
				.fontDesign(.rounded)
		}
		.modelContainer(DataStorage.productionModelContainer)
	}
}
