import Combine
import Resolver

@Observable final class DayViewModel {
    private var navigator: Navigator<ContentSceneFactory>
    private let dataService: DataService = Resolver.resolve()
    private var cancellables = Set<AnyCancellable>()

    var isFilterSheetPresented = false
    var filterText: String = .empty
    var priorities: [Priority] = []
    var selectedPriority: Priority?
    var categories: [Category] = []
    var selectedCategory: Category?

    let date: Date
    var tasks: [Task] = []
    var columns: [TaskColumn] = []

    var filteredTasks: [Task] {
        tasks
            .filter {
                filterText.isEmpty ? true : ($0.title.caseInsensitiveContains(filterText) || $0.taskDescription.caseInsensitiveContains(filterText))
            }
            .filter {
                selectedPriority == nil ? true : $0.priority.id == selectedPriority?.id
            }
            .filter {
                selectedCategory == nil ? true : $0.category.id == selectedCategory?.id
            }
    }

    init(navigator: Navigator<ContentSceneFactory>, date: Date) {
        self.navigator = navigator
        self.date = date

        registerBindings()
    }
}

extension DayViewModel {
    func didTapAdd() {
        navigator.showAddTask(with: date)
    }

    func didTapFilter() {
        isFilterSheetPresented = true
    }

    func didTapTask(_ task: Task) {
        navigator.showTask(task.id)
    }

    func didTapDelete(task: Task) {
        dataService.deleteTask(task)
    }
}

private extension DayViewModel {
    private func registerBindings() {
        registerPriorityBinding()
        registerCategoryBinding()
        registerColumnBinding()
        registerTaskBinding()
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

    private func registerColumnBinding() {
        dataService.fetchColumns()
        dataService.columns
            .sink { [weak self] in
                self?.columns = $0
            }
            .store(in: &cancellables)
    }

    private func registerTaskBinding() {
        dataService.fetchTasks()
        dataService.tasks
            .sink { [weak self] in
                self?.tasks = $0
            }
            .store(in: &cancellables)
    }
}
