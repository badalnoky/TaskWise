import XCTest

// swiftlint: disable all
final class TaskUITests: XCTestCase {
    let app = XCUIApplication()
    let id = UUID().uuidString

    override func setUpWithError() throws {
        try super.setUpWithError()
        continueAfterFailure = false
        app.launch()
        app.navigationBars["_TtGC7SwiftUI32NavigationStackHosting"].buttons["plus.app.fill"].tap()
        let titleTextfield = app.scrollViews.otherElements.textFields["Title"]
        titleTextfield.tap()
        titleTextfield.typeText(id)
        app.scrollViews.otherElements.buttons["Create task"].tap()
        app.collectionViews.scrollViews.otherElements.staticTexts[id].tap()
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
    }

    func test_backButton_whenTapped_shouldNavigate() throws {
        app.navigationBars["_TtGC7SwiftUI32NavigationStackHosting"].buttons["Back"].tap()
        let todayLabel = app.staticTexts["Today"]
        _ = todayLabel.waitForExistence(timeout: 5)
        XCTAssertTrue(todayLabel.exists)
    }

    func test_editButton_whenTapped_shouldNavigate() throws {
        app.navigationBars["_TtGC7SwiftUI32NavigationStackHosting"].buttons["pencil"].tap()
        let todayLabel = app.scrollViews.otherElements.buttons["Save"]
        _ = todayLabel.waitForExistence(timeout: 5)
        XCTAssertTrue(todayLabel.exists)
    }
}
