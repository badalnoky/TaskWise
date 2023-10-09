import CoreData

extension Category {
    public static func initiateDefaultsWith(context: NSManagedObjectContext) {
        let work = Category(context: context)
        work.wId = UUID()
        work.wName = "Work"

        let school = Category(context: context)
        school.wId = UUID()
        school.wName = "School"

        let health = Category(context: context)
        health.wId = UUID()
        health.wName = "Health"

        let freetime = Category(context: context)
        freetime.wId = UUID()
        freetime.wName = "Freetime"

        let other = Category(context: context)
        other.wId = UUID()
        other.wName = "Other"
    }
}
