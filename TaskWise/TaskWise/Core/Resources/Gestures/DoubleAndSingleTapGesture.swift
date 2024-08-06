import SwiftUI

public struct DoubleAndSingleTapGesture {
    var task: TWTask
    var columns: [TaskColumn]
    var onDoubleTap: (TaskColumn, TWTask) -> Void
    var onSingleTap: (TWTask) -> Void
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
