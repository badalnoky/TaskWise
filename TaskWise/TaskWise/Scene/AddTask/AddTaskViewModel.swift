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
    var selectedPriority = Priority()
    var categories: [Category] = []
    var selectedCategory = Category()
    var columns: [TaskColumn] = []
    var selectedColumn = TaskColumn()
    var allDay = false
    var starts: Date = .now
    var ends: Date = .now.advanced(by: .hour)
    var newStepName: String = .empty
    var steps: [TaskStep.DTO] = []

    private var task: Task.DTO {
        Task.DTO(
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
        dataService.addTask(task)
        dismiss()
    }

    func didTapAddStep() {
        steps.append(.init(label: newStepName, index: steps.count))
        newStepName = .empty
    }

    func didTapDeleteSteps(offsets: IndexSet) {
        steps.remove(atOffsets: offsets)
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
