import SwiftUI

struct ListItemView<Content: View> {
    var isEditable: Bool
    var deleteAction: () -> Void
    var content: () -> Content

    @State private var deletButtonWidth: CGFloat = .zero

    init(
        isEditable: Bool,
        deleteAction: @escaping () -> Void,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.isEditable = isEditable
        if isEditable {
            self.deletButtonWidth = .listDeleteButtonMaxWidth
        }
        self.deleteAction = deleteAction
        self.content = content
    }
}

extension ListItemView: View {
    var body: some View {
        HStack(spacing: .zero) {
            HStack {
                content()
            }
            .frame(height: .listItemHeight)
            .background { Rectangle().fill(.appBackground) }

            Button(action: deleteAction) {
                Image.trash
                    .resizable()
                    .scaledToFit()
                    .padding(.vertical, .padding12)
                    .foregroundStyle(.black)
            }
            .padding(.horizontal, deletButtonWidth == .listDeleteButtonMaxWidth ? .padding12 : .zero)
            .frame(width: deletButtonWidth)
            .frame(height: .listItemHeight)
            .background {
                Rectangle()
                    .fill(Color.delete)
            }
        }
        .clipShape(RoundedRectangle(cornerRadius: .padding12))
        .edgeShadows()
        .padding(.vertical, .padding4)
        .gesture(
            DragGesture(minimumDistance: .minimumDragDistance)
                .onChanged { gesture in
                    if gesture.translation.width < .zero, deletButtonWidth < .listDeleteButtonMaxWidth {
                        deletButtonWidth = abs(gesture.translation.width)
                    }
                    if gesture.translation.width > .zero, deletButtonWidth > .zero {
                        deletButtonWidth = .listDeleteButtonMaxWidth - abs(gesture.translation.width)
                    }
                }
                .onEnded { _ in
                    withAnimation {
                        if deletButtonWidth > .listDeleteButtonMaxWidth.half {
                            deletButtonWidth = .listDeleteButtonMaxWidth
                        } else {
                            deletButtonWidth = .zero
                        }
                    }
                }
        )
        .onChange(of: isEditable) { _, _ in
            withAnimation {
                deletButtonWidth = isEditable ? .listDeleteButtonMaxWidth : .zero
            }
        }
    }
}