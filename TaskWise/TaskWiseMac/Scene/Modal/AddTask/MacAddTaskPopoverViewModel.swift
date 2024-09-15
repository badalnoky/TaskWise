import Combine
import Foundation
import Resolver

@Observable final class MacAddTaskPopoverViewModel {
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

    private var task: TWTask.DTO {
        TWTask.DTO(
            id: UUID(),
            title: title,
            description: description,
            date: starts,
            hasTimeConstraints: !allDay,
            startDateTime: starts,
            endDateTime: ends,
            category: selectedCategory,
            priority: selectedPriority,
            column: selectedColumn,
            steps: steps
        )
    }

    init(dataService: DataServiceInput = Resolver.resolve()) {
        self.dataService = dataService
        self.starts = .now
        self.ends = self.starts.advanced(by: .hour)

        registerBindings()
    }
}

extension MacAddTaskPopoverViewModel {
    func didTapCreate() {
        dataService.createTasks(from: task, with: repeatBehaviour)
    }

    func didTapAddStep() {
        steps.append(.init(label: newStepName, index: steps.count))
        newStepName = .empty
    }

    func didTapDeleteSteps(_ step: TaskStep.DTO) {
        guard let stepIdx = steps.firstIndex(of: step) else { return }
        steps.remove(at: stepIdx)
    }

    func didTapToggle(on step: TaskStep.DTO) {
        guard let idx = steps.firstIndex(of: step) else { return }
        steps[idx].toggleIsDone()
    }
}

private extension MacAddTaskPopoverViewModel {
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
