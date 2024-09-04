@testable import TaskWise
import Testing

// swiftlint: disable implicitly_unwrapped_optional
// swiftlint: disable type_contents_order
@Suite("PadDashboardViewModel", .tags(.viewModel))
final class PadDashboardViewModelTests {
    private var sut: PadDashboardViewModel!
    private var dataService: DataServiceInputMock!

    init() {
        dataService = .init()
        dataService.priorities = .init([DataServiceInputMock.priorityMock])
        dataService.categories = .init([DataServiceInputMock.categoryMock])
        dataService.columns = .init([DataServiceInputMock.columnMock])
        dataService.todaysTasks = .init([DataServiceInputMock.taskMock])
        dataService.tasks = .init([DataServiceInputMock.taskMock])

        sut = .init(dataService: self.dataService)
    }

    deinit {
        sut = nil
        dataService = nil
    }

    @Test("Task tap")
    func didTapTask() {
        sut.didTapTask(DataServiceInputMock.taskMock)
        #expect(sut.presentedTask != nil)
        #expect(sut.isTaskPresented)
    }

    @Test("Searched task tap")
    func didTapSearchedTask() {
        sut.didTapSearchedTask(DataServiceInputMock.taskMock)
        #expect(sut.presentedTask != nil)
        #expect(sut.isTaskPresented)
    }

    @Test("Delete non repeated button tap")
    func didTapDelete_withNonRepeated() {
        sut.didTapDelete(task: DataServiceInputMock.taskMock)

        #expect(dataService.deleteTaskCalled)
    }

    @Test("Delete only this button tap")
    func didTapDeleteOnlyThis() {
        sut.didTapDeleteOnlyThis(task: DataServiceInputMock.taskMock)

        #expect(dataService.deleteTaskCalled)
    }

    @Test("Delete repeating button tap")
    func didTapDeleteRepeating() {
        sut.didTapDeleteRepeating(task: DataServiceInputMock.repeatedTaskMock)

        #expect(dataService.deleteRepeatingTasksCalled)
    }

    @Test("Column change")
    func didChangeColumn() {
        sut.didChangeColumn(to: DataServiceInputMock.columnMock, on: DataServiceInputMock.taskMock)

        #expect(dataService.updateColumnToOnCalled)
    }
}
