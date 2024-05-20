@testable import TaskWise
import XCTest

// swiftlint:disable: implicitly_unwrapped_optional
final class SettingsViewModelTests: XCTestCase {
    private var sut: SettingsViewModel!
    private var dataService: DataServiceInputMock!

    override func setUpWithError() throws {
        try super.setUpWithError()

        dataService = .init()
        sut = .init(navigator: .init(sceneFactory: .init(), root: .dashboard))
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()

        sut = nil
        dataService = nil
    }

    func test_didTapAddCategory_whenCalled_shouldInvokeDataServiceAddCategory() throws {
        XCTAssert(false)
    }

    func test_didTapAddColumn_whenCalled_shouldInvokeDataServiceAddColumn() throws {
        XCTAssert(false)
    }

    func test_didTapAddPriority_whenCalled_shouldInvokeDataServiceAddPriority() throws {
        XCTAssert(false)
    }

    func test_didChangeName_whenCalledWithPriority_shouldInvokeDataServiceUpdatePriorityName() throws {
        XCTAssert(false)
    }

    func test_didChangeName_whenCalledWithCategory_shouldInvokeDataServiceUpdateCategoryName() throws {
        XCTAssert(false)
    }

    func test_didChangeName_whenCalledWithColumn_shouldInvokeDataServiceUpdateColumnName() throws {
        XCTAssert(false)
    }

    func test_didMoveColumn_whenCalled_shouldInvokeDataServiceUpdateOrder() throws {
        XCTAssert(false)
    }

    func test_didMovePriority_whenCalled_shouldInvokeDataServiceUpdateOrder() throws {
        XCTAssert(false)
    }

    func test_didChangeColor_whenCalled_shouldInvokeDataServiceUpdateOrder() throws {
        XCTAssert(false)
    }

    func test_didTapDeleteCategory_whenCalled_shouldInvokeDataServiceDeleteCategory() throws {
        XCTAssert(false)
    }

    func test_didTapDeleteColumn_whenCalled_shouldInvokeDataServiceDeleteColumn() throws {
        XCTAssert(false)
    }

    func test_didTapDeletePriority_whenCalled_shouldInvokeDataServiceDeletePriority() throws {
        XCTAssert(false)
    }

    func test_didTapEdit_whenCalledWhileCurretTabIsPriority_shouldTogglePriorityEditMode() throws {
        XCTAssert(false)
    }

    func test_didTapEdit_whenCalledWhileCurretTabIsColumn_shouldToggleColumnEditMode() throws {
        XCTAssert(false)
    }

    func test_didTapEdit_whenCalledWhileCurretTabIsCategory_shouldToggleCategoryEditMode() throws {
        XCTAssert(false)
    }

    func test_didTapAdd_whenCalledWhileCurretTabIsPriority_shouldSetIsNewPrioritySheetPresented() throws {
        XCTAssert(false)
    }

    func test_didTapAdd_whenCalledWhileCurretTabIsColumn_shouldSetIsNewColumnSheetPresented() throws {
        XCTAssert(false)
    }

    func test_didTapAdd_whenCalledWhileCurretTabIsCategory_shouldSetIsNewCategorySheetPresented() throws {
        XCTAssert(false)
    }

    func test_didFinish_whenCalled_shouldInvokeDataServiceFetchTasks() throws {
        XCTAssert(false)
    }
}
