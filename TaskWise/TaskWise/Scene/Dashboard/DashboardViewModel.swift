import Combine
import Resolver
import SwiftUI

@Observable final class DashboardViewModel {
    private var navigator: Navigator<ContentSceneFactory>
    private let dataService: DataServiceInput
    private var cancellables = Set<AnyCancellable>()

    let date: Date = .now
    var tasks: [Task] = []
    var columns: [TaskColumn] = []
    var activeTab: Int = .one

    var doneCount: Int {
        guard let last = columns.last else { return .zero }
        return tasks.from(column: last).count
    }

    var totalCount: Int {
        tasks.count
    }

    init(
        navigator: Navigator<ContentSceneFactory>,
        dataService: DataServiceInput = Resolver.resolve()
    ) {
        self.navigator = navigator
        self.dataService = dataService

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
        navigator.showAddTask(with: date)
    }

    func didTapTask(_ task: Task) {
        navigator.showTask(task.id)
    }

    func didTapDelete(task: Task) {
        dataService.deleteTask(task)
    }

    func didChangeColumn(to column: TaskColumn, on task: Task) {
        dataService.updateColumn(to: column, on: task)
    }

    func openAt(_ url: URL) {
        guard url.scheme == Str.App.scheme, url.host == Str.App.host else { return }
        if url.pathComponents[.one] == Str.App.taskPath {
            // swiftlint: disable: force_unwrapping
            let id = UUID(uuidString: url.pathComponents[.one.next])!
            // swiftlint: enable: force_unwrapping
            navigator.showTask(id)
        } else {
            self.activeTab = Int(url.pathComponents[.one]) ?? .one
        }
    }
}

private extension DashboardViewModel {
    private func registerBindings() {
        registerColumnBinding()
        registerTaskBinding()
    }

    private func registerColumnBinding() {
        dataService.fetchColumns()
        dataService.columns
            .sink { [weak self] in
                self?.columns = $0
            }
            .store(in: &cancellables)
    }

    private func registerTaskBinding() {
        dataService.fetchTasks()
        dataService.todaysTasks
            .sink { [weak self] tasks in
                withAnimation(.smooth(duration: .defaultAnimationDuration)) {
                    self?.tasks = tasks
                }
            }
            .store(in: &cancellables)
    }
}
