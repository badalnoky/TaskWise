import Combine
import Resolver

@Observable final class DayViewModel {
    private var navigator: Navigator<ContentSceneFactory>
    private let dataService: DataServiceInput
    private var cancellables = Set<AnyCancellable>()

    var isFilterSheetPresented = false
    var isAlertPresented = false
    var filterText: String = .empty
    var priorities: [Priority] = []
    var selectedPriority: Priority?
    var categories: [Category] = []
    var selectedCategory: Category?

    let date: Date
    var tasks: [Task] = []
    var columns: [TaskColumn] = []

    var filteredTasks: [Task] {
        tasks.filteredBy(text: filterText, priority: selectedPriority, category: selectedCategory)
    }

    init(
        navigator: Navigator<ContentSceneFactory>,
        dataService: DataServiceInput = Resolver.resolve(),
        date: Date
    ) {
        self.navigator = navigator
        self.dataService = dataService
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
        if task.repeatingTasks != nil {
            isAlertPresented = true
        } else {
            dataService.deleteTask(task)
        }
    }

    func didTapDeleteOnlyThis(task: Task) {
        dataService.deleteTask(task)
    }

    func didTapDeleteRepeating(task: Task) {
        guard let repeating = task.repeatingTasks else { return }
        dataService.deleteRepeatingTasks(repeating)
    }

    func didTapClearFilters() {
        selectedCategory = nil
        selectedPriority = nil
        filterText = .empty
    }

    func didChangeColumn(to column: TaskColumn, on task: Task) {
        dataService.updateColumn(to: column, on: task)
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
                guard let self = self else { return }
                self.tasks = $0.filter {
                    Calendar.current.isDate($0.date, inSameDayAs: self.date)
                }
            }
            .store(in: &cancellables)
    }
}
