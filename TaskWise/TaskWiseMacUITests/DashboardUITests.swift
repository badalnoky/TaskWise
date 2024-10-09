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

    func test_settingsButton_whenClicked_shouldShowPopover() throws {
        let appWindow = app.windows["TaskWiseMac.MacDashboardView-1-AppWindow-1"]
        appWindow.buttons["gear"].click()
        let categoryLabel = appWindow.popovers.staticTexts["Categories"]
        _ = categoryLabel.waitForExistence(timeout: 5)
        XCTAssertTrue(categoryLabel.exists)
    }

    func test_filterButton_whenClicked_shouldShowPopover() throws {
        let appWindow = app.windows["TaskWiseMac.MacDashboardView-1-AppWindow-1"]
        appWindow.buttons["line.3.horizontal.decrease.circle"].click()
        let searchTextfield = appWindow.popovers.textFields["Search"]
        _ = searchTextfield.waitForExistence(timeout: 5)
        XCTAssertTrue(searchTextfield.exists)
    }

    func test_searchButton_whenClicked_shouldShowPopover() throws {
        let appWindow = app.windows["TaskWiseMac.MacDashboardView-1-AppWindow-1"]
        appWindow.buttons["magnifyingglass"].click()
        let searchTextfield = appWindow.popovers.textFields["Search"]
        _ = searchTextfield.waitForExistence(timeout: 5)
        XCTAssertTrue(searchTextfield.exists)

    }

    func test_addButton_whenClicked_shouldShowPopover() throws {
        let appWindow = app.windows["TaskWiseMac.MacDashboardView-1-AppWindow-1"]
        appWindow.buttons["plus.app.fill"].click()
        let titleTextfield = appWindow.popovers.textFields["Title"]
        _ = titleTextfield.waitForExistence(timeout: 5)
        XCTAssertTrue(titleTextfield.exists)
    }

    func test_task_whenClicked_shouldShowPopover() throws {
        let appWindow = app.windows["TaskWiseMac.MacDashboardView-1-AppWindow-1"]
        appWindow.buttons["plus.app.fill"].click()
        let id = UUID().uuidString
        appWindow.popovers.textFields["Title"].typeText(id)
        let stepsLabel = appWindow.popovers.staticTexts["Steps"]
        stepsLabel.click()
        stepsLabel.swipeUp()
        appWindow.popovers.textFields["Step"].click()
        appWindow.popovers.textFields["Step"].typeText("TaskStep")
        appWindow.popovers.buttons["plus.app.fill"].click()
        appWindow.popovers.buttons["Create task"].click()
        appWindow.scrollViews.containing(.staticText, identifier:"TODO").children(matching: .scrollView).element(boundBy: 0).swipeUp()
        appWindow.scrollViews.staticTexts[id].click()
        let titleTextfield = appWindow.sheets.textFields["Title"]
        _ = titleTextfield.waitForExistence(timeout: 5)
        XCTAssertTrue(titleTextfield.exists)
    }

    func test_task_whenRightClicked_shouldShowContextMenu() throws {
        let appWindow = app.windows["TaskWiseMac.MacDashboardView-1-AppWindow-1"]
        appWindow.buttons["plus.app.fill"].click()
        let id = UUID().uuidString
        appWindow.popovers.textFields["Title"].typeText(id)
        appWindow.popovers.buttons["Create task"].click()
        appWindow.scrollViews.containing(.staticText, identifier:"TODO").children(matching: .scrollView).element(boundBy: 0).rightClick()
        let contextMenu = appWindow.menuItems["Done"]
        _ = contextMenu.waitForExistence(timeout: 5)
        XCTAssertTrue(contextMenu.exists)
    }
}
