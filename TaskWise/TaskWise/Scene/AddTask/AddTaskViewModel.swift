import Combine
import Resolver
import SwiftUI

@Observable final class AddTaskViewModel {
    private let navigator: Navigator<ContentSceneFactory>
    private let dataController: DataService = Resolver.resolve()
    private var cancellables = Set<AnyCancellable>()

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

extension AddTaskViewModel {
    func didTapCreate() {
        dataController.addTask(task)
    }

    func dismiss() {
        navigator.pop()
    }
}

private extension AddTaskViewModel {
    private func registerBindings() {
        registerPriorityBinding()
        registerCategoryBinding()
    }

    private func registerPriorityBinding() {
        dataController.fetchPriorities()
        dataController.priorities
            .sink { [weak self] in
                self?.priorities = $0
                self?.selectedPriority = $0[.zero]
            }
            .store(in: &cancellables)
    }

    private func registerCategoryBinding() {
        dataController.fetchCategories()
        dataController.categories
            .sink { [weak self] in
                self?.categories = $0
                self?.selectedCategory = $0[.zero]
            }
            .store(in: &cancellables)
    }
}
