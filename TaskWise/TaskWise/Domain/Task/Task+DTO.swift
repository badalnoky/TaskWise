import CoreData
import Foundation
import SwiftUI

extension Task {
    public struct DTO {
        let id: UUID
        let title: String
        let description: String
        let date: Date
        let hasTimeConstraints: Bool
        let startDateTime: Date
        let endDateTime: Date
        let category: Category
        let priority: Priority
        let column: TaskColumn
        let steps: [TaskStep.DTO]
    }

    static func create(from dto: DTO, on context: NSManagedObjectContext) {
        let task = Task(context: context)
        task.wDate = dto.date
        task.wEndDateTime = dto.endDateTime
        task.wHasTimeConstraints = dto.hasTimeConstraints
        task.wId = dto.id
        task.wStartDateTime = dto.startDateTime
        task.wTaskDescription = dto.description
        task.wTitle = dto.title
        task.wCategory = dto.category
        task.wColumn = dto.column
        task.wPriority = dto.priority
        TaskStep.createSteps(for: task, from: dto.steps, on: context)
    }

    func update(with updated: Task.DTO, on context: NSManagedObjectContext) {
        self.wDate = updated.date
        self.wEndDateTime = updated.endDateTime
        self.wHasTimeConstraints = updated.hasTimeConstraints
        self.wId = updated.id
        self.wStartDateTime = updated.startDateTime
        self.wTaskDescription = updated.description
        self.wTitle = updated.title
        self.wCategory = updated.category
        self.wPriority = updated.priority
        self.wColumn = updated.column
    }
}

extension Task {
    public struct WidgetDTO {
        let id: UUID
        let title: String
        let priority: String
        let category: String
        let categoryColor: Color
        let columnId: UUID

        public init(
            id: UUID,
            title: String,
            priority: String,
            category: String,
            categoryColor: Color,
            columnId: UUID
        ) {
            self.id = id
            self.title = title
            self.priority = priority
            self.category = category
            self.categoryColor = categoryColor
            self.columnId = columnId
        }

        public init(from task: Task) {
            self.id = task.id
            self.title = task.title
            self.priority = task.priority.name
            self.category = task.category.name
            self.categoryColor = .from(components: task.category.colorComponents)
            self.columnId = task.column.id
        }

        static var placeholder: WidgetDTO {
            // swiftlint: disable: force_unwrapping
            .init(
                id: UUID(),
                title: "Task",
                priority: "Low",
                category: "Freetime",
                categoryColor: .blue,
                columnId: UUID(uuidString: "03648B00-ACD7-47E9-8819-63EA18F290C0")!
            )
            // swiftlint: enable: force_unwrapping
        }
    }
}
