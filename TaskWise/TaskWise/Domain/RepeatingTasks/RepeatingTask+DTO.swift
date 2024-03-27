import CoreData
import Foundation

extension RepeatingTasks {
    public struct DTO {
        let id: UUID
        let start: Date
//        let repeatingBehaviour
//        let task: Task.DTO
    }

    static func create(from dto: DTO, on context: NSManagedObjectContext) {
        let repeatingTask = RepeatingTasks(context: context)
        repeatingTask.wId = dto.id
        repeatingTask.wStart = dto.start
        repeatingTask.wLastUpdated = .now
        // repeatingTask.end = repeatbehaviour
        // create tasks from sample task with id
        // task.repeatingTask = repeatingTask
    }
}
