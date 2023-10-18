import Combine
import Resolver
import SwiftUI

@Observable final class AddTaskViewModel {
    private let navigator: Navigator<ContentSceneFactory>
    private let dataService: DataService = Resolver.resolve()
    private var cancellables = Set<AnyCancellable>()

    var title: String = .empty
    var description: String = .empty
    var priorities: [Priority] = []
    var selectedPriority = Priority()
    var categories: [Category] = []
    var selectedCategory = Category()
    var columns: [TaskColumn] = []
    var selectedColumn = TaskColumn()
    var allDay = false
    var starts: Date = .now
    var ends: Date = .now.advanced(by: .hour)
    var repeats: [String] = ["Never", "Weekly", "Biweekly", "Yearly"]
    var selectedRepeats: String = "Never"
    var steps: [TaskStep] = []
    var color: Color = .blue

    var task: Task.DTO {
        Task.DTO(
            id: UUID(),
            title: title,
            description: description,
            date: starts,
            hasTimeConstraints: !allDay,
            startDateTime: starts,
            endDateTime: ends,
            category: selectedCategory,
            priority: selectedPriority,
            colorComponents: color.components,
            steps: steps
        )
    }

    init(navigator: Navigator<ContentSceneFactory>) {
        self.navigator = navigator

        registerBindings()
    }
}

// TODO: add task step modification
extension AddTaskViewModel {
    func didTapCreate() {
        dataService.addTask(task)
    }

    func dismiss() {
        navigator.pop()
    }
}

private extension AddTaskViewModel {
    private func registerBindings() {
        registerPriorityBinding()
        registerCategoryBinding()
        registerColumnBinding()
    }

    private func registerPriorityBinding() {
        dataService.fetchPriorities()
        dataService.priorities
            .sink { [weak self] in
                self?.priorities = $0
                self?.selectedPriority = $0[.zero]
            }
            .store(in: &cancellables)
    }

    private func registerCategoryBinding() {
        dataService.fetchCategories()
        dataService.categories
            .sink { [weak self] in
                self?.categories = $0
                self?.selectedCategory = $0[.zero]
            }
            .store(in: &cancellables)
    }

    private func registerColumnBinding() {
        dataService.fetchColumns()
        dataService.columns
            .sink { [weak self] in
                self?.columns = $0
                self?.selectedColumn = $0[.zero]
            }
            .store(in: &cancellables)
    }
}
