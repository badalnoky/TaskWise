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
        let colorComponents: ColorComponents.DTO
        let steps: [TaskStep]
    }
    static func create(from dto: DTO, on context: NSManagedObjectContext, startingIn column: TaskColumn) {
        let task = Task(context: context)
        task.wDate = dto.date
        task.wEndDateTime = dto.endDateTime
        task.wHasTimeConstraints = dto.hasTimeConstraints
        task.wId = dto.id
        task.wStartDateTime = dto.startDateTime
        task.wTaskDescription = dto.description
        task.wTitle = dto.title
        task.wCategory = dto.category
        task.wColumn = column
        task.wPriority = dto.priority
        task.wSteps?.addingObjects(from: dto.steps)
        task.wColorComponents = ColorComponents.create(from: dto.colorComponents, on: context)
    }
}
