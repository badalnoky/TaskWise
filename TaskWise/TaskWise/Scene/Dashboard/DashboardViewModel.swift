import Foundation

@Observable final class DashboardViewModel {
    private var navigator: Navigator<ContentSceneFactory>

    let date: Date = .now
    let tasks: [String] = ["this", "is", "a", "list", "of", "tasks"]

    init(navigator: Navigator<ContentSceneFactory>) {
        self.navigator = navigator
    }
}

extension DashboardViewModel {
    func didTapCalendar() {
    }

    func didTapSettings() {
    }

    func didTapAddTask() {
    }

    func didTapTask(_ task: String) {
    }
}