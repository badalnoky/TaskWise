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

    func updateOrder(columns: [TaskColumn]) {
        updateIndices(on: columns)
        fetchColumns()
    }

    func deleteColumn(_ column: TaskColumn) {
        if columns.value.count == .one {
            print("Return an error saying there needs to be at least one category")
        } else if (column.wTasks?.count ?? .zero) > .zero {
            print("Return an error saying that some task use it")
        } else {
            let updatedColumns = columns.value.filter { $0.id != column.id }
            delete(item: column)
            updateIndices(on: updatedColumns)
        }
        fetchColumns()
    }

    private func updateIndices(on columns: [TaskColumn]) {
        for idx in columns.indices {
            columns[idx].wIndex = Int16(idx.next)
        }
        save()
    }
}
