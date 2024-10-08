import XCTest

// swiftlint: disable all
final class ModalUITests: XCTestCase {
    let app = XCUIApplication()

    override func setUpWithError() throws {
        try super.setUpWithError()
        continueAfterFailure = false
        app.launch()
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
    }

    func test_addTaskRepeatSetter_whenChanged_shouldShowCorrectView() throws {
        let appWindow = app.windows["TaskWiseMac.MacDashboardView-1-AppWindow-1"]
        appWindow.buttons["plus.app.fill"].click()
        appWindow.popovers.popUpButtons["Never"].click()
        appWindow.popovers.popUpButtons["Never"].menuItems["Custom"].click()
        let dailyPicker = appWindow.popovers.popUpButtons["Daily"]
        _ = dailyPicker.waitForExistence(timeout: 5)
        XCTAssertTrue(dailyPicker.exists)

        appWindow.popovers.popUpButtons["Daily"].click()
        appWindow.popovers.popUpButtons["Daily"].menuItems["Weekly"].click()
        appWindow.popovers.staticTexts["Starts"].swipeUp()
        let dayLabel = appWindow.popovers.scrollViews.otherElements.staticTexts["MON"]
        XCTAssertTrue(dayLabel.exists)

        appWindow.popovers.popUpButtons["Weekly"].click()
        appWindow.popovers.popUpButtons["Weekly"].menuItems["Monthly"].click()
        let dayOfMonthLabel = appWindow.popovers.scrollViews.otherElements.staticTexts["1"]
        _ = dayOfMonthLabel.waitForExistence(timeout: 5)
        XCTAssertTrue(dayOfMonthLabel.exists)
    }

    func test_searchTextfield_whenTyped_shouldShowResults() throws {
        let appWindow = app.windows["TaskWiseMac.MacDashboardView-1-AppWindow-1"]
        appWindow.buttons["plus.app.fill"].click()
        let id = UUID().uuidString
        appWindow.popovers.textFields["Title"].typeText(id)
        appWindow.popovers.buttons["Create task"].click()
        appWindow.buttons["magnifyingglass"].click()
        appWindow.popovers.textFields["Search"].typeText(id)
        let result = appWindow.popovers.buttons[id]
        _ = result.waitForExistence(timeout: 5)
        XCTAssertTrue(result.exists)

        appWindow.popovers.buttons[id].click()
        let titleTextfield = appWindow.sheets.textFields["Title"]
        _ = titleTextfield.waitForExistence(timeout: 5)
        XCTAssertTrue(titleTextfield.exists)
    }
}
