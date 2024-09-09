import XCTest

final class TaskWiseMacUITests: XCTestCase {
    override func setUpWithError() throws {
        print(String.empty)
    }

    override func tearDownWithError() throws {
        print(String.empty)
    }

    @MainActor
    func testExample() throws {
        let app = XCUIApplication()
        app.launch()
    }
}
