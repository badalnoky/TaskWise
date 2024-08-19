import SwiftUI

struct ReorderableList<Item: NamedItem & Equatable & Identifiable, Content: View> {
    var highLabel: String
    var lowLabel: String
    var isEditable: Bool
    var actualItems: [Item]
    var deleteAction: (Item) -> Void
    var moveAction: (IndexSet, Int) -> Void
    var content: (Item) -> Content
    @State var shownItems: [Item] = []
    @State var draggedItem: Item?

    init(
        highLabel: String,
        lowLabel: String,
        isEditable: Bool,
        items: [Item],
        deleteAction: @escaping (Item) -> Void,
        moveAction: @escaping (IndexSet, Int) -> Void,
        @ViewBuilder content: @escaping (Item) -> Content
    ) {
        self.highLabel = highLabel
        self.lowLabel = lowLabel
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
            orderIndicator
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
                        delegate: DropViewDelegate(
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

private extension ReorderableList {
    var orderIndicator: some View {
        ZStack {
            Rectangle()
                .fill(.tertiary.opacity(.lowOpacity))
                .frame(width: .orderIndicatorRectangleWidth)
                .offset(y: .orderIndicatorOffset).clipped().offset(y: .orderIndicatorOffset.negative)
                .shadow(radius: .mutedShadowRadius, y: .orderIndicatorOffset)
            VStack {
                Text(highLabel)
                    .padding(.padding6)
                    .background(
                        Capsule()
                            .fill(.white)
                            .edgeShadows()
                    )
                Spacer()
                Text(lowLabel)
                    .padding(.padding6)
                    .background(
                        Capsule()
                            .fill(.white)
                            .edgeShadows()
                    )
            }
        }
    }
}
