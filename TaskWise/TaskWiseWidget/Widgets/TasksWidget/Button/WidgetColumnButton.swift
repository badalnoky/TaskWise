import SwiftUI

struct WidgetColumnButton: View {
    var type: WidgetButtonType
    var condition: Bool

    var body: some View {
        if condition {
            Button(intent: ColumnIntent(direction: type.intentDirection)) {
                type.label
            }
            .buttonStyle(WidgetColumnButtonStyle())
            .frame(width: .columnButtonWidth)
            .transition(.opacity)
        } else {
            Color.clear
                .frame(width: .columnButtonWidth, height: .zero)
        }
    }
}

#Preview {
    WidgetColumnButton(type: .next, condition: true)
}
