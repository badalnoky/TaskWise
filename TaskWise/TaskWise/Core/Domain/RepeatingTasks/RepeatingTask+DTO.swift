import CoreData
import Foundation

extension RepeatingTasks {
    static func create(from task: TWTask.DTO, with behaviour: RepeatBehaviour, on context: NSManagedObjectContext) {
        let repeatingTask = RepeatingTasks(context: context)
        repeatingTask.wId = UUID()
        repeatingTask.wStart = task.date
        repeatingTask.wLastUpdated = .now
        repeatingTask.wEnd = behaviour.end
        repeatingTask.wBehavior = behaviour.encoded
        for (start, end) in Date.calculateDates(for: behaviour, starting: task.startDateTime, endTime: task.endDateTime) {
            let dto = task.copyOn(start: start, end: end)
            TWTask.createRepeating(from: dto, for: repeatingTask, on: context)
        }
    }

    static func create(
        with behaviour: RepeatBehaviour,
        including existingTask: TWTask,
        on context: NSManagedObjectContext
    ) {
        let repeatingTask = RepeatingTasks(context: context)
        repeatingTask.wId = UUID()
        repeatingTask.wStart = existingTask.date
        repeatingTask.wLastUpdated = .now
        repeatingTask.wEnd = behaviour.end
        repeatingTask.wBehavior = behaviour.encoded
        existingTask.repeatingTasks = repeatingTask
        for (start, end) in Date.calculateDates(for: behaviour, starting: existingTask.startDateTime, endTime: existingTask.endDateTime).dropFirst() {
            var steps: [TaskStep.DTO] = []
            for step in existingTask.steps {
                steps.append(.init(isDone: step.isDone, label: step.label, index: step.index))
            }
            let dto = TWTask.DTO(
                id: UUID(),
                title: existingTask.title,
                description: existingTask.taskDescription,
                date: start,
                hasTimeConstraints: existingTask.hasTimeConstraints,
                startDateTime: start,
                endDateTime: end,
                category: existingTask.category,
                priority: existingTask.priority,
                column: existingTask.column,
                steps: steps
            )
            TWTask.createRepeating(from: dto, for: repeatingTask, on: context)
        }
    }
}
