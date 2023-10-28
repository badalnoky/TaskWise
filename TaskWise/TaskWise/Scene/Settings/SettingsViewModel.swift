import Combine
import Resolver
import SwiftUI

@Observable final class SettingsViewModel {
    private var navigator: Navigator<ContentSceneFactory>
    private let dataService: DataService = Resolver.resolve()
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

    init(navigator: Navigator<ContentSceneFactory>) {
        self.navigator = navigator

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
    }

    func didTapAddColumn() {
        dataService.addColumn(.init(id: UUID(), index: columns.count.next, name: newColumnName))
        newColumnName = .empty
    }

    func didTapAddPriority() {
        dataService.addPriority(.init(id: UUID(), level: priorities.count.next, name: newPriorityName))
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
