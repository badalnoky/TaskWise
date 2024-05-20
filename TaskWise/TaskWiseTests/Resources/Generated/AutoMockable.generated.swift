// Generated using Sourcery 2.0.1 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT
// swiftlint: disable: superfluous_disable_command
// swiftlint: disable: type_contents_order
// swiftlint: disable: implicitly_unwrapped_optional
// swiftlint: disable: line_length
// swiftlint: disable: identifier_name
// swiftlint: disable: let_var_whitespace
// swiftlint: disable: type_body_length
// swiftlint: disable: file_length

import Combine
import TaskWise
import UIKit

class DataServiceInputMock: DataServiceInput {
    var tasks: CurrentValueSubject<[Task], Never> {
        get { underlyingTasks }
        set(value) { underlyingTasks = value }
    }
    var underlyingTasks: CurrentValueSubject<[Task], Never>!
    var todaysTasks: CurrentValueSubject<[Task], Never> {
        get { underlyingTodaysTasks }
        set(value) { underlyingTodaysTasks = value }
    }
    var underlyingTodaysTasks: CurrentValueSubject<[Task], Never>!
    var priorities: CurrentValueSubject<[Priority], Never> {
        get { underlyingPriorities }
        set(value) { underlyingPriorities = value }
    }
    var underlyingPriorities: CurrentValueSubject<[Priority], Never>!
    var categories: CurrentValueSubject<[Category], Never> {
        get { underlyingCategories }
        set(value) { underlyingCategories = value }
    }
    var underlyingCategories: CurrentValueSubject<[Category], Never>!
    var columns: CurrentValueSubject<[TaskColumn], Never> {
        get { underlyingColumns }
        set(value) { underlyingColumns = value }
    }
    var underlyingColumns: CurrentValueSubject<[TaskColumn], Never>!
    var currentSteps: CurrentValueSubject<[TaskStep], Never> {
        get { underlyingCurrentSteps }
        set(value) { underlyingCurrentSteps = value }
    }
    var underlyingCurrentSteps: CurrentValueSubject<[TaskStep], Never>!

    // MARK: - fetchTasks

    var fetchTasksCallsCount = 0
    var fetchTasksCalled: Bool {
        fetchTasksCallsCount > 0
    }
    var fetchTasksClosure: (() -> Void)?

    func fetchTasks() {
        fetchTasksCallsCount += 1
        fetchTasksClosure?()
    }
    // MARK: - fetchPriorities

    var fetchPrioritiesCallsCount = 0
    var fetchPrioritiesCalled: Bool {
        fetchPrioritiesCallsCount > 0
    }
    var fetchPrioritiesClosure: (() -> Void)?

    func fetchPriorities() {
        fetchPrioritiesCallsCount += 1
        fetchPrioritiesClosure?()
    }
    // MARK: - fetchCategories

    var fetchCategoriesCallsCount = 0
    var fetchCategoriesCalled: Bool {
        fetchCategoriesCallsCount > 0
    }
    var fetchCategoriesClosure: (() -> Void)?

    func fetchCategories() {
        fetchCategoriesCallsCount += 1
        fetchCategoriesClosure?()
    }
    // MARK: - fetchColumns

    var fetchColumnsCallsCount = 0
    var fetchColumnsCalled: Bool {
        fetchColumnsCallsCount > 0
    }
    var fetchColumnsClosure: (() -> Void)?

    func fetchColumns() {
        fetchColumnsCallsCount += 1
        fetchColumnsClosure?()
    }
    // MARK: - fetchSteps

    var fetchStepsForCallsCount = 0
    var fetchStepsForCalled: Bool {
        fetchStepsForCallsCount > 0
    }
    var fetchStepsForReceivedTask: Task?
    var fetchStepsForReceivedInvocations: [Task] = []
    var fetchStepsForClosure: ((Task) -> Void)?

    func fetchSteps(for task: Task) {
        fetchStepsForCallsCount += 1
        fetchStepsForReceivedTask = task
        fetchStepsForReceivedInvocations.append(task)
        fetchStepsForClosure?(task)
    }
    // MARK: - fetchRepeatingTasks

