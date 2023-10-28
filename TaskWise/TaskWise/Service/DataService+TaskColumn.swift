extension DataService {
    func addColumn(_ column: TaskColumn.DTO) {
        TaskColumn.create(from: column, on: context)
        save()
        fetchColumns()
    }

    func updateColumnName(on column: TaskColumn, to newName: String) {
        column.wName = newName
        save()
        fetchColumns()
    }

    func updateOrder(of columns: [TaskColumn]) {
        updateIndices(on: columns)
        fetchColumns()
    }

    func deleteColumn(_ column: TaskColumn) {
        // TODO: delete, handle when it has tasks, or it is the last
        fetchColumns()
    }

    private func updateIndices(on columns: [TaskColumn]) {
        for idx in columns.indices {
            columns[idx].wIndex = Int16(idx + 1)
        }
        save()
    }
}
