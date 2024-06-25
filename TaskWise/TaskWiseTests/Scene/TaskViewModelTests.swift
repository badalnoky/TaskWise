@testable import TaskWise
import XCTest

// swiftlint: disable implicitly_unwrapped_optional
final class TaskViewModelTests: XCTestCase {
    private var sut: TaskViewModel!
    private var dataService: DataServiceInputMock!

    override func setUpWithError() throws {
        try super.setUpWithError()

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

    override func tearDownWithError() throws {
        try super.tearDownWithError()

        sut = nil
        dataService = nil
    }

    func test_didTapEdit_shouldToggleEditmode() throws {
        sut.didTapEdit()

        XCTAssertEqual(sut.editMode, .active)
    }

    func test_didTapAction_whenCalledWhileIsEditebleAndIsRepeatingAreSet_shouldSetIsUpdateAlertPresented() throws {
        sut.didTapEdit()

        sut.didTapAction()

        XCTAssert(sut.isUpdateAlertPresented)
    }

    func test_didTapAction_whenCalledWhileIsEditebleAndIsRepeatingAreNotSet_ishouldSetIsDeleteAlertPresented() throws {
        sut.task = DataServiceInputMock.taskMock
        sut.didTapAction()

        XCTAssert(sut.isDeleteAlertPresented)
    }

    func test_didTapAction_whenCalledWithRepeatingBehaviourSet_shouldInvokeDataServiceCreateTasks() throws {
        sut.task = DataServiceInputMock.taskMock
        sut.repeatBehaviour.frequency = .daily
        sut.didTapEdit()

        sut.didTapAction()

        XCTAssert(dataService.createTasksFromWithIncludingCalled)
    }

    func test_didTapAction_whenCalledWithNonRepeating_shouldInvokeDataServiceUpdateTask() throws {
        sut.task = DataServiceInputMock.taskMock
        sut.didTapEdit()

        sut.didTapAction()

        XCTAssert(dataService.updateTaskWithCalled)
    }

    func test_didTapUpdateOnlyThis_whenCalled_shouldInvokeDataServiceUpdateTask() throws {
        sut.didTapUpdateOnlyThis()

        XCTAssert(dataService.updateTaskWithCalled)
    }

    func test_didTapDelete_whenCalled_shouldInvokeDataServiceDeleteTask() throws {
        sut.didTapDelete()

        XCTAssert(dataService.deleteTaskCalled)
    }

    func test_didTapDeleteRepeating_whenCalled_shouldInvokeDataServiceDeleteRepeatingTasks() throws {
        sut.didTapDeleteRepeating()

        XCTAssert(dataService.deleteRepeatingTasksCalled)
    }

    func test_didTapToggle_whenCalled_shouldInvokeDataServiceToggleIsDone() throws {
        sut.didTapToggle(on: DataServiceInputMock.stepMock)

        XCTAssert(dataService.toggleIsDoneOnForCalled)
    }

    func test_didChangeLabel_whenCalledWithRepeatingTask_shouldInvokeDataServiceUpdateStepLabelForRepeating() throws {
        sut.didChangeLabel(on: DataServiceInputMock.stepMock, to: .empty)

        XCTAssert(dataService.updateStepLabelForRepeatingOnToCalled)
    }

    func test_didChangeLabel_whenCalledWithNonRepeatingTask_shouldInvokeDataServiceUpdateStepLabel() throws {
        sut.task = DataServiceInputMock.taskMock
        sut.didChangeLabel(on: DataServiceInputMock.stepMock, to: .empty)

        XCTAssert(dataService.updateStepLabelOnToCalled)
    }

    func test_didTapDeleteSteps_whenCalledWithRepeatingTask_shouldInvokeDataServiceDeleteStepForRepeating() throws {
        sut.task = DataServiceInputMock.repeatedTaskMock
        sut.didTapDeleteSteps(offsets: [0])

        XCTAssert(dataService.deleteStepForRepeatingStepCalled)
    }

    func test_didTapDeleteSteps_whenCalledWithNonRepeatingTask_shouldInvokeDataServiceDelete() throws {
        sut.task = DataServiceInputMock.taskMock
        sut.didTapDeleteSteps(offsets: [0])

        XCTAssert(dataService.deleteStepFromCalled)
    }

    func test_didMoveStep_whenCalledWithRepeatingTask_shouldInvokeDataServiceUpdateStepOrderForRepeating() throws {
        sut.task = DataServiceInputMock.repeatedTaskMock
        sut.didMoveStep(source: [0], destination: 1)

        XCTAssert(dataService.updateStepOrderForRepeatingToCalled)
    }

    func test_didMoveStep_whenCalledWithNonRepeatingTask_shouldInvokeDataServiceUpdateOrder() throws {
        sut.task = DataServiceInputMock.taskMock
        sut.didMoveStep(source: [0], destination: 1)

        XCTAssert(dataService.updateOrderOfOnCalled)
    }

    func test_didTapAddStep_whenCalledWithRepeatingTask_shouldInvokeDataServiceAddStepToRepeating() throws {
        sut.task = DataServiceInputMock.repeatedTaskMock
        sut.didTapAddStep()

        XCTAssert(dataService.addStepToRepeatingStepCalled)
    }

    func test_didTapAddStep_whenCalledWithNonRepeatingTask_shouldInvokeDataServiceAddStepFrom() throws {
        sut.task = DataServiceInputMock.taskMock
        sut.didTapAddStep()

        XCTAssert(dataService.addStepFromDtoToCalled)
    }
}
