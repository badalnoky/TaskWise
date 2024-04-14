import Combine

protocol DataServiceInput {
    var tasks: CurrentValueSubject<[Task], Never> { get set }
    var todaysTasks: CurrentValueSubject<[Task], Never> { get set }
    var priorities: CurrentValueSubject<[Priority], Never> { get set }
    var categories: CurrentValueSubject<[Category], Never> { get set }
    var columns: CurrentValueSubject<[TaskColumn], Never> { get set }
    var currentSteps: CurrentValueSubject<[TaskStep], Never> {get set }

    func fetchTasks()
    func fetchPriorities()
    func fetchCategories()
    func fetchColumns()
    func fetchSteps(for task: Task)
    func fetchRepeatingTasks()

    func addCategory(_ category: Category.DTO)
    func updateCategoryName(on category: Category, to newName: String)
    func updateColor(on category: Category, with newColor: ColorComponents.DTO)
    func deleteCategory(_ category: Category)

    func addPriority(_ priority: Priority.DTO)
    func updatePriorityName(on priority: Priority, to newName: String)
    func updateOrder(of priorities: [Priority])
    func deletePriority(_ priority: Priority)

    func addTask(_ task: Task.DTO)
    func updateTask(_ task: Task, with updated: Task.DTO)
    func updateColumn(to column: TaskColumn, on task: Task)
    func addStepFrom(dto: TaskStep.DTO, to task: Task)
    func toggleIsDone(on step: TaskStep, for task: Task)
    func updateStepLabel(on step: TaskStep, to newLabel: String)
    func updateOrder(of steps: [TaskStep], on task: Task)
    func delete(step deleted: TaskStep, from task: Task)
    func deleteTask(_ task: Task)

    func addColumn(_ column: TaskColumn.DTO)
    func updateColumnName(on column: TaskColumn, to newName: String)
    func updateOrder(of columns: [TaskColumn])
    func deleteColumn(_ column: TaskColumn)

    func createTasks(from task: Task.DTO, with behaviour: RepeatBehaviour)
    func deleteRepeatingTasks(_ repeating: RepeatingTasks)
    func updateRepeatingTasks(_ repeating: RepeatingTasks, from task: Task.DTO)
    func updateStepLabelForRepeating(_ repeating: RepeatingTasks, on step: TaskStep, to newLabel: String)
    func deleteStepForRepeating(_ repeating: RepeatingTasks, step deleted: TaskStep)
    func updateStepOrderForRepeating(_ repeating: RepeatingTasks, to steps: [TaskStep])
    func addStepToRepeating(_ repeating: RepeatingTasks, step: TaskStep.DTO)
    func rescheduleRepeatingTasks(_ repeatingTasks: RepeatingTasks, for behaviour: RepeatBehaviour, from task: Task.DTO)
}
