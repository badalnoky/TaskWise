import Combine
@testable import TaskWiseMac
import Testing

// swiftlint: disable implicitly_unwrapped_optional
// swiftlint: disable type_contents_order
@Suite("MacAddTaskPopoverViewModel", .tags(.viewModel))
final class MacAddTaskPopoverViewModelTests {
    private var sut: MacAddTaskPopoverViewModel!
    private var dataService: DataServiceInputMock!

    init() {
        dataService = .init()
        dataService.priorities = .init([DataServiceInputMock.priorityMock])
        dataService.categories = .init([DataServiceInputMock.categoryMock])
        dataService.columns = .init([DataServiceInputMock.columnMock])

        sut = .init(dataService: self.dataService)
    }

    deinit {
        sut = nil
        dataService = nil
    }

    @Test("Create button tap")
    func didTapCreate() {
        sut.didTapCreate()

        #expect(dataService.createTasksFromWithCalled)
    }

    @Test("Add Step button tap")
    func didTapAddStep() {
        sut.newStepName = "NewStepName"
        sut.didTapAddStep()

        #expect(sut.steps == [.init(isDone: false, label: "NewStepName", index: 0)])
    }

    @Test("Delete button tap")
    func didTapDeleteSteps() {
        sut.steps.append(.init(isDone: false, label: "NewStepName", index: 0))
        sut.didTapDeleteSteps(.init(isDone: false, label: "NewStepName", index: 0))

        #expect(sut.steps.isEmpty)
    }

    @Test("Toggle tap")
    func didTapToggle() {
        sut.steps.append(.init(isDone: false, label: "NewStepName1", index: 0))

        sut.didTapToggle(on: .init(isDone: false, label: "NewStepName1", index: 0))

        guard let step = sut.steps.first else {
            Issue.record("Should succeed!")
            return
        }

        #expect(step.isDone)
    }
}
