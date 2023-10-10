import Combine
import Resolver
import SwiftUI

@Observable final class TaskViewModel {
    private let navigator: Navigator<ContentSceneFactory>
    private let dataController: DataService = Resolver.resolve()
    private var cancellables = Set<AnyCancellable>()
    private var task: Task

    var isEditable = false

    var title: String = .empty
    var description: String = .empty
    var priorities: [Priority] = []
    var selectedPriority = Priority()
    var categories: [Category] = []
    var selectedCategory = Category()
    var allDay = false
    var starts: Date = .now
    var ends: Date = .now.advanced(by: .hour)
    var repeats: [String] = ["Never", "Weekly", "Biweekly", "Yearly"]
    var selectedRepeats: String = "Never"
    var steps: [TaskStep] = []
    var color: Color = .blue

    init(navigator: Navigator<ContentSceneFactory>, task: Task) {
        self.navigator = navigator
        self.task = task
        self.title = task.title
        self.description = task.taskDescription
        print(task.startDateTime)
        print(task.endDateTime)
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
        // TODO: Add edit and delete capability
    }

    func dismiss() {
        navigator.pop()
    }
}

private extension TaskViewModel {
    private func registerBindings() {
        registerPriorityBinding()
        registerCategoryBinding()
    }

    private func registerPriorityBinding() {
        dataController.fetchPriorities()
        dataController.priorities
            .sink { [weak self] in
                self?.priorities = $0
                self?.selectedPriority = $0.first { $0.id == self?.task.priority.id} ?? $0[.zero]
            }
            .store(in: &cancellables)
    }

    private func registerCategoryBinding() {
        dataController.fetchCategories()
        dataController.categories
            .sink { [weak self] in
                self?.categories = $0
                self?.selectedCategory = $0.first { $0.id == self?.task.category.id} ?? $0[.zero]
            }
            .store(in: &cancellables)
    }
}
