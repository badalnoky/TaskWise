import CloudKit
import SwiftData
import SwiftUI

@Model final class Task {
    @Attribute(.unique) var id: UUID
    @Attribute(.spotlight) var title: String
    var taskDescription: String
    var priority: Priority
    var category: Category
    var date: Date
    var hasTimeConstraints: Bool
    var startDateTime: Date
    var endDateTime: Date
    var steps: [TaskStep]
    var colorComponents: ColorComponents
    var column: TaskColumn

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
