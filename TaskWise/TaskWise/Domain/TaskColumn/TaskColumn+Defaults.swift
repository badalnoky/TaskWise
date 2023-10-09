import CoreData

extension TaskColumn {
    public static func initiateDefaultsWith(context: NSManagedObjectContext) {
        let todo = TaskColumn(context: context)
        todo.wId = UUID()
        todo.wIndex = 1
        todo.wName = "TODO"

        let inProgress = TaskColumn(context: context)
        inProgress.wId = UUID()
        inProgress.wIndex = 2
        inProgress.wName = "In Progress"

        let done = TaskColumn(context: context)
        done.wId = UUID()
        done.wIndex = 3
        done.wName = "Done"
    }
}
