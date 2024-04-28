import Combine
import SwiftUI

@Observable final class WatchDashboardViewModel {
    private var dataService: DataService
    private var cancellables = Set<AnyCancellable>()

    var selectedTab: Int = .zero
    var tasks: [Task] = []
    var columns: [TaskColumn] = []

    var firstColumnTasks: [Task] {
        guard let first = columns.first else { return [] }
        return tasks.from(column: first)
    }

    var firstColumnName: String {
        guard let first = columns.first else { return .empty }
        return first.name
    }

    var doneCount: Int {
        guard let last = columns.last else { return .zero }
        return tasks.from(column: last).count
    }

    var totalCount: Int {
        tasks.count
    }

    init() {
        self.dataService = DataService(shouldLoadDefaults: false)
        registerBindings()
    }
}

private extension WatchDashboardViewModel {
    private func registerBindings() {
        registerTaskBinding()
        registerColumnBinding()
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

    private func registerColumnBinding() {
        dataService.fetchColumns()
        dataService.columns
            .sink { [weak self] in
                self?.columns = $0
            }
            .store(in: &cancellables)
    }
}
