import SwiftUI

struct ReorderableList<Item: NamedItem & Equatable & Identifiable, Content: View> {
    var isEditable: Bool
    var actualItems: [Item]
    var deleteAction: (Item) -> Void
    var moveAction: (IndexSet, Int) -> Void
    var content: (Item) -> Content
    @State var shownItems: [Item] = []
    @State var draggedItem: Item?

    init(
        isEditable: Bool,
        items: [Item],
        deleteAction: @escaping (Item) -> Void,
        moveAction: @escaping (IndexSet, Int) -> Void,
        @ViewBuilder content: @escaping (Item) -> Content
    ) {
        self.isEditable = isEditable
        self.actualItems = items
        self.shownItems = items
        self.deleteAction = deleteAction
        self.moveAction = moveAction
        self.content = content
    }
}

extension ReorderableList: View {
    var body: some View {
        HStack {
            VStack {
                ForEach(actualItems, id: \.id) { item in
                    ListItemView(isEditable: isEditable) {
                        deleteAction(item)
                    } content: {
                        content(item)
                    }
                    .onDrag {
                        self.draggedItem = item
                        return NSItemProvider()
                    }
                    .onDrop(
                        of: [.text],
                        delegate: ReorderDropViewDelegate(
                            destinationItem: item,
                            items: $shownItems,
                            draggedItem: $draggedItem,
                            moveAction: moveAction
                        )
                    )
                }
            }
            .padding()
        }
    }
}
