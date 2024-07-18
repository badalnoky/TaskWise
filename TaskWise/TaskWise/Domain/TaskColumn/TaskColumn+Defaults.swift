import CoreData

extension TaskColumn {
    public static func initiateDefaultsWith(context: NSManagedObjectContext) {
        let todo = TaskColumn(context: context)
        todo.wId = UUID(uuidString: "9F432030-1149-4C78-98D7-D8069FEE336E")
        todo.wIndex = 1
        todo.wName = "TODO"

        let inProgress = TaskColumn(context: context)
        inProgress.wId = UUID(uuidString: "7578789B-CE4A-4580-AA90-4C07FE35CB3A")
        inProgress.wIndex = 2
        inProgress.wName = "In Progress"

        let done = TaskColumn(context: context)
        done.wId = UUID(uuidString: "B95CBAD0-0A59-4A88-BD8D-2AC2E28DC874")
        done.wIndex = 3
        done.wName = "Done"
    }
}
