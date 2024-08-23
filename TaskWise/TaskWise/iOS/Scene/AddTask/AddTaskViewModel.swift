import Combine
import Resolver
import SwiftUI

@Observable final class AddTaskViewModel {
    private let navigator: Navigator<ContentSceneFactory>
    private let dataService: DataServiceInput
    private var cancellables = Set<AnyCancellable>()
    var editMode: EditMode = .active

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

    var isStepCreationDisabled: Bool {
        newStepName.isEmpty
    }

    var isCreationDisabled: Bool {
        title.isEmpty
    }

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

    init(
        navigator: Navigator<ContentSceneFactory>,
        dataService: DataServiceInput = Resolver.resolve(),
        date: Date
    ) {
        self.navigator = navigator
        self.dataService = dataService
        self.starts = date
        self.ends = date.advanced(by: .hour)

        registerBindings()
    }
}

extension AddTaskViewModel {
    func didTapCreate() {
        dataService.createTasks(from: task, with: repeatBehaviour)
        dismiss()
    }

    func didTapAddStep() {
        steps.append(.init(label: newStepName, index: steps.count))
        newStepName = .empty
    }

    func didTapDeleteSteps(_ step: TaskStep.DTO) {
        guard let stepIdx = steps.firstIndex(of: step) else { return }
        steps.remove(at: stepIdx)
    }

    func didMoveStep(source: IndexSet, destination: Int) {
        steps.move(fromOffsets: source, toOffset: destination)
        for idx in steps.indices {
            steps[idx].changeIndex(to: idx)
        }
    }

    func didTapToggle(on step: TaskStep.DTO) {
        guard let idx = steps.firstIndex(of: step) else { return }
        steps[idx].toggleIsDone()
    }

    func dismiss() {
        navigator.pop()
    }
}

private extension AddTaskViewModel {
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
