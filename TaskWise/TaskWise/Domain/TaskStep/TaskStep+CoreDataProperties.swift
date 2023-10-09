import CoreData
import Foundation

extension TaskStep {
    public static let entityName: String = "TaskStep"

    @NSManaged public var wIsDone: Bool
    @NSManaged public var wLabel: String?
    @NSManaged public var wIndex: Int16
    @NSManaged public var wTask: Task?

    public var isDone: Bool { wIsDone }
    public var label: String { wLabel ?? .empty }
    public var index: Int { Int(wIndex) }

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TaskStep> {
        NSFetchRequest<TaskStep>(entityName: Self.entityName)
    }
}

extension TaskStep: Identifiable {}
