import SwiftData

struct TaskColumn: Codable, Hashable {
    let name: String
    let index: Int

    init(name: String, index: Int) {
        self.name = name
        self.index = index
    }
}

extension TaskColumn {
    static var defaultColumns: [TaskColumn] {
        [
            TaskColumn(name: "To Do", index: 1),
            TaskColumn(name: "In Progress", index: 2),
            TaskColumn(name: "Done", index: 3)
        ]
    }
}

@Model final class CustomColumn {
    var column = TaskColumn.defaultColumns[0]

    init(column: TaskColumn) {
        self.column = column
    }
}
