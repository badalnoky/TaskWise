import SwiftUI
public struct TaskRow<Content: View, Selection: Hashable> {
    private let title: String
    private let selected: Binding<Selection>
    private let content: Content

    public init(
        title: String,
        selected: Binding<Selection>,
        @ViewBuilder content: () -> Content
    ) {
        self.title = title
        self.selected = selected
        self.content = content()
    }
}

extension TaskRow: View {
    public var body: some View {
        HStack(spacing: .zero) {
            Text(title)
                .textStyle(.body)
            Spacer()
            Picker(String.empty, selection: selected) {
                content
            }
        }
        .padding(.horizontal, .padding4)
        .frame(height: .defaultRowHeight)
        .background(
            RoundedRectangle(cornerRadius: .padding12)
                .fill(.appBackground)
                .edgeShadows()
        )
    }
}

#Preview {
    @Previewable @State var selected: String = "First"
    TaskRow(title: "Title", selected: $selected) {
        ForEach(["First", "Second", "Third"], id: \.self) {
            Text($0).tag($0)
        }
    }
}
