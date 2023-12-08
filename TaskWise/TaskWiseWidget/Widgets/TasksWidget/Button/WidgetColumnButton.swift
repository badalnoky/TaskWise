import SwiftUI

struct WidgetColumnButton: View {
    var type: WidgetButtonType
    var condition: Bool

    var body: some View {
        if condition {
            Button(
                action: {},
                label: { type.label }
            )
            .buttonStyle(WidgetColumnButtonStyle())
        } else {
            Color.clear
                .frame(width: 40, height: .zero)
        }
    }
}

#Preview {
    WidgetColumnButton(type: .next, condition: true)
}
