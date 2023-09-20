import SwiftUI

@Observable final class TaskViewModel {
    private let navigator: Navigator<ContentSceneFactory>

    var isEditable: Bool

    var name: String = "Task name"
    var description: String = "This is the very long descriptions of the task, that should be multiple lines of text."
    var priorities: [String] = ["High", "Medium", "Low"]
    var selectedPriority: String = "High"
    var categories: [String] = ["Homework", "Work", "Exercise", "Other"]
    var selectedCategory: String = "Homework"
    var starts: Date = .now
    var ends: Date = .now.advanced(by: .hour)
    var repeats: [String] = ["Never", "Weekly", "Biweekly", "Yearly"]
    var selectedRepeats: String = "Never"
    var stepIsCompleted: [Bool] = [true, false, false, false]
    var steps: [String] = ["these", "are", "the", "steps"]
    var color: Color = .blue

    init(navigator: Navigator<ContentSceneFactory>, isEditable: Bool = false) {
        self.navigator = navigator
        self.isEditable = isEditable
    }
}

extension TaskViewModel {
    func didTapEdit() {
    }

    func didTapDelete() {
    }
}
