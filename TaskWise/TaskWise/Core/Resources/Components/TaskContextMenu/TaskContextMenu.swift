import SwiftUI
public struct TaskContextMenuItems {
    var task: TWTask
    var columns: [TaskColumn]
    var changeColumnAction: (TaskColumn, TWTask) -> Void
    var deleteAction: (TWTask) -> Void
}

extension TaskContextMenuItems: View {
    public var body: some View {
        if task.column.index != columns.count && task.column.index != columns.count.previous {
            Button {
                changeColumnAction(columns[columns.count.previous], task)
            } label: {
                Label(Str.ContextMenu.doneLabel, systemImage: Str.Icons.contextCheck)
            }
        }
        if task.column.index != columns.count {
            Button {
                changeColumnAction(columns[task.column.index], task)
            } label: {
                Label(Str.ContextMenu.nextLabel, systemImage: Str.Icons.forward)
            }
        }
        if task.column.index != .one {
            Button {
                changeColumnAction(columns[task.column.index.previous.previous], task)
            } label: {
                Label(Str.ContextMenu.previousLabel, systemImage: Str.Icons.back)
            }
        }
        Button(role: .destructive) {
            deleteAction(task)
        } label: {
            Label(Str.ContextMenu.deleteLabel, systemImage: Str.Icons.delete)
        }
    }
}
