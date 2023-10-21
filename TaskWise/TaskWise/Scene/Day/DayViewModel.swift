import Foundation

@Observable final class DayViewModel {
    private var navigator: Navigator<ContentSceneFactory>

    let date: Date = .now
    let tasks: [Task] = []

    init(navigator: Navigator<ContentSceneFactory>) {
        self.navigator = navigator
    }
}

extension DayViewModel {
    func didTapAdd() {
    }

    func didTapTask(_ task: Task) {
        navigator.showTask(task.id)
    }
}
