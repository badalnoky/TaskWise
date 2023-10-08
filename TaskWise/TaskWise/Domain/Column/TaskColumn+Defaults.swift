extension TaskColumn {
    static var defaultColumns: [TaskColumn] {
        [
            TaskColumn(name: "To Do", index: 1),
            TaskColumn(name: "In Progress", index: 2),
            TaskColumn(name: "Done", index: 3)
        ]
    }
}
