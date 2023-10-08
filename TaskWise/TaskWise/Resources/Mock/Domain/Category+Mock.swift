#if DEBUG
extension Category {
    static var mock: Category {
        Category(name: .empty)
    }
}
#endif
