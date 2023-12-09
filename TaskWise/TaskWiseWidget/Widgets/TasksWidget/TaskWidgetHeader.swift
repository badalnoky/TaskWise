import SwiftUI

struct TaskWidgetHeader: View {
    var name: String

    var body: some View {
        Text(name)
            .foregroundStyle(.accent)
            .textStyle(.callout)
            .padding(.padding8)
            .frame(maxWidth: .infinity)
            .background {
                RoundedRectangle(cornerRadius: .padding12)
                    .fill(Color.widgetHeader)
                    .frame(height: .widgetHeaderHeight)
            }
            .padding(.horizontal, .padding4)
            .id(name)
    }
}

#Preview {
    TaskWidgetHeader(name: "TODO")
}
