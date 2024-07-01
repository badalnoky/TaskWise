@testable import TaskWise
import Testing

// swiftlint: disable implicitly_unwrapped_optional
// swiftlint: disable type_contents_order
@Suite("TaskViewModel", .tags(.viewModel))
final class TaskViewModelTests {
    private var sut: TaskViewModel!
    private var dataService: DataServiceInputMock!

    init() {
        dataService = .init()
        dataService.priorities = .init([DataServiceInputMock.priorityMock])
        dataService.categories = .init([DataServiceInputMock.categoryMock])
        dataService.columns = .init([DataServiceInputMock.columnMock])
        dataService.tasks = .init([DataServiceInputMock.repeatedTaskMock])
        dataService.currentSteps = .init([DataServiceInputMock.stepMock])

        sut = .init(
            navigator: .init(sceneFactory: .init(), root: .dashboard),
            dataService: dataService,
            taskId: DataServiceInputMock.taskMock.id
        )
    }

    deinit {
        sut = nil
        dataService = nil
    }

    @Test("Toggle edit mode")
    func didTapEdit() {
        sut.didTapEdit()

        #expect(sut.editMode == .active)
    }

    @Test("Action tap while editable and repeating set")
    func didTapAction_withEditableAndRepeatingSet() {
        sut.didTapEdit()
        sut.didTapAction()

        #expect(sut.isUpdateAlertPresented)
    }

    @Test("Action tap while editable and repeating not set")
    func didTapAction_withEditableAndRepeatingNotSet() {
        sut.task = DataServiceInputMock.taskMock
        sut.didTapAction()

        #expect(sut.isDeleteAlertPresented)
    }

    @Test("Action tap with repeating behavior set")
    func didTapAction_withRepeatingBehaviorSet() {
        sut.task = DataServiceInputMock.taskMock
        sut.repeatBehaviour.frequency = .daily
        sut.didTapEdit()
        sut.didTapAction()

        #expect(dataService.createTasksFromWithIncludingCalled)
    }

    @Test("Action tap with non-repeating task")
    func didTapAction_withNonRepeatingTask() {
        sut.task = DataServiceInputMock.taskMock
        sut.didTapEdit()
        sut.didTapAction()

        #expect(dataService.updateTaskWithCalled)
    }

    @Test("Update only this tap")
    func didTapUpdateOnlyThis() {
        sut.didTapUpdateOnlyThis()

        #expect(dataService.updateTaskWithCalled)
    }

    @Test("Delete tap")
    func didTapDelete() {
        sut.didTapDelete()

        #expect(dataService.deleteTaskCalled)
    }

    @Test("Delete repeating tap")
    func didTapDeleteRepeating() {
        sut.didTapDeleteRepeating()

        #expect(dataService.deleteRepeatingTasksCalled)
    }

    @Test("Toggle step")
    func didTapToggle() {
        sut.didTapToggle(on: DataServiceInputMock.stepMock)

        #expect(dataService.toggleIsDoneOnForCalled)
    }

    @Test("Change step label with repeating task")
    func didChangeLabel_withRepeatingTask() {
        sut.didChangeLabel(on: DataServiceInputMock.stepMock, to: .empty)

        #expect(dataService.updateStepLabelForRepeatingOnToCalled)
    }

    @Test("Change step label with non-repeating task")
    func didChangeLabel_withNonRepeatingTask() {
        sut.task = DataServiceInputMock.taskMock
        sut.didChangeLabel(on: DataServiceInputMock.stepMock, to: .empty)

        #expect(dataService.updateStepLabelOnToCalled)
    }

    @Test("Delete steps with repeating task")
    func didTapDeleteSteps_withRepeatingTask() {
        sut.task = DataServiceInputMock.repeatedTaskMock
        sut.didTapDeleteSteps(offsets: [0])

        #expect(dataService.deleteStepForRepeatingStepCalled)
    }

    @Test("Delete steps with non-repeating task")
    func didTapDeleteSteps_withNonRepeatingTask() {
        sut.task = DataServiceInputMock.taskMock
        sut.didTapDeleteSteps(offsets: [0])

        #expect(dataService.deleteStepFromCalled)
    }

    @Test("Move step with repeating task")
    func didMoveStep_withRepeatingTask() {
        sut.task = DataServiceInputMock.repeatedTaskMock
        sut.didMoveStep(source: [0], destination: 1)

        #expect(dataService.updateStepOrderForRepeatingToCalled)
    }

    @Test("Move step with non-repeating task")
    func didMoveStep_withNonRepeatingTask() {
        sut.task = DataServiceInputMock.taskMock
        sut.didMoveStep(source: [0], destination: 1)

        #expect(dataService.updateOrderOfOnCalled)
    }

    @Test("Add step with repeating task")
    func didTapAddStep_withRepeatingTask() {
        sut.task = DataServiceInputMock.repeatedTaskMock
        sut.didTapAddStep()

        #expect(dataService.addStepToRepeatingStepCalled)
    }

    @Test("Add step with non-repeating task")
    func didTapAddStep_withNonRepeatingTask() {
        sut.task = DataServiceInputMock.taskMock
        sut.didTapAddStep()

        #expect(dataService.addStepFromDtoToCalled)
    }
}
