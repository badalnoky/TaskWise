@testable import TaskWise
import Testing

// swiftlint: disable implicitly_unwrapped_optional
// swiftlint: disable type_contents_order
@Suite("SettingsViewModel", .tags(.viewModel))
final class SettingsViewModelTests {
    private var sut: SettingsViewModel!
    private var dataService: DataServiceInputMock!

    init() {
        dataService = .init()
        dataService.priorities = .init([DataServiceInputMock.priorityMock])
        dataService.categories = .init([DataServiceInputMock.categoryMock])
        dataService.columns = .init([DataServiceInputMock.columnMock])

        sut = .init(
            navigator: .init(sceneFactory: .init(), root: .dashboard),
            dataService: dataService
        )
    }

    deinit {
        sut = nil
        dataService = nil
    }

    @Test("Add category button tap")
    func didTapAddCategory() {
        sut.didTapAddCategory()

        #expect(dataService.addCategoryCalled)
    }

    @Test("Add column button tap")
    func didTapAddColumn() {
        sut.didTapAddColumn()

        #expect(dataService.addColumnCalled)
    }

    @Test("Add priority button tap")
    func didTapAddPriority() {
        sut.didTapAddPriority()

        #expect(dataService.addPriorityCalled)
    }

    @Test("Change name with priority")
    func didChangeName_withPriority() {
        sut.didChangeName(of: DataServiceInputMock.priorityMock, to: .empty)

        #expect(dataService.updatePriorityNameOnToCalled)
    }

    @Test("Change name with category")
    func didChangeName_withCategory() {
        sut.didChangeName(of: DataServiceInputMock.categoryMock, to: .empty)

        #expect(dataService.updateCategoryNameOnToCalled)
    }

    @Test("Change name with column")
    func didChangeName_withColumn() {
        sut.didChangeName(of: DataServiceInputMock.columnMock, to: .empty)

        #expect(dataService.updateColumnNameOnToCalled)
    }

    @Test("Move column")
    func didMoveColumn() {
        sut.didMoveColumn(source: [0], destination: 1)

        #expect(dataService.updateOrderColumnsCalled)
    }

    @Test("Move priority")
    func didMovePriority() {
        sut.didMovePriority(source: [0], destination: 1)

        #expect(dataService.updateOrderPrioritiesCalled)
    }

    @Test("Change color")
    func didChangeColor() {
        sut.didChangeColor(on: DataServiceInputMock.categoryMock, to: .init(red: 1, green: 1, blue: 1, alpha: 1))

        #expect(dataService.updateColorOnWithCalled)
    }

    @Test("Delete category button tap")
    func didTapDeleteCategory() {
        sut.didTapDeleteCategory(offsets: [0])

        #expect(dataService.deleteCategoryCalled)
    }

    @Test("Delete column button tap")
    func didTapDeleteColumn() {
        sut.didTapDeleteColumn(offsets: [0])

        #expect(dataService.deleteColumnCalled)
    }

    @Test("Delete priority button tap")
    func didTapDeletePriority() {
        sut.didTapDeletePriority(offsets: [0])

        #expect(dataService.deletePriorityCalled)
    }

    @Test("Edit button tap while current tab is priority")
    func didTapEdit_withPriorityTab() {
        sut.currentTab = .priority
        sut.didTapEdit()

        #expect(sut.priorityEditMode == .active)
    }

    @Test("Edit button tap while current tab is column")
    func didTapEdit_withColumnTab() {
        sut.currentTab = .column
        sut.didTapEdit()

        #expect(sut.columnEditMode == .active)
    }

    @Test("Edit button tap while current tab is category")
    func didTapEdit_withCategoryTab() {
        sut.currentTab = .category
        sut.didTapEdit()

        #expect(sut.categoryEditMode == .active)
    }

    @Test("Add button tap while current tab is priority")
    func didTapAdd_withPriorityTab() {
        sut.currentTab = .priority
        sut.didTapAdd()

        #expect(sut.isNewPrioritySheetPresented)
    }

    @Test("Add button tap while current tab is column")
    func didTapAdd_withColumnTab() {
        sut.currentTab = .column
        sut.didTapAdd()

        #expect(sut.isNewColumnSheetPresented)
    }

    @Test("Add button tap while current tab is category")
    func didTapAdd_withCategoryTab() {
        sut.currentTab = .category
        sut.didTapAdd()

        #expect(sut.isNewCategorySheetPresented)
    }

    @Test("Finish")
    func didFinish() {
        sut.didChangeName(of: DataServiceInputMock.categoryMock, to: .empty)
        sut.didFinish()

        #expect(dataService.fetchTasksCalled)
    }
}
