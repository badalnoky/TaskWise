@testable import TaskWise
import XCTest

// swiftlint:disable: implicitly_unwrapped_optional
final class SettingsViewModelTests: XCTestCase {
    private var sut: SettingsViewModel!
    private var dataService: DataServiceInputMock!

    override func setUpWithError() throws {
        try super.setUpWithError()

        dataService = .init()
        dataService.priorities = .init([DataServiceInputMock.priorityMock])
        dataService.categories = .init([DataServiceInputMock.categoryMock])
        dataService.columns = .init([DataServiceInputMock.columnMock])

        sut = .init(
            navigator: .init(sceneFactory: .init(), root: .dashboard),
            dataService: dataService
        )
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()

        sut = nil
        dataService = nil
    }

    func test_didTapAddCategory_whenCalled_shouldInvokeDataServiceAddCategory() throws {
        sut.didTapAddCategory()

        XCTAssert(dataService.addCategoryCalled)
    }

    func test_didTapAddColumn_whenCalled_shouldInvokeDataServiceAddColumn() throws {
        sut.didTapAddColumn()

        XCTAssert(dataService.addColumnCalled)
    }

    func test_didTapAddPriority_whenCalled_shouldInvokeDataServiceAddPriority() throws {
        sut.didTapAddPriority()

        XCTAssert(dataService.addPriorityCalled)
    }

    func test_didChangeName_whenCalledWithPriority_shouldInvokeDataServiceUpdatePriorityName() throws {
        sut.didChangeName(of: DataServiceInputMock.priorityMock, to: .empty)

        XCTAssert(dataService.updatePriorityNameOnToCalled)
    }

    func test_didChangeName_whenCalledWithCategory_shouldInvokeDataServiceUpdateCategoryName() throws {
        sut.didChangeName(of: DataServiceInputMock.categoryMock, to: .empty)

        XCTAssert(dataService.updateCategoryNameOnToCalled)
    }

    func test_didChangeName_whenCalledWithColumn_shouldInvokeDataServiceUpdateColumnName() throws {
        sut.didChangeName(of: DataServiceInputMock.columnMock, to: .empty)

        XCTAssert(dataService.updateColumnNameOnToCalled)
    }

    func test_didMoveColumn_whenCalled_shouldInvokeDataServiceUpdateOrder() throws {
        sut.didMoveColumn(source: [0], destination: 1)

        XCTAssert(dataService.updateOrderColumnsCalled)
    }

    func test_didMovePriority_whenCalled_shouldInvokeDataServiceUpdateOrder() throws {
        sut.didMovePriority(source: [0], destination: 1)

        XCTAssert(dataService.updateOrderPrioritiesCalled)
    }

    func test_didChangeColor_whenCalled_shouldInvokeDataServiceUpdateColor() throws {
        sut.didChangeColor(on: DataServiceInputMock.categoryMock, to: .init(red: 1, green: 1, blue: 1, alpha: 1))

        XCTAssert(dataService.updateColorOnWithCalled)
    }

    func test_didTapDeleteCategory_whenCalled_shouldInvokeDataServiceDeleteCategory() throws {
        sut.didTapDeleteCategory(offsets: [0])

        XCTAssert(dataService.deleteCategoryCalled)
    }

    func test_didTapDeleteColumn_whenCalled_shouldInvokeDataServiceDeleteColumn() throws {
        sut.didTapDeleteColumn(offsets: [0])

        XCTAssert(dataService.deleteColumnCalled)
    }

    func test_didTapDeletePriority_whenCalled_shouldInvokeDataServiceDeletePriority() throws {
        sut.didTapDeletePriority(offsets: [0])

        XCTAssert(dataService.deletePriorityCalled)
    }

    func test_didTapEdit_whenCalledWhileCurretTabIsPriority_shouldTogglePriorityEditMode() throws {
        sut.currentTab = .priority
        sut.didTapEdit()

        XCTAssertEqual(sut.priorityEditMode, .active)
    }

    func test_didTapEdit_whenCalledWhileCurretTabIsColumn_shouldToggleColumnEditMode() throws {
        sut.currentTab = .column
        sut.didTapEdit()

        XCTAssertEqual(sut.columnEditMode, .active)
    }

    func test_didTapEdit_whenCalledWhileCurretTabIsCategory_shouldToggleCategoryEditMode() throws {
        sut.currentTab = .category
        sut.didTapEdit()

        XCTAssertEqual(sut.categoryEditMode, .active)
    }

    func test_didTapAdd_whenCalledWhileCurretTabIsPriority_shouldSetIsNewPrioritySheetPresented() throws {
        sut.currentTab = .priority
        sut.didTapAdd()

        XCTAssert(sut.isNewPrioritySheetPresented)
    }

    func test_didTapAdd_whenCalledWhileCurretTabIsColumn_shouldSetIsNewColumnSheetPresented() throws {
        sut.currentTab = .column
        sut.didTapAdd()

        XCTAssert(sut.isNewColumnSheetPresented)
    }

    func test_didTapAdd_whenCalledWhileCurretTabIsCategory_shouldSetIsNewCategorySheetPresented() throws {
        sut.currentTab = .category
        sut.didTapAdd()

        XCTAssert(sut.isNewCategorySheetPresented)
    }

    func test_didFinish_whenCalled_shouldInvokeDataServiceFetchTasks() throws {
        sut.didChangeName(of: DataServiceInputMock.categoryMock, to: .empty)
        sut.didFinish()

        XCTAssert(dataService.fetchTasksCalled)
    }
}
