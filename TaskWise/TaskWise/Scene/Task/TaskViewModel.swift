import SwiftUI

@Observable final class TaskViewModel {
    private let navigator: Navigator<ContentSceneFactory>

    var isEditable = false

    var title: String = "Task name"
    var description: String = "This is the very long descriptions of the task, that should be multiple lines of text."
    var priorities: [Priority] = [
        Priority(name: "Low", level: 1),
        Priority(name: "Medium", level: 2),
        Priority(name: "High", level: 3)
    ]
    var selectedPriority = Priority(name: "Low", level: 1)
    var categories: [Category] = [
        Category(name: "Homework"),
        Category(name: "Work"),
        Category(name: "Exercise"),
        Category(name: "Other")
    ]
    var selectedCategory = Category(name: "Homework")
    var starts: Date = .now
    var ends: Date = .now.advanced(by: .hour)
    var repeats: [String] = ["Never", "Weekly", "Biweekly", "Yearly"]
    var selectedRepeats: String = "Never"
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
        if isEditable {
            let task = Task(
                title: title,
                description: description,
                priority: selectedPriority,
                category: selectedCategory,
                date: starts,
                hasTimeConstraints: false,
                startDateTime: starts,
                endDateTime: ends,
                steps: [],
                colorComponents: color.components
            )
        }
    }
}
