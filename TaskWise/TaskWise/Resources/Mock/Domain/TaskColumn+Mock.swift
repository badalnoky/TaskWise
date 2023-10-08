#if DEBUG
extension TaskColumn {
    static var mock: TaskColumn {
        TaskColumn(name: .empty, index: .zero)
    }
}
#endif
