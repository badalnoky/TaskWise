import CoreData
import Foundation

extension TWTask {
    public static let entityName: String = "TWTask"
    public static let filterPredicate: String = " wDate > %@ && wDate < %@"

    @NSManaged public var repeatingTasks: RepeatingTasks?
    @NSManaged public var wDate: Date?
    @NSManaged public var wEndDateTime: Date?
    @NSManaged public var wHasTimeConstraints: Bool
    @NSManaged public var wId: UUID?
    @NSManaged public var wStartDateTime: Date?
    @NSManaged public var wTaskDescription: String?
    @NSManaged public var wTitle: String?
    @NSManaged public var wCategory: Category?
    @NSManaged public var wColumn: TaskColumn?
    @NSManaged public var wPriority: Priority?
    @NSManaged public var wSteps: NSSet?

    public var date: Date { wDate ?? .now }
    public var endDateTime: Date { wEndDateTime ?? .now }
    public var hasTimeConstraints: Bool { wHasTimeConstraints }
    public var id: UUID { wId ?? UUID() }
    public var startDateTime: Date { wStartDateTime ?? .now }
    public var taskDescription: String { wTaskDescription ?? .empty }
    public var title: String { wTitle ?? .empty }
    public var category: Category { wCategory ?? Category() }
    public var column: TaskColumn { wColumn ?? TaskColumn() }
    public var priority: Priority { wPriority ?? Priority() }
    public var steps: [TaskStep] {
        let set = wSteps as? Set<TaskStep> ?? []
        return set.sorted { $0.index < $1.index }
    }

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TWTask> {
        let request = NSFetchRequest<TWTask>(entityName: Self.entityName)
        let maxDate: NSDate = (Date.now.addingTimeInterval(.twoYears)) as NSDate
        let minDate: NSDate = (Date.now.addingTimeInterval(-1 * .year)) as NSDate
        request.predicate = NSPredicate(format: filterPredicate, argumentArray: [minDate, maxDate])
        return request
    }

    @nonobjc public class func todaysFetchRequest() -> NSFetchRequest<TWTask> {
        let request = NSFetchRequest<TWTask>(entityName: Self.entityName)
        let maxDate: NSDate = (Date.endOfToday) as NSDate
        let minDate: NSDate = (Date.startOfToday) as NSDate
        request.predicate = NSPredicate(format: filterPredicate, argumentArray: [minDate, maxDate])
        return request
    }
}

// MARK: Generated accessors for wSteps
extension TWTask {
    @objc(addWStepsObject:)
    @NSManaged public func addToWSteps(_ value: TaskStep)

    @objc(removeWStepsObject:)
    @NSManaged public func removeFromWSteps(_ value: TaskStep)

    @objc(addWSteps:)
    @NSManaged public func addToWSteps(_ values: NSSet)

    @objc(removeWSteps:)
    @NSManaged public func removeFromWSteps(_ values: NSSet)
}

extension TWTask: Identifiable {}
