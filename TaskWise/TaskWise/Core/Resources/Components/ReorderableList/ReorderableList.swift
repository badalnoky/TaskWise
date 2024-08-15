import SwiftUI

struct ReorderableList<Item: NamedItem & Equatable & Identifiable> {
    var highLabel: String
    var lowLabel: String
    var isEditable: Bool
    var deleteAction: () -> Void
    @State var items: [Item]
    @State var draggedItem: Item?

    init(
        highLabel: String,
        lowLabel: String,
        isEditable: Bool,
        items: [Item],
        deleteAction: @escaping () -> Void
    ) {
        self.highLabel = highLabel
        self.lowLabel = lowLabel
        self.isEditable = isEditable
        self.items = items
        self.deleteAction = deleteAction
    }
}

extension ReorderableList: View {
    var body: some View {
        HStack {
            orderIndicator
            VStack {
                ForEach(items, id: \.id) { item in
                    ListItemView(isEditable: isEditable, deleteAction: deleteAction) {
                        HStack {
                            Text(item.name)
                            Spacer()
                        }
                    }
                    .onDrag {
                        self.draggedItem = item
                        return NSItemProvider()
                    }
                    .onDrop(
                        of: [.text],
                        delegate: DropViewDelegate(
                            destinationItem: item,
                            items: $items,
                            draggedItem: $draggedItem
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
                            .shadow(radius: .shadowRadius)
                    )
                Spacer()
                Text(lowLabel)
                    .padding(.padding6)
                    .background(
                        Capsule()
                            .fill(.white)
                            .shadow(radius: .shadowRadius)
                    )
            }
        }
    }
}
