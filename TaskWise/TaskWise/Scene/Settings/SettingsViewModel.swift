import Combine
import Resolver
import SwiftUI

@Observable final class SettingsViewModel {
    private var navigator: Navigator<ContentSceneFactory>
    private let dataService: DataServiceInput
    private var cancellables = Set<AnyCancellable>()

    var isNewCategorySheetPresented = false
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
    func didTapNewCategory() {
        isNewCategorySheetPresented = true
    }
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
    }

    func didMoveColumn(source: IndexSet, destination: Int) {
        var updated = columns
        updated.move(fromOffsets: source, toOffset: destination)
        dataService.updateOrder(of: updated)
    }

    func didMovePriority(source: IndexSet, destination: Int) {
        var updated = priorities
        updated.move(fromOffsets: source, toOffset: destination)
        dataService.updateOrder(of: updated)
    }

    func didChangeColor(on category: Category, to newColor: ColorComponents.DTO) {
        dataService.updateColor(on: category, with: newColor)
    }

    func didTapDeleteCategory(offsets: IndexSet) {
        guard offsets.count == .one, let idx = offsets.first else { return }
        dataService.deleteCategory(categories[idx])
    }

    func didTapDeleteColumn(offsets: IndexSet) {
        guard offsets.count == .one, let idx = offsets.first else { return }
        dataService.deleteColumn(columns[idx])
    }

    func didTapDeletePriority(offsets: IndexSet) {
        guard offsets.count == .one, let idx = offsets.first else { return }
        dataService.deletePriority(priorities[idx])
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
