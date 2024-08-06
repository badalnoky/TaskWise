import Foundation

extension Array where Element == TWTask {
    var sortedByDateAndPriority: [TWTask] {
        self.sorted { $0.priority.level > $1.priority.level }.sorted { $0.startDateTime < $1.startDateTime}
    }

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
