@testable import TaskWise
import XCTest

// swiftlint:disable: implicitly_unwrapped_optional
final class DashboardViewModelTests: XCTestCase {
    private var sut: DashboardViewModel!
    private var dataService: DataServiceInputMock!

    override func setUpWithError() throws {
        try super.setUpWithError()

        dataService = .init()
        dataService.columns = .init([DataServiceInputMock.columnMock])
        dataService.todaysTasks = .init([DataServiceInputMock.taskMock])
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

    func test_didTapDelete_whenCalledWithRepeatedTask_shouldSetIsAlertPresented() throws {
        sut.didTapDelete(task: DataServiceInputMock.repeatedTaskMock)

        XCTAssert(sut.isAlertPresented)
    }

    func test_didTapDelete_whenCalledWithNonRepeatedTask_shouldInvokeDataServiceDeleteTask() throws {
        sut.didTapDelete(task: DataServiceInputMock.taskMock)

        XCTAssert(dataService.deleteTaskCalled)
    }

    func test_didTapDeleteOnlyThis_shouldInvokeDataServiceDeleteTask() throws {
        sut.didTapDeleteOnlyThis(task: DataServiceInputMock.taskMock)

        XCTAssert(dataService.deleteTaskCalled)
    }

    func test_didTapDeleteRepeating_shouldInvokeDataServiceDeleteRepeatingTask() throws {
        sut.didTapDeleteRepeating(task: DataServiceInputMock.repeatedTaskMock)

        XCTAssert(dataService.deleteRepeatingTasksCalled)
    }

    func test_didChangeColumn_shouldInvokeDataServiceUpdateColumn() throws {
        sut.didChangeColumn(to: DataServiceInputMock.columnMock, on: DataServiceInputMock.taskMock)

        XCTAssert(dataService.updateColumnToOnCalled)
    }
}
