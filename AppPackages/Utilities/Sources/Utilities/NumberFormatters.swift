// Copyright 2024 CCT Plus LLC
// Licensed under the Apache License, Version 2.0 (the "License");
// you may obtain a copy of the License at
//     http://www.apache.org/licenses/LICENSE-2.0
// -----------------------------------------------------------
// Project: Utilities
// Created on 9/14/24 by @HeyJayWilson
// -----------------------------------------------------------

import Foundation

public struct PFNumberFormatter {
	public static let decimal: NumberFormatter = {
		var nf = NumberFormatter()
		nf.numberStyle = .decimal
		return nf
	}()

	public static let int: NumberFormatter = {
		var nf = NumberFormatter()
		nf.numberStyle = .none
		return nf
	}()
}