    var fetchRepeatingTasksCallsCount = 0
    var fetchRepeatingTasksCalled: Bool {
        fetchRepeatingTasksCallsCount > 0
    }
    var fetchRepeatingTasksClosure: (() -> Void)?

    func fetchRepeatingTasks() {
        fetchRepeatingTasksCallsCount += 1
        fetchRepeatingTasksClosure?()
    }
    // MARK: - addCategory

    var addCategoryCallsCount = 0
    var addCategoryCalled: Bool {
        addCategoryCallsCount > 0
    }
    var addCategoryReceivedCategory: Category.DTO?
    var addCategoryReceivedInvocations: [Category.DTO] = []
    var addCategoryClosure: ((Category.DTO) -> Void)?

    func addCategory(_ category: Category.DTO) {
        addCategoryCallsCount += 1
        addCategoryReceivedCategory = category
        addCategoryReceivedInvocations.append(category)
        addCategoryClosure?(category)
    }
    // MARK: - updateCategoryName

    var updateCategoryNameOnToCallsCount = 0
    var updateCategoryNameOnToCalled: Bool {
        updateCategoryNameOnToCallsCount > 0
    }
    var updateCategoryNameOnToReceivedArguments: (category: Category, newName: String)?
    var updateCategoryNameOnToReceivedInvocations: [(category: Category, newName: String)] = []
    var updateCategoryNameOnToClosure: ((Category, String) -> Void)?

    func updateCategoryName(on category: Category, to newName: String) {
        updateCategoryNameOnToCallsCount += 1
        updateCategoryNameOnToReceivedArguments = (category: category, newName: newName)
        updateCategoryNameOnToReceivedInvocations.append((category: category, newName: newName))
        updateCategoryNameOnToClosure?(category, newName)
    }
    // MARK: - updateColor

    var updateColorOnWithCallsCount = 0
    var updateColorOnWithCalled: Bool {
        updateColorOnWithCallsCount > 0
    }
    var updateColorOnWithReceivedArguments: (category: Category, newColor: ColorComponents.DTO)?
    var updateColorOnWithReceivedInvocations: [(category: Category, newColor: ColorComponents.DTO)] = []
    var updateColorOnWithClosure: ((Category, ColorComponents.DTO) -> Void)?

    func updateColor(on category: Category, with newColor: ColorComponents.DTO) {
        updateColorOnWithCallsCount += 1
        updateColorOnWithReceivedArguments = (category: category, newColor: newColor)
        updateColorOnWithReceivedInvocations.append((category: category, newColor: newColor))
        updateColorOnWithClosure?(category, newColor)
    }
    // MARK: - deleteCategory

    var deleteCategoryCallsCount = 0
    var deleteCategoryCalled: Bool {
        deleteCategoryCallsCount > 0
    }
    var deleteCategoryReceivedCategory: Category?
    var deleteCategoryReceivedInvocations: [Category] = []
    var deleteCategoryClosure: ((Category) -> Void)?

    func deleteCategory(_ category: Category) {
        deleteCategoryCallsCount += 1
        deleteCategoryReceivedCategory = category
        deleteCategoryReceivedInvocations.append(category)
        deleteCategoryClosure?(category)
    }
    // MARK: - addPriority

    var addPriorityCallsCount = 0
    var addPriorityCalled: Bool {
        addPriorityCallsCount > 0
    }
    var addPriorityReceivedPriority: Priority.DTO?
    var addPriorityReceivedInvocations: [Priority.DTO] = []
    var addPriorityClosure: ((Priority.DTO) -> Void)?

    func addPriority(_ priority: Priority.DTO) {
        addPriorityCallsCount += 1
        addPriorityReceivedPriority = priority
        addPriorityReceivedInvocations.append(priority)
        addPriorityClosure?(priority)
    }
    // MARK: - updatePriorityName

    var updatePriorityNameOnToCallsCount = 0
    var updatePriorityNameOnToCalled: Bool {
        updatePriorityNameOnToCallsCount > 0
    }
    var updatePriorityNameOnToReceivedArguments: (priority: Priority, newName: String)?
    var updatePriorityNameOnToReceivedInvocations: [(priority: Priority, newName: String)] = []
    var updatePriorityNameOnToClosure: ((Priority, String) -> Void)?

