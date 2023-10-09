import Combine
import CoreData
import Foundation

public final class DataController: ObservableObject {
    private let container = NSPersistentCloudKitContainer(name: "TaskWise")
    var userSettings: UserSettings?
    var tasks: [Task] = []
    public var priorities = CurrentValueSubject<[Priority], Never>([])
    public var categories = CurrentValueSubject<[Category], Never>([])
    public var columns = CurrentValueSubject<[TaskColumn], Never>([])

    init() {
        container.loadPersistentStores { description, error in
            if error != nil {
                print("Core Data failed to load")
            }
        }

        handleDefaultUserSettings()

        fetch()
    }

    func fetch() {
        let request = NSFetchRequest<Task>(entityName: "Task")

        do {
            tasks = try container.viewContext.fetch(request)
        } catch _ {
            print("Could not load data")
        }
    }

    func fetchPriorities() {
        let request = NSFetchRequest<Priority>(entityName: Priority.entityName)
        request.sortDescriptors = [NSSortDescriptor(key: "wLevel", ascending: true)]
        guard let priorities = try? container.viewContext.fetch(request) else { return }
        self.priorities.send(priorities)
    }

    func fetchCategories() {
        let request = NSFetchRequest<Category>(entityName: "Category")
        request.sortDescriptors = [NSSortDescriptor(key: "wName", ascending: true)]
        guard let categories = try? container.viewContext.fetch(request) else { return }
        self.categories.send(categories)
    }

    func fetchColumns() {
        let request = NSFetchRequest<TaskColumn>(entityName: "TaskColumn")
        request.sortDescriptors = [NSSortDescriptor(key: "wIndex", ascending: true)]
        guard let columns = try? container.viewContext.fetch(request) else { return }
        self.columns.send(columns)
    }

    func addTask(
        id: UUID = UUID(),
        title: String,
        description: String,
        date: Date,
        hasTimeConstraints: Bool,
        startDateTime: Date,
        endDateTime: Date
    ) {
        let task = Task(context: container.viewContext)
        task.wId = id
        task.wTitle = title
        task.wTaskDescription = description
        task.wDate = date
        task.wHasTimeConstraints = hasTimeConstraints
        task.wStartDateTime = startDateTime
        task.wEndDateTime = endDateTime
        save()
    }

    func save() {
        do {
            try container.viewContext.save()
            fetch()
        } catch {
            print("Could not save")
        }
    }
}

extension DataController {
    func handleDefaultUserSettings() {
        let request = NSFetchRequest<UserSettings>(entityName: "UserSettings")
        do {
            guard let settings = try container.viewContext.fetch(request).first else {
                self.userSettings = UserSettings(context: container.viewContext)
                defaultPriorities()
                defaultCategories()
                defaultColumns()
                return
            }
            self.userSettings = settings
        } catch _ {
            print("Could not load data")
        }
    }

    func defaultPriorities() {
        let low = Priority(context: container.viewContext)
        low.wId = UUID()
        low.wLevel = 1
        low.wName = "Low"

        let medium = Priority(context: container.viewContext)
        medium.wId = UUID()
        medium.wLevel = 2
        medium.wName = "Medium"

        let high = Priority(context: container.viewContext)
        high.wId = UUID()
        high.wLevel = 3
        high.wName = "High"

        userSettings?.prioritiesInitiated = true

        save()
    }

    func defaultCategories() {
        let work = Category(context: container.viewContext)
        work.wId = UUID()
        work.wName = "Work"

        let school = Category(context: container.viewContext)
        school.wId = UUID()
        school.wName = "School"

        let health = Category(context: container.viewContext)
        health.wId = UUID()
        health.wName = "Health"

        let freetime = Category(context: container.viewContext)
        freetime.wId = UUID()
        freetime.wName = "Freetime"

        let other = Category(context: container.viewContext)
        other.wId = UUID()
        other.wName = "Other"

        userSettings?.categoriesInitiated = true

        save()
    }

    func defaultColumns() {
        let todo = TaskColumn(context: container.viewContext)
        todo.wId = UUID()
        todo.wIndex = 1
        todo.wName = "TODO"

        let inProgress = TaskColumn(context: container.viewContext)
        inProgress.wId = UUID()
        inProgress.wIndex = 2
        inProgress.wName = "In Progress"

        let done = TaskColumn(context: container.viewContext)
        done.wId = UUID()
        done.wIndex = 3
        done.wName = "Done"

        userSettings?.columnsInitiated = true

        save()
    }
}
