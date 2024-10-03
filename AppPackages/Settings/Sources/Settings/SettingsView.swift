//
// -----------------------------------------------------------
// Copyright 2024 CCT Plus LLC
// Licensed under the Apache License, Version 2.0 (the "License");
// you may obtain a copy of the License at
//     http://www.apache.org/licenses/LICENSE-2.0
// -----------------------------------------------------------
// Project: Settings
// Created on 2/10/24 by Samuel Sainz
// -----------------------------------------------------------
//

import SwiftUI

public struct SettingsView: View {

	public init() {}

	public var body: some View {
		NavigationStack {
			Text("This is the Settings View")
				.navigationTitle("Settings")
		}
	}
}

#Preview {
	SettingsView()
}
