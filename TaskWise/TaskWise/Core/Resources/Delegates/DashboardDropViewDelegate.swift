import SwiftUI

struct DashboardDropViewDelegate: DropDelegate {
    let destinationColumn: TaskColumn
    @Binding var draggedItem: TWTask?
    var moveAction: (TaskColumn, TWTask) -> Void

    func dropUpdated(info: DropInfo) -> DropProposal? {
        DropProposal(operation: .move)
    }

    func performDrop(info: DropInfo) -> Bool {
        draggedItem = nil
        return true
    }

    func dropEntered(info: DropInfo) {
        if let draggedItem {
            moveAction(destinationColumn, draggedItem)
        }
    }
}
