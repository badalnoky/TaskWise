import CoreData
import Foundation

extension Priority {
    public static let entityName: String = "Priority"
    public static let sortingKey: String = "wLevel"

    @NSManaged public var wId: UUID?
    @NSManaged public var wLevel: Int16
    @NSManaged public var wName: String?
    @NSManaged public var wTasks: NSSet?

    public var id: UUID { wId ?? UUID() }
    public var level: Int { Int(wLevel) }
    public var name: String { wName ?? .empty }

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Priority> {
        let request = NSFetchRequest<Priority>(entityName: Self.entityName)
        request.sortDescriptors = [NSSortDescriptor(key: Self.sortingKey, ascending: true)]
        return request
    }
}

// MARK: Generated accessors for wTasks
extension Priority {
    @objc(addWTasksObject:)
    @NSManaged public func addToWTasks(_ value: TWTask)

    @objc(removeWTasksObject:)
    @NSManaged public func removeFromWTasks(_ value: TWTask)

    @objc(addWTasks:)
    @NSManaged public func addToWTasks(_ values: NSSet)

    @objc(removeWTasks:)
    @NSManaged public func removeFromWTasks(_ values: NSSet)
}

extension Priority: Identifiable, NamedItem {}
