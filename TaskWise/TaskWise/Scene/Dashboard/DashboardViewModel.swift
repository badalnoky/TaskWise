import Foundation

@Observable final class DashboardViewModel {
    private var navigator: Navigator<ContentSceneFactory>

    let date: Date = .now
    let tasks: [Task] = []

    init(navigator: Navigator<ContentSceneFactory>) {
        self.navigator = navigator
    }
}

extension DashboardViewModel {
    func didTapCalendar() {
        navigator.showCalendar()
    }

    func didTapSettings() {
        navigator.showSettings()
    }

    func didTapAddTask() {
        navigator.showAddTask()
    }

    func didTapTask(_ task: Task) {
        navigator.showTask(task)
    }
}
