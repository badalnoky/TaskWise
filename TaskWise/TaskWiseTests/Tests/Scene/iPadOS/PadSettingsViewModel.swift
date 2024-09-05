@testable import TaskWise
import Testing

// swiftlint: disable implicitly_unwrapped_optional
// swiftlint: disable type_contents_order
@Suite("PadSettingsViewModel", .tags(.viewModel))
final class PadSettingsViewModelTests {
    private var sut: PadSettingsViewModel!
    private var dataService: DataServiceInputMock!

    init() {
        dataService = .init()
        dataService.priorities = .init([DataServiceInputMock.priorityMock])
        dataService.categories = .init([DataServiceInputMock.categoryMock])
        dataService.columns = .init([DataServiceInputMock.columnMock])

        sut = .init(dataService: self.dataService)
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
        sut.didTapDeleteCategory(DataServiceInputMock.categoryMock)

        #expect(dataService.deleteCategoryCalled)
    }

    @Test("Delete column button tap")
    func didTapDeleteColumn() {
        sut.didTapDeleteColumn(DataServiceInputMock.columnMock)

        #expect(dataService.deleteColumnCalled)
    }

    @Test("Delete priority button tap")
    func didTapDeletePriority() {
        sut.didTapDeletePriority(DataServiceInputMock.priorityMock)

        #expect(dataService.deletePriorityCalled)
    }

    @Test("Edit priority button tap")
    func didTapEdit_withPriorityTab() {
        sut.didTapEditPriority()

        #expect(sut.isEditingPriority)
    }

    @Test("Edit column button tap")
    func didTapEdit_withColumnTab() {
        sut.didTapEditColumn()

        #expect(sut.isEditingColumn)
    }

    @Test("Edit category button tap")
    func didTapEdit_withCategoryTab() {
        sut.didTapEditCategory()

        #expect(sut.isEditingCategory)
    }

    @Test("Add priority button tap")
    func didTapAdd_withPriorityTab() {
        sut.didTapNewPriority()

        #expect(sut.isNewPrioritySheetPresented)
    }

    @Test("Add column button tap")
    func didTapAdd_withColumnTab() {
        sut.didTapNewColumn()

        #expect(sut.isNewColumnSheetPresented)
    }

    @Test("Add category button tap")
    func didTapAdd_withCategoryTab() {
        sut.didTapNewCategory()

        #expect(sut.isNewCategorySheetPresented)
    }
}
