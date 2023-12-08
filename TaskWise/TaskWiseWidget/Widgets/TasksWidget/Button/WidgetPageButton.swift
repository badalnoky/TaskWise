import SwiftUI

struct WidgetPageButton: View {
    var type: WidgetButtonType
    var condition: Bool

    var body: some View {
        if condition {
            Button(
                action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: { type.label }
            )
            .buttonStyle(WidgetPageButtonStyle())
            .frame(height: 25)
        } else {
            Color.clear
                .frame(width: .zero, height: 25)
        }
    }
}

#Preview {
    WidgetPageButton(type: .up, condition: true)
}
