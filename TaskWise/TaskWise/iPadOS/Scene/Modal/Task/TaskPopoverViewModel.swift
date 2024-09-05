import Combine
import Resolver
import SwiftUI

@Observable final class TaskPopoverViewModel {
    private let dataService: DataServiceInput
    private var cancellables = Set<AnyCancellable>()
    var task: TWTask

    var isEditable = false
    var isDeleteAlertPresented = false
    var isUpdateAlertPresented = false

    var title: String = .empty
    var description: String = .empty
    var priorities: [Priority] = []
    var selectedPriority: Priority
    var categories: [Category] = []
    var selectedCategory: Category
    var columns: [TaskColumn] = []
    var selectedColumn: TaskColumn
    var allDay = false
    var starts: Date = .now
    var ends: Date = .now.advanced(by: .hour)
    var repeatBehaviour: RepeatBehaviour = .empty
    var steps: [TaskStep] = []
    var newStepName: String = .empty
    var isStepViewExpanded = false

    var repeatBehaviourMemento: RepeatBehaviour = .empty

    var actionButtonLabel: String {
        isEditable ? Str.Task.saveButton : Str.Task.deleteButton
    }

    var isRepeating: Bool {
        task.repeatingTasks != nil
    }

    var deleteAlertMessage: String {
        Str.Alert.message + ( isRepeating ? Str.Alert.repeatingTask : .empty)
    }

    private var updatedTask: TWTask.DTO {
        TWTask.DTO(
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
        dataService: DataServiceInput = Resolver.resolve(),
        task: TWTask,
        priorities: [Priority],
        categories: [Category],
        columns: [TaskColumn]
    ) {
        self.dataService = dataService
        self.task = task
        self.priorities = priorities
        self.selectedPriority = priorities.first { $0.id == task.priority.id} ?? priorities[.zero]
        self.categories = categories
        self.selectedCategory = categories.first { $0.id == task.category.id} ?? categories[.zero]
        self.columns = columns
        self.selectedColumn = columns.first { $0.id == task.column.id} ?? columns[.zero]

        self.title = task.title
        self.description = task.taskDescription
        self.allDay = !task.hasTimeConstraints
        self.starts = task.startDateTime
        self.ends = task.endDateTime
        if let repeating = task.repeatingTasks {
            self.repeatBehaviour = repeating.behaviour
            self.repeatBehaviourMemento = repeating.behaviour
        }

        registerStepsBinding()
    }
}

extension TaskPopoverViewModel {
    func didTapEdit() {
        isEditable.toggle()
    }

    func didTapAction() {
        if isEditable {
            if isRepeating {
                isUpdateAlertPresented = true
            } else {
                if repeatBehaviour.frequency != .never {
                    dataService.createTasks(from: updatedTask, with: repeatBehaviour, including: task)
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
    }

    func didTapDeleteRepeating() {
        guard let repeating = task.repeatingTasks else { return }
        dataService.deleteRepeatingTasks(repeating)
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

    func didTapDeleteSteps(_ step: TaskStep) {
        if let repeating = task.repeatingTasks {
            dataService.deleteStepForRepeating(repeating, step: step)
        } else {
            dataService.delete(step: step, from: task)
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
}

private extension TaskPopoverViewModel {
    private func registerStepsBinding() {
        self.dataService.fetchSteps(for: task)
        dataService.currentSteps
            .sink { [weak self] in
                self?.steps = $0
                if let steps = self?.steps, !steps.isEmpty {
                    self?.isStepViewExpanded = true
                }
            }
            .store(in: &cancellables)
    }
}
