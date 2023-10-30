import Combine
import Resolver

@Observable final class DayViewModel {
    private var navigator: Navigator<ContentSceneFactory>
    private let dataService: DataService = Resolver.resolve()
    private var cancellables = Set<AnyCancellable>()

    let date: Date
    let tasks: [Task] = []

    init(navigator: Navigator<ContentSceneFactory>, date: Date) {
        self.navigator = navigator
        self.date = date
    }
}

extension DayViewModel {
    func didTapAdd() {
    }

    func didTapTask(_ task: Task) {
        navigator.showTask(task.id)
    }
}
