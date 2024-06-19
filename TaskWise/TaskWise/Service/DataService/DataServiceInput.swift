import Combine

// sourcery: AutoMockable
protocol DataServiceInput {
    var tasks: CurrentValueSubject<[TWTask], Never> { get set }
    var todaysTasks: CurrentValueSubject<[TWTask], Never> { get set }
    var priorities: CurrentValueSubject<[Priority], Never> { get set }
    var categories: CurrentValueSubject<[Category], Never> { get set }
    var columns: CurrentValueSubject<[TaskColumn], Never> { get set }
    var currentSteps: CurrentValueSubject<[TaskStep], Never> {get set }

    func fetchTasks()
    func fetchPriorities()
    func fetchCategories()
    func fetchColumns()
    func fetchSteps(for task: TWTask)
    func fetchRepeatingTasks()

    func addCategory(_ category: Category.DTO)
    func updateCategoryName(on category: Category, to newName: String)
    func updateColor(on category: Category, with newColor: ColorComponents.DTO)
    func deleteCategory(_ category: Category)

    func addPriority(_ priority: Priority.DTO)
    func updatePriorityName(on priority: Priority, to newName: String)
    func updateOrder(priorities: [Priority])
    func deletePriority(_ priority: Priority)

    func addTask(_ task: TWTask.DTO)
    func updateTask(_ task: TWTask, with updated: TWTask.DTO)
    func updateColumn(to column: TaskColumn, on task: TWTask)
    func addStepFrom(dto: TaskStep.DTO, to task: TWTask)
    func toggleIsDone(on step: TaskStep, for task: TWTask)
    func updateStepLabel(on step: TaskStep, to newLabel: String)
    func updateOrder(of steps: [TaskStep], on task: TWTask)
    func delete(step deleted: TaskStep, from task: TWTask)
    func deleteTask(_ task: TWTask)

    func addColumn(_ column: TaskColumn.DTO)
    func updateColumnName(on column: TaskColumn, to newName: String)
    func updateOrder(columns: [TaskColumn])
    func deleteColumn(_ column: TaskColumn)

    func createTasks(from task: TWTask.DTO, with behaviour: RepeatBehaviour)
    func createTasks(from updated: TWTask.DTO, with behaviour: RepeatBehaviour, including task: TWTask)
    func deleteRepeatingTasks(_ repeating: RepeatingTasks)
    func updateRepeatingTasks(_ repeating: RepeatingTasks, from task: TWTask.DTO)
    func updateStepLabelForRepeating(_ repeating: RepeatingTasks, on step: TaskStep, to newLabel: String)
    func deleteStepForRepeating(_ repeating: RepeatingTasks, step deleted: TaskStep)
    func updateStepOrderForRepeating(_ repeating: RepeatingTasks, to steps: [TaskStep])
    func addStepToRepeating(_ repeating: RepeatingTasks, step: TaskStep.DTO)
    func rescheduleRepeatingTasks(_ repeatingTasks: RepeatingTasks, for behaviour: RepeatBehaviour, from task: TWTask.DTO)
}
