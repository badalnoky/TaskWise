import Combine
@testable import TaskWise
import Testing

// swiftlint: disable implicitly_unwrapped_optional
// swiftlint: disable type_contents_order
@Suite("AddTaskViewModel", .tags(.viewModel))
final class AddTaskViewModelTests {
    private var sut: AddTaskViewModel!
    private var dataService: DataServiceInputMock!

    init() {
        dataService = .init()
        dataService.priorities = .init([DataServiceInputMock.priorityMock])
        dataService.categories = .init([DataServiceInputMock.categoryMock])
        dataService.columns = .init([DataServiceInputMock.columnMock])

        sut = .init(
            navigator: .init(sceneFactory: .init(), root: .dashboard),
            dataService: self.dataService,
            date: .now
        )
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
        sut.didTapDeleteSteps(offsets: [0])

        #expect(sut.steps.isEmpty)
    }

    @Test("Moved step")
    func didMoveStep() {
        sut.steps.append(.init(isDone: false, label: "NewStepName1", index: 0))
        sut.steps.append(.init(isDone: false, label: "NewStepName2", index: 1))

        sut.didMoveStep(source: [0], destination: 2)

        #expect(sut.steps == [
            .init(isDone: false, label: "NewStepName2", index: 0),
            .init(isDone: false, label: "NewStepName1", index: 1)
        ])
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
