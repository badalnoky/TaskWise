import Foundation

extension Array where Element == Task {
    func from(column: TaskColumn) -> [Task] {
        self.filter { $0.column.id == column.id }
    }

    func from(date: Date) -> [Task] {
        self.filter { Calendar.current.isDate($0.date, inSameDayAs: date) }
    }
}
