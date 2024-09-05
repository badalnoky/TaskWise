@testable import TaskWise
import Testing

// swiftlint: disable implicitly_unwrapped_optional
// swiftlint: disable type_contents_order
@Suite("PhoneDashboardViewModel", .tags(.viewModel))
final class PhoneDashboardViewModelTests {
    private var sut: PhoneDashboardViewModel!
    private var dataService: DataServiceInputMock!

    init() {
        dataService = .init()
        dataService.columns = .init([DataServiceInputMock.columnMock])
        dataService.todaysTasks = .init([DataServiceInputMock.taskMock])
        dataService.tasks = .init([DataServiceInputMock.taskMock])

        sut = .init(
            navigator: .init(sceneFactory: .init(), root: .dashboard),
            dataService: dataService
        )
    }

    deinit {
        sut = nil
        dataService = nil
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
