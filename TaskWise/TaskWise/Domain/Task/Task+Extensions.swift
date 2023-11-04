import Foundation

extension Array where Element == Task {
    func from(column: TaskColumn) -> [Task] {
        self.filter { $0.column.id == column.id }
    }

    func from(date: Date) -> [Task] {
        self.filter { Calendar.current.isDate($0.date, inSameDayAs: date) }
    }

    func filteredBy(text: String, priority: Priority?, category: Category?) -> [Task] {
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
