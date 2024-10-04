import XCTest

// swiftlint: disable all
final class PadSettingsUITests: XCTestCase {
    let app = XCUIApplication()

    override func setUpWithError() throws {
        try super.setUpWithError()
        continueAfterFailure = false
        app.launch()
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
    }

    func test_dashboardButton_whenTapped_shouldNavigate() throws {
        if UIScreen.isPad {
        }
    }

    func test_addCategoryButton_whenTapped_shouldShowSheet() throws {
        if UIScreen.isPad {
        }
    }

    func test_addPriorityButton_whenTapped_shouldShowSheet() throws {
        if UIScreen.isPad {
        }
    }

    func test_addColumnButton_whenTapped_shouldShowSheet() throws {
        if UIScreen.isPad {
        }
    }

    func test_editCategoryButton_whenTapped_shouldShowSheet() throws {
        if UIScreen.isPad {
        }
    }

    func test_editPriorityButton_whenTapped_shouldShowSheet() throws {
        if UIScreen.isPad {
        }
    }

    func test_editColumnButton_whenTapped_shouldShowSheet() throws {
        if UIScreen.isPad {
        }
    }

    func test_colorPicker_whenTapped_shouldShowSheet() throws {
        if UIScreen.isPad {
        }
    }
}
