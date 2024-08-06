@testable import TaskWise
import Testing

// swiftlint: disable implicitly_unwrapped_optional
// swiftlint: disable type_contents_order
@Suite("DayViewModel", .tags(.viewModel))
final class DayViewModelTests {
    private var sut: DayViewModel!
    private var dataService: DataServiceInputMock!

    init() {
        dataService = .init()
        dataService.priorities = .init([DataServiceInputMock.priorityMock])
        dataService.categories = .init([DataServiceInputMock.categoryMock])
        dataService.columns = .init([DataServiceInputMock.columnMock])
        dataService.tasks = .init([DataServiceInputMock.taskMock])

        sut = .init(
            navigator: .init(sceneFactory: .init(), root: .dashboard),
            dataService: dataService,
            date: .now
        )
    }

    deinit {
        sut = nil
        dataService = nil
    }

    @Test("Filter button tap")
    func didTapFilter() {
        sut.didTapFilter()

        #expect(sut.isFilterSheetPresented)
    }

    @Test("Delete repeated button tap")
    func didTapDelete_withRepeated() {
        sut.didTapDelete(task: DataServiceInputMock.repeatedTaskMock)

        #expect(sut.isAlertPresented)
    }

    @Test("Delete non repeated button tap")
    func didTapDelete_withNonRepeated() {
        sut.didTapDelete(task: DataServiceInputMock.taskMock)

        #expect(dataService.deleteTaskCalled)
    }

    @Test("Delete only this button tap")
    func didTapDeleteOnlyThis() {
        sut.didTapDeleteOnlyThis(task: DataServiceInputMock.repeatedTaskMock)

        #expect(dataService.deleteTaskCalled)
    }

    @Test("Delete repeating button tap")
    func didTapDeleteRepeating() {
        sut.didTapDeleteRepeating(task: DataServiceInputMock.repeatedTaskMock)

        #expect(dataService.deleteRepeatingTasksCalled)
    }

    @Test("Clear filters button tap")
    func didTapClearFilters() {
        sut.selectedCategory = DataServiceInputMock.categoryMock
        sut.selectedPriority = DataServiceInputMock.priorityMock
        sut.filterText = "searchText"

        sut.didTapClearFilters()

        #expect(sut.selectedCategory == nil)
        #expect(sut.selectedPriority == nil)
        #expect(sut.filterText.isEmpty)
    }

    @Test("Column change")
    func didChangeColumn() {
        sut.didChangeColumn(to: DataServiceInputMock.columnMock, on: DataServiceInputMock.taskMock)

        #expect(dataService.updateColumnToOnCalled)
    }
}
