import CoreData
import Foundation

extension RepeatingTasks {
    public static let entityName: String = "RepeatingTasks"
    @NSManaged public var end: Date?
    @NSManaged public var wId: UUID?
    @NSManaged public var wLastUpdated: Date?
    @NSManaged public var wStart: Date?
    @NSManaged public var wTasks: NSSet?

    public var id: UUID { wId ?? UUID() }
    public var lastUpdated: Date { wLastUpdated ?? .now }
    public var start: Date { wStart ?? .now }
    public var tasks: [Task] {
        let set = wTasks as? Set<Task> ?? []
        return set.sorted { $0.date < $1.date }
    }
    public var idIndefinite: Bool { end == nil }

    @nonobjc public class func fetchRequest() -> NSFetchRequest<RepeatingTasks> {
        NSFetchRequest<RepeatingTasks>(entityName: entityName)
    }
}

// MARK: Generated accessors for wTasks
extension RepeatingTasks {
    @objc(addWTasksObject:)
    @NSManaged public func addToWTasks(_ value: Task)

    @objc(removeWTasksObject:)
    @NSManaged public func removeFromWTasks(_ value: Task)

    @objc(addWTasks:)
    @NSManaged public func addToWTasks(_ values: NSSet)

    @objc(removeWTasks:)
    @NSManaged public func removeFromWTasks(_ values: NSSet)
}

extension RepeatingTasks: Identifiable {}
