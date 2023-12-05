import SwiftUI
public struct TaskContextMenuItems {
    var task: Task
    var columns: [TaskColumn]
    var changeColumnAction: (TaskColumn, Task) -> Void
    var deleteAction: (Task) -> Void
}

extension TaskContextMenuItems: View {
    public var body: some View {
        if task.column.index != columns.count {
            Button {
                changeColumnAction(columns[task.column.index], task)
            } label: {
                Label("Move to next column", systemImage: "chevron.right")
            }
        }
        if task.column.index != .one {
            Button {
                changeColumnAction(columns[task.column.index.previous.previous], task)
            } label: {
                Label("Move to previous column", systemImage: "chevron.left")
            }
        }
        Button(role: .destructive) {
            deleteAction(task)
        } label: {
            Label("Delete", systemImage: "trash")
        }
    }
}

#Preview {
    TaskContextMenuItems(task: .mock, columns: [], changeColumnAction: { _, _ in }, deleteAction: { _ in })
}
