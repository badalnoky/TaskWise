extension Array where Element == Task {
    func from(column: TaskColumn) -> [Task] {
        self.filter { $0.column.id == column.id }
    }
}
