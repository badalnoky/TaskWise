import CoreData
import Foundation

extension RepeatingTasks {
    public static let entityName: String = "RepeatingTasks"

    @NSManaged public var wBehavior: String?
    @NSManaged public var wEnd: Date?
    @NSManaged public var wId: UUID?
    @NSManaged public var wLastUpdated: Date?
    @NSManaged public var wStart: Date?
    @NSManaged public var wTasks: NSSet?

    public var id: UUID { wId ?? UUID() }
    public var lastUpdated: Date { wLastUpdated ?? .now }
    public var start: Date { wStart ?? .now }
    public var end: Date { wEnd ?? .now }
    public var tasks: [TWTask] {
        let set = wTasks as? Set<TWTask> ?? []
        return set.sorted { $0.date < $1.date }
    }

    public var behaviour: RepeatBehaviour {
        guard let encoded = wBehavior else { return .empty }
        return RepeatBehaviour.decode(encoded, end)
    }

    @nonobjc public class func fetchRequest() -> NSFetchRequest<RepeatingTasks> {
        NSFetchRequest<RepeatingTasks>(entityName: entityName)
    }
}

// MARK: Generated accessors for wTasks
extension RepeatingTasks {
    @objc(addWTasksObject:)
    @NSManaged public func addToWTasks(_ value: TWTask)

    @objc(removeWTasksObject:)
    @NSManaged public func removeFromWTasks(_ value: TWTask)

    @objc(addWTasks:)
    @NSManaged public func addToWTasks(_ values: NSSet)

    @objc(removeWTasks:)
    @NSManaged public func removeFromWTasks(_ values: NSSet)
}

extension RepeatingTasks: Identifiable {}
