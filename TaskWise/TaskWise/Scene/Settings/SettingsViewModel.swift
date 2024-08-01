import Combine
import Resolver
import SwiftUI

@Observable final class SettingsViewModel {
    private var navigator: Navigator<ContentSceneFactory>
    private let dataService: DataServiceInput
    private var cancellables = Set<AnyCancellable>()
    private var hasChanges = false

    var currentTab: SettingTabs = .category

    var isNewCategorySheetPresented = false
    var isNewColumnSheetPresented = false
    var isNewPrioritySheetPresented = false
    var currentColor: Color = .blue

    var categoryEditMode: EditMode = .inactive
    var priorityEditMode: EditMode = .inactive
    var columnEditMode: EditMode = .inactive

    var categories: [Category] = []
    var columns: [TaskColumn] = []
    var priorities: [Priority] = []

    var newCategoryName: String = .empty
    var newColumnName: String = .empty
    var newPriorityName: String = .empty

    var isAlertPresented = false
    var alertMessage: String = .empty

    var isAddDisabled: Bool {
        newColumnName.isEmpty && newCategoryName.isEmpty && newPriorityName.isEmpty
    }

    var isEditing: Bool {
        switch currentTab {
        case .column: return columnEditMode.isEditing
        case .category: return categoryEditMode.isEditing
        case .priority: return priorityEditMode.isEditing
        }
    }

    init(
        navigator: Navigator<ContentSceneFactory>,
        dataService: DataServiceInput = Resolver.resolve()
    ) {
        self.navigator = navigator
        self.dataService = dataService

        registerBindings()
    }
}

extension SettingsViewModel {
    func didTapAddCategory() {
        dataService.addCategory(.init(id: UUID(), name: newCategoryName, colorComponents: currentColor.components))
        newCategoryName = .empty
        isNewCategorySheetPresented.toggle()
    }

    func didTapAddColumn() {
        dataService.addColumn(.init(id: UUID(), index: columns.count.next, name: newColumnName))
        newColumnName = .empty
    }

    func didTapAddPriority() {
        dataService.addPriority(.init(id: UUID(), level: priorities.count.next, name: newPriorityName))
    }

    func didChangeName(of item: NamedItem, to newName: String) {
        if let priority = item as? Priority {
            dataService.updatePriorityName(on: priority, to: newName)
        } else if let category = item as? Category {
            dataService.updateCategoryName(on: category, to: newName)
        } else if let column = item as? TaskColumn {
            dataService.updateColumnName(on: column, to: newName)
        }
        hasChanges = true
    }

    func didMoveColumn(source: IndexSet, destination: Int) {
        var updated = columns
        updated.move(fromOffsets: source, toOffset: destination)
        dataService.updateOrder(columns: updated)
        hasChanges = true
    }

    func didMovePriority(source: IndexSet, destination: Int) {
        var updated = priorities
        updated.move(fromOffsets: source, toOffset: destination)
        dataService.updateOrder(priorities: updated)
        hasChanges = true
    }

    func didChangeColor(on category: Category, to newColor: ColorComponents.DTO) {
        dataService.updateColor(on: category, with: newColor)
        hasChanges = true
    }

    func didTapDeleteCategory(offsets: IndexSet) {
        guard offsets.count == .one, let idx = offsets.first else { return }
        handle {
            try dataService.deleteCategory(categories[idx])
        }
    }

    func didTapDeleteColumn(offsets: IndexSet) {
        guard offsets.count == .one, let idx = offsets.first else { return }
        handle {
            try dataService.deleteColumn(columns[idx])
        }
    }

    func didTapDeletePriority(offsets: IndexSet) {
        guard offsets.count == .one, let idx = offsets.first else { return }
        handle {
            try dataService.deletePriority(priorities[idx])
        }
    }

    func didTapEdit() {
        switch currentTab {
        case .category: EditMode.toggle(mode: &categoryEditMode)
        case .column: EditMode.toggle(mode: &columnEditMode)
        case .priority: EditMode.toggle(mode: &priorityEditMode)
        }
    }

    func didTapAdd() {
        switch currentTab {
        case .category: isNewCategorySheetPresented = true
        case .column: isNewColumnSheetPresented = true
        case .priority: isNewPrioritySheetPresented = true
        }
    }

    func didFinish() {
        if hasChanges {
            dataService.fetchTasks()
        }
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
            hasChanges = true
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

private extension SettingsViewModel {
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
