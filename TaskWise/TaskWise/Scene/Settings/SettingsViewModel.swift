import Combine
import Resolver

@Observable final class SettingsViewModel {
    private var navigator: Navigator<ContentSceneFactory>
    private let dataService: DataService = Resolver.resolve()
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
