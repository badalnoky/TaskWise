@testable import TaskWise
import XCTest

// swiftlint:disable: implicitly_unwrapped_optional
final class DayViewModelTests: XCTestCase {
    private var sut: DayViewModel!
    private var dataService: DataServiceInputMock!

    override func setUpWithError() throws {
        try super.setUpWithError()

        dataService = .init()
        sut = .init(
            navigator: .init(sceneFactory: .init(), root: .dashboard),
            dataService: dataService,
            date: .now
        )
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()

        sut = nil
        dataService = nil
    }

    func test_didTapFilter_shouldSetIsFilterSheetPresented() throws {
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
