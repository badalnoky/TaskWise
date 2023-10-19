import CoreData
import Foundation

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
        let steps: [TaskStep]
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
        task.wSteps?.addingObjects(from: dto.steps)
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
        // FIXME: here adding objects is not the right behaviour, should be update
        self.wSteps?.addingObjects(from: updated.steps)
    }
}
