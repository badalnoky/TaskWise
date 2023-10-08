import SwiftUI

@Observable final class TaskViewModel {
    private let navigator: Navigator<ContentSceneFactory>
    var isEditable = false
    var title: String = "Task name"
    var description: String = "This is the very long descriptions of the task, that should be multiple lines of text."
    var priorities: [Priority] = Priority.defaultPriorities
    var selectedPriority = Priority.defaultPriorities[0]
    var categories: [Category] = Category.defaultCategories
    var selectedCategory = Category.defaultCategories[0]
    var starts: Date = .now
    var ends: Date = .now.advanced(by: .hour)
    var repeats: [String] = ["Never", "Weekly", "Biweekly", "Yearly"]
    var selectedRepeats: String = "Never"
    var taskSteps: [TaskStep] = [
        TaskStep(isDone: false, label: "step1"),
        TaskStep(isDone: true, label: "step2"),
        TaskStep(isDone: false, label: "step3")
    ]
    var stepIsCompleted: [Bool] = [true, false, false, false]
    var steps: [String] = ["these", "are", "the", "steps"]
    var color: Color = .blue

    init(navigator: Navigator<ContentSceneFactory>) {
        self.navigator = navigator
    }
}

extension TaskViewModel {
    func didTapEdit() {
        isEditable.toggle()
    }

    func didTapAction() {
    }

    func dismiss() {
        navigator.pop()
    }
}
