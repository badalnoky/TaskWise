import Combine
import Resolver
import SwiftUI

@Observable final class PadDashboardViewModel {
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

    var isAlertPresented = false
    var isTaskPresented = false
    var presentedTask: TWTask?

    var filteredTasks: [TWTask] {
        tasks
            .from(date: selectedDate)
            .filteredBy(text: filterText, priority: selectedPriority, category: selectedCategory)
    }

    var isToday: Bool {
        Calendar.current.isDate(selectedDate, inSameDayAs: .now)
    }

    var doneCount: Int {
        guard let last = columns.last else { return .zero }
        return tasks.from(column: last).count
    }

    var totalCount: Int {
        tasks.count
    }

    init(dataService: DataServiceInput = Resolver.resolve()) {
        self.dataService = dataService

        registerBindings()
    }
}

extension PadDashboardViewModel {
    func didTapTask(_ task: TWTask) {
        presentedTask = task
        isTaskPresented = true
    }

    func didTapSearchedTask(_ task: TWTask) {
        selectedDate = task.startDateTime
        didTapTask(task)
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

    func didChangeColumn(to column: TaskColumn, on task: TWTask) {
        dataService.updateColumn(to: column, on: task)
    }
}

extension PadDashboardViewModel {
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
