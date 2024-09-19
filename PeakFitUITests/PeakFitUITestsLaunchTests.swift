//
// -----------------------------------------------------------
// Project: PeakFit
// Created on 9/10/24 by @HeyJayWilson
// -----------------------------------------------------------
// Find HeyJayWilson on the web:
// 🕸️ Website             https://heyjaywilson.com
// 💻 Follow on GitHub:   https://github.com/heyjaywilson
// 🧵 Follow on Threads:  https://threads.net/@heyjaywilson
// 💭 Follow on Mastodon: https://iosdev.space/@heyjaywilson
// ☕ Buy me a ko-fi:     https://ko-fi.com/heyjaywilson
// -----------------------------------------------------------
// Copyright© 2024 CCT Plus LLC. All rights reserved.
//

import XCTest

final class PeakFitUITestsLaunchTests: XCTestCase {

	override class var runsForEachTargetApplicationUIConfiguration: Bool {
		true
	}

	override func setUpWithError() throws {
		continueAfterFailure = false
	}

	@MainActor
	func testLaunch() throws {
		let app = XCUIApplication()
		app.launch()

		// Insert steps here to perform after app launch but before taking a screenshot,
		// such as logging into a test account or navigating somewhere in the app

		let attachment = XCTAttachment(screenshot: app.screenshot())
		attachment.name = "Launch Screen"
		attachment.lifetime = .keepAlways
		add(attachment)
	}
}
