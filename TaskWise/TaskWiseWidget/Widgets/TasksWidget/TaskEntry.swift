import WidgetKit

public struct TaskEntry: TimelineEntry {
    public var date: Date
    var tasks: [TWTask.WidgetDTO]
    var columns: [TaskColumn.DTO]
    var selectedIndex: Int
    var selectedPage: Int
}

extension TaskEntry {
    static let empty: TaskEntry = .init(date: .now, tasks: [], columns: [], selectedIndex: .zero, selectedPage: .zero)
    static let placeholder: TaskEntry = .init(date: .now, tasks: [], columns: [], selectedIndex: .zero, selectedPage: .zero)

    static func previewEntry(selectedIndex: Int, selectedPage: Int) -> TaskEntry {
        TaskEntry(
            date: .now,
            tasks: [
                .placeholder, .placeholder, .placeholder, .placeholder,
                .placeholder, .placeholder, .placeholder, .placeholder
            ],
            columns: [.placeholder, .placeholder, .placeholder],
            selectedIndex: selectedIndex,
            selectedPage: selectedPage
        )
    }
}
