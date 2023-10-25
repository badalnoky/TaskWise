import CoreData
import Foundation

extension TaskStep {
    public static let entityName: String = "TaskStep"
    public static let sortingKey: String = "wIndex"

    @NSManaged public var wIsDone: Bool
    @NSManaged public var wLabel: String?
    @NSManaged public var wIndex: Int16
    @NSManaged public var wTask: Task?

    public var isDone: Bool { wIsDone }
    public var label: String { wLabel ?? .empty }
    public var index: Int { Int(wIndex) }

    @nonobjc public class func fetchRequest(for task: Task) -> NSFetchRequest<TaskStep> {
        let request = NSFetchRequest<TaskStep>(entityName: Self.entityName)
        request.sortDescriptors = [NSSortDescriptor(key: Self.sortingKey, ascending: true)]
        request.predicate = NSPredicate(format: "wTask.wId == %@", task.id.uuidString)
        return request
    }
}

extension TaskStep: Identifiable {}
