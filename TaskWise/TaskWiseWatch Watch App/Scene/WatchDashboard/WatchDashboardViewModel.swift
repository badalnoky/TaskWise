import Combine
import SwiftUI

@Observable final class WatchDashboardViewModel {
    private var dataService: DataService
    private var cancellables = Set<AnyCancellable>()
    private var tasks: [TWTask] = []

    var selectedTab: Int = .zero
    var columns: [TaskColumn] = []

    var selectedColumn: Int = .zero

    var tasksForSelected: [TWTask] {
        guard !columns.isEmpty else { return [] }
        return tasks.from(column: columns[selectedColumn])
    }

    var selectedColumnName: String {
        guard !columns.isEmpty else { return .empty }
        return columns[selectedColumn].name
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

extension WatchDashboardViewModel {
    func didTapNextColumn() {
        self.selectedColumn += .one
    }

    func didTapPreviousColumn() {
        self.selectedColumn -= .one
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
