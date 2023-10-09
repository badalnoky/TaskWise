import Combine
import Resolver

@Observable final class DashboardViewModel {
    private var navigator: Navigator<ContentSceneFactory>
    private let dataController: DataService = Resolver.resolve()
    private var cancellables = Set<AnyCancellable>()

    let date: Date = .now
    let tasks: [Task] = []
    var columns: [TaskColumn] = []

    init(navigator: Navigator<ContentSceneFactory>) {
        self.navigator = navigator

        registerBindings()
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

    func didTapTask() {
        navigator.showTask()
    }
}

private extension DashboardViewModel {
    private func registerBindings() {
        dataController.fetchColumns()
        dataController.columns
            .sink { [weak self] in
                self?.columns = $0
            }
            .store(in: &cancellables)
    }
}
