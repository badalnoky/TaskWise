import Combine
import SwiftUI

@Observable final class TaskDetailViewModel {
    private var dataService: DataService
    private var cancellables = Set<AnyCancellable>()

    var task: Task
    var title: String = .empty
    var description: String = .empty
    var priority: String = .empty
    var category: String = .empty
    var startDateTime: Date = .now
    var endDateTime: Date = .now.advanced(by: .hour)
    var steps: [TaskStep] = []
    var allDay = false

    init(task: Task) {
        self.dataService = DataService(shouldLoadDefaults: false)
        self.task = task
        registerBindings()
    }
}

private extension TaskDetailViewModel {
    private func registerBindings() {
        registerTaskBinding()
        registerStepsBinding()
    }

    private func registerTaskBinding() {
        dataService.fetchTasks()
        dataService.tasks
            .sink { [weak self] in
                guard let task = $0.first(where: { $0.id == self?.task.id }) else { return }
                self?.task = task
                self?.title = task.title
                self?.description = task.taskDescription
                self?.priority = task.priority.name
                self?.category = task.category.name
                self?.allDay = !task.hasTimeConstraints
                self?.startDateTime = task.startDateTime
                self?.endDateTime = task.endDateTime
                self?.dataService.fetchSteps(for: task)
            }
            .store(in: &cancellables)
    }

    private func registerStepsBinding() {
        dataService.currentSteps
            .sink { [weak self] in
                self?.steps = $0
            }
            .store(in: &cancellables)
    }
}
