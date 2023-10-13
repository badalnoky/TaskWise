import Combine
import Resolver

@Observable final class DashboardViewModel {
    private var navigator: Navigator<ContentSceneFactory>
    private let dataController: DataService = Resolver.resolve()
    private var cancellables = Set<AnyCancellable>()

    let date: Date = .now
    var tasks: [Task] = []
    var columns: [TaskColumn] = []

    var completionText: String {
        guard let last = columns.last else { return .empty}
        return "\(tasks.from(column: last).count)/\(tasks.count)"
    }

    init(navigator: Navigator<ContentSceneFactory>) {
        self.navigator = navigator

        registerBindings()
    }
}
// TODO: add "more" functionallity
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

private extension DashboardViewModel {
    private func registerBindings() {
        registerColumnBinding()
        registerTaskBinding()
    }

    private func registerColumnBinding() {
        dataController.fetchColumns()
        dataController.columns
            .sink { [weak self] in
                self?.columns = $0
            }
            .store(in: &cancellables)
    }

    private func registerTaskBinding() {
        dataController.fetchTasks()
        dataController.tasks
            .sink { [weak self] in
                self?.tasks = $0
            }
            .store(in: &cancellables)
    }
}
