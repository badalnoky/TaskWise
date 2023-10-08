import SwiftUI

public struct Task: Codable, Identifiable {
    public var id: UUID
    var title: String
    var description: String
    var priorityId: String
    var categoryId: String
    var date = Date.now
    var hasTimeConstraints = false
    var startDateTime = Date.now
    var endDateTime = Date.now
    var steps: [TaskStep] = []
    var colorComponents = ColorComponents(red: .zero, green: .zero, blue: .zero, alpha: .zero)
    var columnId: String

    init(
        id: UUID = UUID(),
        title: String,
        description: String,
        priorityId: String,
        categoryId: String,
        date: Date,
        hasTimeConstraints: Bool,
        startDateTime: Date,
        endDateTime: Date,
        steps: [TaskStep],
        colorComponents: ColorComponents,
        columnId: String
    ) {
        self.id = id
        self.title = title
        self.description = description
        self.priorityId = priorityId
        self.categoryId = categoryId
        self.date = date
        self.hasTimeConstraints = hasTimeConstraints
        self.startDateTime = startDateTime
        self.endDateTime = endDateTime
        self.steps = steps
        self.colorComponents = colorComponents
        self.columnId = columnId
    }
}
