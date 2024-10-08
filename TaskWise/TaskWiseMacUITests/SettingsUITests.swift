import XCTest

// swiftlint: disable all
final class SettingsUITests: XCTestCase {
    let app = XCUIApplication()

    override func setUpWithError() throws {
        try super.setUpWithError()
        continueAfterFailure = false
        app.launch()
        app.windows["TaskWiseMac.MacDashboardView-1-AppWindow-1"].buttons["gear"].click()
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
    }

    func test_addCategoryButton_whenClicked_shouldShowSheet() throws {
        let appWindow = app.windows["TaskWiseMac.MacDashboardView-1-AppWindow-1"]
        appWindow.popovers.groups.children(matching: .button).matching(identifier: "plus.app.fill").element(boundBy: 0).click()
        let categoryTextfield = appWindow.popovers.sheets.textFields["Category name"]
        _ = categoryTextfield.waitForExistence(timeout: 5)
        XCTAssertTrue(categoryTextfield.exists)
    }

    func test_addColumnButton_whenClicked_shouldShowSheet() throws {
        let appWindow = app.windows["TaskWiseMac.MacDashboardView-1-AppWindow-1"]
        appWindow.popovers.groups.children(matching: .button).matching(identifier: "plus.app.fill").element(boundBy: 1).click()
        let columnTextfield = appWindow.popovers.sheets.textFields["Column name"]
        _ = columnTextfield.waitForExistence(timeout: 5)
        XCTAssertTrue(columnTextfield.exists)
    }

    func test_addPriorityButton_whenClicked_shouldShowSheet() throws {
        let appWindow = app.windows["TaskWiseMac.MacDashboardView-1-AppWindow-1"]
        appWindow.popovers.groups.children(matching: .button).matching(identifier: "plus.app.fill").element(boundBy: 2).click()
        let priorityTextfield = appWindow.popovers.sheets.textFields["Priority name"]
        _ = priorityTextfield.waitForExistence(timeout: 5)
        XCTAssertTrue(priorityTextfield.exists)
    }

    func test_editCategoryButton_whenClicked_shouldShowSheet() throws {
        let appWindow = app.windows["TaskWiseMac.MacDashboardView-1-AppWindow-1"]
        appWindow.popovers.groups.children(matching: .button).matching(identifier: "pencil").element(boundBy: 0).click()
        let categoryTextfield = appWindow.popovers.scrollViews.children(matching: .textField).element(boundBy: 0)
        _ = categoryTextfield.waitForExistence(timeout: 5)
        XCTAssertTrue(categoryTextfield.exists)
    }

    func test_editPriorityButton_whenClicked_shouldShowSheet() throws {
        let appWindow = app.windows["TaskWiseMac.MacDashboardView-1-AppWindow-1"]
        appWindow.popovers.groups.children(matching: .button).matching(identifier: "pencil").element(boundBy: 1).click()
        let columnTextfield = appWindow.popovers.scrollViews.containing(.staticText, identifier:"First").children(matching: .textField).element(boundBy: 0)
        _ = columnTextfield.waitForExistence(timeout: 5)
        XCTAssertTrue(columnTextfield.exists)
    }

    func test_editColumnButton_whenClicked_shouldShowSheet() throws {
        let appWindow = app.windows["TaskWiseMac.MacDashboardView-1-AppWindow-1"]
        appWindow.popovers.groups.children(matching: .button).matching(identifier: "pencil").element(boundBy: 2).click()
        let priorityTextfield = appWindow.popovers.scrollViews.containing(.staticText, identifier:"Low").children(matching: .textField).element(boundBy: 0)
        _ = priorityTextfield.waitForExistence(timeout: 5)
        XCTAssertTrue(priorityTextfield.exists)
    }
}
