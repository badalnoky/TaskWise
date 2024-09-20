@testable import TaskWiseMac
import Testing

// swiftlint: disable implicitly_unwrapped_optional
// swiftlint: disable type_contents_order
@Suite("MacDashboardViewModel", .tags(.viewModel))
final class MacDashboardViewModelTests {
    private var sut: MacDashboardViewModel!
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

    @Test("Add button tap")
    func didTapAdd() {
        sut.didTapAdd()

        #expect(sut.isAddTaskOpen)
    }

    @Test("Search button tap")
    func didTapSearch() {
        sut.didTapSearch()

        #expect(sut.isSearchOpen)
    }

    @Test("Filter button tap")
    func didTapFilter() {
        sut.didTapFilter()

        #expect(sut.isFilterOpen)
    }

    @Test("Settings button tap")
    func didTapSettings() {
        sut.didTapSettings()

        #expect(sut.isSettingsOpen)
    }
}
