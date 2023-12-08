import Foundation

extension DataService {
    func fetchCompletion() async throws -> (Int, Int) {
        guard let tasks = try? context.fetch(Task.todaysFetchRequest()) else { return (.zero, .zero) }
        guard let columns = try? context.fetch(TaskColumn.fetchRequest()) else { return (.zero, .zero) }
        guard let maxColumn = (columns.max { $0.index < $1.index }) else { return (.zero, .zero) }
        let doneTasks = tasks.from(column: maxColumn)
        return (doneTasks.count, tasks.count)
    }

    func fetchToday() async throws -> ([Task.WidgetDTO], [TaskColumn.DTO]) {
        guard let tasks = try? context.fetch(Task.todaysFetchRequest()) else { return ([], []) }
        guard let columns = try? context.fetch(TaskColumn.fetchRequest()) else { return ([], []) }
        let taskDtos = tasks.map { Task.WidgetDTO(from: $0) }
        let columnDtos = columns.map { TaskColumn.DTO(from: $0) }
        return (taskDtos, columnDtos)
    }
}
