import XCTest

// swiftlint: disable all
final class DayUITests: XCTestCase {
    let app = XCUIApplication()

    override func setUpWithError() throws {
        try super.setUpWithError()
        continueAfterFailure = false
        app.launch()
        app.navigationBars["_TtGC7SwiftUI32NavigationStackHosting"].buttons["calendar"].tap()
        let dayText = String(Calendar.current.dateComponents([.day], from: .now).day ?? .zero)
        app.staticTexts[dayText].tap()
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
    }

    func test_backButton_whenTapped_shouldNavigate() throws {
        app.navigationBars["_TtGC7SwiftUI32NavigationStackHosting"].buttons["Back"].tap()
        let calendarWeekdayLabel = app.staticTexts["MON"]
        _ = calendarWeekdayLabel.waitForExistence(timeout: 5)
        XCTAssertTrue(calendarWeekdayLabel.exists)
    }

    func test_addButton_whenTapped_shouldNavigate() throws {
        app.navigationBars["_TtGC7SwiftUI32NavigationStackHosting"].buttons["plus.app.fill"].tap()
        let titleTextfield = app.scrollViews.otherElements.textFields["Title"]
        _ = titleTextfield.waitForExistence(timeout: 5)
        XCTAssertTrue(titleTextfield.exists)
    }
    
    func test_filterButton_whenTapped_shouldNavigate() throws {
        app.navigationBars["_TtGC7SwiftUI32NavigationStackHosting"].buttons["line.3.horizontal.decrease.circle"].tap()
        let searchTextfield = app.textFields["Search"]
        _ = searchTextfield.waitForExistence(timeout: 5)
        XCTAssertTrue(searchTextfield.exists)
    }
}
