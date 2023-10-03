import SwiftData
import SwiftUI

@Model public final class Task {
    public var id = UUID()
    var title = String.empty
    var taskDescription = String.empty
    var priority = Priority.defaultPriorities[0]
    var category = Category.defaultCategories[0]
    var date = Date.now
    var hasTimeConstraints = false
    var startDateTime = Date.now
    var endDateTime = Date.now
    var steps: [TaskStep] = []
    var colorComponents = ColorComponents(red: 0, green: 0, blue: 0, alpha: 0)
    var column = TaskColumn.defaultColumns[0]

    init(
        title: String,
        description: String,
        priority: Priority,
        category: Category,
        date: Date,
        hasTimeConstraints: Bool,
        startDateTime: Date,
        endDateTime: Date,
        steps: [TaskStep],
        colorComponents: ColorComponents,
        column: TaskColumn
    ) {
        self.id = UUID()
        self.title = title
        self.taskDescription = description
        self.priority = priority
        self.category = category
        self.date = date
        self.hasTimeConstraints = hasTimeConstraints
        self.startDateTime = startDateTime
        self.endDateTime = endDateTime
        self.steps = steps
        self.colorComponents = colorComponents
        self.column = column
    }
}

extension Task {
    static var mock: Task {
        Task(
            title: .empty,
            description: .empty,
            priority: .mock,
            category: .mock,
            date: .now,
            hasTimeConstraints: false,
            startDateTime: .now,
            endDateTime: .now,
            steps: [],
            colorComponents: .mock,
            column: .mock
        )
    }
}
