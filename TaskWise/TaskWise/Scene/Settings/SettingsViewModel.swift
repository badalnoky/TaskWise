import Combine
import Resolver

@Observable final class SettingsViewModel {
    private var navigator: Navigator<ContentSceneFactory>
    private let dataController: DataService = Resolver.resolve()
    private var cancellables = Set<AnyCancellable>()

    var categories: [Category] = []
    var columns: [TaskColumn] = []
    var priorities: [Priority] = []

    init(navigator: Navigator<ContentSceneFactory>) {
        self.navigator = navigator

        registerBindings()
    }
}

// TODO: Add edit, add, remove capability
extension SettingsViewModel {
    func didTapAddCategory() {
    }

    func didTapAddColumns() {
    }

    func didTapAddPriority() {
    }
}

private extension SettingsViewModel {
    private func registerBindings() {
        registerCategoryBinding()
        registerColumnsBinding()
        registerPriorityBinding()
    }

    private func registerColumnsBinding() {
        dataController.fetchColumns()
        dataController.columns
            .sink { [weak self] in
                self?.columns = $0
            }
            .store(in: &cancellables)
    }

    private func registerPriorityBinding() {
        dataController.fetchPriorities()
        dataController.priorities
            .sink { [weak self] in
                self?.priorities = $0
            }
            .store(in: &cancellables)
    }

    private func registerCategoryBinding() {
        dataController.fetchCategories()
        dataController.categories
            .sink { [weak self] in
                self?.categories = $0
            }
            .store(in: &cancellables)
    }
}
