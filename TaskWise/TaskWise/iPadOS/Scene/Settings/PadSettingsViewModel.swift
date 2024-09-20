import Combine
import Resolver
import SwiftUI

@Observable final class PadSettingsViewModel {
    private let dataService: DataServiceInput
    private var cancellables = Set<AnyCancellable>()

    var categories: [Category] = []
    var columns: [TaskColumn] = []
    var priorities: [Priority] = []

    var isNewCategorySheetPresented = false
    var isNewColumnSheetPresented = false
    var isNewPrioritySheetPresented = false
    var newCategoryName: String = .empty
    var newColumnName: String = .empty
    var newPriorityName: String = .empty
    var currentColor: Color = .blue

    var isEditingCategory = false
    var isEditingPriority = false
    var isEditingColumn = false

    var isAlertPresented = false
    var alertMessage: String = .empty

    var isAddDisabled: Bool {
        newColumnName.isEmpty && newCategoryName.isEmpty && newPriorityName.isEmpty
    }

    init(dataService: DataServiceInput = Resolver.resolve()) {
        self.dataService = dataService

        registerBindings()
    }
}

extension PadSettingsViewModel {
    func didTapAddCategory() {
        dataService.addCategory(.init(id: UUID(), name: newCategoryName, colorComponents: currentColor.components))
        newCategoryName = .empty
        isNewCategorySheetPresented.toggle()
    }

    func didTapAddColumn() {
        dataService.addColumn(.init(id: UUID(), index: columns.count.next, name: newColumnName))
        newColumnName = .empty
        isNewColumnSheetPresented.toggle()
    }

    func didTapAddPriority() {
        dataService.addPriority(.init(id: UUID(), level: priorities.count.next, name: newPriorityName))
        newPriorityName = .empty
        isNewPrioritySheetPresented.toggle()
    }

    func didChangeName(of item: NamedItem, to newName: String) {
        if let priority = item as? Priority {
            dataService.updatePriorityName(on: priority, to: newName)
        } else if let category = item as? Category {
            dataService.updateCategoryName(on: category, to: newName)
        } else if let column = item as? TaskColumn {
            dataService.updateColumnName(on: column, to: newName)
        }
        dataService.fetchTasks()
    }

    func didMoveColumn(source: IndexSet, destination: Int) {
        var updated = columns
        updated.move(fromOffsets: source, toOffset: destination)
        dataService.updateOrder(columns: updated)
        dataService.fetchTasks()
    }

    func didMovePriority(source: IndexSet, destination: Int) {
        var updated = priorities
        updated.move(fromOffsets: source, toOffset: destination)
        dataService.updateOrder(priorities: updated)
        dataService.fetchTasks()
    }

    func didChangeColor(on category: Category, to newColor: ColorComponents.DTO) {
        dataService.updateColor(on: category, with: newColor)
        dataService.fetchTasks()
    }

    func didTapDeleteCategory(_ category: Category) {
        handle {
            try dataService.deleteCategory(category)
        }
    }

    func didTapDeleteColumn(_ column: TaskColumn) {
        handle {
            try dataService.deleteColumn(column)
        }
    }

    func didTapDeletePriority(_ priority: Priority) {
        handle {
            try dataService.deletePriority(priority)
        }
    }

    func didTapEditCategory() {
        isEditingCategory.toggle()
    }

    func didTapEditPriority() {
        isEditingPriority.toggle()
    }

    func didTapEditColumn() {
        isEditingColumn.toggle()
    }

    func didTapNewCategory() {
        isNewCategorySheetPresented = true
    }

    func didTapNewPriority() {
        isNewPrioritySheetPresented = true
    }

    func didTapNewColumn() {
        isNewColumnSheetPresented = true
    }

    func closeSheet() {
        isNewCategorySheetPresented = false
        isNewColumnSheetPresented = false
        isNewPrioritySheetPresented = false

        newCategoryName = .empty
        newColumnName = .empty
        newPriorityName = .empty
    }

    private func handle(_ operation: () throws -> Void) {
        do {
            try operation()
            dataService.fetchTasks()
        } catch DataOperationError.existingRelationship(let type) {
            isAlertPresented = true
            alertMessage = Str.Error.existingRelationship(type)
        } catch DataOperationError.lastOfKind(let type) {
            isAlertPresented = true
            alertMessage = Str.Error.lastOfKind(type)
        } catch {
            isAlertPresented = true
            alertMessage = Str.Error.generic
        }
    }
}

private extension PadSettingsViewModel {
    private func registerBindings() {
        registerCategoryBinding()
        registerColumnsBinding()
        registerPriorityBinding()
    }

    private func registerColumnsBinding() {
        dataService.fetchColumns()
        dataService.columns
            .sink { [weak self] in
                self?.columns = $0
            }
            .store(in: &cancellables)
    }

    private func registerPriorityBinding() {
        dataService.fetchPriorities()
        dataService.priorities
            .sink { [weak self] in
                self?.priorities = $0
            }
            .store(in: &cancellables)
    }

    private func registerCategoryBinding() {
        dataService.fetchCategories()
        dataService.categories
            .sink { [weak self] in
                self?.categories = $0
            }
            .store(in: &cancellables)
    }
}
