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
                Label(Str.contextMenuNextLabel, systemImage: Str.iconsForward)
            }
        }
        if task.column.index != .one {
            Button {
                changeColumnAction(columns[task.column.index.previous.previous], task)
            } label: {
                Label(Str.contextMenuPreviousLabel, systemImage: Str.iconsBack)
            }
        }
        Button(role: .destructive) {
            deleteAction(task)
        } label: {
            Label(Str.contextMenuDeleteLabel, systemImage: Str.iconsDelete)
        }
    }
}

#Preview {
    TaskContextMenuItems(task: .mock, columns: [], changeColumnAction: { _, _ in }, deleteAction: { _ in })
}
