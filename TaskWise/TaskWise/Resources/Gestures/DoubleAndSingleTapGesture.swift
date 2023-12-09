import SwiftUI

public struct DoubleAndSingleTapGesture {
    var task: Task
    var columns: [TaskColumn]
    var onDoubleTap: (TaskColumn, Task) -> Void
    var onSingleTap: (Task) -> Void
}

extension DoubleAndSingleTapGesture: Gesture {
    public var body: some Gesture {
        TapGesture(count: .one.next)
            .onEnded {
                if task.column.index != columns.count {
                    onDoubleTap(columns[task.column.index], task)
                }
            }
            .exclusively(before: TapGesture(count: .one).onEnded { onSingleTap(task) })
    }
}
