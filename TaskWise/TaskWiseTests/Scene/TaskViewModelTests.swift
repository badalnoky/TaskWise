@testable import TaskWise
import XCTest

// swiftlint:disable: implicitly_unwrapped_optional
final class TaskViewModelTests: XCTestCase {
    private var sut: TaskViewModel!
    private var dataService: DataServiceInputMock!

    override func setUpWithError() throws {
        try super.setUpWithError()

        dataService = .init()
        sut = .init(navigator: .init(sceneFactory: .init(), root: .dashboard), taskId: UUID())
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()

        sut = nil
        dataService = nil
    }

    func test_didTapEdit_shouldToggleEditmode() throws {
        XCTAssert(false)
    }

    func test_didTapAction_whenCalledWhileIsEditebleAndIsRepeatingAreSet_shouldSetIsUpdateAlertPresented() throws {
        XCTAssert(false)
    }

    func test_didTapAction_whenCalledWhileIsEditebleAndIsRepeatingAreNotSet_ishouldSetIsDeleteAlertPresented() throws {
        XCTAssert(false)
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
        XCTAssert(false)
    }

    func test_didTapDelete_whenCalled_shouldInvokeDataServiceDeleteTask() throws {
        XCTAssert(false)
    }

    func test_didTapDeleteRepeating_whenCalled_shouldInvokeDataServiceDeleteRepeatingTasks() throws {
        XCTAssert(false)
    }

    func test_didTapToggle_whenCalled_shouldInvokeDataServiceToggleIsDone() throws {
        XCTAssert(false)
    }

    func test_didChangeLabel_whenCalledWithRepeatingTask_shouldInvokeDataServiceUpdateStepLabelForRepeating() throws {
        XCTAssert(false)
    }

    func test_didChangeLabel_whenCalledWithNonRepeatingTask_shouldInvokeDataServiceUpdateStepLabel() throws {
        XCTAssert(false)
    }

    func test_didTapDeleteSteps_whenCalledWithRepeatingTask_shouldInvokeDataServiceDeleteStepForRepeating() throws {
        XCTAssert(false)
    }

    func test_didTapDeleteSteps_whenCalledWithNonRepeatingTask_shouldInvokeDataServiceDelete() throws {
        XCTAssert(false)
    }

    func test_didMoveStep_whenCalledWithRepeatingTask_shouldInvokeDataServiceUpdateStepOrderForRepeating() throws {
        XCTAssert(false)
    }

    func test_didMoveStep_whenCalledWithNonRepeatingTask_shouldInvokeDataServiceUpdateOrder() throws {
        XCTAssert(false)
    }

    func test_didTapAddStep_whenCalledWithRepeatingTask_shouldInvokeDataServiceAddStepToRepeating() throws {
        XCTAssert(false)
    }

    func test_didTapAddStep_whenCalledWithNonRepeatingTask_shouldInvokeDataServiceAddStepFrom() throws {
        XCTAssert(false)
    }
}
