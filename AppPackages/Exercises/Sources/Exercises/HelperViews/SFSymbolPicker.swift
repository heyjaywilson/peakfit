// Copyright 2024 CCT Plus LLC
// Licensed under the Apache License, Version 2.0 (the "License");
// you may obtain a copy of the License at
//     http://www.apache.org/licenses/LICENSE-2.0
// -----------------------------------------------------------
// Project: Exercises
// Created on 9/13/24 by @HeyJayWilson
// -----------------------------------------------------------

import SwiftUI

struct SFSymbolPicker: View {
	@Binding var selectedSymbol: String
	@State private var searchText: String = ""

	let columns = [GridItem(.adaptive(minimum: 50))]

	var body: some View {
		VStack {
			ScrollView {
				LazyVGrid(columns: columns, spacing: 20) {
					ForEach(Array(SFSymbols.all), id: \.self) { symbolName in
						Image(systemName: symbolName)
							.font(.title)
							.frame(width: 50, height: 50)
							.foregroundColor(selectedSymbol == symbolName ? .blue : .primary)
							.onTapGesture {
								selectedSymbol = symbolName
							}
					}
				}
				.padding()
			}
		}
	}
}

#Preview {
	SFSymbolPicker(selectedSymbol: .constant("dumbbell"))
}

// Helper struct to store SF Symbols
struct SFSymbols {
	static let all: [String] = [
		"dumbbell", "duffle.bag", "star", "heart",
		"list.clipboard", "list.bullet.clipboard", "list.bullet",
		"list.bullet.rectangle.portrait", "figure.step.training",
		"figure.strengthtraining.traditional",
		"figure.strengthtraining.functional", "figure.core.training", "figure.cross.training",
	]
}
