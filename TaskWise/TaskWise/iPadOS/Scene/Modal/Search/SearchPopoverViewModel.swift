import Combine
import Resolver
import SwiftUI

@Observable final class SearchPopoverViewModel {
    private let dataService: DataServiceInput
    private var cancellables = Set<AnyCancellable>()

    var didTapTaskAction: (TWTask) -> Void
    var searchText: String = .empty
    var tasks: [TWTask] = []

    var foundTasks: [TWTask] {
        tasks
            .filter {
                searchText.isEmpty ? false : ($0.title.caseInsensitiveContains(searchText) || $0.taskDescription.caseInsensitiveContains(searchText))
            }
            .sorted { $0.date < $1.date }
    }

    var foundDates: [Date] {
        foundTasks
            .map { $0.date }
            .groupedByDay()
    }

    init(dataService: DataServiceInput = Resolver.resolve(), didTapTaskAction: @escaping (TWTask) -> Void) {
        self.dataService = dataService
        self.didTapTaskAction = didTapTaskAction

        registerTaskBinding()
    }
}

private extension SearchPopoverViewModel {
    private func registerTaskBinding() {
        dataService.fetchTasks()
        dataService.tasks
            .sink { [weak self] in
                self?.tasks = $0
            }
            .store(in: &cancellables)
    }
}
