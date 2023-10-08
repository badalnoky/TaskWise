#if DEBUG
extension Task {
    static var mock: Task {
        Task(
            title: .empty,
            description: .empty,
            priorityId: .empty,
            categoryId: .empty,
            date: .now,
            hasTimeConstraints: false,
            startDateTime: .now,
            endDateTime: .now,
            steps: [],
            colorComponents: .mock,
            columnId: .empty
        )
    }
}
#endif
