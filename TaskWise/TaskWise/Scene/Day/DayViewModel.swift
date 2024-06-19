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
    var tasks: [TWTask] = []
    var columns: [TaskColumn] = []

    var filteredTasks: [TWTask] {
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

    func didTapTask(_ task: TWTask) {
        navigator.showTask(task.id)
    }

    func didTapDelete(task: TWTask) {
        if task.repeatingTasks != nil {
            isAlertPresented = true
        } else {
            dataService.deleteTask(task)
        }
    }

    func didTapDeleteOnlyThis(task: TWTask) {
        dataService.deleteTask(task)
    }

    func didTapDeleteRepeating(task: TWTask) {
        guard let repeating = task.repeatingTasks else { return }
        dataService.deleteRepeatingTasks(repeating)
    }

    func didTapClearFilters() {
        selectedCategory = nil
        selectedPriority = nil
        filterText = .empty
    }

    func didChangeColumn(to column: TaskColumn, on task: TWTask) {
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
