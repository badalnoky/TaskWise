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

    func deleteColumn(_ column: TaskColumn) throws {
        if columns.value.count == .one {
            throw DataOperationError.lastOfKind(type: TaskColumn.entityName)
        } else if (column.wTasks?.count ?? .zero) > .zero {
            throw DataOperationError.existingRelationship(type: TaskColumn.entityName)
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
