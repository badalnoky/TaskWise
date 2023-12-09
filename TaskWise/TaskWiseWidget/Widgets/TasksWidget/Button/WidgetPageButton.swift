import SwiftUI

struct WidgetPageButton: View {
    var type: WidgetButtonType
    var condition: Bool

    var body: some View {
        if condition {
            Button(intent: PagingIntent(direction: type.intentDirection)) {
                type.label
            }
            .buttonStyle(WidgetPageButtonStyle())
            .frame(height: .pageButtonHeight)
            .transition(.opacity)
        } else {
            Color.clear
                .frame(width: .zero, height: .pageButtonHeight)
        }
    }
}

#Preview {
    WidgetPageButton(type: .up, condition: true)
}
