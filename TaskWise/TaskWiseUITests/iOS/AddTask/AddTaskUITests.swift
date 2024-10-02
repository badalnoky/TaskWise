import XCTest

// swiftlint: disable all
final class AddTaskUITests: XCTestCase {
    let app = XCUIApplication()

    override func setUpWithError() throws {
        try super.setUpWithError()
        continueAfterFailure = false
        app.launch()
        app.navigationBars["_TtGC7SwiftUI32NavigationStackHosting"].buttons["plus.app.fill"].tap()
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

    func test_stepsRightButton_whenTapped_shouldOpenStepsList() throws {
        app.scrollViews.otherElements.images["chevron.right"].tap()
        let stepTextField = app.scrollViews.otherElements.textFields["Step"]
        _ = stepTextField.waitForExistence(timeout: 5)
        XCTAssertTrue(stepTextField.exists)
    }

    func test_stepsRightButton_whenTapped_shouldAdd() throws {
        app.scrollViews.otherElements.images["chevron.right"].tap()
        app.swipeUp()
        let stepTextfield = app.scrollViews.otherElements.textFields["Step"]
        stepTextfield.tap()
        stepTextfield.typeText("UITestStep")
        app.scrollViews.otherElements.buttons["plus.app.fill"].tap()
        let textField = app.scrollViews.otherElements.scrollViews.otherElements.containing(.image, identifier:"trash").children(matching: .textField).element
        _ = textField.waitForExistence(timeout: 5)
        XCTAssertTrue(textField.exists)
    }

    func test_createButton_whenTapped_shouldNavigateAndCreate() throws {
        let id = UUID().uuidString
        let titleTextfield = app.scrollViews.otherElements.textFields["Title"]
        titleTextfield.tap()
        titleTextfield.typeText(id)
        app.scrollViews.otherElements.buttons["Create task"].tap()

        let todayLabel = app.staticTexts["Today"]
        _ = todayLabel.waitForExistence(timeout: 5)
        XCTAssertTrue(todayLabel.exists)

        let taskTitleLabel = app.collectionViews.scrollViews.otherElements.staticTexts[id]
        _ = taskTitleLabel.waitForExistence(timeout: 5)
        XCTAssertTrue(taskTitleLabel.exists)
    }
}
