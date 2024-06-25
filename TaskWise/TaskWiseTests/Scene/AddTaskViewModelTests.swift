import Combine
@testable import TaskWise
import XCTest

// swiftlint: disable implicitly_unwrapped_optional
final class AddTaskViewModelTests: XCTestCase {
    private var sut: AddTaskViewModel!
    private var dataService: DataServiceInputMock!

    override func setUpWithError() throws {
        try super.setUpWithError()

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

    override func tearDownWithError() throws {
        try super.tearDownWithError()

        sut = nil
        dataService = nil
    }

    func test_didTapCreate_shouldInvokeDataServiceCreateTasks() throws {
        sut.didTapCreate()

        XCTAssert(dataService.createTasksFromWithCalled)
    }

    func test_didTapAddStep_shouldAddStep() throws {
        sut.newStepName = "NewStepName"
        sut.didTapAddStep()

        XCTAssertEqual(sut.steps, [.init(isDone: false, label: "NewStepName", index: 0)])
    }

    func test_didTapDeleteSteps_shouldRemoveStep() throws {
        sut.steps.append(.init(isDone: false, label: "NewStepName", index: 0))
        sut.didTapDeleteSteps(offsets: [0])

        XCTAssert(sut.steps.isEmpty)
    }

    func test_didMoveStep_shouldReorderSteps() throws {
        sut.steps.append(.init(isDone: false, label: "NewStepName1", index: 0))
        sut.steps.append(.init(isDone: false, label: "NewStepName2", index: 1))

        sut.didMoveStep(source: [0], destination: 2)

        XCTAssertEqual(sut.steps, [
            .init(isDone: false, label: "NewStepName2", index: 0),
            .init(isDone: false, label: "NewStepName1", index: 1)
        ])
    }

    func test_didTapToggle_shouldToggleIsDone() throws {
        sut.steps.append(.init(isDone: false, label: "NewStepName1", index: 0))

        sut.didTapToggle(on: .init(isDone: false, label: "NewStepName1", index: 0))

        guard let step = sut.steps.first else {
            XCTFail("Should succeed!")
            return
        }

        XCTAssert(step.isDone)
    }
}
