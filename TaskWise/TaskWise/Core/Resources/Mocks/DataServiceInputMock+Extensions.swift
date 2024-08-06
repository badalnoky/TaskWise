import CoreData

extension DataServiceInputMock {
    static var persistentContainer: NSPersistentContainer {
        let description = NSPersistentStoreDescription()
        description.url = URL(fileURLWithPath: "/dev/null")
        let container = NSPersistentContainer(name: Str.DataService.mockContainer)
        container.persistentStoreDescriptions = [description]
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }

    static var colorComponentMock: ColorComponents {
        let components = ColorComponents(context: Self.persistentContainer.viewContext)
        components.wRed = .zero
        components.wGreen = .zero
        components.wBlue = .one
        components.wAlpha = .one
        return components
    }

    static var categoryMock: Category {
        let category = Category(context: Self.persistentContainer.viewContext)
        category.wId = UUID()
        category.wName = "Category"
        category.wColorComponents = colorComponentMock
        return category
    }

    static var columnMock: TaskColumn {
        let column = TaskColumn(context: Self.persistentContainer.viewContext)
        column.wId = UUID()
        column.wIndex = 1
        column.wName = "Column"
        return column
    }

    static var priorityMock: Priority {
        let priority = Priority(context: Self.persistentContainer.viewContext)
        priority.wId = UUID()
        priority.wLevel = 1
        priority.wName = "Priority"
        return priority
    }

    static var taskMock: TWTask {
        let task = TWTask(context: Self.persistentContainer.viewContext)
        task.wDate = .now
        task.wEndDateTime = .now
        task.wHasTimeConstraints = false
        task.wId = UUID()
        task.wStartDateTime = .now
        task.wTaskDescription = "Description"
        task.wTitle = "Task"
        task.wCategory = categoryMock
        task.wColumn = columnMock
        task.wPriority = priorityMock
        return task
    }

    static var repeatingMock: RepeatingTasks {
        let repeating = RepeatingTasks(context: Self.persistentContainer.viewContext)
        repeating.wBehavior = "W/D/1"
        repeating.wId = UUID()
        repeating.wEnd = Date(timeIntervalSince1970: .one)
        repeating.wStart = Date(timeIntervalSince1970: .one)
        repeating.wLastUpdated = Date(timeIntervalSince1970: .one)
        return repeating
    }

    static var repeatedTaskMock: TWTask {
        let task = TWTask(context: Self.persistentContainer.viewContext)
        task.wDate = .now
        task.wEndDateTime = .now
        task.wHasTimeConstraints = false
        task.wId = UUID()
        task.wStartDateTime = .now
        task.wTaskDescription = "Description"
        task.wTitle = "Task"
        task.wCategory = categoryMock
        task.wColumn = columnMock
        task.wPriority = priorityMock
        task.repeatingTasks = repeatingMock
        return task
    }

    static var stepMock: TaskStep {
        let step = TaskStep(context: Self.persistentContainer.viewContext)
        step.wIndex = .zero
        step.wLabel = "Step"
        step.wIsDone = false
        step.wTask = taskMock
        return step
    }
}
