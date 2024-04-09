import CoreData
import Foundation

extension RepeatingTasks {
    static func create(from task: Task.DTO, with behaviour: RepeatBehaviour, on context: NSManagedObjectContext) {
        let repeatingTask = RepeatingTasks(context: context)
        repeatingTask.wId = UUID()
        repeatingTask.wStart = task.date
        repeatingTask.wLastUpdated = .now
        repeatingTask.wEnd = behaviour.end
        repeatingTask.wBehavior = behaviour.encoded
        for (start, end) in Date.calculateDates(for: behaviour, starting: task.startDateTime, endTime: task.endDateTime) {
            let dto = task.copyOn(start: start, end: end)
            Task.createRepeating(from: dto, for: repeatingTask, on: context)
        }
    }
}
