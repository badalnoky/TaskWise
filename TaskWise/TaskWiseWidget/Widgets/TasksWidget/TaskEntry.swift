import WidgetKit

public struct TaskEntry: TimelineEntry {
    public var date: Date
    var tasks: [Task.WidgetDTO]
    var columns: [TaskColumn.DTO]
}
