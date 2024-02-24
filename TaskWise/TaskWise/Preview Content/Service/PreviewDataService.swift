import Combine
import CoreData
import SwiftUI

#if DEBUG
class PreviewDataService: DataServiceInput {
    static let global = PreviewDataService()
    private let container = NSPersistentContainer(name: Str.DataService.previewContainerName)
    var context: NSManagedObjectContext { container.viewContext }

    var tasks = CurrentValueSubject<[Task], Never>([])
    var todaysTasks = CurrentValueSubject<[Task], Never>([])
    var priorities = CurrentValueSubject<[Priority], Never>([])
    var categories = CurrentValueSubject<[Category], Never>([])
    var columns = CurrentValueSubject<[TaskColumn], Never>([])
    var currentSteps = CurrentValueSubject<[TaskStep], Never>([])

    private init() {
        // swiftlint: disable: force_unwrapping
        container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        container.loadPersistentStores { description, error in
            if error != nil { print(Str.DataService.containerFailureMessage) }
        }
    }

    func fetchTasks() {
        tasks.send([.mock])
    }

    func fetchPriorities() {
        priorities.send([.mock])
    }

    func fetchCategories() {
        categories.send([.mock])
    }

    func fetchColumns() {
        columns.send([.mock])
    }

    func fetchSteps(for task: Task) {
        currentSteps.send([.mock])
    }

    func addCategory(_ category: Category.DTO) {}
    func updateCategoryName(on category: Category, to newName: String) {}
    func updateColor(on category: Category, with newColor: ColorComponents.DTO) {}
    func deleteCategory(_ category: Category) {}
    func addPriority(_ priority: Priority.DTO) {}
    func updatePriorityName(on priority: Priority, to newName: String) {}
    func updateOrder(of priorities: [Priority]) {}
    func deletePriority(_ priority: Priority) {}
    func addTask(_ task: Task.DTO) {}
    func updateTask(_ task: Task, with updated: Task.DTO) {}
    func updateColumn(to column: TaskColumn, on task: Task) {}
    func addStepFrom(dto: TaskStep.DTO, to task: Task) {}
    func toggleIsDone(on step: TaskStep, for task: Task) {}
    func updateStepLabel(on step: TaskStep, to newLabel: String) {}
    func updateOrder(of steps: [TaskStep], on task: Task) {}
    func delete(step deleted: TaskStep, from task: Task) {}
    func deleteTask(_ task: Task) {}
    func addColumn(_ column: TaskColumn.DTO) {}
    func updateColumnName(on column: TaskColumn, to newName: String) {}
    func updateOrder(of columns: [TaskColumn]) {}
    func deleteColumn(_ column: TaskColumn) {}
}
#endif
