import Combine
import Resolver
import SwiftUI

@Observable final class TaskViewModel {
    private let navigator: Navigator<ContentSceneFactory>
    private let dataService: DataService = Resolver.resolve()
    private var cancellables = Set<AnyCancellable>()
    private var task: Task

    var isEditable = false
    var isAlertVisible = false

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

    private var updatedTask: Task.DTO {
        Task.DTO(
            id: task.id,
            title: title,
            description: description,
            date: starts,
            hasTimeConstraints: !allDay,
            startDateTime: starts,
            endDateTime: ends,
            category: selectedCategory,
            priority: selectedPriority,
            column: selectedColumn,
            colorComponents: color.components,
            steps: steps
        )
    }

    init(navigator: Navigator<ContentSceneFactory>, task: Task) {
        self.navigator = navigator
        self.task = task
        self.title = task.title
        self.description = task.taskDescription
        self.allDay = !task.hasTimeConstraints
        self.starts = task.startDateTime
        self.ends = task.endDateTime
        self.steps = task.steps
        self.color = .from(components: task.colorComponents)

        registerBindings()
    }
}

extension TaskViewModel {
    func didTapEdit() {
        isEditable.toggle()
    }

    func didTapAction() {
        if isEditable {
            // TODO: detect whether there were any real changes in the object -> memento?
            dataService.updateTask(task, with: updatedTask)
        } else {
            isAlertVisible = true
        }
    }

    func didTapDelete() {
        dataService.deleteTask(task)
        dismiss()
    }

    func dismiss() {
        navigator.pop()
    }
}

private extension TaskViewModel {
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
                self?.selectedPriority = $0.first { $0.id == self?.task.priority.id} ?? $0[.zero]
            }
            .store(in: &cancellables)
    }

    private func registerCategoryBinding() {
        dataService.fetchCategories()
        dataService.categories
            .sink { [weak self] in
                self?.categories = $0
                self?.selectedCategory = $0.first { $0.id == self?.task.category.id} ?? $0[.zero]
            }
            .store(in: &cancellables)
    }

    private func registerColumnBinding() {
        dataService.fetchColumns()
        dataService.columns
            .sink { [weak self] in
                self?.columns = $0
                self?.selectedColumn = $0.first { $0.id == self?.task.column.id} ?? $0[.zero]
            }
            .store(in: &cancellables)
    }
}
