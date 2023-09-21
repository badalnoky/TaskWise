import Foundation

@Observable final class DayViewModel {
    private var navigator: Navigator<ContentSceneFactory>

    let date: Date = .now
    let tasks: [String] = ["these", "are", "the", "tasks"]

    init(navigator: Navigator<ContentSceneFactory>) {
        self.navigator = navigator
    }
}

extension DayViewModel {
    func didTapAdd() {
    }
}
