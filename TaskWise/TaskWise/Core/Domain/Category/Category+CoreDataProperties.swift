import CoreData
import Foundation

extension Category {
    public static let entityName: String = "Category"
    public static let sortingKey: String = "wName"

    @NSManaged public var wId: UUID?
    @NSManaged public var wName: String?
    @NSManaged public var wTasks: NSSet?
    @NSManaged public var wColorComponents: ColorComponents?

    public var id: UUID { wId ?? UUID() }
    public var name: String { wName ?? .empty }
    public var colorComponents: ColorComponents { wColorComponents ?? ColorComponents() }

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Category> {
        let request = NSFetchRequest<Category>(entityName: Self.entityName)
        request.sortDescriptors = [NSSortDescriptor(key: Self.sortingKey, ascending: true)]
        return request
    }
}

// MARK: Generated accessors for wTasks
extension Category {
    @objc(addWTasksObject:)
    @NSManaged public func addToWTasks(_ value: TWTask)

    @objc(removeWTasksObject:)
    @NSManaged public func removeFromWTasks(_ value: TWTask)

    @objc(addWTasks:)
    @NSManaged public func addToWTasks(_ values: NSSet)

    @objc(removeWTasks:)
    @NSManaged public func removeFromWTasks(_ values: NSSet)
}

extension Category: Identifiable, NamedItem {}
