import Combine
import Resolver
import SwiftUI

@Observable final class AddTaskViewModel {
    private let navigator: Navigator<ContentSceneFactory>
    private let dataController: DataService = Resolver.resolve()
    private var cancellables = Set<AnyCancellable>()

    var title: String = "Task name"
    var description: String = "This is the very long descriptions of the task, that should be multiple lines of text."
    var priorities: [Priority] = []
    var selectedPriority = Priority()
    var categories: [Category] = []
    var selectedCategory = Category()
    var starts: Date = .now
    var ends: Date = .now.advanced(by: .hour)
    var repeats: [String] = ["Never", "Weekly", "Biweekly", "Yearly"]
    var selectedRepeats: String = "Never"
    var taskSteps: [TaskStep] = []
    var stepIsCompleted: [Bool] = [true, false, false, false]
    var steps: [String] = ["these", "are", "the", "steps"]
    var color: Color = .blue

    init(navigator: Navigator<ContentSceneFactory>) {
        self.navigator = navigator

        registerBindings()
    }
}

extension AddTaskViewModel {
    func didTapCreate() {
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
                self?.selectedPriority = $0[0]
            }
            .store(in: &cancellables)
    }

    private func registerCategoryBinding() {
        dataController.fetchCategories()
        dataController.categories
            .sink { [weak self] in
                self?.categories = $0
                self?.selectedCategory = $0[0]
            }
            .store(in: &cancellables)
    }
}