import Combine
import Foundation
import Resolver

@Observable final class AddTaskPopoverViewModel {
    private let dataService: DataServiceInput
    private var cancellables = Set<AnyCancellable>()

    var title: String = .empty
    var description: String = .empty
    var priorities: [Priority] = []
    var selectedPriority = DataServiceInputMock.priorityMock
    var categories: [Category] = []
    var selectedCategory = DataServiceInputMock.categoryMock
    var columns: [TaskColumn] = []
    var selectedColumn = DataServiceInputMock.columnMock
    var allDay = false
    var starts: Date = .now
    var ends: Date = .now.advanced(by: .hour)
    var repeatBehaviour: RepeatBehaviour = .empty
    var newStepName: String = .empty
    var steps: [TaskStep.DTO] = []
    var isStepViewExpanded = false

    init(dataService: DataServiceInput = Resolver.resolve()) {
        self.dataService = dataService
        self.starts = .now
        self.ends = self.starts.advanced(by: .hour)

        registerBindings()
    }
}

extension AddTaskPopoverViewModel {
    func didTapCreate() {
    }

    func didTapAddStep() {
    }
}

private extension AddTaskPopoverViewModel {
    private func registerBindings() {
        registerPriorityBinding()
        registerCategoryBinding()
        registerColumnBinding()
    }

    private func registerPriorityBinding() {
        dataService.fetchPriorities()
        dataService.priorities
            .sink { [weak self] in
                self?.priorities = $0
                self?.selectedPriority = $0[.zero]
            }
            .store(in: &cancellables)
    }

    private func registerCategoryBinding() {
        dataService.fetchCategories()
        dataService.categories
            .sink { [weak self] in
                self?.categories = $0
                self?.selectedCategory = $0[.zero]
            }
            .store(in: &cancellables)
    }

    private func registerColumnBinding() {
        dataService.fetchColumns()
        dataService.columns
            .sink { [weak self] in
                self?.columns = $0
                self?.selectedColumn = $0[.zero]
            }
            .store(in: &cancellables)
    }
}
