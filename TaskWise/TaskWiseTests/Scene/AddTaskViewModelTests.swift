@testable import TaskWise
import XCTest

// swiftlint:disable: implicitly_unwrapped_optional
final class AddTaskViewModelTests: XCTestCase {
    private var sut: AddTaskViewModel!
    private var dataService: DataServiceInputMock!

    override func setUpWithError() throws {
        try super.setUpWithError()

        dataService = .init()
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
        XCTAssert(false)
    }

    func test_didTapDeleteSteps_shouldRemoveStep() throws {
        XCTAssert(false)
    }

    func test_didMoveStep_shouldReorderSteps() throws {
        XCTAssert(false)
    }

    func test_didTapToggle_shouldToggleIsDone() throws {
        XCTAssert(false)
    }
}
