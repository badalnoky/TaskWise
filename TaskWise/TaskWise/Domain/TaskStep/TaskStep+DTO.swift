import CoreData

extension TaskStep {
    struct DTO: Hashable {
        var isDone: Bool
        var label: String
        var index: Int

        init(isDone: Bool = false, label: String, index: Int) {
            self.isDone = isDone
            self.label = label
            self.index = index
        }

        mutating func changeIndex(to newIndex: Int) {
            self.index = newIndex
        }

        mutating func toggleIsDone() {
            self.isDone.toggle()
        }
    }

    static func createSteps(for task: TWTask, from dtos: [DTO], on context: NSManagedObjectContext) {
        for dto in dtos {
            TaskStep.create(for: task, from: dto, on: context)
        }
    }

    static func create(for task: TWTask, from dto: DTO, on context: NSManagedObjectContext) {
        let step = TaskStep(context: context)
        step.wIsDone = dto.isDone
        step.wLabel = dto.label
        step.wIndex = Int16(dto.index)
        step.wTask = task
    }
}
