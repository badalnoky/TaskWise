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
        // TODO: update order
        save()
        fetchColumns()
    }

    func deleteColumn(_ column: TaskColumn) {
        // TODO: delete, handle when it has tasks, or it is the last
        fetchColumns()
    }
}
