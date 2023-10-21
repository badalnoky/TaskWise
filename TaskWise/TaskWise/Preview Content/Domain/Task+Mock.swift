import Foundation

#if DEBUG
extension Task {
    static var mock: Task {
        let task = Task(context: PreviewDataController.global.context)
        task.wDate = .now
        task.wEndDateTime = .now
        task.wHasTimeConstraints = false
        task.wId = UUID()
        task.wStartDateTime = .now
        task.wTaskDescription = "Description"
        task.wTitle = "Task"
        task.wCategory = .mock
        task.wColumn = .mock
        task.wPriority = .mock
        return task
    }
}
#endif
