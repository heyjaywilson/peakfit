//
// -----------------------------------------------------------
// Copyright 2024 CCT Plus LLC
// Licensed under the Apache License, Version 2.0 (the "License");
// you may obtain a copy of the License at
//     http://www.apache.org/licenses/LICENSE-2.0
// -----------------------------------------------------------
// Project: Design
// Created on 9/27/24
// -----------------------------------------------------------
//

import Foundation
import SwiftUI

extension Text {
	/// Applies title, bold, and rounded
	public func title() -> Text {
		self
			.font(.title)
			.fontWeight(.bold)
			.fontDesign(.rounded)
	}

	/// Applies title2, bold, and rounded
	public func title2() -> Text {
		self
			.font(.title2)
			.fontWeight(.bold)
			.fontDesign(.rounded)
	}

	/// Applies headline and rounded font design to any Text view
	public func headline() -> Text {
		self
			.font(.headline)
			.fontDesign(.rounded)
	}

	/// Applies bold and rounded font design to any Text view
	public func boldRounded() -> Text {
		self
			.bold()
			.fontDesign(.rounded)
	}

	/// Applies caption and rounded font design to any Text view
	public func caption() -> Text {
		self
			.font(.caption)
			.fontDesign(.rounded)
	}
}
