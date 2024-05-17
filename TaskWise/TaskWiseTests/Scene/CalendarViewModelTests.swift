@testable import TaskWise
import XCTest

final class CalendarViewModelTests: XCTestCase {
    override func setUpWithError() throws {
        try super.setUpWithError()
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
    }

    func test_didTapList_shouldToggleIsListed() throws {
        XCTAssert(false)
    }

    func test_didTapFilter_shouldSetIsFilterSheetPresented() throws {
        XCTAssert(false)
    }

    func test_didToggleSearch_shouldToggleIsSearching() throws {
        XCTAssert(false)
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

    func test_didTapClearFilters_shouldClearFilterFields() throws {
        XCTAssert(false)
    }

    func test_didChangeColumn_shouldInvokeDataServiceUpdateColumn() throws {
        XCTAssert(false)
    }
}
