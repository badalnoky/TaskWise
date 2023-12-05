import Combine
import Resolver
import SwiftUI

@Observable final class CalendarViewModel {
    private var navigator: Navigator<ContentSceneFactory>
    private let dataService: DataServiceInput
    private var cancellables = Set<AnyCancellable>()

    var isSearching = false
    var searchText: String = .empty

    var isFilterSheetPresented = false
    var filterText: String = .empty
    var priorities: [Priority] = []
    var selectedPriority: Priority?
    var categories: [Category] = []
    var selectedCategory: Category?

    var isListed = false
    var selectedDate: Date = .now
    var tasks: [Task] = []
    var columns: [TaskColumn] = []

    var filteredTasks: [Task] {
        tasks
            .filter {
                Calendar.current.isDate($0.date, inSameDayAs: self.selectedDate)
            }
            .filteredBy(text: filterText, priority: selectedPriority, category: selectedCategory)
    }

    var foundTasks: [Task] {
        tasks
            .filter {
                searchText.isEmpty ? false : ($0.title.caseInsensitiveContains(searchText) || $0.taskDescription.caseInsensitiveContains(searchText))
            }
            .sorted { $0.date < $1.date }
    }

    var foundDates: [Date] {
        foundTasks
            .map { $0.date }
            .groupedByDay()
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

extension CalendarViewModel {
    func didTapList() {
        withAnimation {
            isListed.toggle()
        }
    }

    func didTapFilter() {
        isFilterSheetPresented = true
    }

    func didToggleSearch() {
        withAnimation {
            isSearching.toggle()
        }
    }

    func didTapTask(_ task: Task) {
        navigator.showTask(task.id)
    }

    func didTapDelete(task: Task) {
        dataService.deleteTask(task)
    }

    func didTapDate() {
        if !isListed {
            self.navigator.showDay(selectedDate)
        }
    }

    func dismiss() {
        navigator.pop()
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

private extension CalendarViewModel {
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
