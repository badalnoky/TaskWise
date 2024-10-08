import SwiftUI

struct ReorderDropViewDelegate<Item: NamedItem & Equatable & Identifiable>: DropDelegate {
    let destinationItem: Item
    @Binding var items: [Item]
    @Binding var draggedItem: Item?
    var moveAction: (IndexSet, Int) -> Void

    func dropUpdated(info: DropInfo) -> DropProposal? {
        DropProposal(operation: .move)
    }

    func performDrop(info: DropInfo) -> Bool {
        draggedItem = nil
        return true
    }

    func dropEntered(info: DropInfo) {
        if let draggedItem {
            if let fromIndex = items.firstIndex(of: draggedItem) {
                if let toIndex = items.firstIndex(of: destinationItem), fromIndex != toIndex {
                    let fromOffset = IndexSet(integer: fromIndex)
                    let toOffset = (toIndex > fromIndex ? (toIndex + .one) : toIndex)
                    withAnimation {
                        self.items.move(fromOffsets: fromOffset, toOffset: toOffset)
                        moveAction(fromOffset, toOffset)
                    }
                }
            }
        }
    }
}
