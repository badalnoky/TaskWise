import XCTest

// swiftlint: disable all
final class CalendarUITests: XCTestCase {
    let app = XCUIApplication()

    override func setUpWithError() throws {
        try super.setUpWithError()
        continueAfterFailure = false
        app.launch()
        if UIScreen.isPhone {
            app.navigationBars["_TtGC7SwiftUI32NavigationStackHosting"].buttons["calendar"].tap()
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

    func test_listButton_whenTapped_shouldOpenTable() throws {
        if UIScreen.isPhone {
            app.navigationBars["_TtGC7SwiftUI32NavigationStackHosting"].buttons["list.bullet.below.rectangle"].tap()
            let columnLabel = app.collectionViews.staticTexts["TODO"]
            _ = columnLabel.waitForExistence(timeout: 5)
            XCTAssertTrue(columnLabel.exists)
        }
    }

    func test_filterButton_whenTapped_shouldOpenSheet() throws {
        if UIScreen.isPhone {
            app.navigationBars["_TtGC7SwiftUI32NavigationStackHosting"].buttons["list.bullet.below.rectangle"].tap()
            app.navigationBars["_TtGC7SwiftUI32NavigationStackHosting"].buttons["line.3.horizontal.decrease.circle"].tap()
            let searchTextfield = app.textFields["Search"]
            _ = searchTextfield.waitForExistence(timeout: 5)
            XCTAssertTrue(searchTextfield.exists)
        }
    }

    func test_searchButton_whenTapped_shouldShowSearch() throws {
        if UIScreen.isPhone {
            app.navigationBars["_TtGC7SwiftUI32NavigationStackHosting"].buttons["magnifyingglass"].tap()
            let searchTextfield = app.textFields["Search"]
            _ = searchTextfield.waitForExistence(timeout: 5)
            XCTAssertTrue(searchTextfield.exists)
        }
    }

    func test_searchSearchtextfield_whenTyped_shouldShowResults() throws {
        if UIScreen.isPhone {
            app.navigationBars["_TtGC7SwiftUI32NavigationStackHosting"].buttons["Back"].tap()
            app.navigationBars["_TtGC7SwiftUI32NavigationStackHosting"].buttons["plus.app.fill"].tap()
            let titleTextfield = app.scrollViews.otherElements.textFields["Title"]
            titleTextfield.tap()
            let id = UUID().uuidString
            titleTextfield.typeText(id)
            app.scrollViews.otherElements.buttons["Create task"].tap()
            app.navigationBars["_TtGC7SwiftUI32NavigationStackHosting"].buttons["calendar"].tap()
            app.navigationBars["_TtGC7SwiftUI32NavigationStackHosting"].buttons["magnifyingglass"].tap()
            let searchTextfield = app.textFields["Search"]
            searchTextfield.tap()
            searchTextfield.typeText(id)
            let result = app.scrollViews.otherElements.buttons[id]
            _ = result.waitForExistence(timeout: 5)
            XCTAssertTrue(result.exists)
        }
    }

    func test_dayButton_whenTapped_shouldNavigate() throws {
        if UIScreen.isPhone {
            let date = Date.now
            let dateText = "\(date.formatted(.dateTime.year().month().day(.defaultDigits)))"
            let dayText = String(Calendar.current.dateComponents([.day], from: date).day ?? .zero)
            app.staticTexts[dayText].tap()
            let dateLabel = app.staticTexts[dateText]
            _ = dateLabel.waitForExistence(timeout: 5)
            XCTAssertTrue(dateLabel.exists)
        }
    }
}
