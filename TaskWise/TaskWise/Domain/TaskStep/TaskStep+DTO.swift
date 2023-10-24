import CoreData

extension TaskStep {
    struct DTO {
        let isDone: Bool
        let label: String
        let index: Int

        init(isDone: Bool = false, label: String, index: Int) {
            self.isDone = isDone
            self.label = label
            self.index = index
        }
    }
    static func createSteps(for task: Task, from dtos: [DTO], on context: NSManagedObjectContext) {
        for dto in dtos {
            TaskStep.create(for: task, from: dto, on: context)
        }
    }

    static func create(for task: Task, from dto: DTO, on context: NSManagedObjectContext) {
        let step = TaskStep(context: context)
        step.wIsDone = dto.isDone
        step.wLabel = dto.label
        step.wIndex = Int16(dto.index)
        step.wTask = task
    }
}
