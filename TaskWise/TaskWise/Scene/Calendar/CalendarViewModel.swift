import Combine
import Resolver
import SwiftUI

@Observable final class CalendarViewModel {
    private var navigator: Navigator<ContentSceneFactory>
    private let dataService: DataService = Resolver.resolve()
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
                filterText.isEmpty ? true : ($0.title.caseInsensitiveContains(filterText) || $0.taskDescription.caseInsensitiveContains(filterText))
            }
            .filter {
                selectedPriority == nil ? true : $0.priority.id == selectedPriority?.id
            }
            .filter {
                selectedCategory == nil ? true : $0.category.id == selectedCategory?.id
            }
    }

    var foundTasks: [Task] {
        tasks
            .filter {
                searchText.isEmpty ? false : ($0.title.caseInsensitiveContains(searchText) || $0.taskDescription.caseInsensitiveContains(searchText))
            }
            .sorted { $0.date < $1.date }
    }

    init(navigator: Navigator<ContentSceneFactory>) {
        self.navigator = navigator
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
