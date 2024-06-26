import Combine
import CoreData

public final class DataService: DataServiceInput {
    private typealias Txt = Str.DataService
    private let container = NSPersistentCloudKitContainer(name: Txt.containerName)
    private var userSettings: UserSettings?

    public var tasks = CurrentValueSubject<[Task], Never>([])
    public var todaysTasks = CurrentValueSubject<[Task], Never>([])
    public var priorities = CurrentValueSubject<[Priority], Never>([])
    public var categories = CurrentValueSubject<[Category], Never>([])
    public var columns = CurrentValueSubject<[TaskColumn], Never>([])
    public var currentSteps = CurrentValueSubject<[TaskStep], Never>([])
    public var repeatingTasks = CurrentValueSubject<[RepeatingTasks], Never>([])

    public var context: NSManagedObjectContext { container.viewContext }

    init(shouldLoadDefaults: Bool = true) {
        loadContainer()
        #if !os(watchOS)
        if shouldLoadDefaults {
            handleDefaultUserSettings()
        }
        #endif
    }

    private func loadContainer() {
        // swiftlint: disable: force_unwrapping
        let containerURL = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: Str.App.groupIdentifier)!
        let storeURL = containerURL.appendingPathComponent(Str.App.sqlite)
        let description = container.persistentStoreDescriptions.first!
        // swiftlint: enable: force_unwrapping

        description.url = storeURL
        description.setOption(true as NSNumber, forKey: NSPersistentHistoryTrackingKey)

        container.viewContext.automaticallyMergesChangesFromParent = true
        container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        container.loadPersistentStores { description, error in
            if error != nil {
                print(Txt.containerFailureMessage)
            }
        }
    }

    func save() {
        do {
            try context.save()
        } catch { print(Txt.saveFailureMessage) }
    }

    func delete(item: NSManagedObject) {
        context.delete(item)
        save()
    }
}

#if !os(watchOS)
// MARK: Default values
extension DataService {
    private func handleDefaultUserSettings() {
        WidgetTimelineService.initiateWidgetDefaults()
        let request = NSFetchRequest<UserSettings>(entityName: UserSettings.entityName)
        guard let settings = try? context.fetch(request).first else {
            self.userSettings = UserSettings(context: context)
            initiateDefaultPriorities()
            initiateDefaultCategories()
            initiateDefaultColumns()
            return
        }
        self.userSettings = settings
    }

    private func initiateDefaultPriorities() {
        Priority.initiateDefaultsWith(context: context)
        userSettings?.prioritiesInitiated = true
        save()
    }

    private func initiateDefaultCategories() {
        Category.initiateDefaultsWith(context: context)
        userSettings?.categoriesInitiated = true
        save()
    }

    private func initiateDefaultColumns() {
        TaskColumn.initiateDefaultsWith(context: context)
        userSettings?.columnsInitiated = true
        save()
    }
}
#endif
