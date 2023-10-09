import CoreData

extension Priority {
    public static func initiateDefaultsWith(context: NSManagedObjectContext) {
        let low = Priority(context: context)
        low.wId = UUID()
        low.wLevel = 1
        low.wName = "Low"

        let medium = Priority(context: context)
        medium.wId = UUID()
        medium.wLevel = 2
        medium.wName = "Medium"

        let high = Priority(context: context)
        high.wId = UUID()
        high.wLevel = 3
        high.wName = "High"
    }
}
