@testable import TaskWise
import XCTest

// swiftlint:disable: implicitly_unwrapped_optional
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
        XCTAssert(false)
    }

    func test_didTapAction_whenCalledWhileIsEditebleAndIsRepeatingAreNotSet_ishouldSetIsDeleteAlertPresented() throws {
        sut.didTapAction()

        XCTAssert(sut.isDeleteAlertPresented)
    }

    func test_didTapAction_whenCalledWithRepeatingBehaviourSet_shouldInvokeDataServiceCreateTasks() throws {
        XCTAssert(false)
    }

    func test_didTapAction_whenCalledWithNonRepeating_shouldInvokeDataServiceUpdateTask() throws {
        XCTAssert(false)
    }

    func test_didTapUpdateAll_whenCalledWithChangedBehaviour_shouldInvokeDataServiceReschedulRepeatingTasks() throws {
        XCTAssert(false)
    }

    func test_didTapUpdateAll_whenCalledWithUnchangedBehaviour_shouldInvokeDataServiceUpdateRepeatingTasks() throws {
        XCTAssert(false)
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
        XCTAssert(false)
    }

    func test_didTapToggle_whenCalled_shouldInvokeDataServiceToggleIsDone() throws {
        sut.didTapToggle(on: DataServiceInputMock.stepMock)

        XCTAssert(dataService.toggleIsDoneOnForCalled)
    }

    func test_didChangeLabel_whenCalledWithRepeatingTask_shouldInvokeDataServiceUpdateStepLabelForRepeating() throws {
        XCTAssert(false)
    }

    func test_didChangeLabel_whenCalledWithNonRepeatingTask_shouldInvokeDataServiceUpdateStepLabel() throws {
        sut.didChangeLabel(on: DataServiceInputMock.stepMock, to: .empty)

        XCTAssert(dataService.updateStepLabelOnToCalled)
    }

    func test_didTapDeleteSteps_whenCalledWithRepeatingTask_shouldInvokeDataServiceDeleteStepForRepeating() throws {
        XCTAssert(false)
    }

    func test_didTapDeleteSteps_whenCalledWithNonRepeatingTask_shouldInvokeDataServiceDelete() throws {
        sut.didTapDeleteSteps(offsets: [0])

        XCTAssert(dataService.deleteStepFromCalled)
    }

    func test_didMoveStep_whenCalledWithRepeatingTask_shouldInvokeDataServiceUpdateStepOrderForRepeating() throws {
        XCTAssert(false)
    }

    func test_didMoveStep_whenCalledWithNonRepeatingTask_shouldInvokeDataServiceUpdateOrder() throws {
        sut.didMoveStep(source: [0], destination: 1)

        XCTAssert(dataService.updateOrderOfOnCalled)
    }

    func test_didTapAddStep_whenCalledWithRepeatingTask_shouldInvokeDataServiceAddStepToRepeating() throws {
        XCTAssert(false)
    }

    func test_didTapAddStep_whenCalledWithNonRepeatingTask_shouldInvokeDataServiceAddStepFrom() throws {
        sut.didTapAddStep()

        XCTAssert(dataService.addStepFromDtoToCalled)
    }
}
