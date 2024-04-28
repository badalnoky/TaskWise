import Foundation

@Observable final class TaskDetailViewModel {
    var task: Task

    init(task: Task) {
        self.task = task
    }
}
