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

    func test_addButton_whenTapped_shouldNavigate() throws {
    }
}
