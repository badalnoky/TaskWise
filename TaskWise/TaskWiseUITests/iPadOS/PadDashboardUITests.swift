import XCTest

// swiftlint: disable all
final class PadDashboardUITests: XCTestCase {
    let app = XCUIApplication()

    override func setUpWithError() throws {
        try super.setUpWithError()
        continueAfterFailure = false
        app.launch()
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
    }

    func test_addButton_whenTapped_shouldShowPopover() throws {
        if UIScreen.isPad {
            app.navigationBars["_TtGC7SwiftUI32NavigationStackHosting"].buttons["plus.app.fill"].tap()
            let titleTextField = app.popovers.scrollViews.otherElements.textFields["Title"]
            _ = titleTextField.waitForExistence(timeout: 5)
            XCTAssertTrue(titleTextField.exists)
        }
    }

    func test_searchButton_whenTapped_shouldShowPopover() throws {
        if UIScreen.isPad {
            app.navigationBars["_TtGC7SwiftUI32NavigationStackHosting"].buttons["magnifyingglass"].tap()
            let searchTextField = app.popovers.textFields["Search"]
            _ = searchTextField.waitForExistence(timeout: 5)
            XCTAssertTrue(searchTextField.exists)
        }
    }

    func test_filterButton_whenTapped_shouldShowPopover() throws {
        if UIScreen.isPad {
            app.navigationBars["_TtGC7SwiftUI32NavigationStackHosting"].buttons["line.3.horizontal.decrease.circle"].tap()
            let searchTextField = app.popovers.textFields["Search"]
            _ = searchTextField.waitForExistence(timeout: 5)
            XCTAssertTrue(searchTextField.exists)
        }
    }

    func test_settingsButton_whenTapped_shouldNavigate() throws {
        if UIScreen.isPad {
            app.buttons["gear"].tap()
            let categoriesLabel = app.staticTexts["Categories"]
            _ = categoriesLabel.waitForExistence(timeout: 5)
            XCTAssertTrue(categoriesLabel.exists)
        }
    }

    func test_task_whenTapped_shouldShowSheet() throws {
        if UIScreen.isPad {
            let id = UUID().uuidString
            app.navigationBars["_TtGC7SwiftUI32NavigationStackHosting"].buttons["plus.app.fill"].tap()
            let titleTextfield = app.popovers.scrollViews.otherElements.textFields["Title"]
            titleTextfield.tap()
            titleTextfield.typeText(id)
            app.popovers.scrollViews.otherElements.buttons["Create task"].tap()
            app.scrollViews.otherElements.scrollViews.otherElements.staticTexts[id].tap()
            let titleLabel = app.scrollViews.otherElements.textFields["Title"]
            _ = titleLabel.waitForExistence(timeout: 5)
            XCTAssertTrue(titleLabel.exists)
        }
    }

    func test_task_whenLongPressed_shouldShowContextMenu() throws {
        if UIScreen.isPad {
            let id = UUID().uuidString
            app.navigationBars["_TtGC7SwiftUI32NavigationStackHosting"].buttons["plus.app.fill"].tap()
            let titleTextfield = app.popovers.scrollViews.otherElements.textFields["Title"]
            titleTextfield.tap()
            titleTextfield.typeText(id)
            app.popovers.scrollViews.otherElements.buttons["Create task"].tap()
            app.scrollViews.otherElements.scrollViews.otherElements.staticTexts[id].press(forDuration: 2)
            let doneButton = app.collectionViews.buttons["checkmark.circle"]
            _ = doneButton.waitForExistence(timeout: 5)
            XCTAssertTrue(doneButton.exists)
        }
    }
}