    func updatePriorityName(on priority: Priority, to newName: String) {
        updatePriorityNameOnToCallsCount += 1
        updatePriorityNameOnToReceivedArguments = (priority: priority, newName: newName)
        updatePriorityNameOnToReceivedInvocations.append((priority: priority, newName: newName))
        updatePriorityNameOnToClosure?(priority, newName)
    }
    // MARK: - updateOrder

    var updateOrderOfCallsCount = 0
    var updateOrderOfCalled: Bool {
        updateOrderOfCallsCount > 0
    }
    var updateOrderOfReceivedPriorities: [Priority]?
    var updateOrderOfReceivedInvocations: [[Priority]] = []
    var updateOrderOfClosure: (([Priority]) -> Void)?

    func updateOrder(of priorities: [Priority]) {
        updateOrderOfCallsCount += 1
        updateOrderOfReceivedPriorities = priorities
        updateOrderOfReceivedInvocations.append(priorities)
        updateOrderOfClosure?(priorities)
    }
    // MARK: - deletePriority

    var deletePriorityCallsCount = 0
    var deletePriorityCalled: Bool {
        deletePriorityCallsCount > 0
    }
    var deletePriorityReceivedPriority: Priority?
    var deletePriorityReceivedInvocations: [Priority] = []
    var deletePriorityClosure: ((Priority) -> Void)?

    func deletePriority(_ priority: Priority) {
        deletePriorityCallsCount += 1
        deletePriorityReceivedPriority = priority
        deletePriorityReceivedInvocations.append(priority)
        deletePriorityClosure?(priority)
    }
    // MARK: - addTask

    var addTaskCallsCount = 0
    var addTaskCalled: Bool {
        addTaskCallsCount > 0
    }
    var addTaskReceivedTask: Task.DTO?
    var addTaskReceivedInvocations: [Task.DTO] = []
    var addTaskClosure: ((Task.DTO) -> Void)?

    func addTask(_ task: Task.DTO) {
        addTaskCallsCount += 1
        addTaskReceivedTask = task
        addTaskReceivedInvocations.append(task)
        addTaskClosure?(task)
    }
    // MARK: - updateTask

    var updateTaskWithCallsCount = 0
    var updateTaskWithCalled: Bool {
        updateTaskWithCallsCount > 0
    }
    var updateTaskWithReceivedArguments: (task: Task, updated: Task.DTO)?
    var updateTaskWithReceivedInvocations: [(task: Task, updated: Task.DTO)] = []
    var updateTaskWithClosure: ((Task, Task.DTO) -> Void)?

    func updateTask(_ task: Task, with updated: Task.DTO) {
        updateTaskWithCallsCount += 1
        updateTaskWithReceivedArguments = (task: task, updated: updated)
        updateTaskWithReceivedInvocations.append((task: task, updated: updated))
        updateTaskWithClosure?(task, updated)
    }
    // MARK: - updateColumn

    var updateColumnToOnCallsCount = 0
    var updateColumnToOnCalled: Bool {
        updateColumnToOnCallsCount > 0
    }
    var updateColumnToOnReceivedArguments: (column: TaskColumn, task: Task)?
    var updateColumnToOnReceivedInvocations: [(column: TaskColumn, task: Task)] = []
    var updateColumnToOnClosure: ((TaskColumn, Task) -> Void)?

    func updateColumn(to column: TaskColumn, on task: Task) {
        updateColumnToOnCallsCount += 1
        updateColumnToOnReceivedArguments = (column: column, task: task)
        updateColumnToOnReceivedInvocations.append((column: column, task: task))
        updateColumnToOnClosure?(column, task)
    }
    // MARK: - addStepFrom

    var addStepFromDtoToCallsCount = 0
    var addStepFromDtoToCalled: Bool {
        addStepFromDtoToCallsCount > 0
    }
    var addStepFromDtoToReceivedArguments: (dto: TaskStep.DTO, task: Task)?
    var addStepFromDtoToReceivedInvocations: [(dto: TaskStep.DTO, task: Task)] = []
    var addStepFromDtoToClosure: ((TaskStep.DTO, Task) -> Void)?

