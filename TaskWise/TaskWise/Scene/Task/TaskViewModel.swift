import Combine
import Resolver
import SwiftUI

@Observable final class TaskViewModel {
    private let navigator: Navigator<ContentSceneFactory>
    private let dataService: DataServiceInput
    private var cancellables = Set<AnyCancellable>()
    private var taskId: UUID
    private var task = Task()

    var editMode: EditMode = .inactive
    var isDeleteAlertPresented = false
    var isUpdateAlertPresented = false

    var isEditable: Bool {
        editMode == .active
    }
    var actionButtonLabel: String {
        isEditable ? Str.Task.saveButton : Str.Task.deleteButton
    }

    var isRepeating: Bool {
        task.repeatingTasks != nil
    }

    var deleteAlertMessage: String {
        Str.Alert.message + ( isRepeating ? Str.Alert.repeatingTask : .empty)
    }

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
    var repeatBehaviour: RepeatBehaviour = .empty
    var steps: [TaskStep] = []
    var newStepName: String = .empty

    var repeatBehaviourMemento: RepeatBehaviour = .empty

    private var updatedTask: Task.DTO {
        Task.DTO(
            id: task.id,
            title: title,
            description: description,
            date: starts,
            hasTimeConstraints: !allDay,
            startDateTime: starts,
            endDateTime: ends,
            category: selectedCategory,
            priority: selectedPriority,
            column: selectedColumn,
            steps: []
        )
    }

    init(
        navigator: Navigator<ContentSceneFactory>,
        dataService: DataServiceInput = Resolver.resolve(),
        taskId: UUID
    ) {
        self.navigator = navigator
        self.dataService = dataService
        self.taskId = taskId

        registerBindings()
    }
}

extension TaskViewModel {
    func didTapEdit() {
        EditMode.toggle(mode: &editMode)
    }

    func didTapAction() {
        if isEditable {
            if isRepeating {
                isUpdateAlertPresented = true
            } else {
                if repeatBehaviour.frequency != .never {
                    // TODO: update task and schedule repeated tasks
                } else {
                    dataService.updateTask(task, with: updatedTask)
                }
            }
        } else {
            isDeleteAlertPresented = true
        }
    }

    func didTapUpdateAll() {
        guard let repeating = task.repeatingTasks else { return }
        if repeatBehaviourMemento != repeatBehaviour || starts != task.startDateTime || ends != task.endDateTime {
            dataService.rescheduleRepeatingTasks(repeating, for: repeatBehaviour, from: updatedTask)
        } else {
            dataService.updateRepeatingTasks(repeating, from: updatedTask)
        }
    }

    func didTapUpdateOnlyThis() {
        dataService.updateTask(task, with: updatedTask)
    }

    func didTapDelete() {
        dataService.deleteTask(task)
        dismiss()
    }

    func didTapDeleteRepeating() {
        guard let repeating = task.repeatingTasks else { return }
        dataService.deleteRepeatingTasks(repeating)
        dismiss()
    }

    func didTapToggle(on step: TaskStep) {
        dataService.toggleIsDone(on: step, for: task)
    }

    func didChangeLabel(on step: TaskStep, to newLabel: String) {
        if let repeating = task.repeatingTasks {
            dataService.updateStepLabelForRepeating(repeating, on: step, to: newLabel)
        } else {
            dataService.updateStepLabel(on: step, to: newLabel)
        }
    }

    func didTapDeleteSteps(offsets: IndexSet) {
        guard offsets.count == .one, let idx = offsets.first else { return }
        if let repeating = task.repeatingTasks {
            dataService.deleteStepForRepeating(repeating, step: steps[idx])
        } else {
            dataService.delete(step: steps[idx], from: task)
        }
    }

    func didMoveStep(source: IndexSet, destination: Int) {
        var updated = steps
        updated.move(fromOffsets: source, toOffset: destination)
        if let repeating = task.repeatingTasks {
            dataService.updateStepOrderForRepeating(repeating, to: updated)
        } else {
            dataService.updateOrder(of: updated, on: task)
        }
    }

    func didTapAddStep() {
        if let repeating = task.repeatingTasks {
            dataService.addStepToRepeating(repeating, step: .init(label: newStepName, index: steps.count))
        } else {
            dataService.addStepFrom(dto: .init(label: newStepName, index: steps.count), to: task)
        }
        newStepName = .empty
    }

    func dismiss() {
        navigator.pop()
    }
}

private extension TaskViewModel {
    private func registerBindings() {
        registerTaskBinding()
        registerPriorityBinding()
        registerCategoryBinding()
        registerColumnBinding()
        registerStepsBinding()
    }

    private func registerTaskBinding() {
        dataService.fetchTasks()
        dataService.tasks
            .sink { [weak self] in
                guard let task = $0.first(where: { $0.id == self?.taskId }) else { return }
                self?.task = task
                self?.title = task.title
                self?.description = task.taskDescription
                self?.allDay = !task.hasTimeConstraints
                self?.starts = task.startDateTime
                self?.ends = task.endDateTime
                if let repeating = task.repeatingTasks {
                    self?.repeatBehaviour = repeating.behaviour
                    self?.repeatBehaviourMemento = repeating.behaviour
                }
                self?.dataService.fetchSteps(for: task)
            }
            .store(in: &cancellables)
    }

    private func registerStepsBinding() {
        dataService.currentSteps
            .sink { [weak self] in
                self?.steps = $0
            }
            .store(in: &cancellables)
    }

    private func registerPriorityBinding() {
        dataService.fetchPriorities()
        dataService.priorities
            .sink { [weak self] in
                self?.priorities = $0
                self?.selectedPriority = $0.first { $0.id == self?.task.priority.id} ?? $0[.zero]
            }
            .store(in: &cancellables)
    }

    private func registerCategoryBinding() {
        dataService.fetchCategories()
        dataService.categories
            .sink { [weak self] in
                self?.categories = $0
                self?.selectedCategory = $0.first { $0.id == self?.task.category.id} ?? $0[.zero]
            }
            .store(in: &cancellables)
    }

    private func registerColumnBinding() {
        dataService.fetchColumns()
        dataService.columns
            .sink { [weak self] in
                self?.columns = $0
                self?.selectedColumn = $0.first { $0.id == self?.task.column.id} ?? $0[.zero]
            }
            .store(in: &cancellables)
    }
}
