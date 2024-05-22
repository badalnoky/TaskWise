@testable import TaskWise
import XCTest

// swiftlint:disable: implicitly_unwrapped_optional
final class CalendarViewModelTests: XCTestCase {
    private var sut: CalendarViewModel!
    private var dataService: DataServiceInputMock!

    override func setUpWithError() throws {
        try super.setUpWithError()

        dataService = .init()
        dataService.priorities = .init([DataServiceInputMock.priorityMock])
        dataService.categories = .init([DataServiceInputMock.categoryMock])
        dataService.columns = .init([DataServiceInputMock.columnMock])
        dataService.tasks = .init([DataServiceInputMock.taskMock])

        sut = .init(
            navigator: .init(sceneFactory: .init(), root: .dashboard),
            dataService: dataService
        )
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()

        sut = nil
        dataService = nil
    }

    func test_didTapList_shouldToggleIsListed() throws {
        sut.didTapList()

        XCTAssert(sut.isListed)
    }

    func test_didTapFilter_shouldSetIsFilterSheetPresented() throws {
        sut.didTapFilter()

        XCTAssert(sut.isFilterSheetPresented)
    }

    func test_didToggleSearch_shouldToggleIsSearching() throws {
        sut.didToggleSearch()

        XCTAssert(sut.isSearching)
    }

    func test_didTapDelete_whenCalledWithRepeatedTask_shouldSetIsAlertPresented() throws {
        sut.didTapDelete(task: DataServiceInputMock.repeatedTaskMock)

        XCTAssert(sut.isAlertPresented)
    }

    func test_didTapDelete_whenCalledWithNonRepeatedTask_shouldInvokeDataServiceDeleteTask() throws {
        sut.didTapDelete(task: DataServiceInputMock.taskMock)

        XCTAssert(dataService.deleteTaskCalled)
    }

    func test_didTapDeleteOnlyThis_shouldInvokeDataServiceDeleteTask() throws {
        sut.didTapDeleteOnlyThis(task: DataServiceInputMock.repeatedTaskMock)

        XCTAssert(dataService.deleteTaskCalled)
    }

    func test_didTapDeleteRepeating_shouldInvokeDataServiceDeleteRepeatingTask() throws {
        sut.didTapDeleteRepeating(task: DataServiceInputMock.repeatedTaskMock)

        XCTAssert(dataService.deleteRepeatingTasksCalled)
    }

    func test_didTapClearFilters_shouldClearFilterFields() throws {
        sut.selectedCategory = DataServiceInputMock.categoryMock
        sut.selectedPriority = DataServiceInputMock.priorityMock
        sut.filterText = "searchText"

        sut.didTapClearFilters()

        XCTAssertNil(sut.selectedCategory)
        XCTAssertNil(sut.selectedPriority)
        XCTAssert(sut.filterText.isEmpty)
    }

    func test_didChangeColumn_shouldInvokeDataServiceUpdateColumn() throws {
        sut.didChangeColumn(to: DataServiceInputMock.columnMock, on: DataServiceInputMock.taskMock)

        XCTAssert(dataService.updateColumnToOnCalled)
    }
}
