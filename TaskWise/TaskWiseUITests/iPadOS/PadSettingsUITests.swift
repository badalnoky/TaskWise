import XCTest

// swiftlint: disable all
final class PadSettingsUITests: XCTestCase {
    let app = XCUIApplication()

    override func setUpWithError() throws {
        try super.setUpWithError()
        continueAfterFailure = false
        app.launch()
        app.buttons["gear"].tap()
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
    }

    func test_dashboardButton_whenTapped_shouldNavigate() throws {
        if UIScreen.isPad {
            app.buttons["rectangle.3.group"].tap()
            let todayLabel = app.staticTexts["Today"]
            _ = todayLabel.waitForExistence(timeout: 5)
            XCTAssertTrue(todayLabel.exists)
        }
    }

    func test_addCategoryButton_whenTapped_shouldShowSheet() throws {
        if UIScreen.isPad {
            app.windows.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element(boundBy: 1).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .button).matching(identifier: "plus.app.fill").element(boundBy: 0).tap()
            
            let categoryTextfield = app.textFields["Category name"]
            _ = categoryTextfield.waitForExistence(timeout: 5)
            XCTAssertTrue(categoryTextfield.exists)
        }
    }

    func test_addColumnButton_whenTapped_shouldShowSheet() throws {
        if UIScreen.isPad {
            app.windows.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element(boundBy: 1).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .button).matching(identifier: "plus.app.fill").element(boundBy: 1).tap()

            let columnTextfield = app.textFields["Column name"]
            _ = columnTextfield.waitForExistence(timeout: 5)
            XCTAssertTrue(columnTextfield.exists)
        }
    }

    func test_addPriorityButton_whenTapped_shouldShowSheet() throws {
        if UIScreen.isPad {
            app.windows.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element(boundBy: 1).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .button).matching(identifier: "plus.app.fill").element(boundBy: 2).tap()

            let priorityTextfield = app.textFields["Priority name"]
            _ = priorityTextfield.waitForExistence(timeout: 5)
            XCTAssertTrue(priorityTextfield.exists)
        }
    }

    func test_editCategoryButton_whenTapped_shouldShowSheet() throws {
        if UIScreen.isPad {
            app.windows.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element(boundBy: 1).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .button).matching(identifier: "pencil").element(boundBy: 0).tap()

            let item = app.windows.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element(boundBy: 1).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .scrollView).element(boundBy: 0).otherElements.containing(.image, identifier:"trash").children(matching: .image).matching(identifier: "trash").element(boundBy: 0)
            _ = item.waitForExistence(timeout: 5)
            XCTAssertTrue(item.exists)
        }
    }

    func test_editPriorityButton_whenTapped_shouldShowSheet() throws {
        if UIScreen.isPad {
            app.windows.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element(boundBy: 1).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .button).matching(identifier: "pencil").element(boundBy: 1).tap()

            let item = app.windows.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element(boundBy: 1).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .scrollView).element(boundBy: 0).otherElements.containing(.image, identifier:"trash").children(matching: .image).matching(identifier: "trash").element(boundBy: 0)
            _ = item.waitForExistence(timeout: 5)
            XCTAssertTrue(item.exists)
        }
    }

    func test_editColumnButton_whenTapped_shouldShowSheet() throws {
        if UIScreen.isPad {
            app.windows.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element(boundBy: 1).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .button).matching(identifier: "pencil").element(boundBy: 2).tap()

            let item = app.windows.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element(boundBy: 1).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .scrollView).element(boundBy: 0).otherElements.containing(.image, identifier:"trash").children(matching: .image).matching(identifier: "trash").element(boundBy: 0)
            _ = item.waitForExistence(timeout: 5)
            XCTAssertTrue(item.exists)
        }
    }
}
