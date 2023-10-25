import Combine
import CoreData

public final class DataService {
    private let container = NSPersistentCloudKitContainer(name: Str.dataServiceContainerName)

    public var userSettings: UserSettings?
    public var tasks = CurrentValueSubject<[Task], Never>([])
    public var priorities = CurrentValueSubject<[Priority], Never>([])
    public var categories = CurrentValueSubject<[Category], Never>([])
    public var columns = CurrentValueSubject<[TaskColumn], Never>([])
    public var currentSteps = CurrentValueSubject<[TaskStep], Never>([])

    init() {
        loadContainer()
        handleDefaultUserSettings()
    }

    private func loadContainer() {
        container.loadPersistentStores { description, error in
            if error != nil { print(Str.dataServiceContainerFailureMessage) }
        }
    }

    private func save() {
        do {
            try container.viewContext.save()
        } catch { print(Str.dataServiceSaveFailureMessage) }
    }

    private func delete(item: NSManagedObject) {
        container.viewContext.delete(item)
        save()
    }
}

// MARK: Fetching
extension DataService {
    func fetchTasks() {
        guard let tasks = try? container.viewContext.fetch(Task.fetchRequest()) else { return }
        self.tasks.send(tasks)
    }

    func fetchPriorities() {
        guard let priorities = try? container.viewContext.fetch(Priority.fetchRequest()) else { return }
        self.priorities.send(priorities)
    }

    func fetchCategories() {
        guard let categories = try? container.viewContext.fetch(Category.fetchRequest()) else { return }
        self.categories.send(categories)
    }

    func fetchColumns() {
        guard let columns = try? container.viewContext.fetch(TaskColumn.fetchRequest()) else { return }
        self.columns.send(columns)
    }

    func fetchSteps(for task: Task) {
        guard let steps = try? container.viewContext.fetch(TaskStep.fetchRequest(for: task)) else { return }
        self.currentSteps.send(steps)
    }
}

// MARK: Default values
extension DataService {
    private func handleDefaultUserSettings() {
        let request = NSFetchRequest<UserSettings>(entityName: UserSettings.entityName)
        guard let settings = try? container.viewContext.fetch(request).first else {
            self.userSettings = UserSettings(context: container.viewContext)
            initiateDefaultPriorities()
            initiateDefaultCategories()
            initiateDefaultColumns()
            return
        }
        self.userSettings = settings
    }

    private func initiateDefaultPriorities() {
        Priority.initiateDefaultsWith(context: container.viewContext)
        userSettings?.prioritiesInitiated = true
        save()
    }

    private func initiateDefaultCategories() {
        Category.initiateDefaultsWith(context: container.viewContext)
        userSettings?.categoriesInitiated = true
        save()
    }

    private func initiateDefaultColumns() {
        TaskColumn.initiateDefaultsWith(context: container.viewContext)
        userSettings?.columnsInitiated = true
        save()
    }
}

// MARK: Create, Update, Delete
extension DataService {
    func addTask(_ task: Task.DTO) {
        Task.create(from: task, on: container.viewContext)
        save()
        fetchTasks()
    }

    func deleteTask(_ task: Task) {
        delete(item: task)
        fetchTasks()
    }

    func updateTask(_ task: Task, with updated: Task.DTO) {
        task.update(with: updated, on: container.viewContext)
        save()
        fetchTasks()
    }

    func toggleIsDone(on step: TaskStep, for task: Task) {
        step.wIsDone.toggle()
        save()
        fetchSteps(for: task)
    }

    func updateStepLabel(on step: TaskStep, to newLabel: String) {
        step.wLabel = newLabel
        save()
    }

    func addStepFrom(dto: TaskStep.DTO, to task: Task) {
        TaskStep.create(for: task, from: dto, on: container.viewContext)
        save()
        fetchSteps(for: task)
    }

    func delete(step deleted: TaskStep, from task: Task) {
        let updatedSteps = task.steps.filter { $0.index != deleted.index }
        delete(item: deleted)
        updateIndices(on: updatedSteps)
        fetchSteps(for: task)
    }

    func updateOrder(of steps: [TaskStep], on task: Task) {
        updateIndices(on: steps)
        fetchSteps(for: task)
    }

    private func updateIndices(on steps: [TaskStep]) {
        for idx in steps.indices {
            steps[idx].wIndex = Int16(idx)
        }
        save()
    }
}
