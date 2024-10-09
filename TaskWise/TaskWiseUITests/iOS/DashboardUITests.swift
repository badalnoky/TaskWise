import XCTest

// swiftlint: disable all
final class DashboardUITests: XCTestCase {
    let app = XCUIApplication()

    override func setUpWithError() throws {
        try super.setUpWithError()
        continueAfterFailure = false
        app.launch()
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
    }

    func test_addButton_whenTapped_shouldNavigate() throws {
        if UIScreen.isPhone {
            app.navigationBars["_TtGC7SwiftUI32NavigationStackHosting"].buttons["plus.app.fill"].tap()
            let titleTextfield = app.scrollViews.otherElements.textFields["Title"]
            _ = titleTextfield.waitForExistence(timeout: 5)
            XCTAssertTrue(titleTextfield.exists)
        }
    }

    func test_calendarButton_whenTapped_shouldNavigate() throws {
        if UIScreen.isPhone {
            app.navigationBars["_TtGC7SwiftUI32NavigationStackHosting"].buttons["calendar"].tap()
            let calendarWeekdayLabel = app.staticTexts["MON"]
            _ = calendarWeekdayLabel.waitForExistence(timeout: 5)
            XCTAssertTrue(calendarWeekdayLabel.exists)
        }
    }

    func test_settingsButton_whenTapped_shouldNavigate() throws {
        if UIScreen.isPhone {
            app.navigationBars["_TtGC7SwiftUI32NavigationStackHosting"].buttons["gear"].tap()
            let settingsLabel = app.navigationBars["_TtGC7SwiftUI32NavigationStackHosting"].staticTexts["Settings"]
            _ = settingsLabel.waitForExistence(timeout: 5)
            XCTAssertTrue(settingsLabel.exists)
        }
    }

    func test_task_whenTapped_shouldNavigate() throws {
        if UIScreen.isPhone {
            let id = UUID().uuidString
            app.navigationBars["_TtGC7SwiftUI32NavigationStackHosting"].buttons["plus.app.fill"].tap()
            let titleTextfield = app.scrollViews.otherElements.textFields["Title"]
            titleTextfield.tap()
            titleTextfield.typeText(id)
            app.scrollViews.otherElements.buttons["Create task"].tap()
            app.collectionViews.scrollViews.otherElements.staticTexts[id].tap()
        }
    }
}
