import Combine
import CoreData

public final class DataService {
    private let container = NSPersistentCloudKitContainer(name: Str.dataServiceContainerName)

    public var userSettings: UserSettings?
    public var tasks = CurrentValueSubject<[Task], Never>([])
    public var priorities = CurrentValueSubject<[Priority], Never>([])
    public var categories = CurrentValueSubject<[Category], Never>([])
    public var columns = CurrentValueSubject<[TaskColumn], Never>([])

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
}

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
}
