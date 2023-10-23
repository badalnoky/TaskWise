import Combine
import Resolver
import SwiftUI

@Observable final class TaskViewModel {
    private let navigator: Navigator<ContentSceneFactory>
    private let dataService: DataService = Resolver.resolve()
    private var cancellables = Set<AnyCancellable>()
    private var taskId: UUID
    private var task = Task()

    var editMode: EditMode = .inactive
    var isAlertVisible = false

    var isEditable: Bool {
        editMode == .active
    }
    var actionButtonLabel: String {
        isEditable ? Str.taskSaveButton : Str.taskDeleteButton
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
    var repeats: [String] = ["Never", "Weekly", "Biweekly", "Yearly"]
    var selectedRepeats: String = "Never"
    var steps: [TaskStep] = []
    var newStepName: String = .empty

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

    init(navigator: Navigator<ContentSceneFactory>, taskId: UUID) {
        self.navigator = navigator
        self.taskId = taskId

        registerBindings()
    }

    // swiftlint: disable: function_body_length
    #if DEBUG
    init() {
        self.navigator = .init(sceneFactory: .init(), root: .dashboard)
        self.taskId = UUID()

        let components = ColorComponents(context: PreviewDataController.global.context)
        components.wRed = Color.blue.components.red
        components.wGreen = Color.blue.components.green
        components.wBlue = Color.blue.components.blue
        components.wAlpha = Color.blue.components.alpha

        let priority = Priority(context: PreviewDataController.global.context)
        priority.wId = UUID()
        priority.wLevel = 1
        priority.wName = "PreviewPriority"

        let category = Category(context: PreviewDataController.global.context)
        category.wId = UUID()
        category.wName = "PreviewCategory"
        category.wColorComponents = components

        let column = TaskColumn(context: PreviewDataController.global.context)
        column.wId = UUID()
        column.wIndex = 1
        column.wName = "PreviewColumn"

        let task = Task(context: PreviewDataController.global.context)
        task.wDate = .now
        task.wEndDateTime = .now
        task.wHasTimeConstraints = false
        task.wId = UUID()
        task.wStartDateTime = .now
        task.wTaskDescription = "Description"
        task.wTitle = "Task"
        task.wCategory = category
        task.wColumn = column
        task.wPriority = priority

        let step = TaskStep(context: PreviewDataController.global.context)
        step.wIndex = .zero
        step.wLabel = "PreviewStep"
        step.wIsDone = false
        step.wTask = task

        self.task = task
        self.title = task.title
        self.description = task.taskDescription
        self.allDay = !task.hasTimeConstraints
        self.starts = task.startDateTime
        self.ends = task.endDateTime
        self.steps = task.steps

        self.priorities = [priority]
        self.selectedPriority = priority
        self.categories = [category]
        self.selectedCategory = category
        self.columns = [column]
        self.selectedColumn = column
    }
    #endif
}

extension TaskViewModel {
    func didTapEdit() {
        if isEditable {
            editMode = .inactive
        } else {
            editMode = .active
        }
    }

    func didTapAction() {
        if isEditable {
            // TODO: detect whether there were any real changes in the object -> memento?
            dataService.updateTask(task, with: updatedTask)
        } else {
            isAlertVisible = true
        }
    }

    func didTapDelete() {
        dataService.deleteTask(task)
        dismiss()
    }

    func didTapToggle(on step: TaskStep) {
        dataService.toggleIsDone(on: step)
    }

    func didChangeLabel(on step: TaskStep, to newLabel: String) {
        // TODO: update label
    }

    func didTapDeleteSteps(offsets: IndexSet) {
        // TODO: delete steps
    }

    func didMoveStep(source: IndexSet, destination: Int) {
        // TODO: mod order of steps
    }

    func didTapAddStep() {
        // TODO: add steps
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
                self?.steps = task.steps
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