    func addStepFrom(dto: TaskStep.DTO, to task: Task) {
        addStepFromDtoToCallsCount += 1
        addStepFromDtoToReceivedArguments = (dto: dto, task: task)
        addStepFromDtoToReceivedInvocations.append((dto: dto, task: task))
        addStepFromDtoToClosure?(dto, task)
    }
    // MARK: - toggleIsDone

    var toggleIsDoneOnForCallsCount = 0
    var toggleIsDoneOnForCalled: Bool {
        toggleIsDoneOnForCallsCount > 0
    }
    var toggleIsDoneOnForReceivedArguments: (step: TaskStep, task: Task)?
    var toggleIsDoneOnForReceivedInvocations: [(step: TaskStep, task: Task)] = []
    var toggleIsDoneOnForClosure: ((TaskStep, Task) -> Void)?

    func toggleIsDone(on step: TaskStep, for task: Task) {
        toggleIsDoneOnForCallsCount += 1
        toggleIsDoneOnForReceivedArguments = (step: step, task: task)
        toggleIsDoneOnForReceivedInvocations.append((step: step, task: task))
        toggleIsDoneOnForClosure?(step, task)
    }
    // MARK: - updateStepLabel

    var updateStepLabelOnToCallsCount = 0
    var updateStepLabelOnToCalled: Bool {
        updateStepLabelOnToCallsCount > 0
    }
    var updateStepLabelOnToReceivedArguments: (step: TaskStep, newLabel: String)?
    var updateStepLabelOnToReceivedInvocations: [(step: TaskStep, newLabel: String)] = []
    var updateStepLabelOnToClosure: ((TaskStep, String) -> Void)?

    func updateStepLabel(on step: TaskStep, to newLabel: String) {
        updateStepLabelOnToCallsCount += 1
        updateStepLabelOnToReceivedArguments = (step: step, newLabel: newLabel)
        updateStepLabelOnToReceivedInvocations.append((step: step, newLabel: newLabel))
        updateStepLabelOnToClosure?(step, newLabel)
    }
    // MARK: - updateOrder

    var updateOrderOfOnCallsCount = 0
    var updateOrderOfOnCalled: Bool {
        updateOrderOfOnCallsCount > 0
    }
    var updateOrderOfOnReceivedArguments: (steps: [TaskStep], task: Task)?
    var updateOrderOfOnReceivedInvocations: [(steps: [TaskStep], task: Task)] = []
    var updateOrderOfOnClosure: (([TaskStep], Task) -> Void)?

    func updateOrder(of steps: [TaskStep], on task: Task) {
        updateOrderOfOnCallsCount += 1
        updateOrderOfOnReceivedArguments = (steps: steps, task: task)
        updateOrderOfOnReceivedInvocations.append((steps: steps, task: task))
        updateOrderOfOnClosure?(steps, task)
    }
    // MARK: - delete

    var deleteStepFromCallsCount = 0
    var deleteStepFromCalled: Bool {
        deleteStepFromCallsCount > 0
    }
    var deleteStepFromReceivedArguments: (deleted: TaskStep, task: Task)?
    var deleteStepFromReceivedInvocations: [(deleted: TaskStep, task: Task)] = []
    var deleteStepFromClosure: ((TaskStep, Task) -> Void)?

    func delete(step deleted: TaskStep, from task: Task) {
        deleteStepFromCallsCount += 1
        deleteStepFromReceivedArguments = (deleted: deleted, task: task)
        deleteStepFromReceivedInvocations.append((deleted: deleted, task: task))
        deleteStepFromClosure?(deleted, task)
    }
    // MARK: - deleteTask

    var deleteTaskCallsCount = 0
    var deleteTaskCalled: Bool {
        deleteTaskCallsCount > 0
    }
    var deleteTaskReceivedTask: Task?
    var deleteTaskReceivedInvocations: [Task] = []
    var deleteTaskClosure: ((Task) -> Void)?

