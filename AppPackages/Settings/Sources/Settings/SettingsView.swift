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

    @AppStorage("restTimeMinutes") private var restTimeMinutes = 1
    @AppStorage("restTimeSeconds") private var restTimeSeconds = 5

    public init() {}

    public var body: some View {
        NavigationStack {
            HStack {
                Text("Rest")
                    .bold()
                Picker("", selection: $restTimeMinutes) {
                    ForEach(0...5, id: \.self) {
                        Text("\($0)")
                    }
                }
                Text(restTimeMinutes <= 1 ? "minute" : "minutes")
                Picker("", selection: $restTimeSeconds) {
                    ForEach(Array(stride(from: 0, to: 60, by: 5)), id: \.self) {
                        Text("\($0)")
                    }
                }
                Text("seconds")
            }.navigationTitle("Settings")
        }
    }
}

#Preview {
    SettingsView()
}
