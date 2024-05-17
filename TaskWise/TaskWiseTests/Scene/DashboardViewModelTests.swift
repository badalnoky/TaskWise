@testable import TaskWise
import XCTest

final class DashboardViewModelTests: XCTestCase {
    override func setUpWithError() throws {
        try super.setUpWithError()
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
    }

    func test_didTapDelete_whenCalledWithRepeatedTask_shouldSetIsAlertPresented() throws {
        XCTAssert(false)
    }

    func test_didTapDelete_whenCalledWithNonRepeatedTask_shouldInvokeDataServiceDeleteTask() throws {
        XCTAssert(false)
    }

    func test_didTapDeleteOnlyThis_shouldInvokeDataServiceDeleteTask() throws {
        XCTAssert(false)
    }

    func test_didTapDeleteRepeating_shouldInvokeDataServiceDeleteRepeatingTask() throws {
        XCTAssert(false)
    }

    func test_didChangeColumn_shouldInvokeDataServiceUpdateColumn() throws {
        XCTAssert(false)
    }
}