    func deleteTask(_ task: Task) {
        deleteTaskCallsCount += 1
        deleteTaskReceivedTask = task
        deleteTaskReceivedInvocations.append(task)
        deleteTaskClosure?(task)
    }
    // MARK: - addColumn

    var addColumnCallsCount = 0
    var addColumnCalled: Bool {
        addColumnCallsCount > 0
    }
    var addColumnReceivedColumn: TaskColumn.DTO?
    var addColumnReceivedInvocations: [TaskColumn.DTO] = []
    var addColumnClosure: ((TaskColumn.DTO) -> Void)?

    func addColumn(_ column: TaskColumn.DTO) {
        addColumnCallsCount += 1
        addColumnReceivedColumn = column
        addColumnReceivedInvocations.append(column)
        addColumnClosure?(column)
    }
    // MARK: - updateColumnName

    var updateColumnNameOnToCallsCount = 0
    var updateColumnNameOnToCalled: Bool {
        updateColumnNameOnToCallsCount > 0
    }
    var updateColumnNameOnToReceivedArguments: (column: TaskColumn, newName: String)?
    var updateColumnNameOnToReceivedInvocations: [(column: TaskColumn, newName: String)] = []
    var updateColumnNameOnToClosure: ((TaskColumn, String) -> Void)?

    func updateColumnName(on column: TaskColumn, to newName: String) {
        updateColumnNameOnToCallsCount += 1
        updateColumnNameOnToReceivedArguments = (column: column, newName: newName)
        updateColumnNameOnToReceivedInvocations.append((column: column, newName: newName))
        updateColumnNameOnToClosure?(column, newName)
    }
    // MARK: - updateOrder

    var updateOrderOfCallsCount = 0
    var updateOrderOfCalled: Bool {
        updateOrderOfCallsCount > 0
    }
    var updateOrderOfReceivedColumns: [TaskColumn]?
    var updateOrderOfReceivedInvocations: [[TaskColumn]] = []
    var updateOrderOfClosure: (([TaskColumn]) -> Void)?

    func updateOrder(of columns: [TaskColumn]) {
        updateOrderOfCallsCount += 1
        updateOrderOfReceivedColumns = columns
        updateOrderOfReceivedInvocations.append(columns)
        updateOrderOfClosure?(columns)
    }
    // MARK: - deleteColumn

    var deleteColumnCallsCount = 0
    var deleteColumnCalled: Bool {
        deleteColumnCallsCount > 0
    }
    var deleteColumnReceivedColumn: TaskColumn?
    var deleteColumnReceivedInvocations: [TaskColumn] = []
    var deleteColumnClosure: ((TaskColumn) -> Void)?

    func deleteColumn(_ column: TaskColumn) {
        deleteColumnCallsCount += 1
        deleteColumnReceivedColumn = column
        deleteColumnReceivedInvocations.append(column)
        deleteColumnClosure?(column)
    }
    // MARK: - createTasks

    var createTasksFromWithCallsCount = 0
    var createTasksFromWithCalled: Bool {
        createTasksFromWithCallsCount > 0
    }
    var createTasksFromWithReceivedArguments: (task: Task.DTO, behaviour: RepeatBehaviour)?
    var createTasksFromWithReceivedInvocations: [(task: Task.DTO, behaviour: RepeatBehaviour)] = []
    var createTasksFromWithClosure: ((Task.DTO, RepeatBehaviour) -> Void)?

    func createTasks(from task: Task.DTO, with behaviour: RepeatBehaviour) {
        createTasksFromWithCallsCount += 1
        createTasksFromWithReceivedArguments = (task: task, behaviour: behaviour)
        createTasksFromWithReceivedInvocations.append((task: task, behaviour: behaviour))
        createTasksFromWithClosure?(task, behaviour)
    }
    // MARK: - createTasks

    var createTasksFromWithIncludingCallsCount = 0
    var createTasksFromWithIncludingCalled: Bool {
        createTasksFromWithIncludingCallsCount > 0
    }
    var createTasksFromWithIncludingReceivedArguments: (updated: Task.DTO, behaviour: RepeatBehaviour, task: Task)?
    var createTasksFromWithIncludingReceivedInvocations: [(updated: Task.DTO, behaviour: RepeatBehaviour, task: Task)] = []
    var createTasksFromWithIncludingClosure: ((Task.DTO, RepeatBehaviour, Task) -> Void)?

