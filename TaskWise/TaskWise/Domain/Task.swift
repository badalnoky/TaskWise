import CloudKit
import SwiftData
import SwiftUI

@Model final class Task {
    var id = UUID()
    var title = String.empty
    var taskDescription = String.empty
    var priority = Priority(name: String.empty, level: 1)
    var category = Category(name: String.empty)
    var date = Date.now
    var hasTimeConstraints = false
    var startDateTime = Date.now
    var endDateTime = Date.now
    var steps: [TaskStep] = []
    var colorComponents = ColorComponents(red: 0, green: 0, blue: 0, alpha: 0)
    var column = TaskColumn.TODO

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
        colorComponents: ColorComponents
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
        self.column = .TODO
    }
}
