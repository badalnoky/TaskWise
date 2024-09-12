import Combine
import Resolver
import SwiftUI

@Observable final class MacDashboardViewModel {
    let dataService: DataServiceInput
    private var cancellables = Set<AnyCancellable>()
    
    var selectedDate: Date = .now
    var tasks: [TWTask] = []
    var filterText: String = .empty
    var priorities: [Priority] = []
    var categories: [Category] = []
    var columns: [TaskColumn] = []
    var selectedPriority: Priority?
    var selectedCategory: Category?

    var filteredTasks: [TWTask] {
        tasks
            .from(date: selectedDate)
            .filteredBy(text: filterText, priority: selectedPriority, category: selectedCategory)
    }

    var doneCount: Int {
        guard let last = columns.last else { return .zero }
        return tasks.from(date: selectedDate).from(column: last).count
    }

    var totalCount: Int {
        tasks.from(date: selectedDate).count
    }

    var isToday: Bool {
        Calendar.current.isDate(selectedDate, inSameDayAs: .now)
    }

    init(dataService: DataServiceInput = Resolver.resolve()) {
        self.dataService = dataService

        registerBindings()
    }
}

extension MacDashboardViewModel {
    func didTapTask(_ task: TWTask) {
    }

    func didChangeColumn(to column: TaskColumn, on task: TWTask) {
        dataService.updateColumn(to: column, on: task)
    }

    func didTapDelete(task: TWTask) {
    }
}

extension MacDashboardViewModel {
    private func registerBindings() {
        registerColumnsBinding()
        registerPriorityBinding()
        registerCategoryBinding()
        registerTaskBinding()
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

    private func registerTaskBinding() {
        dataService.fetchTasks()
        dataService.tasks
            .sink { [weak self] tasks in
                withAnimation(.smooth(duration: .defaultAnimationDuration)) {
                    self?.tasks = tasks
                }
            }
            .store(in: &cancellables)
    }
}