    func createTasks(from updated: Task.DTO, with behaviour: RepeatBehaviour, including task: Task) {
        createTasksFromWithIncludingCallsCount += 1
        createTasksFromWithIncludingReceivedArguments = (updated: updated, behaviour: behaviour, task: task)
        createTasksFromWithIncludingReceivedInvocations.append((updated: updated, behaviour: behaviour, task: task))
        createTasksFromWithIncludingClosure?(updated, behaviour, task)
    }
    // MARK: - deleteRepeatingTasks

    var deleteRepeatingTasksCallsCount = 0
    var deleteRepeatingTasksCalled: Bool {
        deleteRepeatingTasksCallsCount > 0
    }
    var deleteRepeatingTasksReceivedRepeating: RepeatingTasks?
    var deleteRepeatingTasksReceivedInvocations: [RepeatingTasks] = []
    var deleteRepeatingTasksClosure: ((RepeatingTasks) -> Void)?

    func deleteRepeatingTasks(_ repeating: RepeatingTasks) {
        deleteRepeatingTasksCallsCount += 1
        deleteRepeatingTasksReceivedRepeating = repeating
        deleteRepeatingTasksReceivedInvocations.append(repeating)
        deleteRepeatingTasksClosure?(repeating)
    }
    // MARK: - updateRepeatingTasks

    var updateRepeatingTasksFromCallsCount = 0
    var updateRepeatingTasksFromCalled: Bool {
        updateRepeatingTasksFromCallsCount > 0
    }
    var updateRepeatingTasksFromReceivedArguments: (repeating: RepeatingTasks, task: Task.DTO)?
    var updateRepeatingTasksFromReceivedInvocations: [(repeating: RepeatingTasks, task: Task.DTO)] = []
    var updateRepeatingTasksFromClosure: ((RepeatingTasks, Task.DTO) -> Void)?

    func updateRepeatingTasks(_ repeating: RepeatingTasks, from task: Task.DTO) {
        updateRepeatingTasksFromCallsCount += 1
        updateRepeatingTasksFromReceivedArguments = (repeating: repeating, task: task)
        updateRepeatingTasksFromReceivedInvocations.append((repeating: repeating, task: task))
        updateRepeatingTasksFromClosure?(repeating, task)
    }
    // MARK: - updateStepLabelForRepeating

    var updateStepLabelForRepeatingOnToCallsCount = 0
    var updateStepLabelForRepeatingOnToCalled: Bool {
        updateStepLabelForRepeatingOnToCallsCount > 0
    }
    var updateStepLabelForRepeatingOnToReceivedArguments: (repeating: RepeatingTasks, step: TaskStep, newLabel: String)?
    var updateStepLabelForRepeatingOnToReceivedInvocations: [(repeating: RepeatingTasks, step: TaskStep, newLabel: String)] = []
    var updateStepLabelForRepeatingOnToClosure: ((RepeatingTasks, TaskStep, String) -> Void)?

    func updateStepLabelForRepeating(_ repeating: RepeatingTasks, on step: TaskStep, to newLabel: String) {
        updateStepLabelForRepeatingOnToCallsCount += 1
        updateStepLabelForRepeatingOnToReceivedArguments = (repeating: repeating, step: step, newLabel: newLabel)
        updateStepLabelForRepeatingOnToReceivedInvocations.append((repeating: repeating, step: step, newLabel: newLabel))
        updateStepLabelForRepeatingOnToClosure?(repeating, step, newLabel)
    }
    // MARK: - deleteStepForRepeating

    var deleteStepForRepeatingStepCallsCount = 0
    var deleteStepForRepeatingStepCalled: Bool {
        deleteStepForRepeatingStepCallsCount > 0
    }
    var deleteStepForRepeatingStepReceivedArguments: (repeating: RepeatingTasks, deleted: TaskStep)?
    var deleteStepForRepeatingStepReceivedInvocations: [(repeating: RepeatingTasks, deleted: TaskStep)] = []
    var deleteStepForRepeatingStepClosure: ((RepeatingTasks, TaskStep) -> Void)?

