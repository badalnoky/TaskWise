import CoreData
import Foundation

extension TaskColumn {
    public static let entityName: String = "TaskColumn"
    public static let sortingKey: String = "wIndex"

    @NSManaged public var wId: UUID?
    @NSManaged public var wIndex: Int16
    @NSManaged public var wName: String?
    @NSManaged public var wTasks: NSSet?

    public var id: UUID { wId ?? UUID() }
    public var index: Int { Int(wIndex) }
    public var name: String { wName ?? .empty }

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TaskColumn> {
        let request = NSFetchRequest<TaskColumn>(entityName: Self.entityName)
        request.sortDescriptors = [NSSortDescriptor(key: Self.sortingKey, ascending: true)]
        return request
    }
}

// MARK: Generated accessors for wTasks
extension TaskColumn {
    @objc(addWTasksObject:)
    @NSManaged public func addToWTasks(_ value: Task)

    @objc(removeWTasksObject:)
    @NSManaged public func removeFromWTasks(_ value: Task)

    @objc(addWTasks:)
    @NSManaged public func addToWTasks(_ values: NSSet)

    @objc(removeWTasks:)
    @NSManaged public func removeFromWTasks(_ values: NSSet)
}

extension TaskColumn: Identifiable {}
