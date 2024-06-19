import Combine
import CoreData
import SwiftUI

#if DEBUG
class PreviewDataService: DataServiceInput {
    static let global = PreviewDataService()
    private let container = NSPersistentContainer(name: Str.DataService.previewContainerName)
    var context: NSManagedObjectContext { container.viewContext }

    var tasks = CurrentValueSubject<[TWTask], Never>([])
    var todaysTasks = CurrentValueSubject<[TWTask], Never>([])
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

    func fetchSteps(for task: TWTask) {
        currentSteps.send([.mock])
    }

    func addCategory(_ category: Category.DTO) {}
    func updateCategoryName(on category: Category, to newName: String) {}
    func updateColor(on category: Category, with newColor: ColorComponents.DTO) {}
    func deleteCategory(_ category: Category) {}
    func addPriority(_ priority: Priority.DTO) {}
    func updatePriorityName(on priority: Priority, to newName: String) {}
    func updateOrder(priorities: [Priority]) {}
    func deletePriority(_ priority: Priority) {}
    func addTask(_ task: TWTask.DTO) {}
    func updateTask(_ task: TWTask, with updated: TWTask.DTO) {}
    func updateColumn(to column: TaskColumn, on task: TWTask) {}
    func addStepFrom(dto: TaskStep.DTO, to task: TWTask) {}
    func toggleIsDone(on step: TaskStep, for task: TWTask) {}
    func updateStepLabel(on step: TaskStep, to newLabel: String) {}
    func updateOrder(of steps: [TaskStep], on task: TWTask) {}
    func delete(step deleted: TaskStep, from task: TWTask) {}
    func deleteTask(_ task: TWTask) {}
    func addColumn(_ column: TaskColumn.DTO) {}
    func updateColumnName(on column: TaskColumn, to newName: String) {}
    func updateOrder(columns: [TaskColumn]) {}
    func deleteColumn(_ column: TaskColumn) {}
    func fetchRepeatingTasks() {}
    func createTasks(from task: TWTask.DTO, with behaviour: RepeatBehaviour) {}
    func createTasks(from updated: TWTask.DTO, with behaviour: RepeatBehaviour, including task: TWTask) {}
    func deleteRepeatingTasks(_ repeating: RepeatingTasks) {}
    func updateRepeatingTasks(_ repeating: RepeatingTasks, from task: TWTask.DTO) {}
    func updateStepLabelForRepeating(_ repeating: RepeatingTasks, on step: TaskStep, to newLabel: String) {}
    func deleteStepForRepeating(_ repeating: RepeatingTasks, step deleted: TaskStep) {}
    func updateStepOrderForRepeating(_ repeating: RepeatingTasks, to steps: [TaskStep]) {}
    func addStepToRepeating(_ repeating: RepeatingTasks, step: TaskStep.DTO) {}
    func rescheduleRepeatingTasks(_ repeatingTasks: RepeatingTasks, for behaviour: RepeatBehaviour, from task: TWTask.DTO) {}
}
#endif