    func deleteStepForRepeating(_ repeating: RepeatingTasks, step deleted: TaskStep) {
        deleteStepForRepeatingStepCallsCount += 1
        deleteStepForRepeatingStepReceivedArguments = (repeating: repeating, deleted: deleted)
        deleteStepForRepeatingStepReceivedInvocations.append((repeating: repeating, deleted: deleted))
        deleteStepForRepeatingStepClosure?(repeating, deleted)
    }
    // MARK: - updateStepOrderForRepeating

    var updateStepOrderForRepeatingToCallsCount = 0
    var updateStepOrderForRepeatingToCalled: Bool {
        updateStepOrderForRepeatingToCallsCount > 0
    }
    var updateStepOrderForRepeatingToReceivedArguments: (repeating: RepeatingTasks, steps: [TaskStep])?
    var updateStepOrderForRepeatingToReceivedInvocations: [(repeating: RepeatingTasks, steps: [TaskStep])] = []
    var updateStepOrderForRepeatingToClosure: ((RepeatingTasks, [TaskStep]) -> Void)?

    func updateStepOrderForRepeating(_ repeating: RepeatingTasks, to steps: [TaskStep]) {
        updateStepOrderForRepeatingToCallsCount += 1
        updateStepOrderForRepeatingToReceivedArguments = (repeating: repeating, steps: steps)
        updateStepOrderForRepeatingToReceivedInvocations.append((repeating: repeating, steps: steps))
        updateStepOrderForRepeatingToClosure?(repeating, steps)
    }
    // MARK: - addStepToRepeating

    var addStepToRepeatingStepCallsCount = 0
    var addStepToRepeatingStepCalled: Bool {
        addStepToRepeatingStepCallsCount > 0
    }
    var addStepToRepeatingStepReceivedArguments: (repeating: RepeatingTasks, step: TaskStep.DTO)?
    var addStepToRepeatingStepReceivedInvocations: [(repeating: RepeatingTasks, step: TaskStep.DTO)] = []
    var addStepToRepeatingStepClosure: ((RepeatingTasks, TaskStep.DTO) -> Void)?

    func addStepToRepeating(_ repeating: RepeatingTasks, step: TaskStep.DTO) {
        addStepToRepeatingStepCallsCount += 1
        addStepToRepeatingStepReceivedArguments = (repeating: repeating, step: step)
        addStepToRepeatingStepReceivedInvocations.append((repeating: repeating, step: step))
        addStepToRepeatingStepClosure?(repeating, step)
    }
    // MARK: - rescheduleRepeatingTasks

    var rescheduleRepeatingTasksForFromCallsCount = 0
    var rescheduleRepeatingTasksForFromCalled: Bool {
        rescheduleRepeatingTasksForFromCallsCount > 0
    }
    var rescheduleRepeatingTasksForFromReceivedArguments: (repeatingTasks: RepeatingTasks, behaviour: RepeatBehaviour, task: Task.DTO)?
    var rescheduleRepeatingTasksForFromReceivedInvocations: [(repeatingTasks: RepeatingTasks, behaviour: RepeatBehaviour, task: Task.DTO)] = []
    var rescheduleRepeatingTasksForFromClosure: ((RepeatingTasks, RepeatBehaviour, Task.DTO) -> Void)?

    func rescheduleRepeatingTasks(_ repeatingTasks: RepeatingTasks, for behaviour: RepeatBehaviour, from task: Task.DTO) {
        rescheduleRepeatingTasksForFromCallsCount += 1
        rescheduleRepeatingTasksForFromReceivedArguments = (repeatingTasks: repeatingTasks, behaviour: behaviour, task: task)
        rescheduleRepeatingTasksForFromReceivedInvocations.append((repeatingTasks: repeatingTasks, behaviour: behaviour, task: task))
        rescheduleRepeatingTasksForFromClosure?(repeatingTasks, behaviour, task)
    }
}
