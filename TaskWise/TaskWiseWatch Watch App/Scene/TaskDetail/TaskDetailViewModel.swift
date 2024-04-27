import Foundation

@Observable final class TaskDetailViewModel {
    var task: String

    init(task: String) {
        self.task = task
    }
}
