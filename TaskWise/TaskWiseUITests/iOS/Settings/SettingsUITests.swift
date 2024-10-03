import XCTest

// swiftlint: disable all
final class SettingsUITests: XCTestCase {
    let app = XCUIApplication()

    override func setUpWithError() throws {
        try super.setUpWithError()
        continueAfterFailure = false
        app.launch()
        if UIScreen.isPhone {
            app.navigationBars["_TtGC7SwiftUI32NavigationStackHosting"].buttons["gear"].tap()
        }
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
    }

    func test_backButton_whenTapped_shouldNavigate() throws {
        if UIScreen.isPhone {
            app.navigationBars["_TtGC7SwiftUI32NavigationStackHosting"].buttons["Back"].tap()
            let todayLabel = app.staticTexts["Today"]
            _ = todayLabel.waitForExistence(timeout: 5)
            XCTAssertTrue(todayLabel.exists)
        }
    }

    func test_addCategoryButton_whenTapped_shouldOpenSheet() throws {
        if UIScreen.isPhone {
            app.navigationBars["_TtGC7SwiftUI32NavigationStackHosting"].buttons["plus.app.fill"].tap()
            let categoryTextField = app.textFields["Category name"]
            _ = categoryTextField.waitForExistence(timeout: 5)
            XCTAssertTrue(categoryTextField.exists)
        }

    }

    func test_editCategoryButton_whenTapped_shouldOpenSheet() throws {
        if UIScreen.isPhone {
            app.navigationBars["_TtGC7SwiftUI32NavigationStackHosting"].buttons["pencil"].tap()
            let categoryTextField = app.scrollViews.otherElements.containing(.image, identifier:"trash").children(matching: .textField).element(boundBy: 0)
            _ = categoryTextField.waitForExistence(timeout: 5)
            XCTAssertTrue(categoryTextField.exists)
        }
    }

    func test_columnsButton_whenTapped_shouldChangeTab() throws {
        if UIScreen.isPhone {
            app.tabBars["Tab Bar"].buttons["Columns"].tap()
            let firstLabel = app.scrollViews.otherElements.staticTexts["First"]
            _ = firstLabel.waitForExistence(timeout: 5)
            XCTAssertTrue(firstLabel.exists)
        }
    }

    func test_addColumnButton_whenTapped_shouldOpenSheet() throws {
        if UIScreen.isPhone {
            app.tabBars["Tab Bar"].buttons["Columns"].tap()
            app.navigationBars["_TtGC7SwiftUI32NavigationStackHosting"].buttons["plus.app.fill"].tap()
            let columnTextField = app.textFields["Column name"]
            _ = columnTextField.waitForExistence(timeout: 5)
            XCTAssertTrue(columnTextField.exists)
        }
    }

    func test_editColumnButton_whenTapped_shouldOpenSheet() throws {
        if UIScreen.isPhone {
            app.tabBars["Tab Bar"].buttons["Columns"].tap()
            app.navigationBars["_TtGC7SwiftUI32NavigationStackHosting"].buttons["pencil"].tap()
            let columnTextField = app.scrollViews.otherElements.containing(.image, identifier:"trash").children(matching: .textField).element(boundBy: 0)
            _ = columnTextField.waitForExistence(timeout: 5)
            XCTAssertTrue(columnTextField.exists)
        }
    }

    func test_prioritiesButton_whenTapped_shouldChangeTab() throws {
        if UIScreen.isPhone {
            app.tabBars["Tab Bar"].buttons["Priorities"].tap()
            let firstLabel = app.scrollViews.otherElements.staticTexts["High"]
            _ = firstLabel.waitForExistence(timeout: 5)
            XCTAssertTrue(firstLabel.exists)
        }
    }

    func test_addPriorityButton_whenTapped_shouldOpenSheet() throws {
        if UIScreen.isPhone {
            app.tabBars["Tab Bar"].buttons["Priorities"].tap()
            app.navigationBars["_TtGC7SwiftUI32NavigationStackHosting"].buttons["plus.app.fill"].tap()
            let columnTextField = app.textFields["Priority name"]
            _ = columnTextField.waitForExistence(timeout: 5)
            XCTAssertTrue(columnTextField.exists)
        }
    }

    func test_editPriorityButton_whenTapped_shouldOpenSheet() throws {
        if UIScreen.isPhone {
            app.tabBars["Tab Bar"].buttons["Priorities"].tap()
            app.navigationBars["_TtGC7SwiftUI32NavigationStackHosting"].buttons["pencil"].tap()
            let columnTextField = app.scrollViews.otherElements.containing(.image, identifier:"trash").children(matching: .textField).element(boundBy: 0)
            _ = columnTextField.waitForExistence(timeout: 5)
            XCTAssertTrue(columnTextField.exists)
        }
    }
}
