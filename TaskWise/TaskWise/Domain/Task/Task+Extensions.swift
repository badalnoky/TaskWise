import Foundation

extension Array where Element == TWTask {
    func from(column: TaskColumn) -> [TWTask] {
        self.filter { $0.column.id == column.id }
    }

    func from(date: Date) -> [TWTask] {
        self.filter { Calendar.current.isDate($0.date, inSameDayAs: date) }
    }

    func filteredBy(text: String, priority: Priority?, category: Category?) -> [TWTask] {
        self
            .filter {
                text.isEmpty ? true : ($0.title.caseInsensitiveContains(text) || $0.taskDescription.caseInsensitiveContains(text))
            }
            .filter {
                priority == nil ? true : $0.priority.id == priority?.id
            }
            .filter {
                category == nil ? true : $0.category.id == category?.id
            }
    }
}
