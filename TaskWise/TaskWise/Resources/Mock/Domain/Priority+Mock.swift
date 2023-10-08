#if DEBUG
extension Priority {
    static var mock: Priority {
        Priority(name: .empty, level: .zero)
    }
}
#endif
